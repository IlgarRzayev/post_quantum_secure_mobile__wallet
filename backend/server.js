const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// MySQL bağlantı bilgileri
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'Ilgar*2023',
  database: 'digital_wallet',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Token kaydetme endpoint'i
app.post('/store_token', async (req, res) => {
  if (!req.body.data) {
    return res.status(400).json({ success: false, message: 'Şifrelenmiş veri gerekiyor' });
  }

  try {
    const connection = await pool.getConnection();
    await connection.query('INSERT INTO payments (token) VALUES (?)', [req.body.data]);
    connection.release();
    res.status(200).json({ success: true, message: 'Şifrelenmiş veri başarıyla kaydedildi' });
  } catch (error) {
    console.error('Veritabanı hatası:', error);
    res.status(500).json({ success: false, message: 'Sunucu hatası' });
  }
});

// Sunucuyu başlat
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Sunucu http://localhost:${PORT} adresinde çalışıyor`);
});
