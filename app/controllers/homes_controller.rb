class HomesController < ApplicationController
    
    def home
        @user = User.unscoped.where(is_active: true)
        @events = Event.all.order(id: :DESC)
        @comments = Comment.all
    end

    def join_event
        @user = User.unscoped.where(is_active: true)
        event_user = EventUser.new
        event_user.event_id = params[:id]
        event_user.user_id = @user[0].id
        event_user.status = 1
        event_user.save
        redirect_to home_path
    end

    def comment
        @comment = Comment.new
        @user = User.unscoped.where(is_active: true)
        @event = Event.find(params[:id])
    end

    def post_comment
        @user = User.unscoped.where(is_active: true)
        @comment = Comment.new(comment_params)
        @comment.user_id = @user[0].id
        @comment.event_id = params[:id]

        if @comment.save
            redirect_to home_path
        else
            render :comment, status: :unprocessable_entity
        end
    end

    def delete_comment
        @comment = Comment.find(params[:id])
        @comment.destroy
        @comment.save
        redirect_to home_path
    end

    def like_comment
        @user = User.unscoped.where(is_active: true)
        @comment = Comment.find(params[:id])
        @comment.liked_by.push(@user[0].id)
        @comment.save
        redirect_to home_path
    end

    def unlike_comment
        @user = User.unscoped.where(is_active: true)
        @comment = Comment.find(params[:id])
        @comment.liked_by.delete(@user[0].id)
        @comment.save
        redirect_to home_path
    end

    private
    def comment_params
        params.require(:comment).permit(:comment)
    end

end
