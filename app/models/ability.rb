class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :public_recipes

    can :manage, Food, user_id: user.id
    can :manage, Recipe, user_id: user.id
    can :manage, RecipeFood, recipe: { user_id: user.id }
  end
end
