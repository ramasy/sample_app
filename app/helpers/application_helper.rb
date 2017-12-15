module ApplicationHelper
  def titre
    base_titre = "App"
    if @titre
      return "#{base_titre} | #{@titre}"
    else
      return base_titre
    end
  end
end
