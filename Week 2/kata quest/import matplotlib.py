import matplotlib.pyplot as plt

meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
media_visualizaciones = [10000, 12000, 8000, 15000, 20000, 18000, 22000, 25000, 21000, 19000, 23000, 24000]

plt.bar(meses, media_visualizaciones)
plt.xlabel('Mes')
plt.ylabel('Media de visualizaciones')
plt.title('Media de visualizaciones de Wikipedia por mes')
plt.xticks(rotation=45)
plt.show()
