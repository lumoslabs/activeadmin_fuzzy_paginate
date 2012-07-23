# ActiveadminFuzzyPaginate

This will turn off pagination counts for the specified resource. This will prevent aggregate
queries like COUNT for being called on these collections.

To use:

```ruby
ActiveAdmin.register User do
  config.fuzzy_paginate = true
end
```