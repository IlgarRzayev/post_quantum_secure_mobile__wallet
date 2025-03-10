const express = require('express');
const Stripe = require('stripe');
const app = express();
const stripe = Stripe('sk_test_51R0kQrQAJX5ewLgAcHKR3nuYvgzJCKONuaRoJfiWZwJaeMCUcefylPyczjuTGfjMHjHi1LiCEeBbAmYdx7gSgkEE003vHT3Lt2'); // Stripe Secret Key

app.use(express.json());

app.post('/create-payment-intent', async (req, res) => {
  const { amount, currency } = req.body;

  try {
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount,
      currency: currency,
      payment_method_types: ['card'],
    });

    res.send({
      client_secret: paymentIntent.client_secret,
    });
  } catch (error) {
    res.status(400).send({ error: error.message });
  }
});

app.listen(3000, () => console.log('Backend running on port 3000'));
