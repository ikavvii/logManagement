import streamlit as st
from backend import LogManagementDB

db = LogManagementDB()

st.title("💻 Lab Log Management System")

menu = st.sidebar.radio(
    "Navigation",
    ["Student Login", "Student Logout", "Active Sessions", "View Student Details", "View Total Hours"]
)

# student login
if menu == "Student Login":
    st.header("Student Login")

    roll_no = st.text_input("Enter Roll Number")

    if roll_no:
        student_id = db.get_student_id(roll_no)

        if not student_id:
            st.error("Student not found!")
        else:
            active = db.has_active_session(student_id)

            if active:
                st.warning("You are already logged in.")
                st.info(f"System: {active['system_name']}")
                st.info(f"In Time: {active['in_time']}")
            else:
                lab_choice = st.selectbox("Select Lab", ["Select", "IS", "CC", "CAT"])

                if lab_choice != "Select":
                    systems = db.get_systems_by_lab(lab_choice)
                    system_dict = {s["system_name"]: s["system_id"] for s in systems}

                    system = st.selectbox("Select System", list(system_dict.keys()))

                    if st.button("LOGIN"):
                        sys_id = system_dict[system]

                        if db.is_system_active(sys_id):
                            st.error("System already in use!")
                        else:
                            db.check_in(student_id, sys_id)
                            st.success(f"Logged in to {system}")

# student logout
if menu == "Student Logout":
    st.header("Student Logout")

    roll_no = st.text_input("Enter Roll Number to Logout")

    if roll_no:
        student_id = db.get_student_id(roll_no)

        if not student_id:
            st.error("Student not found!")
        else:
            active = db.has_active_session(student_id)

            if not active:
                st.warning("You are not logged in!")
            else:
                st.info(f"System: {active['system_name']}")
                st.info(f"In Time: {active['in_time']}")

                if st.button("LOGOUT"):
                    db.check_out(student_id)
                    st.success("Logout successful")

# active sessions
if menu == "Active Sessions":
    st.header("Active Sessions")

    sessions = db.get_active_sessions()
    if sessions:
        st.table(sessions)
    else:
        st.info("No active sessions.")

# student details
if menu == "View Student Details":
    st.header("Student Details")

    roll_no = st.text_input("Enter Roll Number")

    if roll_no:
        details = db.get_student_details(roll_no)
        if details:
            st.json(details)
        else:
            st.error("Student not found.")

# total hours
if menu == "View Total Hours":
    st.header("Total Logged Hours")

    roll_no = st.text_input("Enter Roll Number")

    if roll_no:
        student_id = db.get_student_id(roll_no)

        if not student_id:
            st.error("Student not found.")
        else:
            hours = db.get_total_hours(student_id)
            st.success(f"Total Hours Logged: {hours} hours")
