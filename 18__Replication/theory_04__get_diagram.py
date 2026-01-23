"""Графики зависимости цены от производительности
для одиночных серверов и кластеров
"""

import matplotlib.pyplot as plt  # pip install matplotlib

# Данные для одного сервера
perf_single = [20, 50, 100, 180, 300, 500]  # IOPS (тыс.)
cost_single = [1000, 2000, 4500, 8000, 15000, 30000]  # Стоимость ($)

# Данные для кластера
perf_cluster = [20, 100, 200, 300, 400, 500]  # IOPS (тыс.)
cost_cluster = [1000, 5000, 8000, 12000, 16000, 20000]  # Стоимость ($)

# Построение графика
plt.plot(perf_single, cost_single, marker='o', label='Один сервер', color='blue', linewidth=2)
plt.plot(perf_cluster, cost_cluster, marker='s', label='Кластер', color='green', linewidth=2)

# Настройка графика
plt.xlabel('Производительность (IOPS, тыс.)')
plt.ylabel('Стоимость ($)')
plt.title('Зависимость стоимости от производительности')
plt.legend()
plt.grid(True)
plt.yscale('linear')  # Линейная шкала для наглядности
plt.xlim(0, 550)
plt.ylim(0, 35000)
plt.show()