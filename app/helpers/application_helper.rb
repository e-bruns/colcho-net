module ApplicationHelper
  def error_tag(model, attribute)
    if model.errors.include? attribute
      content_tag :div, model.errors[attribute], class: "error_message"
    end
  end
end
