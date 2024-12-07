const { registerCommand } = require('chatlib');
const fetch = require('node-fetch');

const API_KEY = 'your-api-key-here';

registerCommand({
  command: 'accountcreated',
  aliases: ['accountdate'],
  description: 'Fetches the account creation date from Hypixel API',
  usage: '/accountcreated',
  async callback() {
    const playerName = Player.getName();
    
    try {
      const response = await fetch(`https://api.hypixel.net/player?key=${API_KEY}&name=${playerName}`);
      const data = await response.json();

      if (data.success) {
        const accountCreationDate = new Date(data.player.firstLogin);
        const formattedDate = accountCreationDate.toLocaleDateString('en-US');
        ChatLib.chat(`Your account was created on: ${formattedDate}`);
      } else {
        ChatLib.chat('Could not fetch account creation date. Please try again.');
      }
    } catch (error) {
      ChatLib.chat('An error occurred while fetching account data.');
      console.error(error);
    }
  },
});
