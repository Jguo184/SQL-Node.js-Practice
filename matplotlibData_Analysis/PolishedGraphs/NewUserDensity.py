from matplotlib import pyplot as plt
import pandas as pd
plt.style.use('ggplot')

data = pd.read_csv('WeekDayUser.csv')
#print(data)

dayOfWeek = data['day_name']
numOfUsers = data['COUNT(*)']
plt.plot(dayOfWeek, numOfUsers, label = 'All_users')
plt.legend()
plt.ylim(min(numOfUsers)-1, max(numOfUsers)+1)
plt.title('New User Density')
plt.xlabel('Day of Week')
plt.ylabel('Number of Users')
plt.annotate('Peak User \nSignup dates', 
             xy=("Sunday", 16), arrowprops=dict(arrowstyle='->', color = 'black', lw = 0.6), xytext= ("Tuesday", 16))
plt.show()
