require 'lorem_ipsum_amet'

User.create(
  email: 'kevin@gmail.com',
  password: 'password',
  firstname: 'Kevin',
  lastname: 'L',
  birthday: '12/12/1999'
)

User.create(
  email: 'shahid@gmail.com',
  password: 'password',
  firstname: 'Shahid',
  lastname: 'S',
  birthday: '01/01/1900'
)

User.create(
  email: 'david@gmail.com',
  password: 'password',
  firstname: 'David',
  lastname: 'P',
  birthday: '11/12/1980'
)

(1..100).each do |_|
  Post.create(
    title: LoremIpsum.w(rand(1..4)),
    content: LoremIpsum.medium,
    user_id: rand(1..3),
    image_url: '',
    datetime: Time.now
  )
end