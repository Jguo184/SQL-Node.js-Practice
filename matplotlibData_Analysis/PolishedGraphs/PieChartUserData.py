'''
#below is the sql code I used to query the sql data from the database.
CREATE VIEW user_post_count_better AS
SELECT user_id, COUNT(*) AS num_of_posts FROM photos GROUP BY user_id;

SELECT * FROM user_post_count_better;

CREATE VIEW ref_numofUsers AS
SELECT num_of_posts, COUNT(*) AS num_of_users FROM user_post_count_better GROUP BY num_of_posts ORDER BY num_of_posts;

CREATE VIEW percentage_view AS
SELECT num_of_posts, num_of_users/(SELECT SUM(num_of_users) FROM ref_numofUsers)*100 AS percentage FROM ref_numofUsers;


SELECT num_of_posts, percentage FROM percentage_view WHERE num_of_posts < 6 UNION ALL 
SELECT 6 AS num_of_posts, SUM(percentage) AS percentage FROM percentage_view WHERE num_of_posts>5;
'''
import math
from matplotlib import pyplot as plt
import pandas as pd
plt.style.use("ggplot")
#plt.xkcd()
data = pd.read_csv("numOfPosts.csv")
slices = data['percentage']
pie_labels = data['num_of_posts']
explode_values = [0.2,0,0,0,0,0]
#angle_values = []
#let's add annotations to the largest slice

#ngle = 24.3/100*360
#x = math.cos(angle)
#y = math.sin(angle)

#for i in range(len(pie_labels)):
    #pie_labels[i] = str(pie_labels[i]) + ' Posts'
plt.pie(slices, labels = pie_labels, wedgeprops = {'edgecolor': 'black'}, explode = explode_values, shadow = True, autopct = "%1.1f%%")
plt.annotate("Data shows that\n most users \n only post once.", xy = (0.7, 0.4), xytext = (1.05,1.05), arrowprops = dict(arrowstyle = '->', color = 'black'))

plt.title("Distribution of User Post Activity")
plt.tight_layout()
plt.show()


