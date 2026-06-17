import express, { Express, Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

const app: Express = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Health Check
app.get('/health', (req: Request, res: Response) => {
  res.json({ status: 'PolyLingua+ API is running' });
});

// Translation Endpoint
app.post('/api/translate', (req: Request, res: Response) => {
  const { text, sourceLang, targetLang } = req.body;
  // TODO: Implement translation using Google Translate API
  res.json({ translatedText: text });
});

// Language Detection Endpoint
app.post('/api/detect-language', (req: Request, res: Response) => {
  const { text } = req.body;
  // TODO: Implement language detection
  res.json({ language: 'en' });
});

app.listen(PORT, () => {
  console.log(`✅ PolyLingua+ API running on port ${PORT}`);
});