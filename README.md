# Store Rating App

A web application built with **Ruby on Rails 8**, designed to manage users, stores, and ratings with role-based access.

## 📚 **Tech Stack**
- **Ruby Version:** 8.x
- **Database:** PostgreSQL
- **Frontend:** Bootstrap (for UI styling)
- **Authentication:** Custom Authentication System

---

## ⚙️ **Setup Instructions**

### 1️⃣ **Clone the Repository**
```bash
git clone <url>
cd <navigate to the folder>
```

### 2️⃣ **Setup Environment Variables**
Create a `.env` file in the project root and add the following:
```env
DB_USERNAME=
DB_PASSWORD=
DB_HOST=
```

### 3️⃣ **Install Dependencies**
```bash
bundle install
```

### 4️⃣ **Database Setup**
```bash
rails db:create db:migrate
```

### 5️⃣ **Seed the Database**
```bash
rails db:seed
```

### 6️⃣ **Start the Server**
```bash
rails server
```
Visit the app at: [http://localhost:3000](http://localhost:3000)

---

## 🚀 **Key Features**
- User authentication with roles (**Admin**, **Store Owner**, **Normal User**)
- Store management with CRUD operations
- Rating and review system
- Admin Dashboard for analytics
- Search and filtering functionality

---

## 🛡️ **Roles & Permissions**
- **Admin:** Manage users, stores, and view analytics.
- **Store Owner:** Manage their store details.
- **User:** Browse stores and provide ratings.

Happy coding! 🚀✨

