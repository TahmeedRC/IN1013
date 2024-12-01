Task 3. Joins.Specify SQL queries to satisfy the following:1. List the names of the waiters who have served the customer Tanya Singh.2. On which dates in February 2016 did the Headwaiter 'Charles' manage the 'Green' room? The output date should be in the format they are stored.3. List the names and surnames of the waiters with the same headwaiter as the waiter Zoe Ball.4. List the customer name, the amount they spent and the waiter�s name for all bills. Order the list by the amount spent, highest bill first.5. List the names and surnames of the waiters who serve tables that worked in the same team that served bills 00014 and 00017.6. List the names and surnames of the waiters in the team (including the headwaiter) that served Blue room on 160312.1.  SELECT rs.first_name, rs.surname     FROM restBill rb     JOIN restStaff rs ON rb.waiter_no = rs.staff_no     WHERE rb.cust_name = 'Tanya Singh';2. SELECT rm.room_date     FROM restRoom_management rm     JOIN restStaff rs ON rm.headwaiter = rs.staff_no     WHERE rm.room_name = 'Green'         AND rs.first_name = 'Charles'         AND rm.room_date BETWEEN 160201 AND 160229;3. SELECT rs.first_name, rs.surname    FROM restStaff rs    WHERE rs.headwaiter = (        SELECT headwaiter        FROM restStaff        WHERE first_name = 'Zoe' AND surname = 'Ball'    );4. SELECT         rb.cust_name AS customer_name,         rb.bill_total AS amount_spent,         rs.first_name || ' ' || rs.surname AS waiter_name    FROM         restBill rb    JOIN         restStaff rs ON rb.waiter_no = rs.staff_no    ORDER BY         rb.bill_total DESC;5. SELECT DISTINCT rs.first_name, rs.surnameFROM restBill rbJOIN restStaff rs ON rb.waiter_no = rs.staff_noWHERE rb.table_no IN (    SELECT DISTINCT table_no    FROM restBill    WHERE bill_no IN (00014, 00017));6. SELECT DISTINCT rs.first_name, rs.surnameFROM restStaff rsWHERE rs.staff_no IN (    SELECT rrm.headwaiter    FROM restRoom_management rrm    WHERE rrm.room_name = 'Blue' AND rrm.room_date = 160312    UNION    SELECT rb.waiter_no    FROM restBill rb    JOIN restRest_table rrt ON rb.table_no = rrt.table_no    WHERE rrt.room_name = 'Blue' AND rb.bill_date = 160312);