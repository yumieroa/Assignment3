from flask import render_template, flash, redirect
from app import app

@app.route("/main")
def main():
    return render_template("main.html")

@app.route("/pages")
def pages():
    return redirect(url_for("pages.html"))
