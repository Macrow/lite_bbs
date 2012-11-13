module LiteBbs
  class Ability
    include CanCan::Ability
    def initialize(user)
      user ||= LiteBbs.user_class.constantize.new
      if user.send(LiteBbs.litebbs_user_helper_methods[:admin?])
        can :manage, :all
      else
        can :read, :all
        can :create, [Topic, Reply] unless user.new_record?
        can [:edit, :update], [Topic, Reply] do |item|
          item.try(:user) == user
        end
        can :destroy, Reply do |item|
          item.try(:user) == user
        end
      end
    end
  end
end
