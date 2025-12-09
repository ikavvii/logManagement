# Lab Log Management System

A Streamlit-based application for managing student login/logout sessions in computer labs, powered by Supabase.

🔗 **[View Deployment Guide](DEPLOYMENT.md)**

## Features

- 🔐 Student login/logout to lab systems
- 📊 View active sessions in real-time
- 👤 Student details lookup
- ⏱️ Track total hours logged per student
- 🏢 Manage multiple labs (IS, CC, CAT) with 62 systems each

## Quick Deploy (3 minutes)

### Streamlit Community Cloud (Recommended - FREE)

1. **Fork/Push this repo to GitHub**
2. **Go to [share.streamlit.io](https://share.streamlit.io)**
3. **Click "New app" and select your repo**
4. **Add secrets** (Settings → Secrets):
   ```toml
   SUPABASE_URL = "your_supabase_url"
   SUPABASE_KEY = "your_supabase_anon_key"
   ```
5. **Click Deploy!** 🚀

**[Full deployment guide with all options →](DEPLOYMENT.md)**

## Local Setup

### 1. Supabase Setup

1. Create a new project at [supabase.com](https://supabase.com)
2. Go to the SQL Editor in your Supabase dashboard
3. Copy and paste the contents of `supabase_setup.sql`
4. Run the SQL script to create tables and insert sample data
5. Get your project URL and anon key from Settings > API

### 2. Local Development

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd logManagement-master
   ```

2. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/Scripts/activate  # Windows Git Bash
   # or
   source venv/bin/activate       # Linux/Mac
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure environment variables**
   ```bash
   cp .env.example .env
   # Edit .env and add your Supabase credentials
   ```

5. **Run the application**
   ```bash
   streamlit run app.py
   ```

## Usage

### Student Login
1. Navigate to "Student Login" in the sidebar
2. Enter your roll number
3. Select lab (IS/CC/CAT) and available system
4. Click LOGIN

### Student Logout
1. Navigate to "Student Logout"
2. Enter your roll number
3. Click LOGOUT

### View Active Sessions
- Shows all currently logged-in students with their system assignments

### View Student Details
- Look up student information by roll number

### View Total Hours
- Check total lab hours logged for any student

## Database Schema

- **student**: Student information (roll_no, name, department, email, phone, group)
- **lab**: Lab details (lab_name, room_no, capacity)
- **system_unit**: Computer systems in each lab (system_name, lab_id, status)
- **logs**: Login/logout records (student_id, system_id, in_time, out_time)

## Technologies Used

- **Streamlit**: Web interface
- **Supabase**: PostgreSQL database and backend
- **Python 3.8+**

## Deployment

This app is designed for **Streamlit Community Cloud** (FREE).

**[See deployment guide →](DEPLOYMENT.md)**

## Environment Variables

```
SUPABASE_URL=your_supabase_project_url
SUPABASE_KEY=your_supabase_anon_key
```

## License

MIT License
