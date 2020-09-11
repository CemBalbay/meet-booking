CREATE DATABASE IF NOT EXISTS meet_booking CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


#Calışanlar Tablosu
CREATE TABLE meet_booking.employees (
    id          INT(10)         NOT NULL,
    status      CHAR(1) NOT NULL DEFAULT 'a' COMMENT 'Record status. a: active, d: deleted, i: inactive',
    birth_date  DATE            NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,    
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)                                                           
);


#departmanlar tablosu
CREATE TABLE meet_booking.departments (
    id          INT(10)         NOT NULL,
    status      CHAR(1) NOT NULL DEFAULT 'a' COMMENT 'Record status. a: active, d: deleted, i: inactive',
    dept_name   VARCHAR(40)     NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);


CREATE TABLE meet_booking.employees_of_departments (
    employee    INT(10)     NOT NULL,
    status      CHAR(1) NOT NULL DEFAULT 'a' COMMENT 'Record status. a: active, d: deleted, i: inactive',
    department INT(10)     NOT NULL,
    from_date   DATE        NOT NULL,
    to_date     DATE        NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (employee,department),
    UNIQUE INDEX `xu_employee_department_todate` (employee,department,to_date) USING BTREE,
    FOREIGN KEY (employee) REFERENCES employees (id) ON DELETE CASCADE,
    FOREIGN KEY (department) REFERENCES departments (id) ON DELETE CASCADE
);

CREATE TABLE meet_booking.meet_rooms (
    id          INT(10)     NOT NULL,
    status      CHAR(1) NOT NULL DEFAULT 'a' COMMENT 'Record status. a: active, d: deleted, i: inactive',
    name  VARCHAR(250)      NOT NULL,
    size  INT(15)           NULL DEFAULT 50,
    facility  JSON          DEFAULT NULL
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);



CREATE TABLE meet_booking.meet_reservation (
    id           INT(10)     NOT NULL,
    start        DATETIME NULL,
	end          DATETIME NULL,
    employee     INT(10)     NOT NULL,
    meet_room    INT(10)     NOT NULL,
    type         CHAR(1) NOT NULL DEFAULT 'b' COMMENT 'Bussiness:b, Oparationl:o, Edu:e';
    description  TEXT  NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (employee) REFERENCES employees (id) ON DELETE CASCADE,
    FOREIGN KEY (meet_room) REFERENCES meet_rooms (id) ON DELETE CASCADE
);




CREATE TABLE meet_booking.meet_available_schedule (
    id          INT(10)     NOT NULL,
    time_occupied_start     DATETIME NOT NULL,
	time_occupied_end       DATETIME NOT NULL,
    reservation             INT(10) NULL,
    name  VARCHAR(250)      NOT NULL,
    size  INT(15)           NULL DEFAULT 50,
    facility  JSON          DEFAULT NULL
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (reservation) REFERENCES meet_reservation (id) ON DELETE CASCADE

);

