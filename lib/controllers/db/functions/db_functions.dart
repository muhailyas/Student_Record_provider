import 'package:sqflite/sqflite.dart';
import 'package:student_data_using_getx/models/student_model.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  factory DB() => instance;

  late Database db;

  Future initialiseDatabase() async {
    db = await openDatabase(
      'student.db',
      version: 1,
      onCreate: (db, version) async => db.execute(
          'CREATE TABLE Student(id INTEGER PRIMARY KEY,name TEXT,age TEXT,batch TEXT,mobile TEXT,email TEXT,image TEXT)'),
    );
  }

  Future<List<StudentModel>> getStudents() async {
    List<Map<String, Object?>> list =
        await db.rawQuery('SELECT * FROM Student');
    return list.isEmpty
        ? []
        : list.map((student) => StudentModel.fromMap(student)).toList();
  }

  // inserting data into database
  Future<bool> addStudent(StudentModel student) async {
    try {
      db.rawInsert(
          'INSERT INTO Student(name,age,batch,mobile,email,image) VALUES(?,?,?,?,?,?)',
          [
            student.name,
            student.age,
            student.batch,
            student.mobile,
            student.email,
            student.image
          ]);
      await getStudents();
    } catch (e) {
      return false;
    }
    return true;
  }

  updateStudent(StudentModel student, int id) async {
    await db.rawUpdate(
        'UPDATE Student SET name = ?,age = ?,batch = ?,mobile = ?,email = ?,image = ? WHERE id = ?',
        [
          student.name,
          student.age,
          student.batch,
          student.mobile,
          student.email,
          student.image,
          id,
        ]);
  }

  deleteStudent(int id) async {
    await db.delete('Student', where: 'id=?', whereArgs: [id]);
  }
}
