from django.shortcuts import render

from .models import Doctor


def index(request):
    doctor = Doctor.objects.order_by('-name')[0]
    print(doctor.name)
    context = {'doctor': doctor}
    return render(request, 'html/index.html', context)
