class OrderRepository
  def initialize(csv_path, meal_repository, employee_repository, customer_repository)
    @csv_path = csv_path
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository

    @orders = []

    @next_id = 1
    load_csv if File.exist?(@csv_path)
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    write_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def save
    write_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, csv_options) do |row|
      order = build_order(row)
      @orders << order
      @next_id += 1
    end
  end

  def write_csv
    CSV.open(@csv_path, 'wb') do |csv|
      csv << %w(id delivered meal_id employee_id customer_id)
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end

  def build_order(row)
    row[:id] = row[:id].to_i                          # Convert column to Integer
    row[:delivered] = row[:delivered] == "true"       # Convert column to Integer
    row[:meal] = @meal_repository.find(row[:meal_id].to_i)
    row[:employee] = @employee_repository.find(row[:employee_id].to_i)
    row[:customer] = @customer_repository.find(row[:customer_id].to_i)
    Order.new(row)
  end
end
