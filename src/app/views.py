from django.shortcuts import render
from django.core import serializers
import json
from datetime import datetime

from .models import Doctor
from .models import Patient
from .models import Test
from .models import TrackingChart

def index(request):
    return render(request, 'pages/index.html', {})

def personal(request):
    doctors_arr = Doctor.objects.all()
    doctors_json = serializers.serialize('json', doctors_arr)
    doctors_json = json.loads(doctors_json)
    for element in doctors_json:
        element['fields']['license_num'] = element['pk']
        fields = element['fields']
        element.clear()
        element.update(fields)
    #doctors_json = json.dumps(doctors_json)

    patients_arr = Patient.objects.all()
    patients_json = serializers.serialize('json', patients_arr)
    patients_json = json.loads(patients_json)
    for element in patients_json:
        element['fields']['id_num'] = element['pk']
        fields = element['fields']
        element.clear()
        element.update(fields)
    #patients_json = json.dumps(patients_json)

def logic(request):
    doctors_arr = Doctor.objects.all()
    doctors_json = serializers.serialize('json', doctors_arr)
    doctors_json = json.loads(doctors_json)
    # Removing and fixing unrelevant parts of the object
    for element in doctors_json:
        element['fields']['license_num'] = element['pk']
        fields = element['fields']
        element.clear()
        element.update(fields)

    patients_arr = Patient.objects.all()
    patients_json = serializers.serialize('json', patients_arr)
    patients_json = json.loads(patients_json)
    for element in patients_json:
        element['fields']['id_num'] = element['pk']
        fields = element['fields']
        element.clear()
        element.update(fields)

    tests_arr = Test.objects.all()
    tests_json = serializers.serialize('json', tests_arr)
    tests_json = json.loads(tests_json)
    for element in tests_json:
        element['fields']['code'] = element['pk']
        fields = element['fields']
        element.clear()
        element.update(fields)

    # __lte = less then or equal
    tracking_chart_arr = TrackingChart.objects.filter(due_date__lte=datetime.now()) 
    tracking_chart_json = serializers.serialize('json', tracking_chart_arr)
    tracking_chart_json = json.loads(tracking_chart_json)
    i = 0
    for element in tracking_chart_json:
        fields = element['fields']
        element.clear()
        element.update(fields)
        element['ordered_by'] = json.loads(serializers.serialize('json', [tracking_chart_arr[i].ordered_by]))[0]['fields']
        element['patient'] = json.loads(serializers.serialize('json', [tracking_chart_arr[i].patient]))[0]['fields']
        element['test'] = json.loads(serializers.serialize('json', [tracking_chart_arr[i].test]))[0]['fields']
        i = i +1


    all = {}
    all['doctors'] = doctors_json
    all['patients'] = patients_json
    all['tests'] = tests_json
    all['tracking_chart'] = tracking_chart_json
    all = json.dumps(all)

    context = {'tracking_chart' : tracking_chart_json,
        'all': all}

    return render(request, 'pages/logic.html', context)

def handler404(request, exception, template_name="pages/404.html"):
    response = render(request, template_name, {})
    response.status_code = 404
    return response

def handler400(request, exception, template_name="pages/400.html"):
    response = render(request, template_name, {})
    response.status_code = 400
    return response