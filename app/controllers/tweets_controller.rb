class TweetsController < ApplicationController

    get "/tweets" do
        if !logged_in?
            redirect '/login' 
        end
        @tweets = Tweet.all
        erb :"/tweets/index"
    end

    get '/tweets/new' do
        # binding.pry
        if !logged_in?
            redirect '/login'
        end
        erb :'/tweets/new'
    end

    post "/tweets" do
        if Tweet.create(params).id
            @tweet = Tweet.all.last
            # binding.pry
            @tweet.user_id = current_user.id
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        end
        # binding.pry
        redirect '/tweets/new'
    end

    get "/tweets/:id" do
        if !logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find_by_id(params[:id]) 
        erb :'tweets/show'
    end

    get "/tweets/:id/edit" do
        if !logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find_by_id(params[:id]) 
        erb :'tweets/edit'
    end

    patch '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find_by_id(params[:id])
        if params[:content] == "" 
            redirect "/tweets/#{@tweet.id}/edit"
        end
        if @tweet = Tweet.find_by_id(params[:id])
            if current_user.id == @tweet.user_id
                @tweet.update(content: params[:content])
            end
            redirect "/tweets/#{@tweet.id}/edit"
        end
        erb :'tweets/index'
    end

    delete '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find_by_id(params[:id])
        if current_user.id == @tweet.user_id
            @tweet.destroy
        end
        redirect '/tweets'
    end
end
