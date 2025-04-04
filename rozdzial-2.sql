-- Zadanie 1
select *
  from zespoly
 order by id_zesp asc;

-- Zadanie 2
select *
  from pracownicy
 order by id_prac asc;

-- Zadanie 3
select nazwisko,
       placa_pod * 12 as roczna_placa
  from pracownicy
 order by nazwisko asc;

-- Zadanie 4
select nazwisko,
       etat,
       placa_pod + coalesce(
          placa_dod,
          0
       ) as miesieczne_zarobki
  from pracownicy
 order by miesieczne_zarobki desc;

-- Zadanie 5
select *
  from zespoly
 order by nazwa asc;

-- Zadanie 6
select distinct etat
  from pracownicy
 order by etat asc;

-- Zadanie 7
select *
  from pracownicy
 where etat = 'ASYSTENT'
 order by nazwisko;

-- Zadanie 8
select id_prac,
       nazwisko,
       etat,
       placa_pod,
       id_zesp
  from pracownicy
 where id_zesp in ( 30,
                    40 )
 order by placa_pod desc;

-- Zadanie 9
select nazwisko,
       id_zesp,
       placa_pod
  from pracownicy
 where placa_pod between 300 and 800
 order by nazwisko asc;

-- Zadanie 10
select nazwisko,
       etat,
       id_zesp
  from pracownicy
 where nazwisko like '%SKI'
 order by nazwisko asc;

-- Zadanie 11
select id_prac,
       id_szefa,
       nazwisko,
       placa_pod
  from pracownicy
 where placa_pod > 1000
   and id_szefa is not null;

-- Zadanie 12
select nazwisko,
       id_zesp
  from pracownicy
 where id_zesp = 20
   and ( nazwisko like 'M%'
    or nazwisko like '%SKI' )
 order by nazwisko;

-- Zadanie 13
select nazwisko,
       etat,
       placa_pod / 160 as stawka
  from pracownicy
 where etat not in ( 'ADIUNKT',
                     'ASYSTENT',
                     'STAZYSTA' )
   and placa_pod not between 400 and 800
 order by stawka asc;

-- Zadanie 14
select nazwisko,
       etat,
       placa_pod,
       placa_dod
  from pracownicy
 where placa_pod + coalesce(
   placa_dod,
   0
) > 1000
 order by etat,
          nazwisko;

-- Zadanie 15
select nazwisko
       || ' PRACEUJE OD '
       || zatrudniony
       || ' I ZARABIA '
       || placa_pod as profesorowie
  from pracownicy
 where etat = 'PROFESOR'
 order by placa_pod desc;