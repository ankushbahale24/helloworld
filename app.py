from flask import Flask, jsonify
import os
import pymysql

app = Flask(__CodeFrontier__)

def get_db_connection():
    return pymysql.connect(
        host=os.getenv('MYSQL_SERVER_IP'),
        user=os.getenv('MYSQL_USER_NAME'),
        password=os.getenv('MYSQL_PASSWORD'),
        database=os.getenv('MYSQL_DB')
    )

@app.route('/')
def hello_world():
    connection = get_db_connection()
    with connection.cursor() as cursor:
        cursor.execute("SELECT content FROM messages LIMIT 1")
        result = cursor.fetchone()
    connection.close()
    return jsonify({'message': result[0]})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)