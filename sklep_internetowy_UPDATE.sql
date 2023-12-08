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
    ID_Pracownika = 5