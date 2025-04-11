import { writable } from 'svelte/store';

// UI visibility
export const visible = writable(false);

// Current rental location
export const location = writable('');

// Available vehicle categories at the current location
export const categories = writable([]);

// Available vehicles in the selected category
export const vehicles = writable([]);

// Currently selected vehicle details
export const selectedVehicle = writable(null);

// Available rental durations
export const rentalDurations = writable([]);

// Active rentals for the player
export const activeRentals = writable([]);

// Player's loyalty points
export const loyaltyPoints = writable(0);

// Current loyalty discount
export const loyaltyDiscount = writable(0); 