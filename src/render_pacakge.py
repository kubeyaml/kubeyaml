from lib import *
import sys

package_name = sys.argv[1]
# print(package_name)

packages = read_yaml('sources.yaml')
for package in packages:
    if package['name'] == package_name:
        break

# set up kustoimzation
kustomization = {}
if 'resources' in package:
    kustomization = {'resources': package['resources']}
else:
    if 'chartName' in package:
        package['name'] = package['chartName']
        del package['chartName']
    kustomization = {'helmCharts': [package]}

print(yaml.dump(kustomization))
