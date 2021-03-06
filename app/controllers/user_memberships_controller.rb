class UserMembershipsController < ApplicationController
  def create 

    @membership = UserMembership.new
    @group = Group.find(params[:user_membership][:group_id]) 
    @membership.member_id = params[:user_membership][:member]
    @membership.group_id  = @group.id

    puts @membership.errors.full_messages
    @membership.save

    redirect_to group_path(@group)
  end

  def index 
    @pending_memberships = current_user.user_memberships.where(approved: false)
  end

  def approve
    @membership = UserMembership.find(params[:user_membership_id])
    @membership.approved = true
    @membership.save

    redirect_to groups_path
  end

  def destroy
    @membership = UserMembership.find(params[:id])
    @membership.destroy 

    flash.alert = "Left Group"
    redirect_to groups_path
  end

end
