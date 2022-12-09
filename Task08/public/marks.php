<?php
require_once '../utils.php';

$pdo = new PDO('sqlite:../data/students.db');
$id = 0;
if($_SERVER['REQUEST_METHOD'] === 'POST') {
    $sql = "INSERT INTO marks (mark, studentId, disciplineId)
VALUES (?, ?, ?);";
    $statement = $pdo->prepare($sql);
    $statement->execute(
        [
            $_POST['mark'],
            $_POST['id'],
            $_POST['disciplineId']
        ]
    );
    $statement->closeCursor();
    $id = $_POST['id'];
} else {
    $id = $_GET['id'];
}
$student = getStudentWithId($id);

$sql = "SELECT mark, discipline.name AS subject FROM marks INNER JOIN discipline ON disciplineId=discipline.id WHERE studentId={$id}";
$statement = $pdo->query($sql);
$marks = $statement->fetchAll();
$statement->closeCursor();



?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>StudentMarks</title>
</head>
<body>
<?php
print "<h3> {$student['surname']} {$student['name']} {$student['lastname']}</h3>";
$subjects = [];
foreach ($marks as $mark) {
    print "<p>{$mark['subject']}: {$mark['mark']}</p>";
    $subjects[] = $mark['subject'];
}

$sql = "SELECT discipline.name as subj_name, discipline.id as subj_id from discipline 
                inner join plan on plan.disciplineId=discipline.id 
                inner join student on student.educationalDirectionId=planId
                where studentsNumber={$id};";
$statement = $pdo->query($sql);
$disciplines = $statement->fetchAll();
$statement->closeCursor();

if (count($disciplines) !== count($subjects)) {
    print <<<HTML
<b>Поставить оценку:</b> <form action="" method="POST">
    <input type="hidden" name="id" value={$id}>
    <br><select name="disciplineId">
HTML;


    foreach ($disciplines as $discipline) {
        if (!in_array($discipline['subj_name'], $subjects))
            print "<option value={$discipline['subj_id']}>{$discipline['subj_name']}</option>";
    }

    print <<<HTML
    </select>
    <input type="text" name="mark"><br>
    <input type="submit" value="Поставить">
</form>
HTML;

}
?>
<a href="index.php">Назад</a>
</body>
</html>
