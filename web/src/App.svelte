<script lang="ts">
  import { onMount } from 'svelte';
  import Router from 'svelte-spa-router';
  import { wrap } from 'svelte-spa-router/wrap';
  
  // Pages
  import MainMenu from './pages/MainMenu.svelte';
  import VehicleDetails from './pages/VehicleDetails.svelte';
  import ActiveRentals from './pages/ActiveRentals.svelte';
  
  // State
  import { visible, location, categories, activeRentals, loyaltyPoints } from './stores/appStore';
  
  // NUI Message handler
  let colors = {
    primary: "#3f51b5",
    secondary: "#f44336",
    accent: "#4caf50",
    background: "#f5f5f5",
    text: "#212121"
  };
  
  // Routes
  const routes = {
    '/': wrap({
      component: MainMenu
    }),
    '/vehicle/:model': wrap({
      component: VehicleDetails
    }),
    '/active-rentals': wrap({
      component: ActiveRentals
    })
  };
  
  // NUI Messages
  window.addEventListener('message', (event) => {
    const data = event.data;
    
    switch (data.action) {
      case 'openRentalMenu':
        $location = data.data.location;
        $categories = data.data.categories;
        $activeRentals = data.data.activeRentals;
        $loyaltyPoints = data.data.loyaltyPoints;
        $visible = true;
        break;
        
      case 'updateVehicles':
        // Will be handled by specific components
        break;
        
      case 'updateConfig':
        colors = data.data.colors;
        updateCssVariables();
        break;
        
      case 'updateActiveRentals':
        $activeRentals = data.data;
        break;
        
      case 'notification':
        showNotification(data.data.message, data.data.type);
        break;
    }
  });
  
  function updateCssVariables() {
    document.documentElement.style.setProperty('--color-primary', colors.primary);
    document.documentElement.style.setProperty('--color-secondary', colors.secondary);
    document.documentElement.style.setProperty('--color-accent', colors.accent);
    document.documentElement.style.setProperty('--color-background', colors.background);
    document.documentElement.style.setProperty('--color-text', colors.text);
  }
  
  function hideUI() {
    $visible = false;
    fetch('https://vein-rentals/closeMenu', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({})
    });
  }
  
  function showNotification(message, type) {
    // Simple notification system - can be expanded
    const notification = document.createElement('div');
    notification.className = `notification ${type} fade-in`;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
      notification.classList.remove('fade-in');
      notification.classList.add('fade-out');
      
      setTimeout(() => {
        document.body.removeChild(notification);
      }, 300);
    }, 3000);
  }
  
  onMount(() => {
    updateCssVariables();
    
    // Tell the NUI that we're ready
    fetch('https://vein-rentals/nuiReady', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({})
    });
    
    // Handle escape key
    window.addEventListener('keyup', (e) => {
      if (e.key === 'Escape') {
        hideUI();
      }
    });
  });
</script>

<main class:visible={$visible}>
  <div class="container fade-in slide-up">
    <div class="header">
      <h1>Premium Vehicle Rentals</h1>
      <h2>{$location}</h2>
      <div class="loyalty-points">
        <span class="mdi mdi-star"></span>
        <span>{$loyaltyPoints} Loyalty Points</span>
      </div>
      <button class="close-btn" on:click={hideUI}>
        <span class="mdi mdi-close"></span>
      </button>
    </div>
    
    <div class="content">
      <Router {routes} />
    </div>
  </div>
</main>

<style>
  main {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: none;
    justify-content: center;
    align-items: center;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 999;
  }
  
  main.visible {
    display: flex;
  }
  
  .container {
    width: 80%;
    max-width: 1200px;
    height: 80%;
    background-color: var(--color-background);
    border-radius: 8px;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
  }
  
  .header {
    background-color: var(--color-primary);
    color: white;
    padding: 20px;
    display: flex;
    flex-direction: column;
    position: relative;
  }
  
  h1 {
    font-size: 24px;
    margin: 0;
    font-weight: 500;
  }
  
  h2 {
    font-size: 16px;
    margin: 4px 0 0 0;
    font-weight: 400;
    opacity: 0.9;
  }
  
  .loyalty-points {
    position: absolute;
    top: 20px;
    right: 60px;
    display: flex;
    align-items: center;
    font-size: 16px;
  }
  
  .loyalty-points .mdi {
    color: gold;
    margin-right: 5px;
  }
  
  .close-btn {
    position: absolute;
    top: 16px;
    right: 16px;
    background: none;
    border: none;
    color: white;
    font-size: 24px;
    cursor: pointer;
    outline: none;
  }
  
  .content {
    flex: 1;
    overflow: auto;
    padding: 20px;
  }
  
  .notification {
    position: fixed;
    bottom: 20px;
    right: 20px;
    padding: 12px 20px;
    border-radius: 4px;
    color: white;
    font-weight: 500;
    z-index: 1000;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  }
  
  .notification.info {
    background-color: var(--color-primary);
  }
  
  .notification.success {
    background-color: var(--color-accent);
  }
  
  .notification.warning {
    background-color: #f9a825;
  }
  
  .notification.error {
    background-color: var(--color-secondary);
  }
</style> 