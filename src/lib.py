import yaml


def read_yaml(filepath):
    f = open(filepath, "r")
    y = yaml.safe_load(f)
    f.close()
    return y
