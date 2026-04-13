SET SERVEROUTPUT ON;


-- EXERCICE 1


-- 1
DECLARE
    a NUMBER := &a;
    b NUMBER := &b;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Somme = ' || (a + b));
END;
/

-- 2
DECLARE
    n NUMBER := &n;
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(n || ' x ' || i || ' = ' || (n*i));
    END LOOP;
END;
/

-- 3
CREATE OR REPLACE FUNCTION puissance(x NUMBER, n NUMBER)
RETURN NUMBER IS
BEGIN
    IF n = 0 THEN
        RETURN 1;
    ELSE
        RETURN x * puissance(x, n-1);
    END IF;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('2^3 = ' || puissance(2,3));
END;
/

-- 4 et 5
CREATE TABLE resultatFactoriel (
    n NUMBER,
    fact NUMBER
);

DECLARE
    fact NUMBER;
BEGIN
    FOR n IN 1..20 LOOP
        fact := 1;
        FOR i IN 1..n LOOP
            fact := fact * i;
        END LOOP;

        INSERT INTO resultatFactoriel VALUES (n, fact);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Factorielles insérées');
END;
/


-- EXERCICE 2


-- 
CREATE TABLE emp (
    matr NUMBER(10) PRIMARY KEY,
    nom VARCHAR2(50),
    sal NUMBER(7,2),
    adresse VARCHAR2(96),
    dep NUMBER(10)
);

-- 1
DECLARE
    v_employe emp%ROWTYPE;
BEGIN
    v_employe.matr := 4;
    v_employe.nom := 'Youcef';
    v_employe.sal := 2500;
    v_employe.adresse := 'avenue Anatole France';
    v_employe.dep := 92000;

    INSERT INTO emp VALUES v_employe;
END;
/

-- 2
DECLARE
    v_nb NUMBER;
BEGIN
    DELETE FROM emp WHERE dep = 10;
    v_nb := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Supprimés : ' || v_nb);
END;
/

-- 3 et 4
DECLARE
    v_salaire emp.sal%TYPE;
    v_total NUMBER := 0;
    v_count NUMBER := 0;

    CURSOR c IS SELECT sal FROM emp;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v_salaire;
        EXIT WHEN c%NOTFOUND;

        IF v_salaire IS NOT NULL THEN
            v_total := v_total + v_salaire;
            v_count := v_count + 1;
        END IF;
    END LOOP;
    CLOSE c;

    DBMS_OUTPUT.PUT_LINE('Total = ' || v_total);
    DBMS_OUTPUT.PUT_LINE('Moyenne = ' || (v_total / v_count));
END;
/

-- 5
DECLARE
    v_total NUMBER := 0;
    v_count NUMBER := 0;
BEGIN
    FOR rec IN (SELECT sal FROM emp) LOOP
        IF rec.sal IS NOT NULL THEN
            v_total := v_total + rec.sal;
            v_count := v_count + 1;
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total FOR = ' || v_total);
    DBMS_OUTPUT.PUT_LINE('Moyenne FOR = ' || (v_total / v_count));
END;
/

-- 6
DECLARE
    CURSOR c(p_dep emp.dep%TYPE) IS
        SELECT nom FROM emp WHERE dep = p_dep;
BEGIN
    FOR v IN c(92000) LOOP
        DBMS_OUTPUT.PUT_LINE('Dep 92000 : ' || v.nom);
    END LOOP;

    FOR v IN c(75000) LOOP
        DBMS_OUTPUT.PUT_LINE('Dep 75000 : ' || v.nom);
    END LOOP;
END;
/


-- EXERCICE 3


-- Table CLIENT
CREATE TABLE client (
    id NUMBER PRIMARY KEY,
    nom VARCHAR2(50),
    age NUMBER
);

-- SPEC
CREATE OR REPLACE PACKAGE pkg_client IS
    PROCEDURE ajouter_client(p_id NUMBER, p_nom VARCHAR2);
    PROCEDURE ajouter_client(p_id NUMBER, p_nom VARCHAR2, p_age NUMBER);
END pkg_client;
/

-- BODY
CREATE OR REPLACE PACKAGE BODY pkg_client IS

    PROCEDURE ajouter_client(p_id NUMBER, p_nom VARCHAR2) IS
    BEGIN
        INSERT INTO client(id, nom) VALUES (p_id, p_nom);

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('ID existe déjà');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur');
    END;

    PROCEDURE ajouter_client(p_id NUMBER, p_nom VARCHAR2, p_age NUMBER) IS
    BEGIN
        INSERT INTO client(id, nom, age)
        VALUES (p_id, p_nom, p_age);

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('ID existe déjà');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur');
    END;

END pkg_client;
/

-- Test
BEGIN
    pkg_client.ajouter_client(1, 'Ali');
    pkg_client.ajouter_client(2, 'Sara', 25);
END;
/
