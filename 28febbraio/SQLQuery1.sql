CREATE DATABASE PoliziaMunicipale;
USE PoliziaMunicipale;

CREATE TABLE Anagrafica (
    IDAnagrafica UNIQUEIDENTIFIER PRIMARY KEY,
    Cognome NVARCHAR(50) NOT NULL,
    Nome NVARCHAR(50) NOT NULL,
    Indirizzo NVARCHAR(100) NOT NULL,
    Citta NVARCHAR(50) NOT NULL,
    CAP INT NOT NULL,
    Codice_Fiscale  NVARCHAR(17) NOT NULL
);

CREATE TABLE Violazione (
    IDViolazione UNIQUEIDENTIFIER PRIMARY KEY,
    Descrizione NVARCHAR(255) NOT NULL

);

CREATE TABLE Verbale (
    IDVerbale INT NOT NULL,
    IDAnagrafica UNIQUEIDENTIFIER,
    IDViolazione UNIQUEIDENTIFIER,
    DataViolazione DATE NOT NULL,
    IndirizzoViolazione NVARCHAR(100) NOT NULL,
    Nominativo_Agente NVARCHAR(50) NOT NULL,
    DataTrascrizioneVerbale DATE NOT NULL,
    Importo DECIMAL(10,2) NOT NULL,
    DecurtamentoPunti INT NOT NULL,
    FOREIGN KEY (IDAnagrafica) REFERENCES Anagrafica(IDAnagrafica),
    FOREIGN KEY (IDViolazione) REFERENCES Violazione(IDViolazione)
);


INSERT INTO Anagrafica (IDAnagrafica, Cognome, Nome, Indirizzo, Citta, CAP, Codice_Fiscale) VALUES
(NEWID(), 'Rossi', 'Mario', 'Via Roma 1', 'Palermo', 90100, 'RSSMRA70A01H501Z'),
(NEWID(), 'Bianchi', 'Luigi', 'Via Milano 2', 'Milano', 20100, 'BNCGLG80B01F205X'),
(NEWID(), 'Verdi', 'Anna', 'Via Napoli 3', 'Napoli', 80100, 'VRDANN85C41I912Y');

INSERT INTO Violazione (IDViolazione, Descrizione) VALUES
(NEWID(), 'Eccesso di velocità'),
(NEWID(), 'Guida pericolosa'),
(NEWID(), 'Uso del telefono alla guida');

DECLARE @IDAnagrafica1 UNIQUEIDENTIFIER = (SELECT IDAnagrafica FROM Anagrafica WHERE Cognome = 'Rossi');
DECLARE @IDAnagrafica2 UNIQUEIDENTIFIER = (SELECT IDAnagrafica FROM Anagrafica WHERE Cognome = 'Bianchi');
DECLARE @IDAnagrafica3 UNIQUEIDENTIFIER = (SELECT IDAnagrafica FROM Anagrafica WHERE Cognome = 'Verdi');

DECLARE @IDViolazione1 UNIQUEIDENTIFIER = (SELECT IDViolazione FROM Violazione WHERE Descrizione = 'Eccesso di velocità');
DECLARE @IDViolazione2 UNIQUEIDENTIFIER = (SELECT IDViolazione FROM Violazione WHERE Descrizione = 'Guida pericolosa');
DECLARE @IDViolazione3 UNIQUEIDENTIFIER = (SELECT IDViolazione FROM Violazione WHERE Descrizione = 'Sosta vietata');

INSERT INTO Verbale (IDAnagrafica, IDViolazione, DataViolazione, IndirizzoViolazione, Nominativo_Agente, DataTrascrizioneVerbale, Importo, DecurtamentoPunti) VALUES
(@IDAnagrafica1, @IDViolazione1, '2024-01-15', 'Via Roma 15', 'Agente Falcone', '2024-01-16', 200.00, 3),
(@IDAnagrafica2, @IDViolazione2, '2024-02-10', 'Via Milano 25', 'Agente Borsellino', '2024-02-11', 180.00, 0),
(@IDAnagrafica3, @IDViolazione3, '2024-02-15', 'Corso Italia 30', 'Agente Cassara', '2024-02-16', 500.00, 5);

--1
SELECT COUNT(*) AS TotaleVerbali FROM Verbale;

-- 2
SELECT A.Cognome, A.Nome, COUNT(V.IDVerbale) AS NumeroVerbali
FROM Anagrafica A
JOIN Verbale V ON A.IDAnagrafica = V.IDAnagrafica
GROUP BY A.Cognome, A.Nome;

-- 3
SELECT TV.Descrizione, COUNT(V.IDVerbale) AS NumeroVerbali
FROM Violazione TV
JOIN Verbale V ON TV.IDViolazione = V.IDViolazione
GROUP BY TV.Descrizione;


