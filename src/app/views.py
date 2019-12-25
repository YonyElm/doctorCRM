from django.shortcuts import render

from .models import Doctor
from .models import Patient


def index(request):
    return render(request, 'html/index.html', {})

def logic(request):
    doctors_arr = Doctor.objects.order_by('-name')
    patients_arr = Patient.objects.order_by('-name')
    context = {'doctors': doctors_arr,
               'patients': patients_arr}
    return render(request, 'html/logic.html', context)
