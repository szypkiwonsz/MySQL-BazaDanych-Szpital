CREATE TABLE diagnoza (
    id          NUMBER(11) NOT NULL,
    nazwa       VARCHAR2(20) NOT NULL,
    opis        VARCHAR2(50) NOT NULL,
    zalecenia   VARCHAR2(50) NOT NULL,
    wizyta_id   NUMBER(11) NOT NULL
);

COMMENT ON COLUMN diagnoza.id IS
    'Zawiera nazwe, opis oraz zalecenia diagnozy wystawionej przez lekarza.
';


ALTER TABLE diagnoza ADD CONSTRAINT diagnoza_pk PRIMARY KEY ( id );

CREATE TABLE gabinet (
    id             NUMBER(11) NOT NULL,
    numer_pokoju   CHAR(50) NOT NULL,
    opis           VARCHAR2(50) NOT NULL
);

ALTER TABLE gabinet ADD CONSTRAINT gabinet_ck_1 CHECK ( numer_pokoju IS NOT NULL );

ALTER TABLE gabinet ADD CONSTRAINT gabinet_pk PRIMARY KEY ( id );

ALTER TABLE gabinet ADD CONSTRAINT gabinet__un UNIQUE ( numer_pokoju,
                                                        id );

CREATE TABLE historia_choroby (
    id                 NUMBER(11) NOT NULL,
    opis               VARCHAR2(50) NOT NULL,
    data_wystawienia   DATE NOT NULL,
    zmiany             VARCHAR2(50) NOT NULL,
    pacjent_id         NUMBER(11) NOT NULL,
    lekarz_id          NUMBER(11) NOT NULL,
    wizyta_id          NUMBER(11) NOT NULL
);

ALTER TABLE historia_choroby ADD CONSTRAINT historia_choroby_ck_1 CHECK ( opis IS NOT NULL );

ALTER TABLE historia_choroby ADD CONSTRAINT historia_choroby_pk PRIMARY KEY ( id );

CREATE TABLE karta_pacjenta (
    id              NUMBER(11) NOT NULL,
    numer_karty     CHAR(1000) NOT NULL,
    data_waznosci   DATE NOT NULL,
    pacjent_id      NUMBER(11) NOT NULL
);

ALTER TABLE karta_pacjenta ADD CONSTRAINT karta_pacjenta_ck_1 CHECK ( numer_karty IS NOT NULL );

ALTER TABLE karta_pacjenta ADD CONSTRAINT karta_pacjenta_ck_2 CHECK ( data_waznosci IS NOT NULL );

ALTER TABLE karta_pacjenta ADD CONSTRAINT karta_pacjenta_pk PRIMARY KEY ( id );

ALTER TABLE karta_pacjenta ADD CONSTRAINT karta_pacjenta__un UNIQUE ( numer_karty );

CREATE TABLE lekarz (
    id               NUMBER(11) NOT NULL,
    numer_telefonu   CHAR(9) NOT NULL,
    imie             VARCHAR2(20) NOT NULL,
    nazwisko         VARCHAR2(20) NOT NULL,
    szpital_id       NUMBER(11) NOT NULL
);

ALTER TABLE lekarz ADD CONSTRAINT lekarz_ck_1 CHECK ( nazwisko IS NOT NULL );

ALTER TABLE lekarz ADD CONSTRAINT lekarz_pk PRIMARY KEY ( id );

ALTER TABLE lekarz ADD CONSTRAINT lekarz__un UNIQUE ( numer_telefonu );

CREATE TABLE lekarz_h_o (
    lekarz_id    NUMBER(11) NOT NULL,
    oddzial_id   NUMBER(11) NOT NULL
);

CREATE TABLE lekarz_h_s (
    specjalizacja_id   NUMBER(11) NOT NULL,
    lekarz_id          NUMBER(11) NOT NULL
);

CREATE TABLE oddzial (
    id           NUMBER(11) NOT NULL,
    szpital_id   NUMBER(11) NOT NULL,
    nazwa        VARCHAR2(50) NOT NULL,
    opis         VARCHAR2(100) NOT NULL,
    adres        VARCHAR2(50) NOT NULL
);

ALTER TABLE oddzial ADD CONSTRAINT oddzial_pk PRIMARY KEY ( id );

CREATE TABLE oddzial_h_r (
    oddzial_id    NUMBER(11) NOT NULL,
    recepcja_id   NUMBER(11) NOT NULL
);

CREATE TABLE oddzial_h_stolowka (
    stolowka_id   NUMBER(11) NOT NULL,
    oddzial_id    NUMBER(11) NOT NULL
);

CREATE TABLE pacjent (
    id               NUMBER(11) NOT NULL,
    szpital_id       NUMBER(11) NOT NULL,
    imie             VARCHAR2(20) NOT NULL,
    nazwisko         VARCHAR2(20) NOT NULL,
    pesel            CHAR(11) NOT NULL,
    adres            VARCHAR2(50) NOT NULL,
    numer_telefonu   CHAR(9) NOT NULL,
    wiek             INTEGER NOT NULL
);

ALTER TABLE pacjent ADD CONSTRAINT pacjent_ck_1v1 CHECK ( pesel IS NOT NULL );

ALTER TABLE pacjent ADD CONSTRAINT pacjent_ck_2 CHECK ( nazwisko IS NOT NULL );

ALTER TABLE pacjent ADD CONSTRAINT pacjent_pk PRIMARY KEY ( id );

ALTER TABLE pacjent ADD CONSTRAINT pacjent__un UNIQUE ( pesel,
                                                        numer_telefonu );

CREATE TABLE pacjent_h_w (
    pacjent_id   NUMBER(11) NOT NULL,
    wizyta_id    NUMBER(11) NOT NULL
);

CREATE TABLE pacjent_h_zabieg (
    zabieg_id    NUMBER(11) NOT NULL,
    pacjent_id   NUMBER(11) NOT NULL
);

CREATE TABLE parking_strzezony (
    id                   NUMBER(11) NOT NULL,
    adres                VARCHAR2(50) NOT NULL,
    godzina_otwarcia     CHAR(20) NOT NULL,
    godzina_zamkniecia   CHAR(20) NOT NULL,
    szpital_id           NUMBER(11) NOT NULL
);

COMMENT ON COLUMN parking_strzezony.id IS
    'xdd';

ALTER TABLE parking_strzezony ADD CONSTRAINT parking_strzezony_ck_1 CHECK ( godzina_otwarcia IS NOT NULL );

ALTER TABLE parking_strzezony ADD CONSTRAINT parking_strzezony_ck_2 CHECK ( godzina_zamkniecia IS NOT NULL );

ALTER TABLE parking_strzezony ADD CONSTRAINT parking_pk PRIMARY KEY ( id );

CREATE TABLE recepcja (
    id                   NUMBER(11) NOT NULL,
    godzina_otwarcia     CHAR(20) NOT NULL,
    godzina_zamkniecia   CHAR(20) NOT NULL
);

ALTER TABLE recepcja ADD CONSTRAINT recepcja_ck_1 CHECK ( godzina_otwarcia IS NOT NULL );

ALTER TABLE recepcja ADD CONSTRAINT recepcja_ck_2 CHECK ( godzina_otwarcia IS NOT NULL );

ALTER TABLE recepcja ADD CONSTRAINT recepcja_pk PRIMARY KEY ( id );

CREATE TABLE recepta (
    id                 NUMBER(11) NOT NULL,
    nazwa_leku         VARCHAR2(20) NOT NULL,
    data_wystawienia   DATE NOT NULL,
    zalecenia          VARCHAR2(50) NOT NULL,
    wizyta_id          NUMBER(11) NOT NULL
);

ALTER TABLE recepta ADD CONSTRAINT recepta_pk PRIMARY KEY ( id );

CREATE TABLE specjalizacja (
    id       NUMBER(11) NOT NULL,
    nazwa    VARCHAR2(20) NOT NULL,
    opis     VARCHAR2(50) NOT NULL,
    rodzaj   VARCHAR2(20) NOT NULL
);

ALTER TABLE specjalizacja ADD CONSTRAINT specjalizacja_pk PRIMARY KEY ( id );

ALTER TABLE specjalizacja ADD CONSTRAINT specjalizacja__un UNIQUE ( nazwa );

CREATE TABLE stolowka (
    id                   NUMBER(11) NOT NULL,
    opis                 VARCHAR2(50) NOT NULL,
    godzina_otwarcia     CHAR(20) NOT NULL,
    godzina_zamkniecia   CHAR(20) NOT NULL
);

ALTER TABLE stolowka ADD CONSTRAINT stolowka_ck_1 CHECK ( godzina_otwarcia IS NOT NULL );

ALTER TABLE stolowka ADD CONSTRAINT stolowka_ck_2 CHECK ( godzina_zamkniecia IS NOT NULL );

ALTER TABLE stolowka ADD CONSTRAINT stolowka_pk PRIMARY KEY ( id );

CREATE TABLE szpital (
    id      NUMBER(11) NOT NULL,
    nazwa   VARCHAR2(50) NOT NULL,
    adres   VARCHAR2(50) NOT NULL
);

ALTER TABLE szpital ADD CONSTRAINT szpital_ck_1 CHECK ( nazwa IS NOT NULL );

ALTER TABLE szpital ADD CONSTRAINT szpital_pk PRIMARY KEY ( id );

ALTER TABLE szpital ADD CONSTRAINT szpital__un UNIQUE ( adres,
                                                        id );

CREATE TABLE wizyta (
    id                    NUMBER(11) NOT NULL,
    data_rejestracji      DATE NOT NULL,
    data_wizyty           DATE NOT NULL,
    godzina_wizyty        CHAR(20) NOT NULL,
    godzina_zakonczenia   CHAR(20) NOT NULL,
    gabinet_id            NUMBER(11) NOT NULL
);

ALTER TABLE wizyta ADD CONSTRAINT wizyta_ck_1 CHECK ( data_rejestracji IS NOT NULL );

ALTER TABLE wizyta ADD CONSTRAINT wizyta_ck_2 CHECK ( data_wizyty IS NOT NULL );

ALTER TABLE wizyta ADD CONSTRAINT wizyta_pk PRIMARY KEY ( id );

CREATE TABLE zabieg (
    id           NUMBER(11) NOT NULL,
    nazwa        VARCHAR2(20) NOT NULL,
    opis         VARCHAR2(50) NOT NULL,
    cena         NUMBER(8, 2) NOT NULL,
    gabinet_id   NUMBER(11) NOT NULL,
    lekarz_id    NUMBER(11) NOT NULL
);

ALTER TABLE zabieg ADD CONSTRAINT zabieg_pk PRIMARY KEY ( id );

ALTER TABLE zabieg ADD CONSTRAINT zabieg__un UNIQUE ( nazwa );

ALTER TABLE diagnoza
    ADD CONSTRAINT diagnoza_wizyta_fk FOREIGN KEY ( wizyta_id )
        REFERENCES wizyta ( id );

ALTER TABLE historia_choroby
    ADD CONSTRAINT historia_choroby_lekarz_fk FOREIGN KEY ( lekarz_id )
        REFERENCES lekarz ( id );

ALTER TABLE historia_choroby
    ADD CONSTRAINT historia_choroby_pacjent_fk FOREIGN KEY ( pacjent_id )
        REFERENCES pacjent ( id );

ALTER TABLE historia_choroby
    ADD CONSTRAINT historia_choroby_wizyta_fk FOREIGN KEY ( wizyta_id )
        REFERENCES wizyta ( id );

ALTER TABLE karta_pacjenta
    ADD CONSTRAINT karta_pacjenta_pacjent_fk FOREIGN KEY ( pacjent_id )
        REFERENCES pacjent ( id );

ALTER TABLE lekarz_h_o
    ADD CONSTRAINT lekarz_h_o_lekarz_fk FOREIGN KEY ( lekarz_id )
        REFERENCES lekarz ( id );

ALTER TABLE lekarz_h_o
    ADD CONSTRAINT lekarz_h_ol_oddzial_fk FOREIGN KEY ( oddzial_id )
        REFERENCES oddzial ( id );

ALTER TABLE lekarz_h_s
    ADD CONSTRAINT lekarz_h_s_lekarz_fk FOREIGN KEY ( lekarz_id )
        REFERENCES lekarz ( id );

ALTER TABLE lekarz_h_s
    ADD CONSTRAINT lekarz_h_s_specjalizacja_fk FOREIGN KEY ( specjalizacja_id )
        REFERENCES specjalizacja ( id );

ALTER TABLE lekarz
    ADD CONSTRAINT lekarz_szpital_fk FOREIGN KEY ( szpital_id )
        REFERENCES szpital ( id );

ALTER TABLE oddzial_h_r
    ADD CONSTRAINT oddzial_h_r_oddzial_fk FOREIGN KEY ( oddzial_id )
        REFERENCES oddzial ( id );

ALTER TABLE oddzial_h_r
    ADD CONSTRAINT oddzial_h_r_recepcja_fk FOREIGN KEY ( recepcja_id )
        REFERENCES recepcja ( id );

ALTER TABLE oddzial_h_stolowka
    ADD CONSTRAINT oddzial_h_s_oddzial_fk FOREIGN KEY ( oddzial_id )
        REFERENCES oddzial ( id );

ALTER TABLE oddzial_h_stolowka
    ADD CONSTRAINT oddzial_h_s_stolowka_fk FOREIGN KEY ( stolowka_id )
        REFERENCES stolowka ( id );

ALTER TABLE oddzial
    ADD CONSTRAINT oddzial_szpital_fk FOREIGN KEY ( szpital_id )
        REFERENCES szpital ( id );

ALTER TABLE pacjent_h_w
    ADD CONSTRAINT pacjent_h_w_pacjent_fk FOREIGN KEY ( pacjent_id )
        REFERENCES pacjent ( id );

ALTER TABLE pacjent_h_w
    ADD CONSTRAINT pacjent_h_w_wizyta_fk FOREIGN KEY ( wizyta_id )
        REFERENCES wizyta ( id );

ALTER TABLE pacjent_h_zabieg
    ADD CONSTRAINT pacjent_h_z_pacjent_fk FOREIGN KEY ( pacjent_id )
        REFERENCES pacjent ( id );

ALTER TABLE pacjent_h_zabieg
    ADD CONSTRAINT pacjent_h_z_zabieg_fk FOREIGN KEY ( zabieg_id )
        REFERENCES zabieg ( id );

ALTER TABLE pacjent
    ADD CONSTRAINT pacjent_szpital_fk FOREIGN KEY ( szpital_id )
        REFERENCES szpital ( id );

ALTER TABLE parking_strzezony
    ADD CONSTRAINT parking_strzezony_szpital_fk FOREIGN KEY ( szpital_id )
        REFERENCES szpital ( id );

ALTER TABLE recepta
    ADD CONSTRAINT recepta_wizyta_fk FOREIGN KEY ( wizyta_id )
        REFERENCES wizyta ( id );

ALTER TABLE wizyta
    ADD CONSTRAINT wizyta_gabinet_fk FOREIGN KEY ( gabinet_id )
        REFERENCES gabinet ( id );

ALTER TABLE zabieg
    ADD CONSTRAINT zabieg_gabinet_fk FOREIGN KEY ( gabinet_id )
        REFERENCES gabinet ( id );

ALTER TABLE zabieg
    ADD CONSTRAINT zabieg_lekarz_fk FOREIGN KEY ( lekarz_id )
        REFERENCES lekarz ( id );

CREATE SEQUENCE diagnoza_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER diagnoza_id_trg BEFORE
    INSERT ON diagnoza
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := diagnoza_id_seq.nextval;
END;
/

CREATE SEQUENCE gabinet_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER gabinet_id_trg BEFORE
    INSERT ON gabinet
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := gabinet_id_seq.nextval;
END;
/

CREATE SEQUENCE historia_choroby_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER historia_choroby_id_trg BEFORE
    INSERT ON historia_choroby
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := historia_choroby_id_seq.nextval;
END;
/

CREATE SEQUENCE lekarz_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER lekarz_id_trg BEFORE
    INSERT ON lekarz
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := lekarz_id_seq.nextval;
END;
/

CREATE SEQUENCE oddzial_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oddzial_id_trg BEFORE
    INSERT ON oddzial
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := oddzial_id_seq.nextval;
END;
/

CREATE SEQUENCE parking_strzezony_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER parking_strzezony_id_trg BEFORE
    INSERT ON parking_strzezony
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := parking_strzezony_id_seq.nextval;
END;
/

CREATE SEQUENCE recepcja_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER recepcja_id_trg BEFORE
    INSERT ON recepcja
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := recepcja_id_seq.nextval;
END;
/

CREATE SEQUENCE recepta_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER recepta_id_trg BEFORE
    INSERT ON recepta
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := recepta_id_seq.nextval;
END;
/

CREATE SEQUENCE specjalizacja_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER specjalizacja_id_trg BEFORE
    INSERT ON specjalizacja
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := specjalizacja_id_seq.nextval;
END;
/

CREATE SEQUENCE stolowka_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER stolowka_id_trg BEFORE
    INSERT ON stolowka
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := stolowka_id_seq.nextval;
END;
/

CREATE SEQUENCE szpital_id_seq START WITH 1 MINVALUE 1 MAXVALUE 100 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER szpital_id_trg BEFORE
    INSERT ON szpital
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := szpital_id_seq.nextval;
END;
/

CREATE SEQUENCE wizyta_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER wizyta_id_trg BEFORE
    INSERT ON wizyta
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := wizyta_id_seq.nextval;
END;
/

CREATE SEQUENCE zabieg_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER zabieg_id_trg BEFORE
    INSERT ON zabieg
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := zabieg_id_seq.nextval;
END;
/