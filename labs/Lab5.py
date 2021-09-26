#a python script that calculates how many seconds have passed since a person's birthday
import datetime
print('*'*44+'\n****How Many Seconds Have You Been Alive****\n'+'*'*44)
while True:
    try:
        dbirth = input("Please enter your Date of Birth \n(eg. April 1 1900):")
        birthday = datetime.datetime.strptime(dbirth, '%B %d %Y')
        break
    except:
         print('\n--------------------------------------------')
         print("Please put in the Format 'Month/DD/YYYY' with no initial")
today = datetime.datetime.today()
alivetime = (today - birthday).total_seconds()
print('\n--------------------------------------------------')
print("You have been alive for:",alivetime,"seconds")

