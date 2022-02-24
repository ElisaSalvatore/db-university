-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(`enrolment_date`), COUNT(`id`) AS "ID_Studenti_iscritti" 
FROM `students` GROUP BY YEAR(`enrolment_date`) 
ORDER BY YEAR(`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT `office_address`, COUNT(`teachers`.`id`)
FROM `teachers` 
GROUP BY `office_address`;

-- Esempio usando HAVING
-- SELECT `office_address`, COUNT(`teachers`.`id`) 
-- FROM `teachers` 
-- GROUP BY `office_address`
-- 	HAVING COUNT(`teachers`.`id`) > 1;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id` AS "ID_Appello", `exams`.`date` AS "data_appello", `exams`.`hour` AS "ora_appello", 
        ROUND(AVG(`vote`), 1) AS "media_voti_appello" 
        -- ROUND AVG per arrotondare, mentre il numero "1" indica quante cifre decimali vogliamo mostrare (dopo la virgola)
FROM `exam_student` 
JOIN `exams` 
    ON `exam_id` = `exams`.`id` 
GROUP BY `exams`.`date`, `exams`.`hour`, `exam_id` 
    HAVING AVG(`vote`) > 20
ORDER BY `data_appello`, `ora_appello`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(`degrees`.`id`) AS "ID_Corso_di_laurea", 
    `department_id` AS "ID_(in)Dipartimento" 
FROM `degrees` 
GROUP BY `department_id`;