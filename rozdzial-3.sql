-- Zadanie 1
select nazwisko,
       substr(
          etat,
          1,
          2
       )
       || id_prac as kod
  from pracownicy;

-- Zadanie 2
select nazwisko,
       translate(
          nazwisko,
          'KLM',
          'XXX'
       ) as wojna_literom
  from pracownicy;

-- Zadanie 3
select nazwisko
  from pracownicy
 where instr(
   substr(
      nazwisko,
      1,
      length(nazwisko) / 2
   ),
   'L',
   1,
   1
) > 0;

-- Zadanie 4
select nazwisko,
       round(
          placa_pod * 1.15,
          0
       )
  from pracownicy;

-- Zadanie 5
select nazwisko,
       placa_pod,
       placa_pod * 0.2 as inwestycja,
       placa_pod * 0.2 * ( power(
          1.1,
          10
       ) ) as kapital,
       placa_pod * 0.2 * ( ( power(
          1.1,
          10
       ) ) - 1 ) as zysk
  from pracownicy;

-- Zadanie 6
select nazwisko,
       zatrudniony,
       extract(year from(date '2000-01-01' - zatrudniony) year to month) as staz_w_2000
  from pracownicy;

-- Zadanie 7
select nazwisko,
       to_char(
          zatrudniony,
          'MONTH, DD YYYY'
       ) as data_zatrudnienia
  from pracownicy
 where id_zesp = 20;

-- Zadanie 8
select to_char(
   sysdate,
   'DAY'
) as today
  from dual;

-- Zadanie 9
select nazwa,
       adres,
       case
          when ( adres like 'MIELZYNSKIEGO%'
              or adres like 'STRZELECKA%' ) then
             'STARE MIASTO'
          when adres like 'PIOTROWO%' then
             'NOWE MIASTO'
          when adres like 'WLODKOWICA%' then
             'GRUNWALD'
       end as dzielnica
  from zespoly;

-- Zadanie 10
select nazwisko,
       placa_pod,
       case
          when placa_pod < 480 then
             'Ponizej 480'
          when placa_pod = 480 then
             'Dokladnie 480'
          else
             'Powyzej 480'
       end as prog
  from pracownicy
 order by placa_pod desc;

-- Zadanie 11
select nazwisko,
       id_zesp,
       placa_pod
  from pracownicy
 where placa_pod >= case
   when id_zesp = 10 then
      1070.10
   when id_zesp = 20 then
      616.60
   when id_zesp = 30 then
      502.00
   when id_zesp = 40 then
      1350.00
                    end
 order by id_zesp,
          placa_pod;

-- Zadanie 11 ze skorelowanym podzapytaniem
select nazwisko,
       id_zesp,
       placa_pod
  from pracownicy p1
 where placa_pod > (
   select avg(placa_pod)
     from pracownicy
    where id_zesp = p1.id_zesp
);

-- Zadanie 12
select nazwisko,
       etat,
       case
          when etat in ( 'PROFESOR',
                         'DYREKTOR' ) then
             extract(year from(date '2000-01-01' - zatrudniony) year to month)
       end as staz_w_2000,
       case
          when etat in ( 'ASYSTENT',
                         'ADIUNKT' ) then
             extract(year from(date '2010-01-01' - zatrudniony) year to month)
       end as staz_w_2010,
       case
          when etat in ( 'STAZYSTA',
                         'SEKRETARKA' ) then
             extract(year from(date '2020-01-01' - zatrudniony) year to month)
       end as staz_w_2020
  from pracownicy
 order by staz_w_2000 nulls last,
          staz_w_2010 nulls last,
          staz_w_2020 nulls last;