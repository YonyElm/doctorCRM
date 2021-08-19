from django.contrib import admin

# Register your models here.

from .models import Patient
from .models import Test
from .models import TrackingChart
from .models import Doctor

admin.site.register(Patient)
admin.site.register(Test)
admin.site.register(Doctor)
admin.site.register(TrackingChart)