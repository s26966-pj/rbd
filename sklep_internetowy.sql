CREATE TABLE
  Adresy (
    ID_Adresu int NOT NULL AUTO_INCREMENT,
    Województwo varchar(255) NOT NULL,
    Powiat varchar(255) NOT NULL,
    Miejscowość varchar(255) NOT NULL,
    Adres_pocztowy char(6) NOT NULL,
    Ulica varchar(255) NOT NULL,
    Numer_domu varchar(5) NOT NULL,
    Numer_lokalu int NULL,
    PRIMARY KEY (ID_Adresu)
  );

CREATE TABLE
  Klienci (
    ID_Klienta int NOT NULL AUTO_INCREMENT,
    Imie varchar(255) NOT NULL,
    Nazwisko varchar(255) NOT NULL,
    Adres int NOT NULL,
    Email varchar(255) NOT NULL,
    Telefon char(9) NOT NULL,
    PRIMARY KEY (ID_Klienta),
    FOREIGN KEY (Adres) REFERENCES Adresy (ID_Adresu)
  );

CREATE TABLE
  Pracownicy (
    ID_Pracownika int NOT NULL AUTO_INCREMENT,
    Imie varchar(255) NOT NULL,
    Nazwisko varchar(255) NOT NULL,
    Adres int NOT NULL,
    Telefon char(9) NULL,
    Data_urodzenia date NOT NULL,
    Rodzaj_umowy enum ('umowa zlecenie', 'umowa o pracę') NULL,
    Wynagrodzenie_brutto float NULL,
    Wynagrodzenie_netto float NULL,
    Data_zawarcia_umowy date NULL,
    PRIMARY KEY (ID_Pracownika),
    FOREIGN KEY (Adres) REFERENCES Adresy (ID_Adresu)
  );

CREATE TABLE
  Magazyny (
    ID_Magazynu int NOT NULL AUTO_INCREMENT,
    Adres int NOT NULL,
    Telefon char(9) NULL,
    Pracownicy int NULL,
    Powierzchnia int NULL,
    PRIMARY KEY (ID_Magazynu),
    FOREIGN KEY (Adres) REFERENCES Adresy (ID_Adresu),
    FOREIGN KEY (Pracownicy) REFERENCES Pracownicy (ID_Pracownika)
  );

CREATE TABLE
  Producenci (
    ID_Producenta int NOT NULL AUTO_INCREMENT,
    Nazwa varchar(255) NOT NULL,
    Adres_siedziby int NULL,
    Telefon char(9) NULL,
    Założyciel varchar(255) NULL,
    Data_założenia date NULL,
    PRIMARY KEY (ID_Producenta),
    FOREIGN KEY (Adres_siedziby) REFERENCES Adresy (ID_Adresu)
  );

CREATE TABLE
  Produkt (
    ID_Produktu int NOT NULL AUTO_INCREMENT,
    Kategoria enum (
      'komputery i laptopy',
      'smartfony',
      'sprzet audio',
      'smartwatche',
      'fotografia',
      'klawiatury',
      'myszki',
      'monitory'
    ) NOT NULL,
    Nazwa varchar(255) NOT NULL,
    Producent int NOT NULL,
    Cena_brutto float NOT NULL,
    Cena_netto float NOT NULL,
    VAT char(3) NULL,
    EAN char(13) NULL,
    Waga int NULL,
    Opis text NULL,
    PRIMARY KEY (ID_Produktu),
    FOREIGN KEY (Producent) REFERENCES Producenci (ID_Producenta)
  );

CREATE TABLE
  Zamówienia (
    ID_Zamówienia int NOT NULL AUTO_INCREMENT,
    Status enum (
      'Nowe zamówienie',
      'W trakcie realizacji',
      'Wysłane',
      'U klienta'
    ) NOT NULL,
    Data_złożenia datetime NULL,
    Data_wysłania datetime NULL,
    Data_odebrania datetime NULL,
    -- Produkty NOT NULL,
    Klient int NOT NULL,
    Adres int NOT NULL,
    Sposób_wysyłki enum (
      'fedex',
      'inpost paczkomaty',
      'inpost kurier',
      'dpd'
    ) NOT NULL,
    Rodzaj_płatności enum ('pobranie', 'przelew', 'karta płatnicza', 'blik') NOT NULL,
    Kwota_produktów float NOT NULL,
    Koszt_wysyłki float NOT NULL,
    Dokument_sprzedaży enum ('paragon', 'faktura'),
    PRIMARY KEY (ID_Zamówienia),
    FOREIGN KEY (Adres) REFERENCES Adresy (ID_Adresu),
    FOREIGN KEY (Klient) REFERENCES Klienci (ID_Klienta)
  );

CREATE TABLE
  Zwroty (
    ID_Zwrotu int NOT NULL AUTO_INCREMENT,
    Zamówienie int NOT NULL,
    Rodzaj_zwrotu enum ('całkowity', 'czesciowy') NOT NULL,
    Pracownik int NOT NULL,
    Data_rozpatrzenia datetime NOT NULL,
    Czy_przyjeto boolean NOT NULL,
    -- Produkty NOT NULL,
    Zwrócona_kwota float NULL,
    PRIMARY KEY (ID_Zwrotu),
    FOREIGN KEY (Zamówienie) REFERENCES Zamówienia (ID_Zamówienia),
    FOREIGN KEY (Pracownik) REFERENCES Pracownicy (ID_Pracownika)
  );

--adresy
INSERT INTO
  `adresy` (
    `ID_Adresu`,
    `Województwo`,
    `Powiat`,
    `Miejscowość`,
    `Adres_pocztowy`,
    `Ulica`,
    `Numer_domu`,
    `Numer_lokalu`
  )
VALUES
  (
    NULL,
    'pomorskie',
    'gdański',
    'Gdańsk',
    '80-005',
    'Jana Pawła',
    '3a',
    NULL
  ),
  (
    NULL,
    'pomorskie',
    'kartuski',
    'Żukowo',
    '83-330',
    'Mickiewicza',
    '30',
    NULL
  ),
  (
    NULL,
    'małopolskie',
    'krakowski',
    'Kraków',
    '32-200',
    'Leśna',
    '1',
    '23'
  ),
  (
    NULL,
    'małopolskie',
    'krakowski',
    'Kraków',
    '32-200',
    'Długa',
    '43',
    NULL
  ),
  (
    NULL,
    'pomorskie',
    'gdański',
    'Kolbudy',
    '81-323',
    'Szczęśliwa',
    '3',
    NULL
  ),
  (
    NULL,
    'zachodniopomorskie',
    'szczeciński',
    'Szczecin',
    '71-090',
    'Jana Brzechwy',
    '4',
    '12'
  ),
  (
    NULL,
    'wielkopolskie',
    'poznański',
    'Starachowice',
    '22-300',
    'Krańcowa',
    '55',
    NULL
  ),
  (
    NULL,
    'pomorskie',
    'gdański',
    'Gdańsk',
    '80-020',
    'Józefa Piłsudskiego',
    '59',
    NULL
  ),
  (
    NULL,
    'pomorskie',
    'kartuski',
    'Kartuzy',
    '84-100',
    'Wzgórze wolności',
    '5',
    NULL
  ),
  (
    NULL,
    'lubelskie',
    'lubelski',
    'Lublin',
    '10-123',
    'Dębowa',
    '80',
    NULL
  );

--klienci
INSERT INTO
  `klienci` (
    `ID_Klienta`,
    `Imie`,
    `Nazwisko`,
    `Adres`,
    `Email`,
    `Telefon`
  )
VALUES
  (
    NULL,
    'Jan ',
    'Kowalski',
    '2',
    'jkowa@gmail.com',
    '483627489'
  ),
  (
    NULL,
    'Kamil',
    'Kujawski',
    '4',
    'kujawski123@gmail.com',
    '394823749'
  ),
  (
    NULL,
    'Andrzej',
    'Pietruszka',
    '7',
    'pietrucha@wp.pl',
    '876483984'
  ),
  (
    NULL,
    'Michał',
    'Smolik',
    '6',
    'msmolik@wp.pl',
    '432758493'
  ),
  (
    NULL,
    'Grzegorz',
    'Mucha',
    '10',
    'mucha45@interia.pl',
    '784987594'
  ),
  (
    NULL,
    'Julia',
    'Ptak',
    '7',
    'ptakjulia@gmail.com',
    '784987894'
  ),
  (
    NULL,
    'Maria',
    'Baran',
    '3',
    'baran@wp.pl',
    '784987504'
  ),
  (
    NULL,
    'Michał',
    'Konstantynowicz',
    '2',
    'michalek@tlen.pl',
    '894098594'
  ),
  (
    NULL,
    'Jan',
    'Janek',
    '6',
    'totot@gmail.com',
    '849585948'
  ),
  (
    NULL,
    'Mateusz',
    'Matuszewski',
    '9',
    'matuszewski@gmail.com',
    '874987849'
  );

INSERT INTO
  `producenci` (
    `ID_Producenta`,
    `Nazwa`,
    `Adres_siedziby`,
    `Telefon`,
    `Założyciel`,
    `Data_założenia`
  )
VALUES
  (
    NULL,
    'Apple',
    2,
    '543543643',
    'Steve Jobs',
    '1980-12-12'
  ),
  (
    NULL,
    'Samsung',
    3,
    '543543657',
    'Lee Byung-chul',
    '1950-03-23'
  ),
  (
    NULL,
    'Garmin',
    4,
    '765874765',
    'John Smith',
    '1999-08-01'
  ),
  (NULL, 'Sony', 1, NULL, NULL, '1910-10-10'),
  (NULL, 'Motorola', 8, NULL, NULL, NULL),
  (NULL, 'JBL', 5, NULL, NULL, NULL),
  (NULL, 'Intel', 10, NULL, NULL, NULL);