import os
import requests

from pathlib import Path


ENDPOINT_REL = "BackendComponentTemplateVersionUpload"

api_base_url = os.environ['API_BASE_URL']
template_id = os.environ['TEMPLATE_ID']

access_token = Path(os.environ['ACCESS_TOKEN_FILE']).read_text().strip()
bundle = Path(os.environ['BUNDLE_FILE']).read_bytes()

headers = {
    "Accept": "application/json",
    "Api-Version": os.environ['API_VERSION'],
    "Api-Application": os.environ['API_APPLICATION_ID'],
    "Api-Company": os.environ['COMPANY_ID'],
    "Authorization": f"Bearer {access_token}",
}

res_discovery = requests.get(f"{api_base_url}", headers=headers)
res_discovery.raise_for_status()

discovery = res_discovery.json()["data"]
for endpoint in discovery:
    if endpoint["rel"] == ENDPOINT_REL:
        url: str = endpoint["href"]
        break
else:
    raise KeyError(f"API endpoint not found: {ENDPOINT_REL}")

url = url.replace("{publicId}", template_id)

res_upload = requests.post(url, data=bundle, headers={**headers, "Content-Type": "application/zip"})
print(res_upload.text)
