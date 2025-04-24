import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the Data
df = pd.read_csv("Retail_Sales_Dataset.csv", encoding='latin1')

# Handling Missing Values
df.isnull().sum()

# Check for Duplicates Values and Drop Duplicates if any
df.duplicated().sum()
df.drop_duplicates(inplace = True)

# Standardize columns names like lowercase, no spaces
df.columns = df.columns.str.strip().str.lower().str.replace('-','_').str.replace(' ','_')

# Covert to Datetime
df['order_date'] = pd.to_datetime(df['order_date'])
df['ship_date'] = pd.to_datetime(df['ship_date'])

# Generate Inventory_Days column 
df['inventory_days'] = df['quantity'] / (df['sales'] / 30)

# Ensure Profit is numeric
df['profit'] = pd.to_numeric(df['profit'], errors = 'coerce')

# Correlation between Inventory_Days and profit
plt.figure(figsize =(10, 6))
sns.scatterplot(data = df, x = 'inventory_days', y = 'profit', alpha = 0.6)
sns.regplot(data = df, x = 'inventory_days', y = 'profit', scatter = False, color = 'red', line_kws={"linewidth":2})
plt.title("Correlation between Inventory Days and Profit")
plt.xlabel("Inventory Days")
plt.ylabel("Profit")
plt.grid(True)
plt.tight_layout()
plt.show()
