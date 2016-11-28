require 'spec_helper'
require 'bar_graph'

RSpec.describe BarGraph do
  let(:data) { [[0, 10, 15, 20]] }
  let(:options) { {} }
  let(:graph) { BarGraph.new(data, options) }
  let(:svg) { Capybara.string(graph.render) }

  let(:rectangles) { svg.all('rect') }
  let(:widths) { rectangles.map { |r| r[:width] } }
  let(:heights) { rectangles.map { |r| r[:height] } }
  let(:ys) { rectangles.map { |r| r[:y] } }
  let(:xs) { rectangles.map { |r| r[:x] } }

  describe '#initialize' do
    it 'provides default options' do
      expect(graph.options[:width]).to eq(100)
    end
    it 'provides default options' do
      expect(graph.options[:height]).to eq(100)
    end
  end

  describe '#prepare_data' do
    it 'maps the data to a value between 0 and 1' do
      expect(graph.prepared_data).to eq([[0, 0.5, 0.75, 1]])
    end
    it 'maps the data to a value between 0 and 1' do
      graph.prepared_data.each do |set|
        set.each do |item|
          expect(item).to be <= 1
          expect(item).to be >= 0
        end
      end
    end
    context 'data has negative values' do
      let(:data) { [[10, -10, 5, 0, -5]] }
      it 'maps the data to a value between 0 and 1' do
        expect(graph.prepared_data).to eq([[1.0, 0.0, 0.75, 0.5, 0.25]])
      end
      it 'sets the base_line' do
        expect(graph.base_line).to eq(0.5)
      end
    end
    describe 'base_line' do
      context 'zero is 0' do
        let(:data) { [[0, 10]] }
        it 'sets the base_line' do
          expect(graph.base_line).to eq(0)
        end
      end
      context 'zero is 0.5' do
        let(:data) { [[-10, 10]] }
        it 'sets the base_line' do
          expect(graph.base_line).to eq(0.5)
        end
      end
      context 'zero is 1' do
        let(:data) { [[-10, 0]] }
        it 'sets the base_line' do
          expect(graph.base_line).to eq(1)
        end
      end
      context 'zero is 1' do
        let(:data) { [[10, 20]] }
        it 'sets the base_line' do
          expect(graph.base_line).to eq(0)
        end
      end
    end
  end

  context 'one dataset with four bars' do
    let(:data) { [[0, 10, 15, 20]] }
    it 'renders four rect' do
      expect(rectangles.count).to eq(4)
    end
    it 'correctly sets the xs' do
      expect(xs).to eq(['0.0', '25.0', '50.0', '75.0'])
    end
    it 'correctly sets the width' do
      expect(widths).to eq(['25', '25', '25', '25'])
    end
    it 'correctly sets the ys' do
      expect(ys).to eq(['100.0', '50.0', '25.0', '0.0'])
    end
    it 'correctly sets the heights' do
      expect(heights).to eq(['0.0', '50.0', '75.0', '100.0'])
    end
  end

  context 'one dataset with two bars, include_zero: true' do
    let(:data) { [[10, 20]] }
    let(:options) { { include_zero: true } }
    it 'correctly sets the ys' do
      expect(ys).to eq(['50.0', '0.0'])
    end
    it 'correctly sets the heights' do
      expect(heights).to eq(['50.0', '100.0'])
    end
  end

  context 'one dataset with two bars, include_zero: false' do
    let(:data) { [[10, 20]] }
    let(:options) { { include_zero: false } }
    it 'correctly sets the ys' do
      expect(ys).to eq(['100.0', '0.0'])
    end
    it 'correctly sets the heights' do
      expect(heights).to eq(['0.0', '100.0'])
    end
  end

  context 'one dataset with four bars with negative values' do
    let(:data) { [[-10, 0, 10, 30]] }
    it 'renders three rect' do
      expect(rectangles.count).to eq(4)
    end
    it 'correctly sets the xs' do
      expect(xs).to eq(['0.0', '25.0', '50.0', '75.0'])
    end
    it 'correctly sets the width' do
      expect(widths).to eq(['25', '25', '25', '25'])
    end
    it 'correctly sets the ys' do
      expect(ys).to eq(['75.0', '75.0', '50.0', '0.0'])
    end
    it 'correctly sets the heights' do
      expect(heights).to eq(['25.0', '0.0', '25.0', '75.0'])
    end
  end

  describe '#height and #width' do
    it 'has a width attribute' do
      expect(graph).to respond_to(:width)
    end
    it 'has a height attribute' do
      expect(graph).to respond_to(:height)
    end
    context 'provides width and height via the options' do
      let(:options) { { width: 200, height: 200 } }
      it "sets the graph.width to 200" do
        expect(graph.width).to eq(200)
      end
      it "sets the graph.height to 200" do
        expect(graph.height).to eq(200)
      end
    end
  end

end