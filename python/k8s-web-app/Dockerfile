# Use the official Python image as the base image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Flask and its dependencies
RUN pip install --no-cache-dir flask

# Expose the port on which the Flask app will run
EXPOSE 5000

# Define the command to run the Flask app when the container starts
CMD ["python", "app.py"]
