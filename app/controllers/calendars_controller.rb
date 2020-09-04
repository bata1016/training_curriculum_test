class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    week_days = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @today_date = Date.today
    # 例)今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []


    plans = Plan.where(date: @todays_date..@todays_date + 6)
    wday_num = Date.today.wday

    7.times do |x|
      today_plans = []
      plan = plans.map do |plan|
        today_plans.push(plan.plan) if plan.date == @today_date + x
      end

      if wday_num >= 7
        wday_num = wday_num - 7
      end
      wday_num += 1
      days = { month:(@today_date + x).month, date: (@today_date+x).day, plans:  today_plans, wday:　wdays[wday_num - 1 ] }

      @week_days.push(days)
    end
  end
end
