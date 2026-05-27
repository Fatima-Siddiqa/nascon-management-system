function toggleTeamFields() {
    const registrationType = document.getElementById('registration-type').value;
    const addButton = document.getElementById('add-participant');
    
    if (registrationType === 'team') {
      addButton.style.display = 'inline-block';
    } else {
      addButton.style.display = 'none';
      const participants = document.getElementById('participants');
      participants.innerHTML = participants.querySelector('.participant').outerHTML; // keep only one
    }
  }
  
  document.getElementById('add-participant').addEventListener('click', function() {
    const participants = document.getElementById('participants');
    const count = participants.querySelectorAll('.participant').length + 1;
    
    const newParticipant = document.createElement('div');
    newParticipant.classList.add('participant');
    newParticipant.innerHTML = `
      <h3>Participant ${count}</h3>
      <div class="form-group">
        <label>Name:</label>
        <input type="text" name="name[]" required>
      </div>
      <div class="form-group">
        <label>Institution Name:</label>
        <input type="text" name="institution[]" required>
      </div>
      <div class="form-group">
        <label>Phone Number:</label>
        <input type="tel" name="phone[]" required>
      </div>
      <div class="form-group">
        <label>CNIC:</label>
        <input type="text" name="cnic[]" required>
      </div>
      <div class="form-group">
        <label>Email:</label>
        <input type="email" name="email[]" required>
      </div>
      <div class="form-group">
        <label>Event Name:</label>
        <select name="eventId[]" required>
          <option value="ai_hackathon">AI HACKATHON</option>
          <option value="web_dev">WEB DEV</option>
          <option value="genai_masterpiece">GENAI MASTERPIECE</option>
          <option value="edathon">EDATHON</option>
          <option value="entrepreneurial_venture">ENTREPRENEURIAL VENTURE</option>
          <option value="business_scavenger_hunt">BUSINESS SCAVENGER HUNT</option>
          <option value="case_quest">CASE QUEST</option>
          <option value="crypto">CRYPTO</option>
          <option value="squid_bizz">SQUID BIZZ</option>
          <option value="nascon_fifa_frenzy">NASCON FIFA FRENZY</option>
          <option value="tekken_iron_fist_championship">TEKKEN IRON FIST CHAMPIONSHIP</option>
          <option value="nascon_valo_showdown">NASCON VALO SHOWDOWN</option>
          <option value="nascon_got_talent">NASCON GOT TALENT</option>
          <option value="bait_baazi">BAIT BAAZI</option>
          <option value="dish_it_out">DISH IT OUT</option>
          <option value="battle_of_the_bands">BATTLE OF THE BANDS</option>
        </select>
      </div>

      <div class="form-group">
        <label>Address:</label>
        <input type="text" name="address[]" required>
      </div>
        <div style="display: flex; gap: 30px; margin-top: 8px;">
        <label style="display: flex; align-items: center;">
          <input type="radio" name="accommodation${count}" value="yes" required style="margin-right: 6px;"> Yes
        </label>
        <label style="display: flex; align-items: center;">
          <input type="radio" name="accommodation${count}" value="no" required style="margin-right: 6px;"> No
        </label>
      </div>
    `;
    
    participants.appendChild(newParticipant);
  });
  