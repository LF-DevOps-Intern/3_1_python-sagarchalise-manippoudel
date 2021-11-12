
import sys
import os
import argparse
import pywebcopy
from pywebcopy import save_webpage
import subprocess
import requests


parser = argparse.ArgumentParser("Simple HTTP File Server and Downloading")
parser.add_argument(
    '--url', help="Add the Link to the URL after this flag", type=str, required=True)
parser.add_argument(
    '--http_server', help="To serve the url file downloaded", action='store_true')


args = parser.parse_args()


def websiteDownloader():
    kwargs = {'project_name': 'webpage', 'bypass_robots': True}

    save_webpage(
        url=args.url,

        project_folder=".",
        **kwargs
    )


if args.http_server:
    print('Downloading Website..............')
    websiteDownloader()
    print('Serving the Website..............')
    subprocess.run('python -m http.server -d webpage'.split())

else:

    websiteDownloader()
    print('Website Downloading')
