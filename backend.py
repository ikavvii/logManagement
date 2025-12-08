# backend.py
import mysql.connector

class LogManagementDB:
    def __init__(self):
        self.conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="Smilyoracle@19",
            database="logManagement"
        )
        self.cursor = self.conn.cursor(dictionary=True)

    # Normalize roll number to uppercase
    def normalize_roll(self, roll_no):
        return roll_no.upper().strip()

    # Get student_id from roll_no (case-insensitive)
    def get_student_id(self, roll_no):
        roll_no = self.normalize_roll(roll_no)
        query = "SELECT student_id FROM student WHERE UPPER(roll_no) = %s"
        self.cursor.execute(query, (roll_no,))
        result = self.cursor.fetchone()
        return result["student_id"] if result else None

    # Get student details
    def get_student_details(self, roll_no):
        roll_no = self.normalize_roll(roll_no)
        query = "SELECT * FROM student WHERE UPPER(roll_no) = %s"
        self.cursor.execute(query, (roll_no,))
        return self.cursor.fetchone()

    # Get active sessions
    def get_active_sessions(self):
        query = """
        SELECT 
            student.roll_no,
            student.name,
            system_unit.system_name,
            logs.in_time
        FROM logs
        JOIN student ON logs.student_id = student.student_id
        JOIN system_unit ON logs.system_id = system_unit.system_id
        WHERE logs.out_time IS NULL;
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    # Get systems under a specific lab prefix (IS, CC, CAT)
    def get_systems_by_lab(self, lab_prefix):
        query = """
        SELECT system_id, system_name 
        FROM system_unit 
        WHERE system_name LIKE %s AND status='active'
        ORDER BY system_name
        """
        self.cursor.execute(query, (lab_prefix + "%",))
        return self.cursor.fetchall()

    # Check if system is already in use
    def is_system_active(self, system_id):
        query = """
        SELECT * FROM logs 
        WHERE system_id = %s AND out_time IS NULL
        """
        self.cursor.execute(query, (system_id,))
        return self.cursor.fetchone()

    # Check if student has an active session
    def has_active_session(self, student_id):
        query = "SELECT * FROM logs WHERE student_id = %s AND out_time IS NULL"
        self.cursor.execute(query, (student_id,))
        return self.cursor.fetchone()

    # Student check-in
    def check_in(self, student_id, system_id):
        query = "INSERT INTO logs (student_id, system_id) VALUES (%s, %s)"
        self.cursor.execute(query, (student_id, system_id))
        self.conn.commit()

    # Student check-out
    def check_out(self, student_id):
        query = """
        UPDATE logs 
        SET out_time = NOW()
        WHERE student_id = %s AND out_time IS NULL
        """
        self.cursor.execute(query, (student_id,))
        self.conn.commit()

    # Total hours of a student
    def get_total_hours(self, student_id):
        query = """
        SELECT SUM(TIMESTAMPDIFF(MINUTE, in_time, out_time)) AS minutes_spent
        FROM logs
        WHERE student_id = %s AND out_time IS NOT NULL
        """
        self.cursor.execute(query, (student_id,))
        result = self.cursor.fetchone()

        if not result or result["minutes_spent"] is None:
            return 0

        return round(result["minutes_spent"] / 60, 2)
