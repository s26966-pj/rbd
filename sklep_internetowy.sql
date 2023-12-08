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
    ID_Adresu int NOT NULL,
    Email varchar(255) NOT NULL,
    Telefon char(9) NOT NULL,
    PRIMARY KEY (ID_Klienta),
    FOREIGN KEY (ID_Adresu) REFERENCES Adresy (ID_Adresu)
  );

CREATE TABLE
  Magazyny (
    ID_Magazynu int NOT NULL AUTO_INCREMENT,
    ID_Adresu int NOT NULL,
    Telefon char(9) NULL,
    Powierzchnia int NULL,
    Czynny boolean NOT NULL,
    PRIMARY KEY (ID_Magazynu),
    FOREIGN KEY (ID_Adresu) REFERENCES Adresy (ID_Adresu)
  );

CREATE TABLE
  Pracownicy (
    ID_Pracownika int NOT NULL AUTO_INCREMENT,
    Imie varchar(255) NOT NULL,
    Nazwisko varchar(255) NOT NULL,
    ID_Adresu int NOT NULL,
    Telefon char(9) NULL,
    Data_urodzenia date NOT NULL,
    Rodzaj_umowy enum ('umowa zlecenie', 'umowa o pracę') NULL,
    Wynagrodzenie_brutto float NULL,
    Data_zawarcia_umowy date NULL,
    ID_Magazynu int NOT NULL,
    PRIMARY KEY (ID_Pracownika),
    FOREIGN KEY (ID_Adresu) REFERENCES Adresy (ID_Adresu),
    FOREIGN KEY (ID_Magazynu) REFERENCES Magazyny (ID_Magazynu)
  );

CREATE TABLE
  Producenci (
    ID_Producenta int NOT NULL AUTO_INCREMENT,
    Nazwa varchar(255) NOT NULL,
    ID_Adresu int NULL,
    Telefon char(9) NULL,
    Założyciel varchar(255) NULL,
    Data_założenia date NULL,
    PRIMARY KEY (ID_Producenta),
    FOREIGN KEY (ID_Adresu) REFERENCES Adresy (ID_Adresu)
  );

CREATE TABLE
  Produkty (
    ID_Produktu int NOT NULL AUTO_INCREMENT,
    Kategoria enum (
      'smartfon',
      'słuchawki',
      'smartwatch',
      'głośnik',
      'klawiatura',
      'myszka',
      'monitor'
    ) NOT NULL,
    Nazwa varchar(255) NOT NULL,
    ID_Producenta int NOT NULL,
    Cena_brutto float NOT NULL,
    VAT char(3) NULL,
    EAN char(13) NULL,
    Waga int NULL,
    Opis text NULL,
    PRIMARY KEY (ID_Produktu),
    FOREIGN KEY (ID_Producenta) REFERENCES Producenci (ID_Producenta)
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
    ID_Klienta int NOT NULL,
    ID_Adresu int NOT NULL,
    Sposób_wysyłki enum (
      'fedex',
      'inpost paczkomaty',
      'inpost kurier',
      'dpd'
    ) NOT NULL,
    Rodzaj_płatności enum ('pobranie', 'przelew', 'karta płatnicza', 'blik') NOT NULL,
    Koszt_wysyłki float NOT NULL,
    Dokument_sprzedaży enum ('paragon', 'faktura'),
    PRIMARY KEY (ID_Zamówienia),
    FOREIGN KEY (ID_Adresu) REFERENCES Adresy (ID_Adresu),
    FOREIGN KEY (ID_Klienta) REFERENCES Klienci (ID_Klienta)
  );

CREATE TABLE
  Zwroty (
    ID_Zwrotu int NOT NULL AUTO_INCREMENT,
    ID_Zamówienia int NOT NULL,
    Rodzaj_zwrotu enum ('całkowity', 'czesciowy') NOT NULL,
    ID_Pracownika int NOT NULL,
    Data_rozpatrzenia datetime NOT NULL,
    Czy_przyjeto boolean NOT NULL,
    PRIMARY KEY (ID_Zwrotu),
    FOREIGN KEY (ID_Zamówienia) REFERENCES Zamówienia (ID_Zamówienia),
    FOREIGN KEY (ID_Pracownika) REFERENCES Pracownicy (ID_Pracownika)
  );

CREATE TABLE
  Stany_magazynowe (
    ID_Magazynu int NOT NULL,
    ID_Produktu int NOT NULL,
    Ilość int NOT NULL,
    FOREIGN KEY (ID_Magazynu) REFERENCES Magazyny (ID_Magazynu),
    FOREIGN KEY (ID_Produktu) REFERENCES Produkty (ID_Produktu)
  );

CREATE TABLE
  Produkty_do_zamówienia (
    ID_Zamówienia int NOT NULL,
    ID_Produktu int NOT NULL,
    Ilość int NOT NULL,
    FOREIGN KEY (ID_Zamówienia) REFERENCES Zamówienia (ID_Zamówienia),
    FOREIGN KEY (ID_Produktu) REFERENCES Produkty (ID_Produktu)
  );

CREATE TABLE
  Produkty_do_zwrotu (
    ID_Zwrotu int NOT NULL,
    ID_Produktu int NOT NULL,
    Ilość int NOT NULL,
    FOREIGN KEY (ID_Zwrotu) REFERENCES Zwroty (ID_Zwrotu),
    FOREIGN KEY (ID_Produktu) REFERENCES Produkty (ID_Produktu)
  );

INSERT INTO
  Adresy (
    ID_Adresu,
    Województwo,
    Powiat,
    Miejscowość,
    Adres_pocztowy,
    Ulica,
    Numer_domu,
    Numer_lokalu
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

INSERT INTO
  Klienci (
    ID_Klienta,
    Imie,
    Nazwisko,
    ID_Adresu,
    Email,
    Telefon
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
  Producenci (
    ID_Producenta,
    Nazwa,
    ID_Adresu,
    Telefon,
    Założyciel,
    Data_założenia
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
    '4',
    '765874765',
    'John Smith',
    '1999-08-01'
  ),
  (NULL, 'Sony', 1, NULL, NULL, '1910-10-10'),
  (NULL, 'Motorola', 8, NULL, NULL, NULL),
  (NULL, 'JBL', 5, NULL, NULL, NULL),
  (NULL, 'Intel', 10, NULL, NULL, NULL);

INSERT INTO
  Magazyny (
    ID_Magazynu,
    ID_Adresu,
    Telefon,
    Powierzchnia,
    Czynny
  )
VALUES
  (NULL, 2, '123456789', '120', 1),
  (NULL, 3, '987654321', '20', 1),
  (NULL, 10, '123456789', '50', 1),
  (NULL, 1, NULL, NULL, 0);

INSERT INTO
  Pracownicy (
    ID_Pracownika,
    Imie,
    Nazwisko,
    ID_Adresu,
    Telefon,
    Data_urodzenia,
    Rodzaj_umowy,
    Wynagrodzenie_brutto,
    Data_zawarcia_umowy,
    ID_Magazynu
  )
VALUES
  (
    NULL,
    'Andrzej',
    'Szypowski',
    '9',
    '3453434575',
    '1980-12-05',
    'umowa o pracę',
    '5000',
    '2023-03-09',
    '3'
  ),
  (
    NULL,
    'Maria',
    'Kwiat',
    '8',
    '898458385',
    '1996-10-12',
    'umowa o pracę',
    '4550',
    '2021-01-20',
    1
  ),
  (
    NULL,
    'Michał',
    'Wiśnia',
    '10',
    '123456789',
    '1996-10-12',
    'umowa zlecenie',
    '8120',
    '2023-01-10',
    1
  ),
  (
    NULL,
    'Grzegorz',
    'Kowalski',
    '1',
    '123456789',
    '1996-10-12',
    'umowa zlecenie',
    '3800',
    '2023-01-10',
    '1'
  ),
  (
    NULL,
    'Mariusz',
    'Andrzejewski',
    '9',
    '3453434575',
    '1980-12-05',
    'umowa o pracę',
    '11000',
    '2020-03-09',
    '2'
  ),
  (
    NULL,
    'Anna',
    'Wesołowska',
    '9',
    '3453434575',
    '1972-05-14',
    'umowa o pracę',
    '5000',
    '2020-03-09',
    '2'
  ),
  (
    NULL,
    'Antoni',
    'Wesołowski',
    '9',
    '545645345',
    '1972-05-14',
    'umowa o pracę',
    '7250',
    '2021-06-21',
    '1'
  ),
  (
    NULL,
    'Michał',
    'Rozenek',
    '4',
    '65456786',
    '1954-08-12',
    'umowa o pracę',
    '4000',
    '2023-06-21',
    '1'
  );

INSERT INTO
  Produkty (
    ID_Produktu,
    Kategoria,
    Nazwa,
    ID_Producenta,
    Cena_brutto,
    VAT,
    EAN,
    Waga,
    Opis
  )
VALUES
  (
    NULL,
    'smartfon',
    'IPhone 13',
    '1',
    '3000',
    '23%',
    '5645686743213',
    '180',
    NULL
  ),
  (
    NULL,
    'smartfon',
    'IPhone 14',
    '1',
    '4100',
    '23%',
    '5847384958943',
    NULL,
    NULL
  ),
  (
    NULL,
    'słuchawki',
    'X Pro 4',
    '6',
    '825',
    '23%',
    '8594857865432',
    '40',
    NULL
  ),
  (
    NULL,
    'smartwatch',
    'Forerunner 55',
    '3',
    '1230',
    '23%',
    '4543454356819',
    NULL,
    NULL
  ),
  (
    NULL,
    'smartwatch',
    'Apple Watch 8',
    '1',
    '1920',
    '23%',
    '9204947294824',
    NULL,
    NULL
  ),
  (
    NULL,
    'monitor',
    'GG500',
    '2',
    '890',
    '23%',
    '9432754394316',
    '1206',
    NULL
  ),
  (
    NULL,
    'myszka',
    'ZCX Pro',
    '4',
    '180',
    '23%',
    '678374594291',
    NULL,
    NULL
  ),
  (
    NULL,
    'głośnik',
    'Tune 4',
    '6',
    '890',
    '23%',
    '8542943785',
    NULL,
    NULL
  ),
  (
    NULL,
    'smartfon',
    'Gt 4 Pro',
    '5',
    '2300',
    '23%',
    '654819874327',
    NULL,
    NULL
  ),
  (
    NULL,
    'klawiatura',
    'C2000',
    '4',
    '520',
    '23%',
    '654819874327',
    NULL,
    NULL
  );

INSERT INTO
  Zamówienia (
    ID_Zamówienia,
    Status,
    Data_złożenia,
    Data_wysłania,
    Data_odebrania,
    ID_Klienta,
    ID_Adresu,
    Sposób_wysyłki,
    Rodzaj_płatności,
    Koszt_wysyłki,
    Dokument_sprzedaży
  )
VALUES
  (
    NULL,
    'Nowe zamówienie',
    '2023-12-01 16:53:38',
    NULL,
    NULL,
    '9',
    '4',
    'fedex',
    'przelew',
    '8.90',
    'paragon'
  ),
  (
    NULL,
    'W trakcie realizacji',
    '2023-11-08 13:40:10',
    NULL,
    NULL,
    '4',
    '4',
    'inpost paczkomaty',
    'blik',
    '5.70',
    'paragon'
  ),
  (
    NULL,
    'Wysłane',
    '2023-11-08 12:45:10',
    '2023-11-15 10:30:10',
    NULL,
    '6',
    '2',
    'fedex',
    'karta płatnicza',
    '8.90',
    'paragon'
  ),
  (
    NULL,
    'U klienta',
    '2023-12-04 12:59:08',
    '2023-12-10 16:59:08',
    '2023-12-14 19:59:08',
    '3',
    '6',
    'dpd',
    'blik',
    '0',
    'faktura'
  ),
  (
    NULL,
    'Wysłane',
    '2023-11-20 12:45:10',
    '2023-11-22 10:30:10',
    NULL,
    '1',
    '2',
    'fedex',
    'przelew',
    '8.90',
    'paragon'
  ),
  (
    NULL,
    'U klienta',
    '2023-11-17 11:45:10',
    '2023-11-18 8:30:10',
    '2023-11-20 9:30:10',
    '5',
    '1',
    'inpost paczkomaty',
    'blik',
    '8.90',
    'paragon'
  ),
  (
    NULL,
    'U klienta',
    '2023-11-17 11:45:10',
    '2023-11-18 8:30:10',
    '2023-11-20 9:30:10',
    '8',
    '3',
    'inpost paczkomaty',
    'blik',
    '8.90',
    'paragon'
  ),
  (
    NULL,
    'U klienta',
    '2023-11-10 11:45:10',
    '2023-11-15 8:30:10',
    '2023-11-18 9:30:10',
    '8',
    '3',
    'inpost paczkomaty',
    'blik',
    '12.30',
    'faktura'
  );

INSERT INTO
  Produkty_do_zamówienia (ID_Zamówienia, ID_Produktu, Ilość)
VALUES
  ('1', '8', '1'),
  ('2', '7', '1'),
  ('2', '1', '1'),
  ('3', '4', '2'),
  ('3', '7', '1'),
  ('3', '8', '1'),
  ('4', '4', '1'),
  ('5', '10', '3'),
  ('6', '6', '1'),
  ('7', '1', '1'),
  ('7', '2', '1'),
  ('7', '5', '1'),
  ('8', '2', '1');

INSERT INTO
  Zwroty (
    ID_Zwrotu,
    ID_Zamówienia,
    Rodzaj_zwrotu,
    ID_Pracownika,
    Data_rozpatrzenia,
    Czy_przyjeto
  )
VALUES
  (
    NULL,
    '4',
    'całkowity',
    '5',
    '2023-12-20 13:00:00',
    '1'
  ),
  (
    NULL,
    '6',
    'całkowity',
    '5',
    '2023-12-21 13:00:00',
    '1'
  ),
  (
    NULL,
    '8',
    'całkowity',
    '5',
    '2023-12-21 14:00:00',
    '1'
  );

INSERT INTO
  Produkty_do_zwrotu (ID_Zwrotu, ID_Produktu, Ilość)
VALUES
  ('1', '4', '1'),
  ('2', '6', '1'),
  ('3', '2', '1');