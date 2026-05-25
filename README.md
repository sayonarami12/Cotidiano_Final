# Cotidiano_Final
COTIDIANO FRAGRANCE — LOCAL SETUP

1. Install XAMPP from https://www.apachefriends.org

2. Copy the "cotidiano" folder into:
   C:\xampp\htdocs\cotidiano

3. Start Apache and MySQL in XAMPP Control Panel

4. Open your browser and go to:
   http://localhost/phpmyadmin

5. Create a new database named:
   database_cotidiano

6. Click Import → choose cotidatabase.sql → click Go

7. Open the site at:
   http://localhost/cotidiano/index.html

---
NOTE: MySQL Port
This project is configured to use port 3307.
If the site cannot connect to the database, check your XAMPP
MySQL port by clicking "Config" next to MySQL in the Control Panel
and looking for the port number.

If your port is 3306 (the default), open:
   cotidiano/config.php

And change this line:
   $conn = new mysqli("127.0.0.1", "root", "", "database_cotidiano", 3307);

To:
   $conn = new mysqli("127.0.0.1", "root", "", "database_cotidiano", 3306);
