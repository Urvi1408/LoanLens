
from flask import Flask, render_template, abort
import mysql.connector

app = Flask(
    __name__,
    template_folder="application/templates",
    static_folder="application/static"
)

def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="urvi",
        database="LoanLens"
    )

TABLES = {
    "branches": "Branches",
    "customers": "Customers",
    "loan-types": "Loan_Types",
    "applications": "Loan_Applications",
    "loans": "Loans"
}


@app.route("/")
def home():
    conn = get_connection()
    cursor = conn.cursor()

    counts = {}

    for key, table in TABLES.items():
        cursor.execute(f"SELECT COUNT(*) FROM `{table}`")
        counts[key] = cursor.fetchone()[0]

    cursor.close()
    conn.close()

    return render_template("index.html", counts=counts)



@app.route("/table/<name>")
def view_table(name):
    if name not in TABLES:
        abort(404)

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        table = TABLES[name]
        cursor.execute(f"SELECT * FROM `{table}`")
        rows = cursor.fetchall()

        columns = list(rows[0].keys()) if rows else []

        return render_template(
            "table.html",
            rows=rows,
            columns=columns,
            table_name=table,
            active=name,
            counts={}
        )
    finally:
        cursor.close()
        conn.close()


if __name__ == "__main__":
    app.run(debug=True)
