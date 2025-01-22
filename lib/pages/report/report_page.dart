import 'package:flareline_crm/pages/crm_layout.dart';
import 'package:flareline_uikit/components/charts/circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../components/card_report_widget.dart';

class ReportPage extends CrmLayout {
  const ReportPage({super.key});

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.white;

  @override
  String breakTabTitle(BuildContext context) {
    // TODO: implement breakTabTitle
    return 'تقارير';
  }

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: InkWell(
                    child: const FractionallySizedBox(
                        heightFactor: .6,
                        child: ReportCard(
                          title: 'مصاريف',
                          imageSrc: 'assets/crm/budget-cost-colored.svg',
                          amount: '750',
                          //color: Color(0xFFefc3ca).withOpacity(0.8),
                          color: Color(0xFFA7F3D0),
                        )),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/cost');
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(
                  width: 250,
                  height: 250,
                  child: FractionallySizedBox(
                      heightFactor: .6,
                      child: ReportCard(
                        title: 'عدد الجلسات',
                        imageSrc: 'assets/crm/budget-cost-colored.svg',
                        amount: '285',
                        color: Color(0xFFE0F7FA),
                      )),
                ),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(
                  width: 250,
                  height: 250,
                  child: FractionallySizedBox(
                      heightFactor: .6,
                      child: ReportCard(
                        title: 'زائر',
                        imageSrc: 'assets/crm/budget-cost-colored.svg',
                        amount: '69',
                        //color: Colors.deepPurpleAccent.withOpacity(.7) // Remove const here
                        color: Color(0xFF60A5FA),
                      )),
                ),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(
                  width: 250,
                  height: 250,
                  child: FractionallySizedBox(
                      heightFactor: .6,
                      child: ReportCard(
                        title: 'الارباح',
                        imageSrc: 'assets/crm/invoice.svg',
                        amount: '1550',
                        color: Color(0xFFB57EDC),
                        //color: const Color(0xFFf5ebd8)
                        //color: const Color(0xFFc7ff00)
                        //.withOpacity(0.75), // Remove const here
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Card(
                      //color: Colors.amber.shade50,
                      elevation: 10,
                      child: CircularhartWidget(
                        title: 'نوع الزوار',
                        position: LegendPosition.bottom,
                        orientation: LegendItemOrientation.horizontal,
                        palette: const [
                          Color(0xFFD8A7D2),
                          Color(0xFF3B82F6),
                          Color(0xFFA7F3D0),
                        ],
                        chartData: const [
                          {
                            'x': 'نساء',
                            'y': 35,
                          },
                          {
                            'x': 'رجال',
                            'y': 49,
                          },
                          {
                            'x': 'اطفال',
                            'y': 16,
                          },
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Card(
                      //color: Colors.amber.shade50,
                      elevation: 10,
                      child: CircularhartWidget(
                        title: 'المصاريف',
                        position: LegendPosition.bottom,
                        orientation: LegendItemOrientation.horizontal,
                        palette: const [
                          Color(0xFF1D4ED8),
                          Color(0xFF60A5FA),
                          Color(0xFF34D399),
                          Color(0xFFFB923C),
                        ],
                        chartData: const [
                          {
                            'x': 'رواتب',
                            'y': 43,
                          },
                          {
                            'x': 'اجار',
                            'y': 22,
                          },
                          {
                            'x': 'ادوات طبية',
                            'y': 20,
                          },
                          {
                            'x': 'مصاريف اخرى',
                            'y': 15,
                          },
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Card(
                      //color: Colors.amber.shade50,
                      elevation: 10,
                      child: CircularhartWidget(
                        title: 'طريقة الدفع',
                        position: LegendPosition.bottom,
                        orientation: LegendItemOrientation.horizontal,
                        palette: const [Color(0xFF3B82F6), Color(0xFFFB923C)],
                        chartData: const [
                          {
                            'x': 'نقد',
                            'y': 37,
                          },
                          {
                            'x': 'تأمين',
                            'y': 63,
                          },
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                    child: Card(
                  elevation: 10,
                  child: buildBar([
                    ChartData('رقبة', 74, Color(0xFF8B5CF6)), //teal
                    ChartData('دسك', 77, Color(0xFF1D4ED8)), //orange
                    ChartData('ركبة', 68, Color(0xFF14B8A6)), //brown
                    ChartData('مرفق', 66, Color(0xFFF9A8D4)) //deepOrange
                  ]),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Card(
                        //color: Colors.amber.shade50,
                        elevation: 10,
                        child: _buildTrackerBarChart('عدد الجلسات'))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBar(List<ChartData> chartData) {
    return SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        title: const ChartTitle(
            text: 'نوع الجلسات',
            textStyle: TextStyle(fontWeight: FontWeight.bold)),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              // Map color for each data point from the data source
              pointColorMapper: (ChartData data, _) => data.color)
        ]);
  }

  SfCartesianChart _buildTrackerBarChart(String text) {
    return SfCartesianChart(
      palette: const [Color(0xFF34D399)],
      plotAreaBorderWidth: 0,
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          title: AxisTitle(
              text: text,
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          minimum: 0,
          maximum: 50,
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getTrackerBarSeries(),
    );
  }

  /// Returns the lsit of chart series
  /// which need to render on the bar chart with trackers.
  List<BarSeries<ChartSampleData, String>> _getTrackerBarSeries() {
    return <BarSeries<ChartSampleData, String>>[
      BarSeries<ChartSampleData, String>(
        width: 0.5,
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'خالد سالم', y: 14, color: Colors.green),
          ChartSampleData(x: 'هبة عمر', y: 35, color: Colors.green),
          ChartSampleData(x: 'محمد شخاتره', y: 28, color: Colors.green),
          ChartSampleData(x: 'رائد الجمدي', y: 23, color: Colors.green),
        ],
        // borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        pointColorMapper: (datum, index) => datum.color,
        trackColor: Colors.transparent,
        // markerSettings: const MarkerSettings(
        //     isVisible: true,
        //     image: AssetImage(
        //       'assets/crm/therapist_profile_picture_1.jpg',
        //     ),
        //     width: 30,
        //     height: 30),

        /// If we enable this property as true,
        /// then we can show the track of series.
        isTrackVisible: true,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          labelAlignment: ChartDataLabelAlignment.top,
        ),
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
      ),
    ];
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume,
      this.color});

  final Color? color;

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

/// Chart Sales Data
class SalesData {
  /// Holds the datapoint values like x, y, etc.,
  SalesData(this.x, this.y, [this.date, this.color]);

  /// X value of the data point
  final dynamic x;

  /// y value of the data point
  final dynamic y;

  /// color value of the data point
  final Color? color;

  /// Date time value of the data point
  final DateTime? date;
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}
