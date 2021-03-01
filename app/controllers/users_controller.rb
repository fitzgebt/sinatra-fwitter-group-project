class UsersController < ApplicationController


    get "/signup" do
        if logged_in?
            redirect "/tweets"
        end
        erb :"users/signup"
    end

    post "/signup" do
        if User.create(params).id
            session[:user_id] = User.last.id
            redirect "/tweets"
         end
         redirect "/signup"
    end

    get "/login" do
        if logged_in?
            redirect "/tweets"
        end
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(username: params["username"])
        if @user && @user.authenticate(params["password"])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
        erb :'users/login'
    end

    get '/logout' do
        if !logged_in?
            redirect "/"
        end
        session.clear
        redirect "/login"
    end

    get '/users/:slug' do
        # binding.pry
        @user = User.find_by_id(params[:slug])
        erb :'/users/show'
    end







end
