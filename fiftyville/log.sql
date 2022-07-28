-- Keep a log of any SQL queries you execute as you solve the mystery.
-- See whats in reports
SELECT * FROM crime_scene_reports;

--Find report of stolen duck
SELECT * FROM crime_scene_reports WHERE street = "Humphrey Street";
--crime_scene_reports.id is 295

SELECT * FROM crime_scene_reports WHERE id = 295;
--Year=2021, Month=7, day=28, time=10:15am, place=Humphrey Street bakery

--See whats inside interviews
SELECT * FROM interviews WHERE year = 2021 AND month = 7 AND day = 28;
--thief drove away 10 minutes later from parking lot
--earlier thief withdrew money from ATM on Leggett Street
--while leaving bakery thief called acomplice for less than a minute earliest flight out of fiftyville. acomplice bought ticket.

--See whats inside ATM transactions
SELECT * FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%";
--Suspect's account_number inside this list

--See who is inside bank_accounts
SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%");
--Suspect's id inside this list

--Which of these people boarded a flight


--See who drove away from parking lot
SELECT * FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 22 AND minute < 42;
--Suspect's license plate inside this list

--Narrow down suspects list
SELECT name FROM people WHERE license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 22 AND minute < 42) AND id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%"));
--Returns 2 suspects. Taylor and Diana. Check if any of them boarded a flight.

--Did suspects board flights?
SELECT flight_id FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 22 AND minute < 42) AND id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%")));

--Which flights?
SELECT * FROM flights WHERE id IN (SELECT flight_id FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 22 AND minute < 42) AND id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%"))));
--Suspect boarded one ofthese flights

--Which flight originated in Fiftyville
SELECT city FROM airports WHERE id = 7;

--Who made a phone call then?
SELECT * FROM phone_calls WHERE caller IN (SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 22 AND minute < 42) AND id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%"))) AND month = 7 AND day = 28;
--Same 2 suspects

--Who received a phone call?
SELECT * FROM people WHERE phone_number IN (SELECT receiver FROM phone_calls WHERE caller IN (SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 22 AND minute < 42) AND id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%"))) AND month = 7 AND day = 28);


--Who flew where?
SELECT people.name, flights.id, flights.origin_airport_id, flights.destination_airport_id, flights.year, flights.month, flights.day, flights.hour, flights.minute  FROM people JOIN passengers ON people.passport_number = passengers.passport_number JOIN flights ON passengers.flight_id = flights.id WHERE passengers.passport_number IN (SELECT passport_number FROM people WHERE license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 22 AND minute < 42) AND id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%"))) ORDER BY day, hour;
--Taylor is the only one with a 1-way ticket.

--Which city?
SELECT * FROM phone_calls WHERE caller IN (SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 22 AND minute < 42) AND id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%"))) AND month = 7 AND day = 28;

SELECT name FROM people JOIN phone_calls ON

SELECT name FROM people WHERE phone_number = "(725) 555-3243"

SELECT city FROM airports WHERE id = 4;



--Find report of stolen duck
SELECT * FROM crime_scene_reports WHERE street = "Humphrey Street";

SELECT * FROM interviews WHERE year = 2021 AND month = 7 AND day = 28;


SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour >= 10 AND hour <= 11;
--thief drove away 10 minutes later from parking lot

SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%");
--earlier thief withdrew money from ATM on Leggett Street


--3 suspects' names:
SELECT passport_number FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%")) AND license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour >= 10 AND hour <= 11) AND phone_number IN (SELECT caller FROM phone_calls WHERE day = 28 AND duration <= 60);

--who boarded a flight?
SELECT flight_id FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%")) AND license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour >= 10 AND hour <= 11) AND phone_number IN (SELECT caller FROM phone_calls WHERE day = 28 AND duration <= 60));

SELECT * FROM flights WHERE id IN (SELECT flight_id FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%")) AND license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour >= 10 AND hour <= 11) AND phone_number IN (SELECT caller FROM phone_calls WHERE day = 28 AND duration <= 60)));

SELECT * FROM flights WHERE id in (SELECT flight_id FROM passengers WHERE passport_number IN (SELECT passport_number FROM people ))

SELECT name


SELECT id, name FROM people JOIN WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%")) AND license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour >= 10 AND hour <= 11) AND phone_number IN (SELECT caller FROM phone_calls WHERE day = 28 AND duration <= 60);



SELECT DISTINCT(name) FROM people
JOIN passengers ON people.passport_number = passengers.passport_number
JOIN flights ON passengers.flight_id = flights.id
JOIN bank_accounts ON people.id = bank_accounts.person_id
JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
JOIN phone_calls ON people.phone_number = phone_calls.caller
WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location LIKE "%Leggett%") AND bakery_security_logs.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour >= 10 AND hour <= 11) AND phone_number IN (SELECT caller FROM phone_calls WHERE day = 28 AND duration <= 60);

SELECT * FROM flights WHERE id IN (SELECT flight_id FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE name = "Bruce"));

SELECT receiver FROM phone_calls WHERE caller = (SELECT phone_number FROM people WHERE name = "Bruce") AND month = 7 AND day = 28 AND duration <= 60;

SELECT name FROM people WHERE phone_number = "(375) 555-8161";