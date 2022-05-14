# frozen_string_literal: true

class MenuItemPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    return @user
  end

  def show_menu?
    return @user
  end

  def add_to_order?
    return @user && @user.has_role?(:customer)
  end

  def create?
    return @user && @user.has_role?(:restaurant)
  end

  def new?
    create?
  end

  def update?
    return @user && @user.has_role?(:restaurant)
  end

  def edit?
    update?
  end

  def destroy?
    create?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
