Gem::Specification.new do |s|
  s.name        = 'graph_tool'
  s.version     = '0.0.6'
  s.date        = '2016-12-05'
  s.summary     = 'GraphTool renders beautiful graphs'
  s.description = 'A tool to create various kinds of infographics and graphs'
  s.authors     = ['Eike Send', 'Maximilian Maintz']
  s.email       = 'graph_tool@eike.se'
  s.homepage    = 'http://github.com/eikes/graph_tool'
  s.license     = 'MIT'
  s.files       = [
                    'lib/graph_tool/renderer/renderer.rb',
                    'lib/graph_tool/renderer/rvg_renderer.rb',
                    'lib/graph_tool/renderer/svg_renderer.rb',
                    'lib/graph_tool/graph.rb',
                    'lib/graph_tool/bar_graph/grid/grid.rb',
                    'lib/graph_tool/bar_graph/grid/grid_line.rb',
                    'lib/graph_tool/bar_graph/grid/vertical_grid_line.rb',
                    'lib/graph_tool/bar_graph/grid/horizontal_grid_line.rb',
                    'lib/graph_tool/bar_graph/bar_graph.rb',
                    'lib/graph_tool/bar_graph/bar/bar.rb',
                    'lib/graph_tool/bar_graph/bar/vertical_bar.rb',
                    'lib/graph_tool/bar_graph/bar/horizontal_bar.rb',
                    'lib/graph_tool/count_graph/count_graph.rb',
                    'lib/graph_tool/count_graph/circle_count_graph.rb',
                    'lib/graph_tool/count_graph/cross_count_graph.rb',
                    'lib/graph_tool/count_graph/manikin_count_graph.rb',
                    'lib/graph_tool/count_graph/symbol_count_graph.rb',
                    'lib/graph_tool/bin/opt_parser.rb',
                    'lib/graph_tool/bin/dispatcher.rb'
                    ]
  s.add_runtime_dependency 'victor'
  s.add_runtime_dependency 'rmagick'
  s.bindir      = 'bin'
end
