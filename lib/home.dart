import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double loanAmount = 15000;
  double rateOfInterest = 11;
  double loanTenure = 12;
  double? emi;
  double? monthInterest;
  double? totalInterest;

  void emiCalculation() {
    monthInterest = rateOfInterest / 12 / 100;

    emi = loanAmount *
        monthInterest! *
        (pow((1 + monthInterest!), loanTenure) /
            (pow((1 + monthInterest!), loanTenure) - 1));

    totalInterest = (emi! * loanTenure) - loanAmount;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emiCalculation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF27282E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "EMI Calculator",
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 5,
          right: 5,
        ),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color(0xFF252A31),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF42474B),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(-5, -5),
            ),
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Slider(
              min: 15000,
              max: 100000,
              value: loanAmount,
              activeColor: const Color(0xFFBB868F),
              inactiveColor: const Color(0xFFF3F6FB),
              // divisions: 10,
              onChanged: (value) {
                setState(
                  () {
                    loanAmount = value;
                  },
                );
                emiCalculation();
                // debugPrint("$value");
              },
            ),
            userValue(
              title: "Loan Amount",
              value: "₹ ${loanAmount.round()}",
            ),
            Slider(
              min: 11,
              max: 22,
              value: rateOfInterest,
              activeColor: const Color(0xFFBB868F),
              inactiveColor: const Color(0xFFF3F6FB),
              onChanged: (value) {
                setState(
                  () {
                    rateOfInterest = value;
                  },
                );
                emiCalculation();
              },
            ),
            userValue(
              title: "Rate of interest",
              value: "${rateOfInterest.round()} %",
            ),
            Slider(
              min: 12,
              max: 24,
              value: loanTenure,
              activeColor: const Color(0xFFBB868F),
              inactiveColor: const Color(0xFFF3F6FB),
              onChanged: (value) {
                setState(
                  () {
                    loanTenure = value;
                  },
                );
                emiCalculation();
              },
            ),
            userValue(
              title: "Loan tenure",
              value: "${loanTenure.round()} Months",
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 30,
                right: 30,
                bottom: 40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PieChart(
                    colorList: const [
                      Color(0xFFBB868F),
                      Color(0xFFF3F6FB),
                    ],
                    chartType: ChartType.ring,
                    chartRadius: 120,
                    ringStrokeWidth: 40,
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                    dataMap: {
                      "Principal amount": loanAmount,
                      "Total interest": totalInterest!,
                    },
                  ),
                  Text(
                    "EMI\n₹ ${emi!.round()}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFF3F6FB),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Color(0xFFBB868F),
                  size: 30,
                ),
                const Expanded(
                  child: Text(
                    "  Principal amount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFA4A4A4),
                    ),
                  ),
                ),
                Text(
                  "₹ ${loanAmount.round()}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF3F6FB),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle,
                    color: Color(0xFFF3F6FB),
                    size: 30,
                  ),
                  const Expanded(
                    child: Text(
                      "  Total interest",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFFA4A4A4)),
                    ),
                  ),
                  Text(
                    "₹ ${totalInterest!.round()}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF3F6FB),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              indent: 45,
              endIndent: 45,
              thickness: 1,
              color: Color(0xFFA4A4A4),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA4A4A4),
                  ),
                ),
                Text(
                  "₹ ${(loanAmount + totalInterest!).round()}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA4A4A4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget userValue({
    String? title,
    String? value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title",
            style: const TextStyle(
              color: Color(0xFFF3F6FB),
            ),
          ),
          Text(
            // currentValue.toString(),
            "$value",
            style: const TextStyle(
              color: Color(0xFFF3F6FB),
            ),
          )
        ],
      ),
    );
  }
}
