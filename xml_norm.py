#!/usr/bin/python

import xml.etree.ElementTree as ET
from os import listdir, makedirs, path
from sys import argv

#Just establishing the xml directory
last_arg = argv[1:][-1:]
xmldir = path.abspath(last_arg[0] if len(last_arg) else "")

#voyant has some issues when specifying Xpaths on null namespace
ET.register_namespace("tb", "http://www.talkbank.org/ns/talkbank")


#ensure a directory for normalized versions
norm_dir=path.join(xmldir, "normalized")
makedirs(norm_dir, exist_ok=True)


xmlDirEntries = [path.join(xmldir,f) for f in listdir(xmldir)]
# not so glamorous but good enough
xmlFiles = [f for f in xmlDirEntries if path.isfile(f) and f.endswith(".xml")]

print(xmlFiles)

for xmlfile in xmlFiles:
    tree = ET.parse(xmlfile)
    #ensure there is a trailing newline - interesting issue with writing
    tree.getroot().tail = "\n"
    
    tree.write(path.join(norm_dir, path.basename(xmlfile)),
       xml_declaration=True, encoding="Unicode")

