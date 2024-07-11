package com.example.flutter_application

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.sms/sender"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "sendSms") {
                val recipientNumber = call.argument<String>("recipientNumber")
                val message = call.argument<String>("message")
                if (recipientNumber != null && message != null) {
                    sendSms(recipientNumber, message)
                    result.success("SMS Sent")
                } else {
                    result.error("INVALID_ARGUMENT", "Recipient number or message is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun sendSms(recipientNumber: String, message: String) {
        val smsManager = android.telephony.SmsManager.getDefault()
        smsManager.sendTextMessage(recipientNumber, null, message, null, null)
    }
}