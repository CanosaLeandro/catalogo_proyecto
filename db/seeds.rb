# User.create(email: 'master@master.com', username: 'master', password: 'master')
  client = Profile.create(kind: 'client')
  admin = Profile.create(kind: 'admin')
  User.create(username: 'cliente', email: 'cliente@cliente.com', password: 'cliente', profile: client)
  User.create(username: 'master', email: 'master@master.com', password: 'master', profile: admin)
  Config.create(per_page: 3)
  Category.create(name: 'Bazar')
  Category.create(name: 'Jugueteria')
  Category.create(name: 'Electronica')
  Category.create(name: '')

  Tag.create(name: 'historico')
  Tag.create(name: 'cosas generales')

  5.times do |i|
    p = Product.new(name: "Product ##{i}",
                    description: 'A product.',
                    price: 278,
                    cost: 200,
                    active: true,
                    code: i,
                    category_id: 1
                  )
    p.product_images.build(principal: true)
    p.save
  end

  Buy.create(state: 'pending', user: User.first)
  Buy.create(state: 'accepted', user: User.first)
  Buy.create(state: 'rejected', user: User.first)

  Item.create(product: Product.first, price: Product.first.price,count: 3, buy: Buy.first)
  Item.create(product: Product.last, price: Product.last.price,count: 2, buy: Buy.last)
