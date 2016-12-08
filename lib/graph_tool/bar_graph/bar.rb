class GraphTool::BarGraph::Bar
  attr_reader :graph, :data_value, :set_nr, :bar_nr_in_set

  def initialize(graph, data_value, set_nr, bar_nr_in_set)
    @graph = graph
    @data_value = data_value
    @set_nr = set_nr
    @bar_nr_in_set = bar_nr_in_set
  end

  def draw
    graph.renderer.rect x, y, width, height, fill: graph.colors[set_nr], class: 'bar'
  end

  def x
    (x_margin + x_offset).floor.to_i
  end

  def x_margin
    graph.outer_margin + graph.bar_margin + graph.group_margin * bar_nr_in_set
  end

  def x_offset
    graph.bar_outer_width * bar_number_in_graph
  end

  def y
    y_margin + y_offset
  end

  def y_margin
    graph.outer_margin
  end

  def y_offset
    graph.inner_height * [(1 - data_value), (1 - graph.base_line)].min
  end

  def width
    graph.bar_inner_width.floor.to_i
  end

  def height
    graph.inner_height * (data_value - graph.base_line).abs
  end

  def bar_number_in_graph
    set_nr + bar_nr_in_set * graph.set_count
  end
end
