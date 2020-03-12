INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Adam', 'Kowalski', '87654321', 'tel: 6623');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jan', 'Nowak', '12345678', 'tel: 2312, dzwonić po 18.00');

INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wycieczka do Paryza','Francja',TO_DATE('2016-01-01','YYYY-MM-DD'),'Ciekawa wycieczka ...',3);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Piękny Kraków','Polska',TO_DATE('2017-02-03','YYYY-MM-DD'),'Najciekawa wycieczka ...',2);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wieliczka','Polska',TO_DATE('2017-03-03','YYYY-MM-DD'),'Zadziwiająca kopalnia ...',2);

--UWAGA
--W razie problemów z formatem daty można użyć funkcji TO_DATE
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wieliczka2','Polska',TO_DATE('2017-03-03','YYYY-MM-DD'),
 'Zadziwiająca kopalnia ...',2);



INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (2,1,'N');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (3,2,'P');

select * from OSOBY;
select * from WYCIECZKI;

insert into OSOBY(IMIE,NAZWISKO,PESEL,KONTAKT)
values('Bartosz','Bartosiewicz','123123123','tel: 123');
insert into OSOBY(IMIE,NAZWISKO,PESEL,KONTAKT)
values('Tomasz','Tomasiewicz','13425277','tel: 122');
insert into OSOBY(IMIE,NAZWISKO,PESEL,KONTAKT)
values('Kuba','Kubasiewicz','1264343345','tel: 111');
insert into OSOBY(IMIE,NAZWISKO,PESEL,KONTAKT)
values('Maja','Majewska','65462467353','tel: 222');
insert into OSOBY(IMIE,NAZWISKO,PESEL,KONTAKT)
values('Mariusz','Mariusiewicz','12315345','tel: 333');
insert into OSOBY(IMIE,NAZWISKO,PESEL,KONTAKT)
values('Andrzej','Andrejewicz','1999999','tel: 444');
insert into OSOBY(IMIE,NAZWISKO,PESEL,KONTAKT)
values('Bogdan','Bogdanowicz','88888888','tel: 555');
insert into OSOBY(IMIE,NAZWISKO,PESEL,KONTAKT)
values('Janusz','Janusiewicz','666666666','tel: 666');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (2,3,'Z');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (2,4,'A');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (3,5,'N');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (3,6,'P');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4,7,'Z');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4,8,'A');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (5,9,'N');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (5,10,'P');

select * from REZERWACJE;


CREATE VIEW RezerwacjeWszystkie
 AS
 SELECT
 w.ID_WYCIECZKI,
 w.NAZWA,
 w.KRAJ,
 w.DATA,
 o.IMIE,
 o.NAZWISKO,
 r.STATUS
 FROM WYCIECZKI w
 JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
 JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY;


select * from RezerwacjeWszystkie;

Create VIEW RezerwacjePotwierdzone
 AS
 SELECT
 w.ID_WYCIECZKI,
 w.NAZWA,
 w.KRAJ,
 w.DATA,
 o.IMIE,
 o.NAZWISKO,
 r.STATUS
 FROM WYCIECZKI w
 JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
 JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
 WHERE r.STATUS = 'P';

select * from RezerwacjePotwierdzone;

create view RezerwacjeWPrzyszlosci
 as
    select
     w.ID_WYCIECZKI,
     w.NAZWA,
     w.KRAJ,
     w.DATA,
     o.IMIE,
     o.NAZWISKO,
     r.STATUS
     FROM WYCIECZKI w
     JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
     JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
     WHERE w.DATA > CURRENT_DATE;


INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wieliczka3','Polska',TO_DATE('2021-03-03','YYYY-MM-DD'),
 'Zadziwiająca kopalnia ...',5);

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (21,10,'P');

select * from WYCIECZKI;

select * from RezerwacjeWPrzyszlosci

create view WycieczkiMiejsca
 as
    select
     w.ID_WYCIECZKI,
     w.NAZWA,
     w.KRAJ,
     w.DATA,
     w.LICZBA_MIEJSC,
    w.LICZBA_MIEJSC - WolneMiejsca(w.ID_WYCIECZKI) as wolne
     FROM WYCIECZKI w;


CREATE  OR REPLACE FUNCTION WolneMiejsca (IDWYCIECZKI int)
   RETURN int
   IS result INT;
BEGIN
    select count(r.ID_WYCIECZKI) into result
    from WYCIECZKI wy
    join REZERWACJE r on wy.ID_WYCIECZKI = r.ID_WYCIECZKI
    where wy.ID_WYCIECZKI = IDWYCIECZKI;

    return result;
END WolneMiejsca;

select * from WYCIECZKI;
select * from rezerwacje;

select WolneMiejsca(5) from DUAL;

select * from WycieczkiMiejsca;
select * from rezerwacje;

create view WycieczkiDostepne
 as
    select
     w.ID_WYCIECZKI,
     w.NAZWA,
     w.KRAJ,
     w.DATA,
     w.LICZBA_MIEJSC,
    w.LICZBA_MIEJSC - WolneMiejsca(w.ID_WYCIECZKI) as wolne
     FROM WYCIECZKI w
    where w.DATA > CURRENT_DATE and WolneMiejsca(w.ID_WYCIECZKI) > 0;

select * from WycieczkiDostepne;

create or replace type t_uczestnik_row as object(
    ID_WYCIECZKI INT,
    IMIE VARCHAR2(50),
    NAZWISKO VARCHAR(50),
    PESEL VARCHAR2(11),
    STATUS char(1),
    NR_REZERWACJI int
                                            );

create or replace type t_uczestnik_table as table of t_uczestnik_row;

CREATE  OR REPLACE FUNCTION UczestnicyWycieczki (idWycieczki int)
   RETURN t_uczestnik_table PIPELINED IS
BEGIN
    for i IN
   (select w.ID_WYCIECZKI, o.IMIE, o.NAZWISKO, o.PESEL, r.STATUS, r.NR_REZERWACJI
    from WYCIECZKI w
    join REZERWACJE r on w.ID_WYCIECZKI = r.ID_WYCIECZKI
    join OSOBY o on o.ID_OSOBY = r.ID_OSOBY
    where w.ID_WYCIECZKI = idWycieczki) LOOP
        PIPE ROW(t_uczestnik_row(i.ID_WYCIECZKI,i.IMIE,i.NAZWISKO,i.PESEL,i.STATUS,i.NR_REZERWACJI));

        end loop;
    return;
END UczestnicyWycieczki;
