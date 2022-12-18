Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA564FEC3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiLRLca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiLRLcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:32:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615026422;
        Sun, 18 Dec 2022 03:32:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so4629538wms.2;
        Sun, 18 Dec 2022 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGUMh8qUOo0nRY5Ge+o8HiihlH9WbEdrIODpngTYT8o=;
        b=bTZm+6W7pLy9IxX3hontjakYQQNYFg2pZ7HjDXZW+2obJb/tD/ltKYh/EsXA21ztBY
         io59ywVfMTDeW0ML4oyoYqnEOGPNlfyg4PtJHot/wzAMcHG21w/P4bUHPPNVeDyGhj1h
         AsuDij7BQv173ReC4Hd1u+eo+y4WCxn6xdfyOoeb3A3phbuK2tBChyDgorjflFHOa/Me
         L5ZjPm2KDT8Ngk0T5IEetsUBPPmKS3nFbukt645wDMEGrJMNwZDAygi6FyEGX/c4FyOy
         sl5sjy7OLrbVP52y6kMKTIGt/wIkdbtv+rs5qZdnKJzvkJY0P86AhYLRLM29gArLHLKn
         wb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGUMh8qUOo0nRY5Ge+o8HiihlH9WbEdrIODpngTYT8o=;
        b=g94iODeKhyOdLn8Dbvu0Hcn2yUlBp+Qa5cKyUEG3hgyD0b5f8rvOvyEz4HXPyNGKF0
         1mu64S8ZMehmc06M3+5h+SXdSs/1aq1Vjc8g/suWSsuTbhrR0hIILwJoU6rZ7HJkA1SQ
         l2C7xRpsT9EkyDmehPXOby4G5uJUvGexXqdnkP4pWzX1yiOBa4eUT35mEArge4yLCN5T
         etVYEL9D2Zyg8ee09HOds2VtwDaCcLGe9qE3In8o0JyCG1iQZnKDe6YAnRAkg2MWYqOz
         E0oGc8/VxBA123pTkxR9zxJEs2VhiuDiqfrrwhrZ5aPqU27ZlGa7fJCBj0iW7v534qvv
         V6rQ==
X-Gm-Message-State: ANoB5pnfR3yvRAWC0myULveb3NGtwEgywHYRCemvKI3vERZe3Jk9N6P/
        dLIOyHDJHqydXK525Pc5uAKJt7/EAJMdvwXS
X-Google-Smtp-Source: AA0mqf5zQncc9fQm9tNY5rxyqdfw64V7uzyXXXw2q5JHkTwdcb1gJOSSezGuHyGTWNUUf109HkzOkw==
X-Received: by 2002:a05:600c:3b23:b0:3d1:ebdf:d586 with SMTP id m35-20020a05600c3b2300b003d1ebdfd586mr29959461wms.29.1671363125886;
        Sun, 18 Dec 2022 03:32:05 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20fa:a700:21e9:9128:9ea2:3911])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003d069fc7372sm9440751wms.1.2022.12.18.03.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 03:32:05 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 6/6] hwmon: (aquacomputer_d5next) Support sensors for Aquacomputer Aquaero
Date:   Sun, 18 Dec 2022 12:31:31 +0100
Message-Id: <20221218113131.3752-7-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221218113131.3752-1-leonard.anderweit@gmail.com>
References: <20221218113131.3752-1-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reading sensors of the Aquacomputer Aquaero 5/6 fan
controllers. These fan controllers supports 4 fans, 8 physical
temperature sensors, 8 virtual temperature sensors and 2 flow sensors.
Temperature and flow sensor reading implemented by Aleksa Savic [1] [2]
[3].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/31
[2] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/51
[3] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/55

Originally-from: Aleksa Savic <savicaleksa83@gmail.com>
Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |   5 +
 drivers/hwmon/aquacomputer_d5next.c         | 108 ++++++++++++++++++--
 2 files changed, 104 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 637bdbc8fcad..b94ff08080bf 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -5,6 +5,7 @@ Kernel driver aquacomputer-d5next
 
 Supported devices:
 
+* Aquacomputer Aquaero 5/6 fan controllers
 * Aquacomputer D5 Next watercooling pump
 * Aquacomputer Farbwerk RGB controller
 * Aquacomputer Farbwerk 360 RGB controller
@@ -20,6 +21,10 @@ Description
 This driver exposes hardware sensors of listed Aquacomputer devices, which
 communicate through proprietary USB HID protocols.
 
+The Aquaero devices expose eight temperature sensors, eight virtual temperature
+sensors and two flow senors. The fans expose their speed (in RPM), power,
+voltage and current.
+
 For the D5 Next pump, available sensors are pump and fan speed, power, voltage
 and current, as well as coolant temperature and eight virtual temp sensors. Also
 available through debugfs are the serial number, firmware version and power-on
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index d28d7079917a..0fd00cfb86c8 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
- * Quadro, High Flow Next)
+ * Quadro, High Flow Next, Aquaero)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
  * sensor values.
@@ -21,6 +21,7 @@
 #include <asm/unaligned.h>
 
 #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
+#define USB_PRODUCT_ID_AQUAERO		0xf001
 #define USB_PRODUCT_ID_FARBWERK		0xf00a
 #define USB_PRODUCT_ID_QUADRO		0xf00d
 #define USB_PRODUCT_ID_D5NEXT		0xf00e
@@ -28,7 +29,7 @@
 #define USB_PRODUCT_ID_OCTO		0xf011
 #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
 
-enum kinds { d5next, farbwerk, farbwerk360, octo, quadro, highflownext };
+enum kinds { d5next, farbwerk, farbwerk360, octo, quadro, highflownext, aquaero };
 
 static const char *const aqc_device_names[] = {
 	[d5next] = "d5next",
@@ -36,7 +37,8 @@ static const char *const aqc_device_names[] = {
 	[farbwerk360] = "farbwerk360",
 	[octo] = "octo",
 	[quadro] = "quadro",
-	[highflownext] = "highflownext"
+	[highflownext] = "highflownext",
+	[aquaero] = "aquaero"
 };
 
 #define DRIVER_NAME			"aquacomputer_d5next"
@@ -57,7 +59,7 @@ static u8 secondary_ctrl_report[] = {
 	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
 };
 
-/* Info, sensor sizes and offsets for all Aquacomputer devices */
+/* Info, sensor sizes and offsets for most Aquacomputer devices */
 #define AQC_SERIAL_START		0x3
 #define AQC_FIRMWARE_VERSION		0xD
 
@@ -69,6 +71,24 @@ static u8 secondary_ctrl_report[] = {
 #define AQC_FAN_POWER_OFFSET		0x06
 #define AQC_FAN_SPEED_OFFSET		0x08
 
+/* Specs of the Aquaero fan controllers */
+#define AQUAERO_SERIAL_START			0x07
+#define AQUAERO_FIRMWARE_VERSION		0x0B
+#define AQUAERO_NUM_FANS			4
+#define AQUAERO_NUM_SENSORS			8
+#define AQUAERO_NUM_VIRTUAL_SENSORS		8
+#define AQUAERO_NUM_FLOW_SENSORS		2
+
+/* Sensor report offsets for Aquaero fan controllers */
+#define AQUAERO_SENSOR_START			0x65
+#define AQUAERO_VIRTUAL_SENSOR_START		0x85
+#define AQUAERO_FLOW_SENSORS_START		0xF9
+#define AQUAERO_FAN_VOLTAGE_OFFSET		0x04
+#define AQUAERO_FAN_CURRENT_OFFSET		0x06
+#define AQUAERO_FAN_POWER_OFFSET		0x08
+#define AQUAERO_FAN_SPEED_OFFSET		0x00
+static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
+
 /* Specs of the D5 Next pump */
 #define D5NEXT_NUM_FANS			2
 #define D5NEXT_NUM_SENSORS		1
@@ -181,12 +201,16 @@ static const char *const label_d5next_current[] = {
 	"Fan current"
 };
 
-/* Labels for Farbwerk, Farbwerk 360 and Octo and Quadro temperature sensors */
+/* Labels for Aquaero, Farbwerk, Farbwerk 360 and Octo and Quadro temperature sensors */
 static const char *const label_temp_sensors[] = {
 	"Sensor 1",
 	"Sensor 2",
 	"Sensor 3",
-	"Sensor 4"
+	"Sensor 4",
+	"Sensor 5",
+	"Sensor 6",
+	"Sensor 7",
+	"Sensor 8"
 };
 
 static const char *const label_virtual_temp_sensors[] = {
@@ -262,6 +286,16 @@ static const char *const label_quadro_speeds[] = {
 	"Flow speed [dL/h]"
 };
 
+/* Labels for Aquaero fan speeds */
+static const char *const label_aquaero_speeds[] = {
+	"Fan 1 speed",
+	"Fan 2 speed",
+	"Fan 3 speed",
+	"Fan 4 speed",
+	"Flow sensor 1 [dL/h]",
+	"Flow sensor 2 [dL/h]"
+};
+
 /* Labels for High Flow Next */
 static const char *const label_highflownext_temp_sensors[] = {
 	"Coolant temp",
@@ -290,6 +324,14 @@ struct aqc_fan_structure_offsets {
 	u8 speed;
 };
 
+/* Fan structure offsets for Aquaero */
+static struct aqc_fan_structure_offsets aqc_aquaero_fan_structure = {
+	.voltage = AQUAERO_FAN_VOLTAGE_OFFSET,
+	.curr = AQUAERO_FAN_CURRENT_OFFSET,
+	.power = AQUAERO_FAN_POWER_OFFSET,
+	.speed = AQUAERO_FAN_SPEED_OFFSET
+};
+
 /* Fan structure offsets for all devices except Aquaero */
 static struct aqc_fan_structure_offsets aqc_general_fan_structure = {
 	.voltage = AQC_FAN_VOLTAGE_OFFSET,
@@ -496,6 +538,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 				if (channel < 3)
 					return 0444;
 				break;
+			case aquaero:
 			case quadro:
 				/* Special case to support flow sensors */
 				if (channel < priv->num_fans + priv->num_flow_sensors)
@@ -977,6 +1020,42 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto fail_and_stop;
 
 	switch (hdev->product) {
+	case USB_PRODUCT_ID_AQUAERO:
+		/*
+		 * Aquaero presents itself as three HID devices under the same product ID:
+		 * "aquaero keyboard/mouse", "aquaero System Control" and "aquaero Device",
+		 * which is the one we want to communicate with. Unlike most other Aquacomputer
+		 * devices, Aquaero does not return meaningful data when explicitly requested
+		 * using GET_FEATURE_REPORT.
+		 *
+		 * The difference between "aquaero Device" and the other two is in the collections
+		 * they present. The two other devices have the type of the second element in
+		 * their respective collections set to 1, while the real device has it set to 0.
+		 */
+		if (hdev->collection[1].type != 0) {
+			ret = -ENODEV;
+			goto fail_and_close;
+		}
+
+		priv->kind = aquaero;
+
+		priv->num_fans = AQUAERO_NUM_FANS;
+		priv->fan_sensor_offsets = aquaero_sensor_fan_offsets;
+
+		priv->num_temp_sensors = AQUAERO_NUM_SENSORS;
+		priv->temp_sensor_start_offset = AQUAERO_SENSOR_START;
+		priv->num_virtual_temp_sensors = AQUAERO_NUM_VIRTUAL_SENSORS;
+		priv->virtual_temp_sensor_start_offset = AQUAERO_VIRTUAL_SENSOR_START;
+		priv->num_flow_sensors = AQUAERO_NUM_FLOW_SENSORS;
+		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
+
+		priv->temp_label = label_temp_sensors;
+		priv->virtual_temp_label = label_virtual_temp_sensors;
+		priv->speed_label = label_aquaero_speeds;
+		priv->power_label = label_fan_power;
+		priv->voltage_label = label_fan_voltage;
+		priv->current_label = label_fan_current;
+		break;
 	case USB_PRODUCT_ID_D5NEXT:
 		priv->kind = d5next;
 
@@ -1100,10 +1179,20 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		break;
 	}
 
-	priv->serial_number_start_offset = AQC_SERIAL_START;
-	priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
+	switch (priv->kind) {
+	case aquaero:
+		priv->serial_number_start_offset = AQUAERO_SERIAL_START;
+		priv->firmware_version_offset = AQUAERO_FIRMWARE_VERSION;
+
+		priv->fan_structure = &aqc_aquaero_fan_structure;
+		break;
+	default:
+		priv->serial_number_start_offset = AQC_SERIAL_START;
+		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
 
-	priv->fan_structure = &aqc_general_fan_structure;
+		priv->fan_structure = &aqc_general_fan_structure;
+		break;
+	}
 
 	if (priv->buffer_size != 0) {
 		priv->checksum_start = 0x01;
@@ -1152,6 +1241,7 @@ static void aqc_remove(struct hid_device *hdev)
 }
 
 static const struct hid_device_id aqc_table[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUAERO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
-- 
2.38.1

