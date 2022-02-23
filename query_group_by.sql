-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(`enrolment_date`), COUNT(`id`) AS "studenti_iscritti" FROM `students` GROUP BY YEAR(`enrolment_date`) ORDER BY YEAR(`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(`teachers`.`id`), `office_address` FROM `teachers` GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id` AS "singolo_corso", `exams`.`date` AS "data_appello", `exams`.`hour` AS "ora_appello", AVG(`vote`) AS "media_appello" FROM `exam_student` JOIN `exams` ON `exam_id` = `exams`.`id` GROUP BY `exams`.`date`, `exams`.`hour`, `exam_id` ORDER BY data_appello, ora_appello;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(`degrees`.`id`) AS "corso_di_laurea", `department_id` AS "in_dipartimento" FROM `degrees` GROUP BY `department_id`;