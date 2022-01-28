from lib import *

packages = read_yaml('sources.yaml')
for package in packages:
    print(package['name'])
