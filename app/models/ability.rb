class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    can :read, :all # All users can read all resources

    if user.admin?
      can :manage, :all # Admin can manage all resources
    else
      can :destroy, [Post, Comment], author_id: user.id # Regular users can delete their own posts and comments
    end
  end
end
