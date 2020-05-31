from django.shortcuts import render
from django.core import serializers
import json
from datetime import datetime

from .models import Doctor
from .models import Patient
from .models import Test
from .models import TrackingChart


def model_serializer(model_arr, pk_id):
    """
    TBD.

    After applying this function 'json.dumps() function need to be applied.
    """
    json_string = serializers.serialize('json', model_arr)
    json_string = json.loads(json_string)
    i = 0
    for element in json_string:
        for field in element['fields']:
            if (model_arr[i].__dict__.get(field) is None):
                nested_obj = getattr(model_arr[i], field)
                nested_pk_id = nested_obj._meta.pk.name
                element['fields'][field] = model_serializer(
                    [nested_obj], nested_pk_id)[0]
        if (pk_id):
            element['fields'][pk_id] = element['pk']
        fields = element['fields']
        element.clear()
        element.update(fields)
        i = i + 1
    return json_string


def index(request):
    """TBD."""
    return render(request, 'pages/index.html', {})


def personal(request):
    """TBD."""
    doctors_arr = Doctor.objects.all()
    patients_arr = Patient.objects.all()


def logic(request):
    """TBD."""
    # __lte = less then or equal
    recommendations_arr = TrackingChart.objects.filter(
        due_date__lte=datetime.now())
    recommendations_json = json.dumps(
        model_serializer(recommendations_arr, None))
    context = {'recommendations': recommendations_json}

    return render(request, 'pages/logic.html', context)


def handler404(request, exception, template_name="pages/404.html"):
    """TBD."""
    response = render(request, template_name, {})
    response.status_code = 404
    return response


def handler400(request, exception, template_name="pages/400.html"):
    """TBD."""
    response = render(request, template_name, {})
    response.status_code = 400
    return response
