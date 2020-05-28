import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="doctorCRM",
    version="0.0.1",
    author="TechyE",
    author_email="",
    description="Helping doctors to track the treatment process of their patients.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/pypa/sampleproject",
    packages=setuptools.find_packages(),
    install_requires=[
        "Django",   # Django framework
        "djangorestframework", # Enabling more feature for Django (ex: serialization) - not used
        "psycopg2", # Postgres SQL lib
        "uwsgi",    # Web Server Gateway Interface library
    ],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: GNU V3",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.5',
)
