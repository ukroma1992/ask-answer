class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: "Roma",
        username: "ukroma",
        avatar_url: "https://s.gravatar.com/avatar/d84eb0915d45f7279736ad5eac99ae6e?s=100"
      ),
      User.new(
        id: 2,
        name: "Misha",
        username: "aristofun"
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: "Roma",
      username: "@roma",
      avatar_url: "https://s.gravatar.com/avatar/d84eb0915d45f7279736ad5eac99ae6e?s=100"
    )

    @questions = [
      Question.new(text: "как дела?", created_at: Date.parse('23.01.2018')),
      Question.new(text: "Нормально?", created_at: Date.parse('12.05.2018'))
    ]

    @new_question = Question.new
  end
end
