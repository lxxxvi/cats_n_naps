
# Unexpected behaviour in `has_many` association


If there is a scope on a `has_many` assocation, `.valid?` will return false if the record is not persisted.

For example:

```ruby
class Cat < ApplicationRecord
  has_many :naps, -> { where('0 = 0') }
  validates_presence_of :name
end
```


```
$ rails c
Loading development environment (Rails 6.0.0.alpha)

2.5.0 :001 > c = Cat.new(name: 'Fritz')
 => #<Cat id: nil, name: "Fritz", created_at: nil, updated_at: nil>

2.5.0 :002 > c.naps.new(title: 'Naptime')
 => #<Nap id: nil, cat_id: nil, title: "Naptime", created_at: nil, updated_at: nil>

2.5.0 :003 > c.valid?
 => false

2.5.0 :004 > c.errors.to_a
 => ["Naps is invalid"]

2.5.0 :005 > c.naps.first.errors.to_a
 => ["Cat must exist"]
```

Of course the new `Nap` comes with `cat_id: nil`, as the cat itself is not persisted yet.

After removing the `scope` on `Cat`, `.valid?` works fine again:

```ruby
class Cat < ApplicationRecord
  has_many :naps
  validates_presence_of :name
end
```


```
$ rails c
Loading development environment (Rails 6.0.0.alpha)

2.5.0 :001 > c = Cat.new(name: 'Fritz')
 => #<Cat id: nil, name: "Fritz", created_at: nil, updated_at: nil>

2.5.0 :002 > c.naps.new(title: 'Naptime')
 => #<Nap id: nil, cat_id: nil, title: "Naptime", created_at: nil, updated_at: nil>

2.5.0 :003 > c.valid?
 => true
 ```



