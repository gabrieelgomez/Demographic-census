# Ability Authorizate
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :manage, KepplerContactUs::Message
    can :manage, KepplerContactUs::MessageSetting

    if user.has_role? :admin

      # - Banner authorize -
      can :manage, Banner

      # - Photo authorize -
      can :manage, Photo

      # - Album authorize -
      can :manage, Album

      # - Posts authorize -
      can :manage, KepplerBlog::Post
      can :manage, KepplerBlog::Category
      
      # - Banner authorize -
      can :manage, Banner

      # - Shop authorize -
      can :manage, Shop

      # - Category authorize -
      can :manage, Category

      # - Customize authorize -
      can [:delete, :update,
           :new, :create, :install_default,
           :index, :destroy, :destroy_multiple], Customize

      # - Seo authorize -
      can :manage, MetaTag
      can :manage, GoogleAdword

      # - GoogleAnalytics authorize -
      if Setting.first.google_analytics_setting.ga_status
        can :manage, GoogleAnalyticsTrack
      end

      # - Setting authorize -
      can :manage, Setting

      # - User authorize -
      can [:delete, :show, :edit, :update,
           :create, :index, :destroy_multiple], User
      can :destroy, User do |u|
        !u.eql?(user)
      end

    elsif user.has_role? :autor
      can :manage, KepplerBlog::Post, :user_id => user.id

    elsif user.has_role? :editor
      can [:index, :update, :edit, :show]

    elsif user.has_role? :client

    end
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
