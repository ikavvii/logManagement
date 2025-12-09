# Lab Log Management System - Streamlit Cloud Deployment

## Deploy to Streamlit Cloud (FREE)

**Steps:**

1. **Push code to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/yourusername/logManagement.git
   git push -u origin main
   ```

2. **Deploy on Streamlit Cloud:**
   - Go to [share.streamlit.io](https://share.streamlit.io)
   - Sign in with GitHub
   - Click "New app"
   - Select your repository: `yourusername/logManagement`
   - Main file path: `app.py`
   - Click "Deploy"

3. **Add Secrets (Environment Variables):**
   - In Streamlit Cloud dashboard, click on your app
   - Go to Settings → Secrets
   - Add your credentials:
   ```toml
   SUPABASE_URL = "your_supabase_url"
   SUPABASE_KEY = "your_supabase_anon_key"
   ```
   - Save and the app will restart automatically

## Why Streamlit Cloud?
- ✅ **100% Free** forever
- ✅ **Easiest setup** (3 minutes to deploy)
- ✅ **Auto-updates** when you push to GitHub
- ✅ **Built-in secrets management**
- ✅ **Perfect for Streamlit apps**
- ✅ **Custom domain support**
- ✅ **No server management needed**
- ✅ **Automatic HTTPS**
- ✅ **No credit card required**

## Troubleshooting

### App won't start
- Check that your Supabase credentials are correct in Secrets
- Make sure you've run the `supabase_setup.sql` script in Supabase
- Check the logs in Streamlit Cloud dashboard

### Database connection errors
- Verify your `SUPABASE_URL` format: `https://xxxxx.supabase.co`
- Verify your `SUPABASE_KEY` is the **anon/public** key, not the service key
- Check that RLS policies are enabled in Supabase

### Need help?
- Check the [Streamlit Community Forum](https://discuss.streamlit.io/)
- Review [Streamlit Cloud docs](https://docs.streamlit.io/streamlit-community-cloud)
