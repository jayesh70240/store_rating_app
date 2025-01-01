# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", x"Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(name: "UserOne UserOneSurname", email: "userone@user.com", address: "502, 44/2, Central Tower, City Square, City", password: "UserOne@123", role: "user")

User.create(name: "AdminUser AdminSurname", email: "admin@user.com", address: "501, 44/2, Central Tower, City Square, City", password: "AdminUser@123", role: "admin")

User.create(name: "StoreOwner StoreOwnerSurname", email: "storeowner@user.com", address: "503, 44/2, Central Tower, City Square, City", password: "StoreOwner@123", role: "store_owner")
