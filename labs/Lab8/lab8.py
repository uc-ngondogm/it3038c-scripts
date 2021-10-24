import requests
from bs4 import BeautifulSoup
# Make a request
page = requests.get(
    "https://webscraper.io/test-sites/e-commerce/allinone")
soup = BeautifulSoup(page.content, 'html.parser')

# Create items as empty list
items = []
# Extract and store in items 
products = soup.select('div.thumbnail')
for elem in products:
    title = elem.select('h4 > a.title')[0].text
    review = elem.select('div.ratings')[0].text
    
    info = {
        "Item title": title.strip(),
        "Item review": review.strip()
       
    }
    items.append(info)

print(items)