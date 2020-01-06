from django.db import models

# Set up schema for Data base

class Doctor(models.Model):
    GENERAL = 'General'
    CARDIOLOGIST = 'Cardiologist'
    EXPERTISE = [
        (GENERAL, 'General'),
        (CARDIOLOGIST, 'Cardiologist')
    ]
    name = models.CharField(max_length=30)
    surname = models.CharField(max_length=30)
    expertise = models.CharField(max_length=30, choices=EXPERTISE, default=GENERAL)
    license_num = models.IntegerField(unique=True, verbose_name='Dr. Medical License', primary_key=True, default=0)
    phone = models.IntegerField()
    email = models.EmailField()

class Patient(models.Model):
    name = models.CharField(max_length=30, verbose_name='Patient First Name')
    surname = models.CharField(max_length=30, verbose_name='Patient Last Name')
    id_num = models.IntegerField(unique=True, verbose_name='ID Number', primary_key=True, default=0)
    phone = models.IntegerField(verbose_name='Cellphone Number')
    email = models.EmailField(verbose_name='E-Mail Address')
    primary_doctor = models.ForeignKey(Doctor, null=True, on_delete=models.CASCADE, verbose_name='Patient Primary Dr.')
    reg_date = models.DateTimeField(verbose_name='Registration Date', null=True)

class Test(models.Model):
    name = models.CharField(max_length=30)
    code = models.IntegerField(unique=True, verbose_name='Test Code', primary_key=True, default=0)

class TrackingChart(models.Model):
    PENDING = 'Pending'
    ALERT1 = 'Alert 1'
    ALERT2 = 'Alert 2'
    ALERTS = [
        (PENDING, 'Pending'),
        (ALERT1, 'Alert 1'),
        (ALERT2, 'Alert 2')
    ]
    # field name `id` will be added automatically as prime-key
    completed = models.BooleanField(default=False)
    due_date =  models.DateTimeField(verbose_name='Complete test before:', null=True)
    ordered_by = models.ForeignKey(Doctor, on_delete=models.CASCADE, null=True)
    test = models.ForeignKey(Test, on_delete=models.CASCADE)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    alert_code = models.CharField(max_length=30, null=False, choices=ALERTS, default=PENDING)

# After changin models (DB stracture) run the following:
# 1. Make sure the app is mentioned in `settings.py`
# 2. Run `python manage.py makemigrations app`
# 3. Run `python manage.py sqlmigrate app 0001`
# 4. RUN `python manage.py migrate`
# 5. Register nodes in `admin.py`