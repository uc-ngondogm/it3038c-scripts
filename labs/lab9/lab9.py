import requests 
import json 

r = requests.get('http://localhost:3000')
data = r.json()


#print(data)
print("1.",data[0]['name'],"is",data[0]['color'],
"\n2.",data[1]['name'],"is",data[1]['color'])


