# Use an official Python runtime based on Alpine 3.10 as a parent image
FROM python:3.9-bullseye

# The environment variable ensures that the python output is set straight
# to the terminal without buffering it first
ENV PYTHONUNBUFFERED 1

# Declare build arguments for our secrets
ARG PINECONE_KEY
ARG OPENAI_KEY
ARG DYNAMODB_KEY
ARG AUTH0_KEY
ARG AWS_DEFAULT_REGION
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG REDIS_URL

# Set the environment variables in the container
ENV PINECONE_KEY=$PINECONE_KEY
ENV OPENAI_KEY=$OPENAI_KEY
ENV DYNAMODB_KEY=$DYNAMODB_KEY
ENV AUTH0_KEY=$AUTH0_KEY
ENV AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV REDIS_URL=$REDIS_URL

# Install the requirements
COPY /src/requirements.txt /src/
RUN pip install --no-cache-dir -r /src/requirements.txt

# Set the working directory in the container
WORKDIR /src

# Copy the current directory contents into the container at /src
COPY . /src/

# Expose the port the app runs in
EXPOSE 80

# Serve the app with Uvicorn for production
CMD ["uvicorn", "src.server.app:app", "--host", "0.0.0.0", "--port", "80"]
