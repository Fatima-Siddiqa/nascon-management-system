const express = require('express');
const bodyParser = require('body-parser');
const db = require('./database');
const app = express();
const port = 3000;

const path = require('path');

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login.html'));
});


// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static('public')); // serves static files like HTML/CSS/JS

// Individual registration endpoint
app.post('/register-individual', (req, res) => {
  const { name, institution, email, phone, eventId, cnic, accommodation, address } = req.body;
  console.log(req.body); 

  // Get available accommodation if requested
  let getAccommodationQuery = `SELECT A_id FROM Accommodation WHERE Availability = 'Yes' LIMIT 1`;
  db.query(getAccommodationQuery, (err, accResult) => {
    if (err) return res.status(500).send('Error checking accommodation');

    const A_id = accommodation === 'yes' && accResult.length > 0 ? accResult[0].A_id : null;

    // Insert into Participant table
    const insertParticipant = `INSERT INTO Participant (UniversityName, PType, A_id) VALUES (?, 'individual', ?)`;
    db.query(insertParticipant, [institution, A_id], (err, result) => {
      if (err) {
        console.error('Insert Participant Error:', err);
        return res.status(500).send('Error inserting participant');
      }

      const P_id = result.insertId;

      // Insert into User table
      const insertUser = `INSERT INTO User (UName, Email, Address, Role, PhoneNo, P_id) VALUES (?, ?, ?, 'Participant', ?, ?)`;
      db.query(insertUser, [name, email, address, phone, P_id], (err) => {
        if (err) {
            console.error('Insert User Error:', err);
            return res.status(500).send('Error inserting user');
        }

        // Map event name (from form) to event ID
        const eventMapping = {
          ai_hackathon: 1,
          web_dev: 2,
          genai_masterpiece: 3,
          edathon: 4,
          entrepreneurial_venture: 5,
          business_scavenger_hunt: 6,
          case_quest: 7,
          crypto: 8,
          squid_bizz: 9,
          nascon_fifa_frenzy: 10,
          tekken_iron_fist_championship: 11,
          nascon_valo_showdown: 12,
          nascon_got_talent: 13,
          bait_baazi: 14,
          dish_it_out: 15,
          battle_of_the_bands: 16
        };

        const event_id = eventMapping[eventId];
        if (!event_id) return res.status(400).send('Invalid event selected');

        // Insert into ParticRegistersFor
        const insertRegistration = `INSERT INTO ParticRegistersFor (P_id, Event_id) VALUES (?, ?)`;
        db.query(insertRegistration, [P_id, event_id], (err) => {
          if (err) return res.status(500).send('Error registering for event');

          res.send('Registration successful!');
        });
      });
    });
  });
});

app.post('/register-team', (req, res) => {
    const { participants } = req.body;
  
    // 1. Create a new team
    const insertTeam = `INSERT INTO Team () VALUES ()`;
    db.query(insertTeam, (err, teamResult) => {
      if (err) {
        console.error('Insert Team Error:', err);
        return res.status(500).send('Error creating team');
      }
      const T_id = teamResult.insertId;
  
      // 2. For each participant, insert into Participant, User, and ParticRegistersFor
      let completed = 0;
      let hasError = false;
  
      // Event mapping (should match your frontend eventId values)
      const eventMapping = {
        ai_hackathon: 1,
        web_dev: 2,
        genai_masterpiece: 3,
        edathon: 4,
        entrepreneurial_venture: 5,
        business_scavenger_hunt: 6,
        case_quest: 7,
        crypto: 8,
        squid_bizz: 9,
        nascon_fifa_frenzy: 10,
        tekken_iron_fist_championship: 11,
        nascon_valo_showdown: 12,
        nascon_got_talent: 13,
        bait_baazi: 14,
        dish_it_out: 15,
        battle_of_the_bands: 16
      };
  
      participants.forEach(participant => {
        // Insert into Participant
        const insertParticipant = `INSERT INTO Participant (UniversityName, PType, T_id) VALUES (?, 'team', ?)`;
        db.query(insertParticipant, [participant.institution, T_id], (err, partResult) => {
          if (err) {
            if (!hasError) {
              hasError = true;
              console.error('Insert Participant Error:', err);
              return res.status(500).send('Error inserting participant');
            }
            return;
          }
          const P_id = partResult.insertId;
  
          // Insert into User
          const insertUser = `INSERT INTO User (UName, Email, Address, Role, PhoneNo, P_id) VALUES (?, ?, ?, 'Participant', ?, ?)`;
          db.query(insertUser, [participant.name, participant.email, participant.address, participant.phone, P_id], (err) => {
            if (err) {
              if (!hasError) {
                hasError = true;
                console.error('Insert User Error:', err);
                return res.status(500).send('Error inserting user');
              }
              return;
            }
  
            // Insert into ParticRegistersFor
            const event_id = eventMapping[participant.eventId];
            if (!event_id) {
              if (!hasError) {
                hasError = true;
                return res.status(400).send('Invalid event selected');
              }
              return;
            }
            const insertRegistration = `INSERT INTO ParticRegistersFor (P_id, Event_id) VALUES (?, ?)`;
            db.query(insertRegistration, [P_id, event_id], (err) => {
              if (err) {
                if (!hasError) {
                  hasError = true;
                  console.error('Error registering for event:', err);
                  return res.status(500).send('Error registering for event');
                }
                return;
              }
  
              completed++;
              if (completed === participants.length && !hasError) {
                res.send('Team registration successful!');
              }
            });
          });
        });
      });
    });
  });

// Sponsor registration endpoint
app.post('/register-sponsor', (req, res) => {
  const { companyName, contactPerson, sponsorTier, sponsorship, phone, email, address } = req.body;
  const paymentStatus = 'False';

  // Map sponsor tier to Pack_id
  const packIdMapping = {
    'Platinum - PKR 500,000+': 1,
    'Gold - PKR 300,000': 2,
    'Silver - PKR 150,000': 4,
    'Bronze - PKR 75,000': 5
  };

  const packId = packIdMapping[sponsorTier];
  if (!packId) {
    return res.status(400).send('Invalid sponsor tier');
  }

  // First, ensure the sponsorship package exists
  const checkPackage = `SELECT Pack_id FROM SponsorshipPackage WHERE Pack_id = ?`;
  db.query(checkPackage, [packId], (err, results) => {
    if (err) {
      console.error('Check Package Error:', err);
      return res.status(500).send('Error checking sponsorship package');
    }

    if (results.length === 0) {
      // Package doesn't exist, create it
      const createPackage = `INSERT INTO SponsorshipPackage (Pack_id, PackName, Cost) VALUES (?, ?, ?)`;
      const packageName = sponsorTier.split(' - ')[0];  // e.g. "Silver"
      const amount = sponsorTier.split(' - ')[1].replace('PKR ', '').replace(/,/g, '');  // e.g. "150000"

      db.query(createPackage, [packId, packageName, amount], (err) => {
        if (err) {
          console.error('Create Package Error:', err);
          return res.status(500).send('Error creating sponsorship package');
        }
        insertSponsor();
      });
    } else {
      insertSponsor();
    }
  });

  function insertSponsor() {
    // Insert into Sponsor table
    const insertSponsor = `INSERT INTO Sponsor (Payment_status, ContactPerson, CompanyName, SponsorType, Pack_id) VALUES (?, ?, ?, ?, ?)`;
    db.query(insertSponsor, [paymentStatus, contactPerson, companyName, sponsorTier, packId], (err, result) => {
      if (err) {
        console.error('Insert Sponsor Error:', err);
        return res.status(500).send('Error inserting sponsor');
      }

      const S_id = result.insertId; // Get the new sponsor's ID

      // Insert into User table
      const insertUser = `INSERT INTO User (UName, Email, Address, Role, PhoneNo, S_id) VALUES (?, ?, ?, 'Sponsor', ?, ?)`;
      db.query(insertUser, [contactPerson, email, address, phone, S_id], (err) => {
        if (err) {
          console.error('Insert User Error:', err);
          return res.status(500).send('Error inserting user');
        }
        res.send('Sponsorship registration successful!');
      });
    });
  }
});

app.get('/api/participants-by-event', (req, res) => {
    // This query fetches all participants, their user info, event, and team (if any)
    const query = `
      SELECT 
        e.Event_id, e.Ename,
        u.UName, u.Email, u.Address, u.PhoneNo, u.Role,
        p.P_id, p.UniversityName, p.PType, p.T_id,
        t.T_id AS TeamID
      FROM Eventt e
      LEFT JOIN ParticRegistersFor prf ON e.Event_id = prf.Event_id
      LEFT JOIN Participant p ON prf.P_id = p.P_id
      LEFT JOIN User u ON u.P_id = p.P_id
      LEFT JOIN Team t ON p.T_id = t.T_id
      ORDER BY e.Event_id, p.PType, p.P_id
    `;
    db.query(query, (err, results) => {
      if (err) {
        console.error('Dashboard Query Error:', err);
        return res.status(500).json({ error: 'Error fetching participants' });
      }
      // Group by event
      const events = {};
      results.forEach(row => {
        if (!row.Event_id) return; // skip if no event
        if (!events[row.Ename]) events[row.Ename] = [];
        events[row.Ename].push(row);
      });
      res.json(events);
    });
  });
  app.get('/api/sponsors', (req, res) => {
    const query = `
      SELECT S_id, Payment_status, ContactPerson, CompanyName, SponsorType
      FROM Sponsor
      ORDER BY S_id DESC
    `;
    db.query(query, (err, results) => {
      if (err) {
        console.error('Sponsor Query Error:', err);
        return res.status(500).json({ error: 'Error fetching sponsors' });
      }
      res.json(results);
    });
  });

// Start server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
