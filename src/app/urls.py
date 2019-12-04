from django.urls import path

from . import views

# Specify URI and the function that app/views will return
urlpatterns = [
    path('', views.index, name='index'),
]