module PaginateHelper
  def paginate(scope, default_per_page = Settings.pagination.default_per_page)
    collection = scope.page(params[:page]).per((params[:per_page] || default_per_page).to_i)

    current, total, per_page = collection.current_page, collection.total_pages, collection.limit_value

    return {
      pagination: {
        current:  current,
        previous: (current > 1 ? (current - 1) : nil),
        next:     (current == total ? nil : (current + 1)),
        per_page: per_page,
        pages:    total,
        count:    collection.total_count
      },
      collection: collection
    }
  end
end
