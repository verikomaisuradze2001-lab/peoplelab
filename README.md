# PeopleLab V4.2 — Supabase onboarding

1. In Supabase: Authentication → Sign In / Providers → Anonymous → Enable.
2. In this folder create `.env.local`:
   VITE_SUPABASE_URL=your-project-url
   VITE_SUPABASE_PUBLISHABLE_KEY=your-publishable-key
3. Run `npm install`
4. Run `npm run dev`

The Onboarding Hub now stores employees and tasks in Supabase instead of localStorage.
