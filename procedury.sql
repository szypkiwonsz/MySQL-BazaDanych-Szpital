-- PROCEDURY:
-- 1. Procedura dodajaca pacjenta do bazy danych.
CREATE OR REPLACE PROCEDURE dodaj_pacjenta(
    p_id               pacjent.id%TYPE,
    p_szpital_id       pacjent.szpital_id%TYPE,
    p_imie             pacjent.imie%TYPE,
    p_nazwisko         pacjent.nazwisko%TYPE,
    p_pesel            pacjent.pesel%TYPE,
    p_adres            pacjent.adres%TYPE,
    p_numer_telefonu   pacjent.numer_telefonu%TYPE,
    p_wiek             pacjent.wiek%TYPE
)
IS
BEGIN
INSERT INTO pacjent(id,szpital_id,imie,nazwisko,pesel,adres,numer_telefonu,wiek)
VALUES (p_id,p_szpital_id,p_imie,p_nazwisko,p_pesel,p_adres,p_numer_telefonu,p_wiek);
END dodaj_pacjenta;
/
EXEC dodaj_pacjenta(7,2,'Rafal','Rafaello','11111111111','Aleja','999999999',25);

-- 2. Procedura wyszukuj¹ca nazwisko lekarza po pierwszych zadanych literach.
CREATE OR REPLACE PROCEDURE WYPISZ_NAZWISKO_LEKARZA 
(
  ID_INPUT IN VARCHAR2 
, NAZWISKO_OUTPUT OUT VARCHAR2 
) AS 
BEGIN
  SELECT nazwisko INTO nazwisko_output FROM lekarz WHERE id=id_input;
END WYPISZ_NAZWISKO_LEKARZA;

--3. Procedura dodajaca lekarza do bazy danych.
create or replace PROCEDURE dodaj_lekarza(
    x_id               lekarz.id%TYPE,
    x_numer_telefonu   lekarz.numer_telefonu%TYPE,
    x_imie             lekarz.imie%TYPE,
    x_nazwisko         lekarz.nazwisko%TYPE,
    x_szpital_id       lekarz.szpital_id%TYPE
    )
IS
BEGIN
INSERT INTO lekarz(id,numer_telefonu,imie,nazwisko,szpital_id)
VALUES (x_id,x_numer_telefonu,x_imie,x_nazwisko,x_szpital_id);
END dodaj_lekarza;
/
EXEC dodaj_lekarza(7,'662346235','Maciej','Osa',2);