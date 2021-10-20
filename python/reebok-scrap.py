import requests, re 
from bs4 import BeautifulSoup 
 
data  = requests.get("https://www.microcenter.com/product/626304/corsair-icue-4000x-rgb-tempered-glass-atx-mid-tower-computer-case-black").content  
soup = BeautifulSoup(data, 'html.parser')  
details = soup.find("h1")
#print(details)
thisspan = ""
for d in details:
    title = d.find("span")
    if title is not None and title != -1:
    #print(d)
        thisspan = title        
print("Product %s has a price of $ %s" % (thisspan.get('data-name'), thisspan.get('data-price')))

#print(soup.prettify()[:100])