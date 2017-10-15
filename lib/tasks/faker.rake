namespace :faker do
  desc 'TODO'
  task setup: :environment do
    100.times do
      Shop.create(
        brand: '#{Rails.root}/app/assets/images/img/shop.jpg',
        header: '#{Rails.root}/app/assets/images/img/s003.jpg',
        name: Faker::GameOfThrones.character,
        category_id: [1, 2, 3, 4, 5].sample,
        address: Faker::GameOfThrones.city,
        description: Faker::HarryPotter.quote,
        email: Faker::Internet.free_email,
        phone_one: Faker::PhoneNumber.cell_phone,
        phone_two: Faker::PhoneNumber.cell_phone,
        facebook: 'https://www.facebook.com',
        instagram: 'https://www.instagram.com',
        twitter: 'https://www.twitter.com'
      )
    end
  end
end
