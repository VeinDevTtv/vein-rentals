<script lang="ts">
  import { pop } from 'svelte-spa-router';
  import { activeRentals } from '../stores/appStore';
  
  // Return a vehicle
  function returnVehicle(rentalId) {
    fetch('https://vein-rentals/returnVehicle', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ rentalId })
    }).then(response => response.json())
      .then(data => {
        if (data.success) {
          // Rental returned successfully
          // The server will update the activeRentals store
        }
      });
  }
  
  // Go back to main menu
  function goBack() {
    pop();
  }
</script>

<div class="active-rentals">
  <button class="back-btn" on:click={goBack}>
    <span class="mdi mdi-arrow-left"></span>
    Back to Vehicles
  </button>
  
  <h2>My Active Rentals</h2>
  
  {#if $activeRentals && $activeRentals.length > 0}
    <div class="rentals-list">
      {#each $activeRentals as rental}
        <div class="rental-card">
          <div class="rental-info">
            <h3>{rental.model}</h3>
            <p class="plate">Plate: {rental.plate}</p>
            
            {#if rental.isOverdue}
              <div class="status overdue">
                <span class="mdi mdi-alert-circle"></span>
                <span>Overdue: {rental.timeOverdue}</span>
              </div>
              <div class="late-fee">
                <span>Late Fee: ${rental.lateFee}</span>
              </div>
            {:else}
              <div class="status active">
                <span class="mdi mdi-clock-outline"></span>
                <span>Time Remaining: {rental.timeRemaining}</span>
              </div>
            {/if}
          </div>
          
          <div class="rental-actions">
            <button 
              class="return-btn" 
              class:overdue={rental.isOverdue}
              on:click={() => returnVehicle(rental.id)}
            >
              Return Vehicle
            </button>
          </div>
        </div>
      {/each}
    </div>
  {:else}
    <div class="no-rentals">
      <span class="mdi mdi-car-off"></span>
      <p>You don't have any active rentals</p>
      <button class="browse-btn" on:click={goBack}>Browse Vehicles</button>
    </div>
  {/if}
</div>

<style>
  .active-rentals {
    display: flex;
    flex-direction: column;
    height: 100%;
  }
  
  .back-btn {
    background: none;
    border: none;
    display: flex;
    align-items: center;
    gap: 5px;
    cursor: pointer;
    font-weight: 500;
    color: var(--color-primary);
    padding: 0;
    margin-bottom: 20px;
    width: fit-content;
  }
  
  h2 {
    margin: 0 0 20px 0;
    font-weight: 500;
    color: var(--color-primary);
  }
  
  .rentals-list {
    display: flex;
    flex-direction: column;
    gap: 15px;
    overflow-y: auto;
    flex: 1;
  }
  
  .rental-card {
    background-color: white;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .rental-info {
    flex: 1;
  }
  
  .rental-info h3 {
    margin: 0 0 5px 0;
    font-weight: 500;
  }
  
  .plate {
    color: #616161;
    margin: 0 0 10px 0;
    font-size: 14px;
  }
  
  .status {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 14px;
    margin-bottom: 5px;
  }
  
  .status.active {
    color: var(--color-accent);
  }
  
  .status.overdue {
    color: var(--color-secondary);
  }
  
  .late-fee {
    font-size: 14px;
    color: var(--color-secondary);
    font-weight: 500;
  }
  
  .rental-actions {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .return-btn {
    padding: 8px 15px;
    background-color: var(--color-primary);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.2s;
  }
  
  .return-btn:hover {
    background-color: var(--color-secondary);
  }
  
  .return-btn.overdue {
    background-color: var(--color-secondary);
  }
  
  .no-rentals {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: #616161;
    gap: 15px;
  }
  
  .no-rentals .mdi {
    font-size: 48px;
    color: #bdbdbd;
  }
  
  .no-rentals p {
    margin: 0;
    font-size: 18px;
  }
  
  .browse-btn {
    margin-top: 15px;
    padding: 10px 20px;
    background-color: var(--color-primary);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.2s;
  }
  
  .browse-btn:hover {
    background-color: var(--color-accent);
  }
</style> 