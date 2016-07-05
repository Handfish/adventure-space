module ApplicationHelper

  # Handles the construction and returning of full title on a per-page basis,
  def full_title(page_title = '')
    base_title = "Adventure Space"
    if page_title.empty?
      return base_title
    else
      return page_title + " | " + base_title
    end
  end

end
