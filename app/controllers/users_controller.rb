class UsersController < ApplicationController
  def index
    @users = [
        User.new(
            id: 1,
            name: 'Vadim',
            username: 'installero',
            avatar_url: '//secure.gravatar.com/avatar/71269686e0f757ddb4f73614f43ae445?s=100'
        ),
        User.new(
            id: 2,
            name: 'Misha',
            username: 'aristofun',
        )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
        name: 'Vadim',
        username: 'installero',
        avatar_url: '//secure.gravatar.com/avatar/71269686e0f757ddb4f73614f43ae445?s=100'
    )

    @questions = [
        Question.new(text: 'Как успехи?', created_at: Date.parse('02.06.2016')),
        Question.new(text: 'Все гуд?', created_at: Date.parse('02.06.2016'))
    ]

    @new_question = Question.new
  end
end
