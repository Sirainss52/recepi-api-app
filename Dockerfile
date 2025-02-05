FROM python:3.9-alpine3.13

LABEL maintainer="londonappdeveloper.com"

ENV PYTHONUNBUFFERED=1

# Copy the requirements files to /tmp/ directory
COPY requirements.txt /tmp/
COPY requirements.dev.txt /tmp/

WORKDIR /app

EXPOSE 8000

ARG DEV=false
ENV DEV=$DEV

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then \
        /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"
USER django-user
