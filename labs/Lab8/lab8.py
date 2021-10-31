import requests
from bs4 import BeautifulSoup

page = requests.get(
    "https://webscraper.io/test-sites/e-commerce/allinone")
soup = BeautifulSoup(page.content, 'html.parser')

# Create items as empty list
items = [] 
# Extract and store title and review in itmes. 
products = soup.select('div.thumbnail')
for elem in products:
    title = elem.select('h4 > a.title')[0].text
    review = elem.select('div.ratings')[0].text
    
    info = {
        "Item Name": title.strip(),
        "Review": review.strip()
       
    }
    items.append(info)

print("1.",items[0],"\n2.",items[1])
