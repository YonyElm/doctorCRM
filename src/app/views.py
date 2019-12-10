from django.shortcuts import render

from .models import Doctor
from .models import Patient


def index(request):
    doctor = Doctor.objects.order_by('-name')[0]
    patient = Patient.objects.order_by('-name')[0]
    context = {'doctor': doctor,
               'patient': patient}
    return render(request, 'html/index.html', context)
