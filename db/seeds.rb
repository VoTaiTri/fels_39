User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

30.times do |n|
  title = Faker::Name.title+" #{n+1}"
  body = Faker::Lorem.sentences(20)
  Category.create!(title: title, body: body)
end

categories = Category.order(:created_at).take(10)
40.times do |n|
  categories.each do |category|
    word = Faker::Lorem.word+"#{category.id}.#{n+1}"
    Word.create!(japanese: word, category_id: category.id)
  end
end

words = Word.all
words.each do |word|
  answer = Faker::Lorem.word
  Answer.create!(content: answer, word_id: word.id, correct: true)
  3.times do
    answer = Faker::Lorem.word
    Answer.create!(content: answer, word_id: word.id, correct: false)
  end
end

