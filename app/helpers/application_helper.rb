module ApplicationHelper
  def money(value, unit)
    number_to_currency(value, precision: 2, unit: unit)
  end
  
  def render_flash_messages
    flash.map { |n, msg| render_flash_message(n) }.join("\n").html_safe
  end
  
  def render_flash_message(type=nil)
    content_tag(:div, (content_tag(:p, flash[type.to_sym])), :id => "flash-#{type}", :class => "alert-message #{type}") if flash[type.to_sym].present?
  end
end
