-- WYZWALACZE:
-- 1. Wyzwalacz nie pozwalajacy wpisywac nazwisk pacjentow krotszych niz 2 znaki.
CREATE OR REPLACE TRIGGER zabron_nazwisko BEFORE INSERT ON pacjent FOR EACH ROW
BEGIN
    :wynik := ' ';
    IF lenght(nazwisko) <= 2 THEN
    INSERT INTO osoba(nazwisko) VALUES(wynik);
    END IF;
END;
/
INSERT INTO PACJENT VALUES(7,3,'Marcin','i','95849584758','Dworcowa 15','555636674',25);

-- 2. Wyzwalacz wyœwietlaj¹cy zmiany.
CREATE OR REPLACE TRIGGER wypisz_zmiany
  BEFORE DELETE OR INSERT OR UPDATE ON historia_choroby
  FOR EACH ROW
BEGIN
    dbms_output.put('Stare: ' || :old.zmiany);
    dbms_output.put(' Nowe: ' || :new.zmiany);
END;
/
UPDATE historia_choroby SET zmiany = 'nowe zmiany' WHERE id = 1;

-- 3. Wyzwalacz nie pozwalajacy wpisac godziny innej niz wyznaczonej dla tabeli repecja.
CREATE OR REPLACE TRIGGER zakaz_godziny
BEFORE INSERT ON RECEPCJA
BEGIN
    IF (TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '20:00') THEN
        RAISE_APPLICATION_ERROR(-20123, 'Mo¿esz dodaæ godziny otwarcia recepcji tylko pomiedzy 8:00 a 20:00.');
    END IF;
END;
/
INSERT INTO RECEPCJA VALUES(4,'07:00:00', '20:00:00');

-- 4. Wyzwalacz sprawdzajacy czy podany wiek pacjenta jest poprawny.

CREATE OR REPLACE TRIGGER sprawdz_wiek_pacjenta
BEFORE INSERT
  on pacjent
  FOR EACH ROW 

DECLARE
wiek number;

BEGIN

SELECT MONTHS_BETWEEN(TO_DATE(sysdate,'DD-MON-YYYY'), TO_DATE(:new.wiek,'DD-MON-YYYY'))/12 
   INTO wiek FROM DUAL;

    IF (wiek < 18) THEN
      RAISE_APPLICATION_ERROR(-20000,'Pacjent musi byæ pelnoletni!');
    END IF;         

END;
/
INSERT INTO PACJENT VALUES(8,3,'Jan','Kowalski','95849545678','Dworcowa 15','555633627',17);