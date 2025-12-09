import os
from supabase import create_client, Client
from dotenv import load_dotenv

class LogManagementDB:
    def __init__(self):
        # Load environment variables from .env file
        load_dotenv()
        supabase_url = os.environ.get("SUPABASE_URL")
        supabase_key = os.environ.get("SUPABASE_KEY")
        self.client: Client = create_client(supabase_url, supabase_key)

    # normalize roll number
    def normalize_roll(self, roll_no):
        return roll_no.upper().strip()

    # get student_id from roll_no
    def get_student_id(self, roll_no):
        roll_no = self.normalize_roll(roll_no)
        result = self.client.table("student").select("student_id").ilike("roll_no", roll_no).execute()
        return result.data[0]["student_id"] if result.data else None

    # get student details
    def get_student_details(self, roll_no):
        roll_no = self.normalize_roll(roll_no)
        result = self.client.table("student").select("*").ilike("roll_no", roll_no).execute()
        return result.data[0] if result.data else None

    # get active sessions
    def get_active_sessions(self):
        result = self.client.table("logs").select(
            "in_time, student(roll_no, name), system_unit(system_name)"
        ).is_("out_time", "null").execute()
        
        sessions = []
        for log in result.data:
            sessions.append({
                "roll_no": log["student"]["roll_no"],
                "name": log["student"]["name"],
                "system_name": log["system_unit"]["system_name"],
                "in_time": log["in_time"]
            })
        return sessions

    # get systems under specific lab prefix
    def get_systems_by_lab(self, lab_prefix):
        result = self.client.table("system_unit").select(
            "system_id, system_name"
        ).eq("status", "active").like("system_name", f"{lab_prefix}%").order("system_name").execute()
        return result.data

    # check if system is active
    def is_system_active(self, system_id):
        result = self.client.table("logs").select("*").eq(
            "system_id", system_id
        ).is_("out_time", "null").execute()
        return result.data[0] if result.data else None

    # check if student has active session
    def has_active_session(self, student_id):
        result = self.client.table("logs").select(
            "in_time, system_unit(system_name)"
        ).eq("student_id", student_id).is_("out_time", "null").execute()
        
        if result.data:
            log = result.data[0]
            return {
                "in_time": log["in_time"],
                "system_name": log["system_unit"]["system_name"]
            }
        return None

    # student check-in
    def check_in(self, student_id, system_id):
        self.client.table("logs").insert({
            "student_id": student_id,
            "system_id": system_id
        }).execute()

    # student check-out
    def check_out(self, student_id):
        from datetime import datetime
        self.client.table("logs").update({
            "out_time": datetime.now().isoformat()
        }).eq("student_id", student_id).is_("out_time", "null").execute()

    # total hours of a student
    def get_total_hours(self, student_id):
        from datetime import datetime
        result = self.client.table("logs").select(
            "in_time, out_time"
        ).eq("student_id", student_id).not_.is_("out_time", "null").execute()
        
        total_minutes = 0
        for log in result.data:
            in_time = datetime.fromisoformat(log["in_time"].replace("Z", "+00:00"))
            out_time = datetime.fromisoformat(log["out_time"].replace("Z", "+00:00"))
            total_minutes += (out_time - in_time).total_seconds() / 60
        
        return round(total_minutes / 60, 2)
