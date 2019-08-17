-- FUNKCJE:
-- 1. Funkcja wyœwietlajaca liczbe pacjentow.

CREATE OR REPLACE FUNCTION LiczbaPacjentow RETURN NUMBER IS
    v_ile NUMBER(11);
BEGIN
    SELECT count(*) INTO v_ile FROM pacjent;
    RETURN v_ile;
END LiczbaPacjentow;
/
SET SERVEROUTPUT ON 
/
BEGIN
    dbms_output.put_line('Liczba pacjentów: '||LiczbaPacjentow);
END;

-- 2. Funkcja wyswietlajaca liczbe unikatowych imion pacjentow.

CREATE OR REPLACE FUNCTION LiczbaUnikatowychPacjentow RETURN NUMBER IS
    v_ile NUMBER(11);
BEGIN
    SELECT count(*) INTO v_ile FROM (SELECT DISTINCT imie FROM pacjent) t;
    RETURN v_ile;
END LiczbaUnikatowychPacjentow;
/
SET SERVEROUTPUT ON 
/
BEGIN
    dbms_output.put_line('Liczba unikatowych imion pacjentow: '||LiczbaUnikatowychPacjentow);
END;

-- 3. Funkcja wyœwietlajaca liczbe lekarzy.
CREATE OR REPLACE FUNCTION LiczbaLekarzy RETURN NUMBER IS
    v2_ile NUMBER(11);
BEGIN
    SELECT count(*) INTO v2_ile FROM lekarz;
    RETURN v2_ile;
END LiczbaLekarzy;
/
SET SERVEROUTPUT ON 
/
BEGIN
    dbms_output.put_line('Liczba lekarzy: '||LiczbaLekarzy);
END;

