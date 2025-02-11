FROM python:3
RUN pip install mkdocs
RUN git clone https://github.com/NCAR/cirrus-admin-docs.git
RUN rm -r cirrus-admin-docs/Dockerfile cirrus-admin-docs/LICENSE cirrus-admin-docs/README.md cirrus-admin-docs/docs-helm/ cirrus-admin-docs/.github/
EXPOSE 8000
WORKDIR /cirrus-admin-docs
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]