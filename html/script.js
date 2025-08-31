function toggleScoreboard(show) {
    const scoreboard = document.getElementById('scoreboard');

    if (!scoreboard) return;

    if (show) {
        scoreboard.style.display = 'block';
        scoreboard.style.animation = 'flyInFromTop 0.6s ease-out';

        // Reset animation after it finishes so it can be reapplied next time
        setTimeout(() => {
            scoreboard.style.animation = '';
        }, 600);

        document.body.style.backgroundColor = 'rgba(0, 0, 0, 0.75)';
    } else {
        scoreboard.style.display = 'none';
        document.body.style.backgroundColor = 'transparent';
    }
}

// Wait for DOM to load before binding events
document.addEventListener('DOMContentLoaded', () => {
    const closeButton = document.getElementById('closeButton');

    if (closeButton) {
        closeButton.addEventListener('click', () => {
            toggleScoreboard(false);

            // Notify Lua to close scoreboard
            fetch(`https://${GetParentResourceName()}/close`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });
        });
    }
});

// Listen for messages from Lua
window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.type === "open") {
        toggleScoreboard(true);
    } else if (data.type === "close") {
        toggleScoreboard(false);
    } else if (data.type === "update") {
        updateScoreboard(data);
    }
});

// Function to update scoreboard data
function updateScoreboard(data) {
    // Example: update player counts or department stats
    document.getElementById('playerCount').textContent = data.players || 0;
    document.getElementById('policeCount').textContent = data.police || 0;
    document.getElementById('medicCount').textContent = data.medics || 0;
    document.getElementById('taxiCount').textContent = data.taxis || 0;
    document.getElementById('municipalCount').textContent = data.municipal || 0;
    document.getElementById('heistCount').textContent = data.heists || 0;
}