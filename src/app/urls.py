from django.urls import path

from . import views

# Specify URI and the function that app/views will return
urlpatterns = [
    path('design/', views.index, name='index'),
    path('', views.recommendations, name='recommendations'),
    path('personal/', views.personal, name='personal'),
]