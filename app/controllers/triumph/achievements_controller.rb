module Triumph
  class AchievementsController < ApplicationController
    # GET /achievements
    # GET /achievements.xml
    def index
      @achievements = Achievement.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @achievements }
      end
    end

    # GET /achievements/1
    # GET /achievements/1.xml
    def show
      @achievement = Achievement.find(params[:id])
      @conditions = @achievement.achievement_conditions

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @achievement }
      end
    end

    # GET /achievements/new
    # GET /achievements/new.xml
    def new
      @achievement = Achievement.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @achievement }
      end
    end

    # GET /achievements/1/edit
    def edit
      @achievement = Achievement.find(params[:id])
    end

    # POST /achievements
    # POST /achievements.xml
    def create
      @achievement = Achievement.new(params[:triumph_achievement])
      @achievement.observe_class.singularize.downcase!

      if @achievement.save
        achievement_condition = AchievementCondition.new(params[:achievement_condition])
        achievement_condition.achievement_id = @achievement.id
        if achievement_condition.save
          redirect_to(@achievement, :notice => 'Achievement was successfully created.')
        else
          flash[:error] = "Failed to save achievement conditions"
        end
      else  
        render :action => "new"
      end
    end

    # PUT /achievements/1
    # PUT /achievements/1.xml
    def update
      @achievement = Achievement.find(params[:id])
      @achievement.observe_class.downcase!
      
      respond_to do |format|
        if @achievement.update_attributes(params[:triumph_achievement])
          format.html { redirect_to(@achievement, :notice => 'Achievement was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @achievement.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /achievements/1
    # DELETE /achievements/1.xml
    def destroy
      @achievement = Achievement.find(params[:id])
      @achievement.destroy

      respond_to do |format|
        format.html { redirect_to(triumph_achievements_url) }
        format.xml  { head :ok }
      end
    end
  
  end
end