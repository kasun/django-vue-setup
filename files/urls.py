from django.contrib import admin
from django.urls import include, path

from api import root_router
                                                                                                                           
from .views import index                                                                                                   

urlpatterns = [
    path('', index, name='index'),
    path('admin/', admin.site.urls),
]

urlpatterns.extend(root_router.generate_url_patterns())
