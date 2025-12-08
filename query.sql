create database logManagement;
use  logManagement;

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_no VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(200) NOT NULL,
    department VARCHAR(100),
    email VARCHAR(200),
    phone VARCHAR(20),
    student_group ENUM('G1', 'G2') NOT NULL
);

CREATE TABLE lab (
    lab_id INT AUTO_INCREMENT PRIMARY KEY,
    lab_name VARCHAR(200) NOT NULL,
    room_no VARCHAR(200),
    capacity INT
);

CREATE TABLE system_unit (
    system_id INT AUTO_INCREMENT PRIMARY KEY,
    lab_id INT NOT NULL,
    system_name VARCHAR(100) NOT NULL,
    ip_address VARCHAR(50),
    status ENUM('active', 'inactive') DEFAULT 'active',

    FOREIGN KEY (lab_id) REFERENCES lab(lab_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    system_id INT NOT NULL,
    in_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    out_time DATETIME DEFAULT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (system_id) REFERENCES system_unit(system_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

DELIMITER $$
CREATE TRIGGER trg_set_in_time
BEFORE INSERT ON logs
FOR EACH ROW
BEGIN
    IF NEW.in_time IS NULL THEN
        SET NEW.in_time = NOW();
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE checkout_student(IN sid INT)
BEGIN
    UPDATE logs
    SET out_time = NOW()
    WHERE student_id = sid AND out_time IS NULL;
END$$
DELIMITER ;


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

INSERT INTO lab (lab_name, room_no, capacity) VALUES
('ISL', 'K508', 62),
('CC', 'K507', 62),
('Technosphere', 'K511', 62);

INSERT INTO system_unit (system_name, lab_id, status) VALUES
-- ISL (lab_id = 1)
('IS01', 1, 'active'),
('IS02', 1, 'active'),
('IS03', 1, 'active'),
('IS04', 1, 'active'),
('IS05', 1, 'active'),
('IS06', 1, 'active'),
('IS07', 1, 'active'),
('IS08', 1, 'active'),
('IS09', 1, 'active'),
('IS10', 1, 'active'),
('IS11', 1, 'active'),
('IS12', 1, 'active'),
('IS13', 1, 'active'),
('IS14', 1, 'active'),
('IS15', 1, 'active'),
('IS16', 1, 'active'),
('IS17', 1, 'active'),
('IS18', 1, 'active'),
('IS19', 1, 'active'),
('IS20', 1, 'active'),
('IS21', 1, 'active'),
('IS22', 1, 'active'),
('IS23', 1, 'active'),
('IS24', 1, 'active'),
('IS25', 1, 'active'),
('IS26', 1, 'active'),
('IS27', 1, 'active'),
('IS28', 1, 'active'),
('IS29', 1, 'active'),
('IS30', 1, 'active'),
('IS31', 1, 'active'),
('IS32', 1, 'active'),
('IS33', 1, 'active'),
('IS34', 1, 'active'),
('IS35', 1, 'active'),
('IS36', 1, 'active'),
('IS37', 1, 'active'),
('IS38', 1, 'active'),
('IS39', 1, 'active'),
('IS40', 1, 'active'),
('IS41', 1, 'active'),
('IS42', 1, 'active'),
('IS43', 1, 'active'),
('IS44', 1, 'active'),
('IS45', 1, 'active'),
('IS46', 1, 'active'),
('IS47', 1, 'active'),
('IS48', 1, 'active'),
('IS49', 1, 'active'),
('IS50', 1, 'active'),
('IS51', 1, 'active'),
('IS52', 1, 'active'),
('IS53', 1, 'active'),
('IS54', 1, 'active'),
('IS55', 1, 'active'),
('IS56', 1, 'active'),
('IS57', 1, 'active'),
('IS58', 1, 'active'),
('IS59', 1, 'active'),
('IS60', 1, 'active'),
('IS61', 1, 'active'),
('IS62', 1, 'active'),

-- CC (lab_id = 2)
('CC01', 2, 'active'),
('CC02', 2, 'active'),
('CC03', 2, 'active'),
('CC04', 2, 'active'),
('CC05', 2, 'active'),
('CC06', 2, 'active'),
('CC07', 2, 'active'),
('CC08', 2, 'active'),
('CC09', 2, 'active'),
('CC10', 2, 'active'),
('CC11', 2, 'active'),
('CC12', 2, 'active'),
('CC13', 2, 'active'),
('CC14', 2, 'active'),
('CC15', 2, 'active'),
('CC16', 2, 'active'),
('CC17', 2, 'active'),
('CC18', 2, 'active'),
('CC19', 2, 'active'),
('CC20', 2, 'active'),
('CC21', 2, 'active'),
('CC22', 2, 'active'),
('CC23', 2, 'active'),
('CC24', 2, 'active'),
('CC25', 2, 'active'),
('CC26', 2, 'active'),
('CC27', 2, 'active'),
('CC28', 2, 'active'),
('CC29', 2, 'active'),
('CC30', 2, 'active'),
('CC31', 2, 'active'),
('CC32', 2, 'active'),
('CC33', 2, 'active'),
('CC34', 2, 'active'),
('CC35', 2, 'active'),
('CC36', 2, 'active'),
('CC37', 2, 'active'),
('CC38', 2, 'active'),
('CC39', 2, 'active'),
('CC40', 2, 'active'),
('CC41', 2, 'active'),
('CC42', 2, 'active'),
('CC43', 2, 'active'),
('CC44', 2, 'active'),
('CC45', 2, 'active'),
('CC46', 2, 'active'),
('CC47', 2, 'active'),
('CC48', 2, 'active'),
('CC49', 2, 'active'),
('CC50', 2, 'active'),
('CC51', 2, 'active'),
('CC52', 2, 'active'),
('CC53', 2, 'active'),
('CC54', 2, 'active'),
('CC55', 2, 'active'),
('CC56', 2, 'active'),
('CC57', 2, 'active'),
('CC58', 2, 'active'),
('CC59', 2, 'active'),
('CC60', 2, 'active'),
('CC61', 2, 'active'),
('CC62', 2, 'active'),

-- Technosphere (lab_id = 3)
('CAT01', 3, 'active'),
('CAT02', 3, 'active'),
('CAT03', 3, 'active'),
('CAT04', 3, 'active'),
('CAT05', 3, 'active'),
('CAT06', 3, 'active'),
('CAT07', 3, 'active'),
('CAT08', 3, 'active'),
('CAT09', 3, 'active'),
('CAT10', 3, 'active'),
('CAT11', 3, 'active'),
('CAT12', 3, 'active'),
('CAT13', 3, 'active'),
('CAT14', 3, 'active'),
('CAT15', 3, 'active'),
('CAT16', 3, 'active'),
('CAT17', 3, 'active'),
('CAT18', 3, 'active'),
('CAT19', 3, 'active'),
('CAT20', 3, 'active'),
('CAT21', 3, 'active'),
('CAT22', 3, 'active'),
('CAT23', 3, 'active'),
('CAT24', 3, 'active'),
('CAT25', 3, 'active'),
('CAT26', 3, 'active'),
('CAT27', 3, 'active'),
('CAT28', 3, 'active'),
('CAT29', 3, 'active'),
('CAT30', 3, 'active'),
('CAT31', 3, 'active'),
('CAT32', 3, 'active'),
('CAT33', 3, 'active'),
('CAT34', 3, 'active'),
('CAT35', 3, 'active'),
('CAT36', 3, 'active'),
('CAT37', 3, 'active'),
('CAT38', 3, 'active'),
('CAT39', 3, 'active'),
('CAT40', 3, 'active'),
('CAT41', 3, 'active'),
('CAT42', 3, 'active'),
('CAT43', 3, 'active'),
('CAT44', 3, 'active'),
('CAT45', 3, 'active'),
('CAT46', 3, 'active'),
('CAT47', 3, 'active'),
('CAT48', 3, 'active'),
('CAT49', 3, 'active'),
('CAT50', 3, 'active'),
('CAT51', 3, 'active'),
('CAT52', 3, 'active'),
('CAT53', 3, 'active'),
('CAT54', 3, 'active'),
('CAT55', 3, 'active'),
('CAT56', 3, 'active'),
('CAT57', 3, 'active'),
('CAT58', 3, 'active'),
('CAT59', 3, 'active'),
('CAT60', 3, 'active'),
('CAT61', 3, 'active'),
('CAT62', 3, 'active');


