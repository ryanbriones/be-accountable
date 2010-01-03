require 'sinatra/base'
require 'be_accountable/calendar_helper'
require 'be_accountable/models'

module BeAccountable
  class Application < Sinatra::Base
    configure do |env|
      DataMapper.setup(:default, "sqlite3://#{env.root}/db/#{env.environment}.sqlite3")
      
      set :static, true
    end

    get '/' do
      erb :index
    end
    
    get '/:year/:month' do
      erb :index
    end

    helpers do
      include CalendarHelper
      
      def current_date
        year = params[:year] ? params[:year].to_i : Date.today.year
        month = params[:month] ? params[:month].to_i : Date.today.month
        date = Date.civil(year, month)
      end
      
      def be_accountable
        date = current_date

        calendar(:year => date.year, :month => date.month) do |day|
          ledger = Ledger.new(day)
          css_class = if ledger.complete?
                        'strike'
                      elsif ledger.partially_complete?
                        'spare'
                      else
                        'gutter'
                      end

          cell_text = %{<div>#{day.mday}<div class="date">#{day.to_s}</div><div class="overlay"></div>#{responsibilities_list(ledger.responsibilities)}</div>}

          [cell_text, {:class => "day #{css_class}"}]
        end
      end

      def responsibilities_list(responsibilities)
        out = %{<div class="responsibilities"><ul>}
        out << responsibilities.map { |r| "<li>#{r.title}</li>" }.join
        out << '</ul></div>'
        out
      end
      
      def previous_month_link(today = Date.today, text = "Previous Month")
        if today.month > 1
          month_link(today.year, today.month - 1, text)
        else
          month_link(today.year - 1, 12, text)
        end
      end
      
      def next_month_link(today = Date.today, text = "Next Month")
        if today.month < 12
          month_link(today.year, today.month + 1, text)
        else
          month_link(today.year + 1, 1, text)
        end
      end
      
      def month_link(year, month, text = "#{year}/#{month}")
        %{<a href="/#{year}/#{month}">#{text}</a>}
      end
    end
  end
end
