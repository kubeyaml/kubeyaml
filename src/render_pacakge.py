from lib import *
import sys

package_name = sys.argv[1]
# print(package_name)

packages = read_yaml('sources.yaml')
for package in packages:
    if package['name'] == package_name:
        break

package_type = 'helmChart'
if 'type' in package:
    package_type = package['type']
# print(package_type)

# set up kustoimzation
kustomization = {}
if package_type == 'raw':
    kustomization['resources'] = [package['repo']]
elif package_type == 'kustomize':
    kustomization = {'resources': [package['repo']]}
else:
    if 'chartName' in package:
        package['name'] = package['chartName']
        del package['chartName']
    kustomization = {'helmCharts': [package]}

print(yaml.dump(kustomization))
