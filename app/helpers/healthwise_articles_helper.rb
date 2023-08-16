module HealthwiseArticlesHelper

  def article_locale
    if @healthwise_article.languages.include?(HW_LOCALE[params[:locale]])
      params[:locale].downcase
    else
      flash.now[:alert] = "#{t('resources.healthwise.missing_article')}"
      "en"
    end
  end

  def article_locale_unavailability
    # flash.now[:alert] = "Some of the articles listed here are not available in this language. (t)"
    "en"
  end
end
