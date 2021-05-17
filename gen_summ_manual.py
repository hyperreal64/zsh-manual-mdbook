import re
import requests
from bs4 import BeautifulSoup


# Check if input contains integer substring
def hasInteger(input):
    return bool(re.search(r"(?<![\d.])[0-9]+(?![\d.])", input))

# Generate SUMMARY.md from table of contents
page = requests.get("http://zsh.sourceforge.net/Doc/Release/zsh_toc.html")
soup = BeautifulSoup(page.content, "html.parser")
results = soup.find_all("a")[5:329]
contents = []
for elem in results:
    if elem not in contents:
        contents.append(elem.get_text())

output = []
output.append("# Summary\n")

for item in contents:
    if hasInteger(item):
        if "&" in item:
            title = item.lstrip("0123456789. ")
            fn0 = title.replace("&", "_0026")
            fn1 = fn0.replace(" ", "-") + ".md"
            new_line = "- [%s](./%s)" % (title, fn1)
            output.append(new_line)
        else:
            title = item.lstrip("0123456789. ")
            filename = title.replace(" ", "-") + ".md"
            new_line = "- [%s](./%s)" % (title, filename)
            output.append(new_line)
    else:
        continue

for line in output:
    print(line)
