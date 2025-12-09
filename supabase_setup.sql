-- Supabase SQL Setup for Lab Log Management System
-- Run this in your Supabase SQL Editor

-- Create student table
CREATE TABLE student (
    student_id BIGSERIAL PRIMARY KEY,
    roll_no VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(200) NOT NULL,
    department VARCHAR(100),
    email VARCHAR(200),
    phone VARCHAR(20),
    student_group VARCHAR(2) CHECK (student_group IN ('G1', 'G2')) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create lab table
CREATE TABLE lab (
    lab_id BIGSERIAL PRIMARY KEY,
    lab_name VARCHAR(200) NOT NULL,
    room_no VARCHAR(200),
    capacity INT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create system_unit table
CREATE TABLE system_unit (
    system_id BIGSERIAL PRIMARY KEY,
    lab_id BIGINT NOT NULL REFERENCES lab(lab_id) ON UPDATE CASCADE ON DELETE CASCADE,
    system_name VARCHAR(100) NOT NULL,
    ip_address VARCHAR(50),
    status VARCHAR(10) CHECK (status IN ('active', 'inactive')) DEFAULT 'active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create logs table
CREATE TABLE logs (
    log_id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL REFERENCES student(student_id) ON UPDATE CASCADE ON DELETE CASCADE,
    system_id BIGINT NOT NULL REFERENCES system_unit(system_id) ON UPDATE CASCADE ON DELETE CASCADE,
    in_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    out_time TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_student_roll_no ON student(roll_no);
CREATE INDEX idx_logs_student_id ON logs(student_id);
CREATE INDEX idx_logs_system_id ON logs(system_id);
CREATE INDEX idx_logs_out_time ON logs(out_time);
CREATE INDEX idx_system_unit_status ON system_unit(status);

-- Insert sample students (MCA 2025 batch)
INSERT INTO student (roll_no, name, department, email, phone, student_group) VALUES
('25MX101', 'BALAJI K', 'MCA', '25MX101@psgtech.ac.in', '9080078901', 'G1'),
('25MX102', 'BALASUBRAMANIAM S', 'MCA', '25MX102@psgtech.ac.in', '8248850487', 'G1'),
('25MX103', 'BARATHVIKRAMAN S K', 'MCA', '25MX103@psgtech.ac.in', '8148251567', 'G1'),
('25MX104', 'DEEPIKAA B S', 'MCA', '25MX104@psgtech.ac.in', '9159346366', 'G1'),
('25MX105', 'DIVYA R', 'MCA', '25MX105@psgtech.ac.in', '9345575709', 'G1'),
('25MX106', 'DIVYADHARSHINI K', 'MCA', '25MX106@psgtech.ac.in', '6374101188', 'G1'),
('25MX107', 'G SHREE NIVETHA', 'MCA', '25MX107@psgtech.ac.in', '8248227165', 'G1'),
('25MX108', 'GOBBIKA J M', 'MCA', '25MX108@psgtech.ac.in', '9360488987', 'G1'),
('25MX109', 'GOPINATH R G', 'MCA', '25MX109@psgtech.ac.in', '9345071553', 'G1'),
('25MX110', 'HARIKESAN D J', 'MCA', '25MX110@psgtech.ac.in', '9894130378', 'G1'),
('25MX111', 'JARJILA DENET J', 'MCA', '25MX111@psgtech.ac.in', '9791483267', 'G1'),
('25MX112', 'KAAVYA R', 'MCA', '25MX112@psgtech.ac.in', '6382760741', 'G1'),
('25MX113', 'KALEEL UR RAHMAN H', 'MCA', '25MX113@psgtech.ac.in', '9500621265', 'G1'),
('25MX114', 'KAVIN M', 'MCA', '25MX114@psgtech.ac.in', '8825748664', 'G1'),
('25MX115', 'KRISHNAPRIYA M S', 'MCA', '25MX115@psgtech.ac.in', '9344630759', 'G1'),
('25MX116', 'MIRUNA M V', 'MCA', '25MX116@psgtech.ac.in', '9360232695', 'G1'),
('25MX117', 'MOHANKUMAR P', 'MCA', '25MX117@psgtech.ac.in', '9360328669', 'G1'),
('25MX118', 'OVIYA S', 'MCA', '25MX118@psgtech.ac.in', '9965580407', 'G1'),
('25MX119', 'PON AKILESH P', 'MCA', '25MX119@psgtech.ac.in', '7806952626', 'G1'),
('25MX120', 'R SIBIDHARAN', 'MCA', '25MX120@psgtech.ac.in', '8903289194', 'G1'),
('25MX121', 'SATHISH M', 'MCA', '25MX121@psgtech.ac.in', '7305522754', 'G1'),
('25MX122', 'SHAARUKESH K R', 'MCA', '25MX122@psgtech.ac.in', '9677339233', 'G1'),
('25MX123', 'SRI MONIKA J', 'MCA', '25MX123@psgtech.ac.in', '8610189332', 'G1'),
('25MX124', 'SRINITHI J', 'MCA', '25MX124@psgtech.ac.in', '6369227481', 'G1'),
('25MX125', 'STEPHINA SMILY C', 'MCA', '25MX125@psgtech.ac.in', '8300526351', 'G1'),
('25MX126', 'SURYA KRISHNA S', 'MCA', '25MX126@psgtech.ac.in', '6369447530', 'G1'),
('25MX127', 'SWARNA RATHNA A', 'MCA', '25MX127@psgtech.ac.in', '9952873426', 'G1'),
('25MX128', 'SWEATHA A M', 'MCA', '25MX128@psgtech.ac.in', '8778353552', 'G1'),
('25MX129', 'THIRUPATHI B', 'MCA', '25MX129@psgtech.ac.in', '9597024871', 'G1'),
('25MX130', 'VISHAL KARTHIKEYAN P', 'MCA', '25MX130@psgtech.ac.in', '9003423104', 'G1');

-- Insert labs
INSERT INTO lab (lab_name, room_no, capacity) VALUES
('ISL', 'K508', 62),
('CC', 'K507', 62),
('Technosphere', 'K511', 62);

-- Insert systems for ISL (lab_id = 1)
INSERT INTO system_unit (system_name, lab_id, status)
SELECT 'IS' || LPAD(generate_series::TEXT, 2, '0'), 1, 'active'
FROM generate_series(1, 62);

-- Insert systems for CC (lab_id = 2)
INSERT INTO system_unit (system_name, lab_id, status)
SELECT 'CC' || LPAD(generate_series::TEXT, 2, '0'), 2, 'active'
FROM generate_series(1, 62);

-- Insert systems for Technosphere (lab_id = 3)
INSERT INTO system_unit (system_name, lab_id, status)
SELECT 'CAT' || LPAD(generate_series::TEXT, 2, '0'), 3, 'active'
FROM generate_series(1, 62);

-- Enable Row Level Security (RLS) - Optional but recommended
ALTER TABLE student ENABLE ROW LEVEL SECURITY;
ALTER TABLE lab ENABLE ROW LEVEL SECURITY;
ALTER TABLE system_unit ENABLE ROW LEVEL SECURITY;
ALTER TABLE logs ENABLE ROW LEVEL SECURITY;

-- Create policies to allow all operations (adjust based on your security needs)
CREATE POLICY "Allow all operations on student" ON student FOR ALL USING (true);
CREATE POLICY "Allow all operations on lab" ON lab FOR ALL USING (true);
CREATE POLICY "Allow all operations on system_unit" ON system_unit FOR ALL USING (true);
CREATE POLICY "Allow all operations on logs" ON logs FOR ALL USING (true);
