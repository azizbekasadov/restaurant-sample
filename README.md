# Restaurant App

Restaurant App is a full-stack Swift project that combines a **Vapor backend** with a **SwiftUI frontend**. The application demonstrates how a native iOS client can consume REST APIs provided by a backend service to deliver a seamless restaurant browsing and review experience.

## Overview

The project consists of two main components:

- **Vapor Backend** — responsible for exposing RESTful APIs, handling business logic, and managing persistent data storage
- **SwiftUI Frontend** — a native iOS application that consumes backend APIs and presents restaurant data through a modern user interface

Together, they form a complete end-to-end example of building a Swift-based client-server application.

## Features

- Built with **SwiftUI** for the frontend
- Built with **Vapor** for the backend
- REST API communication between client and server
- Restaurant listing and detail views
- Create and manage restaurant records
- Submit and display restaurant reviews
- Backend-powered data persistence
- Clean separation between presentation layer and API layer

## Tech Stack

### Frontend
- Swift
- SwiftUI

### Backend
- Swift
- Vapor
- Fluent
- PostgreSQL

## Architecture

The application follows a client-server architecture:

1. The **SwiftUI app** sends HTTP requests to the backend
2. The **Vapor server** processes requests, applies business logic, and interacts with the database
3. The backend returns JSON responses
4. The frontend decodes and displays the data in the UI

This setup makes the application modular, scalable, and easy to extend.

## Purpose

This project is a practical example of how to build a full-stack Swift application where a **SwiftUI frontend** communicates with a **Vapor backend** through APIs. It is suitable for learning, prototyping, or serving as a foundation for larger production-ready applications.
