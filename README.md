# Engeto_SQL_Project

Cílem projektu je analyzovat životní úroveň obyvatel České republiky a odpovědět na pět stanovených výzkumných otázek, které se zaměřují na dostupnost základních potravin pro veřejnost.
Projekt vychází z rozsáhlých dat, která umožňují srovnání dostupnosti potravin v kontextu průměrných příjmů v různých časových obdobích.
Kromě toho projekt obsahuje i doplňkovou tabulku s informacemi o HDP, GINI koeficientu a populaci vybraných evropských zemí za stejné období, jako je analyzováno pro Českou republiku.
Pro sestavení podkladů pro tento projekt byly využity různé datové sady:

## Využitá data
### Primární tabulky:

czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.

czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.

czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.

czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.

czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.

### Číselníky sdílených informací o ČR:

czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.

czechia_district – Číselník okresů České republiky dle normy LAU.

### Dodatečné tabulky:

countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.

economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.

## Transformace dat
### Primární tabulka
t_martin_buchal_project_sql_primary_final

Tato tabulka poskytuje sjednocená data z primárních tabulek, číselníků o mzdách a cenách v průběhu let. Je základem pro úkoly 1 až 4.

## Sekundární tabulka
t_martin_buchal_project_sql_secondary_final

Tato tabulka poskytuje sjednocená data dodatečných tabulek countries a economies, který byla využita pro splnění posledního 5. úkolu.

## Výzkumné otázky:

# 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

V rámci výzkumu bylo provedeno 247 měření mezd ve 19 různých odvětvích v období let 2006 až 2018. Meziroční pokles mezd byl zaznamenán u 25 případů.

Do roku 2008 zaznamenaly všechny sektory růst mezd. Poté se však začaly projevovat dopady světové ekonomické krize, a některé sektory začaly vykazovat meziroční poklesy mezd, přičemž největší poklesy byly zaznamenány v roce 2013, a to konkrétně u odvětví Peněžnictví a pojišťovnictví, kde mzdy poklesly v průměru o 9,7%.
Mezi roky 2014 a 2018 došlo ke stabilnímu růstu mezd téměř ve všech odvětvích, s výjimkou jednotlivých sektorů v letech 2014 až 2016.
V roce 2009 došlo k poklesu mezd ve čtyřech odvětvích, přičemž největší pokles byl zaznamenán v sektoru Těžba a dobývání, kde průměrná mzda klesla o 3,2 %.
Rok 2010 přinesl pokles mezd ve třech odvětvích, přičemž největší pokles byl v oblasti Vzdělávání, kde průměrná mzda klesla o 1,7 %.
V roce 2011 došlo k poklesu mezd ve čtyřech odvětvích, přičemž největší pokles byl v sektoru Veřejná správa a obrana; povinné sociální zabezpečení, kde průměrná mzda klesla o 2,3 %
Rok 2012 se pak nesl ve znamení zvýšení mezd ve všech sektorech.
V roce 2013 došlo k poklesu mezd v 11 odvětvích, přičemž největší pokles obyl v sektoru Peněžnictví a pojišťovnictví, a to o 9,7%, jak je již zmíměno výše.
Další sledované roky, tedy 2014, 2015 a 2016 byly pozitivnější a došlo k poklesu vždy pouze u jednoho odvětví. V roce 2014 Těžba a dobývání s poklesem O 0,6%, roce 2015 Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu s poklesem 1,6%, načež si svoji roli zopakovalo odvětví Těžba a dobývání a mzdy v něm klesly opět o 0,6%.
V letech 2017 a 2018 pak došlo k růstu mezd ve všech odvětvích.

# 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

V roce 2006 bylo možné za průměrnou mzdu 21 165 Kč nakoupit 1 465 litrů mléka, přičemž cena jednoho litru byla 14,44 Kč.
Oproti tomu v roce 2018, kdy průměrná mzda vzrostla na 33 092 Kč, bylo možné pořídit 1 670 litrů mléka. To znamená, že oproti roku 2006 bylo možné nakoupit o 205 litrů více, ačkoli cena mléka vzrostla na 19,82 Kč za litr.
Pokud se podíváme na chléb, v roce 2006 byla cena jednoho kilogramu chleba 16,12 Kč a za průměrnou mzdu bylo možné zakoupit 1 313 kg chleba.
V roce 2018, kdy cena chleba dosáhla 24,24 Kč za kilogram, bylo možné při průměrné mzdě 33 092 Kč koupit 1 365 kg chleba, což je o 52 kg více než v roce 2006.

# 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

Odpověď na tuto otázku jsem se rozhodl vyhodnotit z vícero úhlů. Na její výstup by se podle zadání dale nahlížet rozdílně, proto zde prezentuji vícero možných interpretací.

Výsledný dotaz má 27 případů, které pomohou odpovědět na výzkumnou otázku.

Největší průměrný pokles cen patří Cukru krystal, jehož cena klesala za dobu měření v průměru o 1,92%. Na druhé straně, největší průměrný nárůst ceny je u paprik, které rostou v průměru o 7,29%.
Pokud bychom ale hledali exaktní odpověď na otázku, která z kategorií zdražuje (nezlevňuje) nejpomaleji, tak jsou to Banány žluté, které v průměru měření zdražují "jen" o 0,81%.

Obdobnou analogií se podíváme i na jednotlivé meziroční nárůsty.
I z pohledu nejvyššího meziročního nárůstu vedou Papriky, kdy mezi roky 2006 a 2007 rostly o 94,82%, nejvíce zlevnily Rajská jablka, a to o 30,28% mezi lety 2006 až 2007.
Nicméně pokud bychom chtěli znovu přesně odpovědět na zadanou otázku, tak nejpomaleji meziročně zdražilo Pivo výčepní v letech 2014-2015, což potěší každého správného pivaře :). 

# 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

V průběhu výzkumu bylo provedeno 12 měření srovnávajících růst cen potravin a růst mezd v období mezi lety 2006 a 2018. Největší rozdíl mezi růstem cen potravin a růstem mezd byl zaznamenán mezi lety 2012 a 2013, kdy ceny potravin vzrostly o 5,1 %, zatímco mzdy ve stejném roce poklesly o 1,56 %. Vzájemný rozdíl tedy činí 6,66pb. 
Nejblíže se k sobě meziroční nárůsty cen a mezd měly mezi lety 2009 a 2010, kdy ceny rostly o 1,95% a mzdy naproti tomu o 1,91%.

# 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

Pro vyhodnocení vlivu jsem zvolil výpočet korelace. Pro upřesnění níže uvádím u korelační škálu a následně pak výsledné korelace pro jednotlivé vztahy.

Korelační škála:

Pearsonův korelační koeficient (r) je číslo v rozmezí od -1 do 1:

	•	r = 1: Dokonalá pozitivní korelace. Když jedna proměnná roste, druhá roste přesně stejnou měrou.
	•	r = -1: Dokonalá negativní korelace. Když jedna proměnná roste, druhá klesá přesně stejnou měrou.
	•	r = 0: Žádná korelace. Mezi proměnnými neexistuje žádný vztah.
	•	r > 0: Pozitivní korelace. Jak roste jedna proměnná, druhá má tendenci také růst.
	•	0.1 < r < 0.3: Slabá pozitivní korelace.
	•	0.3 < r < 0.5: Střední pozitivní korelace.
	•	r > 0.5: Silná pozitivní korelace.
	•	r < 0: Negativní korelace. Jak roste jedna proměnná, druhá má tendenci klesat.
	•	-0.1 > r > -0.3: Slabá negativní korelace.
	•	-0.3 > r > -0.5: Střední negativní korelace.
	•	r < -0.5: Silná negativní korelace.

1. YoY_GDP_diff vs. YoY_Wages_diff (0,44):

Středně silná pozitivní korelace mezi růstem HDP a růstem mezd naznačuje, že s rostoucí ekonomikou mají firmy více zdrojů na zvyšování mezd. Nicméně vztah není silný, což ukazuje na přítomnost dalších faktorů.

Další faktory ovlivňující tento vztah:

	•	Produktivita práce: Zvýšení produktivity může vést k vyšším mzdám bez nutnosti růstu HDP.
	•	Míra nezaměstnanosti: Nízká nezaměstnanost zvyšuje tlak na růst mezd.
	•	Inflace: Vyšší inflace může zvyšovat nominální mzdy, aniž by to odráželo skutečný růst kupní síly.
	•	Vládní politiky: Minimální mzda, daňové politiky a regulace pracovního trhu mohou ovlivnit mzdy nezávisle na HDP.
	•	Globální ekonomické vlivy: Například outsourcing nebo mezinárodní konkurence mohou tlačit mzdy dolů, i když HDP roste.
    
2. YoY_GDP_diff vs. YoY_Price_diff (0,49):

Středně silná pozitivní korelace mezi růstem HDP a růstem cen potravin naznačuje, že ekonomický růst může vést k vyšší poptávce po potravinách a tím i k růstu cen.

Další faktory ovlivňující tento vztah:

	•	Náklady na suroviny: Ceny zemědělských komodit mohou být ovlivněny globálními trhy a počasím.
	•	Dopravní náklady: Růst cen paliv může zvýšit náklady na přepravu potravin.
	•	Kurz měny: Silnější nebo slabší měna ovlivňuje ceny importovaných potravin.
	•	Politické faktory: Cla, dotace a regulace mohou ovlivnit ceny potravin.
	•	Technologický pokrok: Zlepšení v zemědělství může zvýšit nabídku a snížit ceny.

3. YoY_Wages_diff vs. YoY_Price_diff (0,28):

Relativně slabá korelace mezi růstem mezd a růstem cen potravin naznačuje, že změny v mzdách mají omezený přímý dopad na ceny potravin.

Další faktory ovlivňující tento vztah:

	•	Spotřebitelské návyky: Zvýšení mezd nemusí nutně vést k vyšší spotřebě potravin.
	•	Konkurenční prostředí: Vysoká konkurence v maloobchodě může omezit růst cen i při vyšší poptávce.
	•	Technologické inovace: Efektivnější výroba a distribuce mohou snižovat náklady na potraviny.
	•	Mezinárodní obchod: Import levnějších potravin může držet ceny nízko bez ohledu na domácí mzdové úrovně.




