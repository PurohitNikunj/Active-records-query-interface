class UserMailer < ApplicationMailer
    def welcome_email
        @user = params[:user]
        attachments.inline['filename.jpg'] = File.read("/home/nikunjpurohit/Desktop/rails_projects/app/public/#{@user.picture.url}")        
        mail(
            to: @user.email, 
            subject: 'Welcome to My Awesome Site'
        )
    end

    def update_email
        @user = params[:user]
        mail(
            to: @user.email, 
            subject: 'Updation of record'
        )
    end
end
