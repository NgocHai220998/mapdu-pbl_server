# frozen_string_literal: true

module PaginateHelper
  def paginate(scope, default_per_page = Settings.pagination.default_per_page)
    collection = scope.page(params[:page]).per((params[:per_page] || default_per_page).to_i)

    {
      pagination: {
        per_page: collection.limit_value,
        pages: collection.total_pages,
        count: collection.total_count
      },
      collection: collection
    }
  end
end
