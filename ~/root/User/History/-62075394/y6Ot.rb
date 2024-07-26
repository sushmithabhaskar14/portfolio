class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @filter = Campaign.all.group_by{|e| e.campaign_id}
    @users = User.all
    @user_campaignlist = {}
    @users.each do |user|
      @user_campaignlist[user.id] = user.campaigns_list.each{|e| e['campaign_name'] }
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.campaigns_list = create_capaign_hash(params[:user][:campaigns_list].reject { |c| c.empty? })
    respond_to do |format|
      if @user.save
        ActiveRecord::Base.transaction do
          binding.pry
          @user.attachments.build(content:  params[:user][:attachment], imageable_type:  'User', imageable_id: @user.id )
          format.html { redirect_to user_url(@user), notice: "User was successfully created." }
          format.json { render :show, status: :created, location: @user }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def create_capaign_hash(_params)
    Campaign.where(campaign_id: _params).map{|e| { "campaign_id" => e.campaign_id, "campaign_name" => e.campaign_name } }
  end

  def fetch
    @user_campaignlist = {}
    if params['filter'].present?
      sql = "SELECT DISTINCT(id), id, name, email ,campaigns_list
              FROM users,
              JSON_TABLE(campaigns_list, '$[*]' COLUMNS (
              campaign_name VARCHAR(50) PATH '$.campaign_name',
              campaign_id VARCHAR(50) PATH '$.campaign_id'
              )) AS jt
              WHERE jt.campaign_id in ('#{params['filter'].join('\',\'')}')"
       @users= User.find_by_sql(sql)
    else
      @users= User.all
    end
    @users.each do |user|
      @user_campaignlist[user.id] = user.campaigns_list.each{|e| e['campaign_name'] }
    end
  end

  def show_portfolio

  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :campaigns_list)
    end
end
