import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_app/model/global_model.dart';
import 'package:covid_app/model/state_model.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/constant/colors.dart';

class CustomSingleLineGraph extends StatelessWidget {
  final List<StateCases> data;

  CustomSingleLineGraph(this.data);

  @override
  Widget build(BuildContext context) {
    var seriesList = _createSampleData(data);
    return charts.TimeSeriesChart(seriesList, animate: true);
  }

  static List<charts.Series<StateCases, DateTime>> _createSampleData(List<StateCases> data) {
    return [
      new charts.Series<StateCases, DateTime>(
        id: 'Cases',
        colorFn: (StateCases stateCases, __) => darkBarColor,
        domainFn: (StateCases stateCases, _) => stateCases.date,
        measureFn: (StateCases stateCases, _) => stateCases.totalConfirmed,
        data: data
      )
    ];
  }
}

class CustomDoubleLineGraph extends StatelessWidget {
  final List<GlobalCaseModel> data;

  CustomDoubleLineGraph(this.data);

  @override
  Widget build(BuildContext context) {
    var seriesList = _createSampleData(data);
    return charts.TimeSeriesChart(seriesList, animate: true);

  }

  static List<charts.Series<GlobalCaseModel, DateTime>> _createSampleData(List<GlobalCaseModel> data) {
    return [
      new charts.Series<GlobalCaseModel, DateTime>(
        id: 'Confirmed Cases',
        colorFn: (GlobalCaseModel stateCases, __) => darkBarColor,
        domainFn: (GlobalCaseModel stateCases, _) => stateCases.date,
        measureFn: (GlobalCaseModel stateCases, _) => stateCases.confirmedCases,
        data: data
      ),
      new charts.Series<GlobalCaseModel, DateTime>(
        id: 'Sample Test Cases',
        colorFn: (GlobalCaseModel stateCases, __) => secoundBarColor,
        domainFn: (GlobalCaseModel stateCases, _) => stateCases.date,
        measureFn: (GlobalCaseModel stateCases, _) => stateCases.sampleTestCases,
        data: data
      )
    ];
  }
}

