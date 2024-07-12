import MySQLdb


def test_connection():
    connection = MySQLdb.connect(host='mysql', port=3306, user='test', password='test', database='test')
    with connection.cursor() as cursor:
        cursor.execute('SELECT 1')
        result = cursor.fetchall()
        print("result = ", result)
    connection.close()


if __name__ == '__main__':
    test_connection()
