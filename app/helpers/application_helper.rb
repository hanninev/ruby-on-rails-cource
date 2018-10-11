module ApplicationHelper
  def edit_and_destroy_buttons(item)
    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary")
    del = link_to('Destroy', item, method: :delete,
                                   data: { confirm: 'Are you sure?' },
                                   class: "btn btn-danger")
    raw("#{edit} #{del}") unless current_user.nil?
  end

  def round(number)
    number_with_precision(number, precision: 1)
  end
end
