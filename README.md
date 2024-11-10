
# Word Count Analyzer


## Download the apk from this [link](https://drive.google.com/file/d/1xOnXq_Nib-L9DgRQ5EtqtA_2zz72Bg_6/view?usp=sharing)



A full-stack web application that allows users to analyze the word frequency in any given URL. The project consists of two main parts:

- **Frontend**: A Flutter mobile application that allows users to input a URL and specify the number of top words to display.
- **Backend**: A FastAPI backend that processes the URL, extracts the words, and returns the word frequency analysis.

## Project Structure

The project is structured as follows:

```
Word-Count-Analyzer/
├── frontend/
│   └── lib/
│       └── backend.dart  # Configure the backend URL here
├── backend/
│   ├── Dockerfile        # Dockerfile for containerizing the backend
│   └── requirements.txt  # Backend dependencies for FastAPI
│   └── main.py           # FastAPI application logic
├── README.md             # Project documentation
```

## Prerequisites

Before running the project, make sure you have the following installed:

### For Frontend (Flutter)
- [Flutter](https://flutter.dev/docs/get-started/install)
- A suitable IDE (e.g., Visual Studio Code or Android Studio)

### For Backend (FastAPI)
- [Docker](https://www.docker.com/products/docker-desktop) (optional but recommended for containerizing the backend)
- Python 3.7 or later
- Virtual environment tools like `venv` (optional)

## Backend Setup

### 1. **Install Dependencies:**

Navigate to the `backend/` directory and install the required dependencies using `pip`.

```bash
cd backend
pip install -r requirements.txt
```

### 2. **Run Backend Locally:**

To run the FastAPI backend locally, use the following command:

```bash
uvicorn main:app --reload
```

This will start the backend server on `http://127.0.0.1:8000`.

Alternatively, you can containerize the backend with Docker. The next step shows how to do that.

### 3. **Run Backend using Docker:**

To run the backend in a Docker container, build the Docker image first:

```bash
docker build -t fastapi-app .
```

Then run the container:

```bash
docker run -d -p 8000:8000 fastapi-app
```

This will expose the backend at `http://localhost:8000`.

## Frontend Setup (Flutter)

### 1. **Set the Backend URL:**

In the `lib/backend.dart` file inside the `frontend/` folder, specify the URL of your backend. For local development, you can use:

```dart
static const String baseUrl = '[your-backend-url]/analyze';  // Replace with your backend URL
```

If you're deploying the backend, update this URL to the deployed backend's public URL.

### 2. **Install Flutter Dependencies:**

Navigate to the `frontend/` folder and install the Flutter dependencies:

```bash
cd frontend
flutter pub get
```

### 3. **Run the Flutter App:**

To run the Flutter application, use the following command:

```bash
flutter run
```

This will launch the app on your emulator or physical device.

## Project Flow

1. The user enters a URL and specifies the number of top words to display.
2. The frontend (Flutter) sends a request to the backend (FastAPI).
3. The backend processes the URL, extracts the word frequency, and returns the results.
4. The frontend displays the word frequency table.

## Deployment

- **Frontend**: Can be deployed to any platform that supports Flutter (e.g., Google Play, Apple App Store).
- **Backend**: Can be deployed on any cloud provider (e.g., Google Cloud, AWS, Heroku) using Docker or directly as a FastAPI app.

## Contributing

If you'd like to contribute to this project, feel free to fork the repository, make changes, and create a pull request.

## License

This project is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for more information.
