'''
# the data stored in the csv file
CREATE VIEW user_post_count_better AS
SELECT user_id, COUNT(*) AS num_of_posts FROM photos GROUP BY user_id;

SELECT * FROM user_post_count_better;
'''

from matplotlib import pyplot as plt
import pandas as pd
import numpy as np
plt.style.use('ggplot')
data = pd.read_csv('Actual_num_of_posts.csv')
#num_of_users = data['num_of_users']
num_of_posts = data['num_of_posts']
#bins_num = [i for i in range(max(data['num_of_posts']))]
bins_num = [2,4,6,8,10,12]
avg = np.mean(num_of_posts)
median = np.median(num_of_posts)
plt.axvline(avg, color = 'red', label = 'Mean posts')
plt.axvline(median, color = 'green', label = 'Median Posts'),
plt.legend()
plt.hist(num_of_posts, bins = bins_num ,edgecolor = 'black', color = 'blue')
plt.xlabel("Number of Posts")
plt.ylabel("# of Users")
plt.title("Histogram For Proportions of User Activity")
plt.show()