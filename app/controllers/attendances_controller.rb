class AttendancesController < ApplicationController
  include InvitesHelper
  def index
    @event = Event.find(params[:event_id])
  end

  def new
    @attendances = Attendance.new
  end

  def create
    @event = Event.find(params[:event_id])
    @user = User.find_by(email: params[:email])
    if !@user
      flash[:alert] = 'Invalid email!'
      redirect_to event_invites_path(@event)
    elsif @user == current_user
      flash[:alert] = 'You cannot invite yourself!'
      redirect_to event_path(@event)
    else
      @attendances = @event.attendees.create(attendee_id: @user.id)
      if @attendances.save
        flash[:notice] = 'Invite successful!'
        sgmail(@user[:email], @event[:title])
        redirect_to event_invites_path(@event)
      else
        redirect_to events_path
      end
    end
  end

  def update
    @attendee = Attendance.find_by(attendee_id: current_user.id,
                                   event_id: params[:event_id])

    @attendee.update_attributes!(attending: true)
    if @attendee.save
      redirect_to event_path(@attendee.event_id)
    else
      redirect_to events_path
    end
  end

  private

  def attendance_params
    params.require(:attendance).permit(:id)
  end
end
