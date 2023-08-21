import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
void main(){
  late FlutterDriver driver;

  setUpAll(()async{
    driver = await FlutterDriver.connect();
  });

  tearDownAll((){
    if(driver != null){
      driver.close();
    }
  });

  test('the values of pi are 3.0,3.1,3.14,3.141 and 3.1415', () async{
    await driver.waitFor(find.text('Calculating pi...'));
    await driver.waitFor(find.text('The latest known value of pi is 3.0'));
    await driver.waitFor(find.text('The latest known value of pi is 3.1'));
    await driver.waitFor(find.text('The latest known value of pi is 3.14'));
    await driver.waitFor(find.text('The latest known value of pi is 3.141'));
    await driver.waitFor(find.text('The latest known value of pi is 3.1415'));
  });

  test('multiplying 5 and 10 shows 50', () async{
    await driver.takeScreenshot('no_values_entered');
    await driver.tap(find.byValueKey('textField_top_multiplied by'));
    await driver.enterText('5');
    await driver.takeScreenshot('entered_5');
    await driver.tap(find.byValueKey('textField_bottom_multiplied by'));
    await driver.enterText('10');
    await driver.takeScreenshot('entered_10');
    await waitForObject(find.text('is 50.0'),Duration(seconds: 10),driver);
    await driver.takeScreenshot('result_is_50');

    // await driver.waitFor(find.text('is 50.0'));
  });
}
extension on FlutterDriver{
  Future<void> takeScreenshot(String name) async {
    final filePath = File('screenshots/$name.png');
    if(await filePath.exists()){
      await filePath.delete(recursive: true);
    }
    final file = await filePath.create(recursive: true);
    final png = await screenshot();
    file.writeAsBytesSync(png);
    print('screenshot with name $name was taken');
  }
}

Future waitForObject(SerializableFinder object, Duration timeout,FlutterDriver driver, {String errorMessage = "waitForObject timed out"}) async {
  var message = "ERROR ==> $errorMessage";
  return await driver.waitFor(object, timeout: timeout).catchError((e) { throw(message);});
}