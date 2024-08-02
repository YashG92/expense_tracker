import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class UpiPaymentScreen extends StatefulWidget {
  const UpiPaymentScreen({super.key});

  @override
  _UpiPaymentScreenState createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  // New variables for user input
  final _formKey = GlobalKey<FormState>();
  String _receiverUpiId = "redgorillas@icici";
  String _receiverName = 'Rahul';
  double _amount = 1.00;

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: _receiverUpiId,
        receiverName: _receiverName,
        transactionRefId: 'Testing Upi India Plugin',
        transactionNote: 'Not actual. Just an example.',
        amount: _amount,
        merchantId: '');
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (apps!.isEmpty) {
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: SizedBox(
                  height: 200,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.blue.shade900,
                        child: const Icon(
                          Icons.payment,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }
  Widget displayTransactionData(title, body) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$title: ", style: header),
        Flexible(
            child: Text(
          body,
          style: value,
        )),
      ],
    ),
  );
}

    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text("Integrate UPI"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Form fields for user input
              TextFormField(
                initialValue: _receiverUpiId,
                decoration: const InputDecoration(
                  labelText: 'Receiver UPI ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid UPI ID';
                  }
                  return null;
                },
                onSaved: (newValue) => _receiverUpiId = newValue!,
              ),
              TextFormField(
                initialValue: _amount.toString(),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  try {
                    double amount = double.parse(value);
                    if (amount <= 0) {
                      return 'Please enter a positive amount';
                    }
                  } catch (e) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
                onSaved: (newValue) => _amount = double.parse(newValue!),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Initiate transaction after form validation
                  }
                },
                child: const Text('Pay'),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: displayUpiApps(),
              ),
              Expanded(
                child: FutureBuilder(
                  future: _transaction,
                  builder:
                      (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            _upiErrorHandler(snapshot.error.runtimeType),
                            style: header,
                          ),
                        );
                      }

                      UpiResponse _upiResponse = snapshot.data!;

                      String txnId = _upiResponse.transactionId ?? 'N/A';
                      String resCode = _upiResponse.responseCode ?? 'N/A';
                      String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                      String status = _upiResponse.status ?? 'N/A';
                      String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                      _checkTxnStatus(status);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            displayTransactionData('Transaction Id', txnId),
                            displayTransactionData('Response Code', resCode),
                            displayTransactionData('Reference Id', txnRef),
                            displayTransactionData('Status', status.toUpperCase()),
                            displayTransactionData('Approval No', approvalRef),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(''),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


