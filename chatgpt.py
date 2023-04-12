import openai

openai.api_key = '<your api key here>'

file = 'runner/calculator.dart',
#read examples/test.dart
with open('runner/lib/calculator.dart', 'r') as f:
    fileUnderTest = f.read()
    f.flush()

message = [{"role": "user",
             "content": f'this is the file under test file {fileUnderTest} its absolute path is {file} write a test file for it, the project name is runner use it in the import and consider null safety'},]

print(message)
chat=openai.ChatCompletion.create(model='gpt-3.5-turbo',messages=message)
reply = chat.choices[0].message.content
print(reply)

print(reply)
#write the file to a file
with open('runner/lib/tests/chatgptGeneratedFile.dart', 'w') as f:
    f.flush()
    f.write(reply)
    

