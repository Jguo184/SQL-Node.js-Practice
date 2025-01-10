import csv
from matplotlib import pyplot as plt
import numpy as np
plt.style.use("ggplot")
day_axis = []
num_axis = []
plt.plot(day_axis, num_axis)
with open('testing1.csv') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    for row in csv_reader:
        #print(row['day_name'])
        day_axis.append(row['day_name'])
        num_axis.append(int(row['COUNT(*)']))
    #print(day_axis)
    #print(num_axis)
plt.barh(day_axis, num_axis, label = 'All Users' )
#plt.ylim(min(day_axis), max(day_axis))
plt.title('New User Density on parts of the week')
plt.ylabel('Day of The Week')
plt.xlabel('Users Joined')

plt.legend()
plt.show()