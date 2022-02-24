-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`id`, `degrees`.`name` 
FROM `students` 
INNER JOIN `degrees` 
    ON `students`.`degree_id` = `degrees`.`id` 
WHERE `degrees`.`name` = "Corso di Laurea in Economia" 
ORDER BY `students`.`id`;

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT `degrees`.`id`AS "ID_Corso_laurea", `degrees`.`name` AS "nome_corso_laurea", 
        `departments`.`id`AS "ID_Dipartimento", `departments`.`name` AS "nome_dipartimento" 
FROM `degrees` 
INNER JOIN `departments` 
    ON `degrees`.`department_id` = `departments`.`id` 
WHERE `departments`.`name` = "Dipartimento di Neuroscienze";

-- Altro esempio dove andiamo a filtrare solamente i corsi di laurea magistrali:
-- SELECT `degrees`.`id`AS "ID_Corso_laurea", `degrees`.`name` AS "nome_corso_laurea", `degrees`.`level`, 
--         `departments`.`id`AS "ID_Dipartimento", `departments`.`name` AS "nome_dipartimento" 
-- FROM `degrees` 
-- INNER JOIN `departments`
--      ON `degrees`.`department_id` = `departments`.`id` 
-- WHERE `departments`.`name` = "Dipartimento di Neuroscienze" 
--     AND `degrees`.`level` = "magistrale" 

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `teachers`.`id` AS "ID_Insegnante", `teachers`.`name`, `teachers`.`surname`, 
        `courses`.`id` AS "ID_Corso", `courses`.`name` AS "nome_corso" FROM `course_teacher` 
INNER JOIN `teachers` 
    ON `course_teacher`.`teacher_id` = `teachers`.`id` 
INNER JOIN `courses` 
    ON `course_teacher`.`course_id` = `courses`.`id` 
WHERE `teacher_id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`id` AS "ID_Studente",`students`.`surname`, `students`.`name`, `students`.`registration_number`,
        `departments`.`id` AS "ID_Dipartimento",`departments`.`name`, 
        `degrees`.`id` AS "ID_Corso_laurea", `degrees`.`name`, `degrees`.`level`, `degrees`.`address`, `degrees`.`email`, `degrees`.`website` 
FROM `degrees` 
INNER JOIN `departments` 
    ON `degrees`.`department_id` = `departments`.`id` 
INNER JOIN `students` 
    ON `students`.`degree_id` = `degrees`.`id` 
ORDER BY `students`.`surname`, `students`.`name`

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`id` AS "ID_Corso_Laurea",`degrees`.`name` AS "nome_corso_laurea", 
        `courses`.`id` AS "ID_Corso",`courses`.`name` AS "nome_corso", 
        `teachers`.`id` AS "ID_Insegnante",`teachers`.`name`,`teachers`.`surname` 
FROM `degrees` 
INNER JOIN `courses` 
    ON `degrees`.`id` = `courses`.`degree_id` 
INNER JOIN `course_teacher` 
    ON `courses`.`id` = `course_teacher`.`teacher_id` 
INNER JOIN `teachers` 
    ON `course_teacher`.`teacher_id`= `teachers`.`id` 
GROUP BY `degrees`.`id`,`degrees`.`name`, 
        `courses`.`id` ,`courses`.`name`, 
        `teachers`.`id` ,`teachers`.`name`,`teachers`.`surname`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT `departments`.`id` AS "ID_Dipartimento", `departments`.`name`,
        -- `degrees`.`id` AS "ID_Corso_laurea",`degrees`.`name`,
        -- `courses`.`id` AS "ID_Corso", `courses`.`name`,
        `teachers`.`id` AS "ID_Insegnante", `teachers`.`surname`, `teachers`.`name`
FROM `departments` 

INNER JOIN `degrees`
	ON `departments`.`id` = `degrees`.`department_id`
    
INNER JOIN `courses`
	ON `degrees`.`id` = `courses`.`degree_id`
    
INNER JOIN `course_teacher`
	ON `courses`.`id` = `course_teacher`.`course_id`
    
INNER JOIN `teachers`
	ON `course_teacher`.`teacher_id` = `teachers`.`id`
    
WHERE `departments`.`name` = "Dipartimento di Matematica"
ORDER BY `teachers`.`surname`, `teachers`.`name`;

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT `students`.`id` AS `ID_Studente`, `exams`.`course_id` AS `ID_Esame_materia`, 
    COUNT(`exams`.`id`) AS `tentativi_esame`, 
    MAX(`exam_student`.`vote`) AS `voto_max`
FROM `students`
INNER JOIN `exam_student`
	ON `students`.`id` = `exam_student`.`student_id`
INNER JOIN `exams`
	ON `exam_student`.`exam_id` = `exams`.`id`
GROUP BY `students`.`id`, `exams`.`course_id`
	HAVING `voto_massimo` >= 18;

-- Altro metodo per eseguire il bonus:
    -- SELECT CONCAT(`students`.`surname`, " ", `students`.`name`) AS "studenti", `courses`.`name` AS "corso_esame", 
    --     COUNT(`exam_student`.`exam_id`) AS "tentativi_esame", 
    --     MAX(`exam_student`.`vote`) AS "voto_max" 
    -- FROM `students` 
    -- INNER JOIN `exam_student` 
    --     ON `exam_student`.`student_id`=`students`.`id` 
    -- INNER JOIN `exams` 
    --     ON `exams`.`id`=`exam_student`.`exam_id` 
    -- INNER JOIN `courses` 
    --     ON `courses`.`id`= `exams`.`course_id` 
    -- GROUP BY `Students`, `courses`.`name` 
    --     HAVING MAX(`exam_student`.`vote`) > = 18 
    -- ORDER BY `Students`
