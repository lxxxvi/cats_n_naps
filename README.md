
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
Running via Spring preloader in process 57572
Loading development environment (Rails 5.1.4)
2.4.1 :001 > c = Cat.new(name: 'Fritz')
 => #<Cat id: nil, name: "Fritz", created_at: nil, updated_at: nil>
2.4.1 :002 > c.naps.new(from: Time.zone.now, to: Time.zone.now + 1.hour)
 => #<Nap id: nil, cat_id: nil, from: "2018-02-12 12:35:15", to: "2018-02-12 13:35:15", created_at: nil, updated_at: nil>
2.4.1 :003 > c.valid?
 => false
2.4.1 :004 > c.errors.to_a
 => ["Naps is invalid"]
2.4.1 :005 > c.naps.first.errors.to_a
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
Running via Spring preloader in process 57754
Loading development environment (Rails 5.1.4)
2.4.1 :001 > c = Cat.new(name: 'Fritz')
 => #<Cat id: nil, name: "Fritz", created_at: nil, updated_at: nil>
2.4.1 :002 > c.naps.new(from: Time.zone.now, to: Time.zone.now + 1.hour)
 => #<Nap id: nil, cat_id: nil, from: "2018-02-12 12:37:37", to: "2018-02-12 13:37:37", created_at: nil, updated_at: nil>
2.4.1 :003 > c.valid?
 => true
 ```



