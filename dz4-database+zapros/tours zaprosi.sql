--Системная аналитика, УлГУ, 2 курс - ИС-О-24/1 Казаков Артём
--



--агрегатная функция SUM, суммирует все платежи с неактивных туров
SELECT SUM(payments.amount)
FROM payments
JOIN bookings ON payments.payment_id = bookings.booking_id
WHERE bookings.status_active = FALSE;
--


--JOIN трёх таблиц, соединяет название тура и его длительность с датой бронирования и ценой, а также фамилией бронировавшего
SELECT 
    tours.name,
    tours.duration,
    bookings.booking_date,
    bookings.total_price,
    customers.last_name
FROM bookings
JOIN tour_instance ON bookings.instance_id = tour_instance.instance_id
JOIN tours ON tour_instance.tour_id = tours.tour_id
JOIN customers ON bookings.customer_id = customers.customer_id;
--


--GROUP BY, считает и группирует методы проведения оплаты (картой или наличными)
SELECT 
    method,
    COUNT(*),
    SUM(amount)
FROM payments
GROUP BY method
ORDER BY SUM(amount) DESC;
--


--вложенный запрос, вычленяет гидов с действующей аккредитацией и рейтингом выше среднего
SELECT last_name, rating
FROM guides
WHERE rating > (
    SELECT AVG(rating)
    FROM guides
    WHERE accreditation_valid = TRUE
);
--


--условный оператор, на основе возраста определяет человека в некоторую группу (списал из интернета)
SELECT 
    last_name,
    birthdate,
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(birthdate)) < 18 THEN 'Молодой'
        WHEN EXTRACT(YEAR FROM AGE(birthdate)) BETWEEN 18 AND 39 THEN 'Взрослый'
        WHEN EXTRACT(YEAR FROM AGE(birthdate)) BETWEEN 40 AND 60 THEN 'Старый'
        ELSE 'Пенсионер'
    END
FROM customers;
--