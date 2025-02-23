// backend/index.js
require('dotenv').config();
const express = require('express');
const axios = require('axios');
const app = express();
const port = process.env.PORT || 3001;

app.use(express.json());

// Example endpoint to fetch validator performance data using Dune Analytics (EigenLayer)
app.get('/api/performance', async (req, res) => {
    try {
        const response = await axios.get('https://api.dune.com/api/v1/eigenlayer/avs-metadata', {
            headers: { 'X-Dune-Api-Key': process.env.DUNE_API_KEY }
        });
        res.json(response.data);
    } catch (error) {
        res.status(500).send('Error fetching performance data: ' + error.toString());
    }
});

// Example endpoint to compute a simple AVS performance score
app.get('/api/score', async (req, res) => {
    try {
        // Fetch performance and liquidity data concurrently (or from your DB if already stored)
        const [performanceResponse, liquidityResponse] = await Promise.all([
            axios.get('http://localhost:3001/api/performance'),
            axios.get('http://localhost:3001/api/liquidity')
        ]);

        // Extract and normalize data (pseudocode – adjust based on your API responses)
        const uptime = performanceResponse.data.uptime || 0.99; // Example value
        const slashingRate = performanceResponse.data.slashingRate || 0.01; // Example value
        const liquidity = liquidityResponse.data.data.pools[0].liquidity || 0;

        // Weighted scoring: Adjust weights as needed
        const uptimeScore = uptime * 0.5;
        const slashingScore = (1 - slashingRate) * 0.3;
        const liquidityScore = (liquidity / 1e6) * 0.2; // Assume normalization of liquidity

        const totalScore = uptimeScore + slashingScore + liquidityScore;
        res.json({ totalScore });
    } catch (error) {
        res.status(500).send('Error calculating score: ' + error.toString());
    }
});

app.get('/api/test-dune', async (req, res) => {
    try {
        const response = await axios.get('https://api.dune.com/api/v1/eigenlayer/avs-metadata', {
            headers: { 'X-Dune-Api-Key': process.env.DUNE_API_KEY }
        });
        res.json(response.data);
    } catch (error) {
        res.status(500).send('Error testing Dune API: ' + error.toString());
    }
});

app.listen(port, () => {
    console.log(`Backend server listening on port ${port}`);
});