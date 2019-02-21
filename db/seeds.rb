# Fake data for development and test environments

15.times { Ingredient.create!(name: Faker::Food.unique.ingredient) }

50.times {
  Recipe.create!(
    name: Faker::Food.unique.dish,
    steps: Faker::Food.description,
    time: Faker::Number.between(1, 60),
    difficulty: Faker::Number.between(1, 5)
  )
}

200.times {
  Amount.create!(
    amount: Faker::Food.measurement,
    ingredient: Ingredient.all.sample,
    recipe: Recipe.all.sample
  )
}
