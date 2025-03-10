from django.shortcuts import render

def calculator_view(request):
    result = None
    if request.method == "POST":
        try:
            num1 = float(request.POST.get("num1"))
            num2 = float(request.POST.get("num2"))
            operation = request.POST.get("operation")

            if operation == "addition":
                result = num1 + num2
            elif operation == "subtraction":
                result = num1 - num2
            elif operation == "multiplication":
                result = num1 * num2
            elif operation == "division":
                if num2 != 0:
                    result = num1 / num2
                else:
                    result = "Error: Division by zero"
        except ValueError:
            result = "Error: Invalid input"

    return render(request, "calculator/calculator.html", {"result": result})



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Django Calculator</title>
</head>
<body>
    <h2>Simple Calculator</h2>
    <form method="post">
        {% csrf_token %}
        <input type="number" step="any" name="num1" required> 
        <select name="operation">
            <option value="addition">+</option>
            <option value="subtraction">-</option>
            <option value="multiplication">*</option>
            <option value="division">/</option>
        </select>
        <input type="number" step="any" name="num2" required>
        <button type="submit">Calculate</button>
    </form>

    {% if result is not None %}
        <h3>Result: {{ result }}</h3>
    {% endif %}
</body>
</html>


from django.urls import path
from .views import calculator_view

urlpatterns = [
    path('', calculator_view, name="calculator"),
]
 

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('calculator.urls')),  # Include our app
]




