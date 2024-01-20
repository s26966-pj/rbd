UPDATE Adresy
SET
    Numer_domu = '6a'
WHERE
    ID_Adresu = 1;

UPDATE adresy
SET
    Numer_lokalu = '20'
WHERE
    Województwo = 'małopolskie';

UPDATE Klienci
SET
    Imie = 'Andrzej'
WHERE
    ID_Klienta = 1;

UPDATE Klienci
SET
    Telefon = '748392048'
WHERE
    ID_Klienta > 7;

UPDATE Magazyny
SET
    Powierzchnia = '30'
WHERE
    ID_Magazynu = 2;

UPDATE Magazyny
SET
    Telefon = '987654321'
WHERE
    Czynny = 1;

UPDATE Pracownicy
SET
    Wynagrodzenie_brutto = 5000
WHERE
    ID_Pracownika = 2;

UPDATE Pracownicy
SET
    Rodzaj_umowy = 'umowa zlecenie'
WHERE
    Data_urodzenia < '1980-01-01';

UPDATE Producenci
SET
    Data_założenia = '1981-02-10'
WHERE
    ID_Producenta = 1;

UPDATE Producenci
SET
    Telefon = '123456789'
WHERE
    Telefon IS NULL;

UPDATE Produkty
SET
    Nazwa = 'IPhone 13 Pro'
WHERE
    Nazwa = 'Iphone 13';

UPDATE Produkty
SET
    ID_Producenta = 2
WHERE
    ID_Produktu IN (6, 7, 8);

UPDATE Zamówienia
SET
    Status = 'U klienta',
    Data_odebrania = '2023-11-23 12:00:00'
WHERE
    ID_Zamówienia = 5;

UPDATE Zamówienia
SET
    Koszt_wysyłki = 10.5
WHERE
    Sposób_wysyłki = 'inpost paczkomaty';

UPDATE Zwroty
SET
    Czy_przyjeto = 0
WHERE
    ID_Zamówienia = 3;

UPDATE Zwroty
SET
    ID_Pracownika = 1
WHERE
    ID_Pracownika = 5;
    

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM Adresy WHERE Numer_domu = 43;

DELETE FROM Adresy WHERE Kod_pocztowy LIKE '80-%';

DELETE FROM Klienci WHERE Nazwisko = 'Ptak';

DELETE FROM Klienci WHERE ID_Klienta NOT IN(2,4,5,6);

DELETE FROM Magazyny WHERE ID_Magazynu = '4';

DELETE FROM Magazyny WHERE Czynny = '1';

DELETE FROM Pracownicy WHERE Nazwisko = 'Kowalski';

DELETE FROM Pracownicy WHERE ID_Magazynu != '1';

DELETE FROM Producenci WHERE Nazwa = 'JBL';

DELETE FROM Producenci WHERE Data_założenia > '1950-01-01';

DELETE FROM Produkty WHERE Kategoria = 'myszka';

DELETE FROM Produkty WHERE Cena_brutto BETWEEN 1000 AND 3000;

DELETE FROM Zamówienia WHERE ID_Zamówienia = 8;

DELETE FROM Zamówienia WHERE Data_wysłania = NULL;

DELETE FROM Zwroty WHERE ID_Zwrotu = 1;

DELETE FROM Zwroty WHERE Czy_przyjeto = 1;


TRUNCATE TABLE Magazyny;

ALTER TABLE Produkty DROP COLUMN Opis;

--unikalne wojewodztwa które występują w adresach
SELECT DISTINCT Województwo FROM Adresy;

--suma wszystkich produktów w magazynach
SELECT SUM(Ilość) AS 'Suma produktów'
FROM Stany_magazynowe
GROUP BY ID_Magazynu
ORDER BY ID_Magazynu ASC;

--liczba zamowien bez zwrotu
SELECT COUNT(Zamówienia.ID_Zamówienia) AS 'Liczba zamówień bez zwrotu'
FROM Zamówienia
LEFT JOIN Zwroty ON Zamówienia.ID_Zamówienia = Zwroty.ID_Zamówienia 
WHERE ID_Zwrotu IS NULL;

--ile klienci złożyli zamówień
SELECT Imie, Nazwisko, COUNT(ID_Zamówienia) AS 'Liczba zamówień'
FROM Klienci
LEFT JOIN Zamówienia ON Zamówienia.ID_Klienta = Klienci.ID_Klienta
GROUP BY Klienci.ID_Klienta
ORDER BY COUNT(ID_Zamówienia) DESC;

--najlepiej zarabiający pracownik
SELECT Imie, Nazwisko, MAX(Wynagrodzenie_brutto) FROM Pracownicy;

--zamówienia w których jest więcej niż 1 produkt
SELECT ID_Zamówienia, SUM(Ilość) AS 'Ilość produktów'
FROM Produkty_do_zamówienia
GROUP BY ID_Zamówienia 
HAVING SUM(Ilość) > 1;

--produkty które nie znajdują się w żadnym zamówieniu
SELECT * FROM Produkty 
WHERE NOT EXISTS
(SELECT * FROM Produkty_do_zamówienia
WHERE Produkty_do_zamówienia.ID_Produktu = Produkty.ID_Produktu);
