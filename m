Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF3770A6F6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjETJzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjETJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:55:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A2AE5E;
        Sat, 20 May 2023 02:55:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso5547483a12.1;
        Sat, 20 May 2023 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684576531; x=1687168531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjpXxvcjylj4RVp2O6HdWdT9D4KZb2mu368MpbtA/hs=;
        b=GD6IzUtxNHJHjTOLeSqCcfRTmht7d/vHJzYajrUMf2FZ50fCsXmYBKWOsfj8qD7evD
         O6hcmPw/5sb9l+LGTut9zUzqUkxdvXnC6MyxBmXhTQqvojX4kCfhIbL4CDfqvLIqSGcO
         ljwXR3cBPQxPy865kt6iEJwOHgm2tYgTcYv43XnhqBf8A1z6FSqKOH49X+TIk1t47cZK
         K5EvX0k63uufi++KVdLTl26+brTPQlCbEQe049rU35rnziwWyFNUOrNIivW+NkftbVfz
         CoiEF9XTQhmaqaPwTYNobZzDimLBk4ABD0c+CIKTpilNTrWc31b6PxtFQm65o268Qb3x
         rzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684576531; x=1687168531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjpXxvcjylj4RVp2O6HdWdT9D4KZb2mu368MpbtA/hs=;
        b=jQ56hlEnbQim69O73GNk4S1ODjOt5Nh04776+DYrGUmH+/HAWYjof+qSV5I9IGV9h7
         rpfzbDTNo2TW1LDpsMW8v4c6vnA2mIugcD8ouNh4eMiFiGQ2VhCUExDrvb71TVcH5Zlz
         ofZbB2rsNYi4AVe9x66SPGj71lHqT5B7RNK5bfrtU9yvAv3MsN0F4TAfpdROLCuSaBXW
         Y0ITKguLO4Deyry1HtDJ8ApLOA797pFgU+NmDeTUQDn5+1puetp870zAKgfWHnSVmeH3
         70dP6ZQIviu+uNQV6kR27utb5W3Li1tmePPHy4oRPiG9BOtQb6pbJkNvO9EFWQbl8WeY
         xo3A==
X-Gm-Message-State: AC+VfDyLU9nqNPgVyR25NOMgFCH/SanXxeq3ZL53JRNntllfPeKJeO5H
        8m8MfRXCvoErnMJRNmNqdNscq4ZBhba7kA==
X-Google-Smtp-Source: ACHHUZ51FJpEdBKxiVEQ5zpcdIarsW2gr+9zCYKctvOc1eVu+0NhN2AoO8VpZGcTd7L0k+tZigm8Cg==
X-Received: by 2002:a17:906:9743:b0:94f:4102:25c8 with SMTP id o3-20020a170906974300b0094f410225c8mr5583544ejy.61.1684576531250;
        Sat, 20 May 2023 02:55:31 -0700 (PDT)
Received: from fedora.. ([87.116.164.240])
        by smtp.gmail.com with ESMTPSA id jy18-20020a170907763200b0094e1344ddfdsm628335ejc.34.2023.05.20.02.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 02:55:30 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     main@ehvag.de, Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (aquacomputer_d5next) Add support for Aquacomputer Leakshield
Date:   Sat, 20 May 2023 11:54:47 +0200
Message-Id: <20230520095447.509287-3-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520095447.509287-1-savicaleksa83@gmail.com>
References: <20230520095447.509287-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend aquacomputer_d5next driver to expose various hardware sensors of the
Aquacomputer Leakshield leak prevention system, which communicates
through a proprietary USB HID protocol. Implemented by Noah Bergbauer [1].

Two temperature sensors are exposed, along with pressure (current, min, max
and target), reservoir volume (total and filled), pump speed and flow. Pump
speed and flow values are user provided and allow the Leakshield to
optimize its operation. Writing them to the device is subject of future
patches.

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/41

Originally-from: Noah Bergbauer <main@ehvag.de>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v2:
- Moved macro renaming to previous patch
---
 Documentation/hwmon/aquacomputer_d5next.rst |   9 ++
 drivers/hwmon/aquacomputer_d5next.c         | 109 +++++++++++++++++++-
 2 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 14b37851af0c..94dc2d93d180 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -12,6 +12,7 @@ Supported devices:
 * Aquacomputer Octo fan controller
 * Aquacomputer Quadro fan controller
 * Aquacomputer High Flow Next sensor
+* Aquacomputer Leakshield leak prevention system
 * Aquacomputer Aquastream XT watercooling pump
 * Aquacomputer Aquastream Ultimate watercooling pump
 * Aquacomputer Poweradjust 3 fan controller
@@ -57,6 +58,11 @@ The High Flow Next exposes +5V voltages, water quality, conductivity and flow re
 A temperature sensor can be connected to it, in which case it provides its reading
 and an estimation of the dissipated/absorbed power in the liquid cooling loop.
 
+The Leakshield exposes two temperature sensors and coolant pressure (current, min, max and
+target readings). It also exposes the estimated reservoir volume and how much of it is
+filled with coolant. Pump RPM and flow can be set to enhance on-device calculations,
+but this is not yet implemented here.
+
 The Aquastream XT pump exposes temperature readings for the coolant, external sensor
 and fan IC. It also exposes pump and fan speeds (in RPM), voltages, as well as pump
 current.
@@ -83,6 +89,9 @@ Sysfs entries
 temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
 temp[1-8]_offset Temperature sensor correction offset (in millidegrees Celsius)
 fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
+fan1_min         Minimal fan speed (in RPM)
+fan1_max         Maximal fan speed (in RPM)
+fan1_target      Target fan speed (in RPM)
 fan5_pulses      Quadro flow sensor pulses
 power[1-8]_input Pump/fan power (in micro Watts)
 in[0-7]_input    Pump/fan voltage (in milli Volts)
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 834d011e220f..a981f7086114 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
- * Quadro, High Flow Next, Aquaero, Aquastream Ultimate)
+ * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
  * sensor values, except for devices that communicate through the
@@ -29,6 +29,7 @@
 #define USB_PRODUCT_ID_FARBWERK360	0xf010
 #define USB_PRODUCT_ID_OCTO		0xf011
 #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
+#define USB_PRODUCT_ID_LEAKSHIELD	0xf014
 #define USB_PRODUCT_ID_AQUASTREAMXT	0xf0b6
 #define USB_PRODUCT_ID_AQUASTREAMULT	0xf00b
 #define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
@@ -36,7 +37,7 @@
 enum kinds {
 	d5next, farbwerk, farbwerk360, octo, quadro,
 	highflownext, aquaero, poweradjust3, aquastreamult,
-	aquastreamxt
+	aquastreamxt, leakshield
 };
 
 static const char *const aqc_device_names[] = {
@@ -46,6 +47,7 @@ static const char *const aqc_device_names[] = {
 	[octo] = "octo",
 	[quadro] = "quadro",
 	[highflownext] = "highflownext",
+	[leakshield] = "leakshield",
 	[aquastreamxt] = "aquastreamxt",
 	[aquaero] = "aquaero",
 	[aquastreamult] = "aquastreamultimate",
@@ -236,6 +238,21 @@ static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed
 #define HIGHFLOWNEXT_5V_VOLTAGE		97
 #define HIGHFLOWNEXT_5V_VOLTAGE_USB	99
 
+/* Specs of the Leakshield */
+#define LEAKSHIELD_NUM_SENSORS		2
+
+/* Sensor report offsets for Leakshield */
+#define LEAKSHIELD_PRESSURE_ADJUSTED	285
+#define LEAKSHIELD_TEMPERATURE_1	265
+#define LEAKSHIELD_TEMPERATURE_2	287
+#define LEAKSHIELD_PRESSURE_MIN		291
+#define LEAKSHIELD_PRESSURE_TARGET	293
+#define LEAKSHIELD_PRESSURE_MAX		295
+#define LEAKSHIELD_PUMP_RPM_IN		101
+#define LEAKSHIELD_FLOW_IN		111
+#define LEAKSHIELD_RESERVOIR_VOLUME	313
+#define LEAKSHIELD_RESERVOIR_FILLED	311
+
 /* Specs of the Aquastream XT pump */
 #define AQUASTREAMXT_SERIAL_START		0x3a
 #define AQUASTREAMXT_FIRMWARE_VERSION		0x32
@@ -411,6 +428,20 @@ static const char *const label_highflownext_voltage[] = {
 	"+5V USB voltage"
 };
 
+/* Labels for Leakshield */
+static const char *const label_leakshield_temp_sensors[] = {
+	"Temperature 1",
+	"Temperature 2"
+};
+
+static const char *const label_leakshield_fan_speed[] = {
+	"Pressure [ubar]",
+	"User-Provided Pump Speed",
+	"User-Provided Flow [dL/h]",
+	"Reservoir Volume [ml]",
+	"Reservoir Filled [ml]",
+};
+
 /* Labels for Aquastream XT */
 static const char *const label_aquastreamxt_temp_sensors[] = {
 	"Fan IC temp",
@@ -529,7 +560,10 @@ struct aqc_data {
 
 	/* Sensor values */
 	s32 temp_input[20];	/* Max 4 physical and 16 virtual or 8 physical and 12 virtual */
-	u16 speed_input[8];
+	s32 speed_input[8];
+	u32 speed_input_min[1];
+	u32 speed_input_target[1];
+	u32 speed_input_max[1];
 	u32 power_input[8];
 	u16 voltage_input[8];
 	u16 current_input[8];
@@ -747,6 +781,11 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 				if (channel < 3)
 					return 0444;
 				break;
+			case leakshield:
+				/* Special case for Leakshield sensors */
+				if (channel < 5)
+					return 0444;
+				break;
 			case aquaero:
 			case quadro:
 				/* Special case to support flow sensors */
@@ -764,6 +803,13 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 			if (priv->kind == quadro && channel == priv->num_fans)
 				return 0644;
 			break;
+		case hwmon_fan_min:
+		case hwmon_fan_max:
+		case hwmon_fan_target:
+			/* Special case for Leakshield pressure sensor */
+			if (priv->kind == leakshield && channel == 0)
+				return 0444;
+			break;
 		default:
 			break;
 		}
@@ -938,8 +984,20 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_input:
+			if (priv->speed_input[channel] == -ENODATA)
+				return -ENODATA;
+
 			*val = priv->speed_input[channel];
 			break;
+		case hwmon_fan_min:
+			*val = priv->speed_input_min[channel];
+			break;
+		case hwmon_fan_max:
+			*val = priv->speed_input_max[channel];
+			break;
+		case hwmon_fan_target:
+			*val = priv->speed_input_target[channel];
+			break;
 		case hwmon_fan_pulses:
 			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset,
 					       val, AQC_BE16);
@@ -1151,7 +1209,8 @@ static const struct hwmon_channel_info * const aqc_info[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
+			   HWMON_F_TARGET,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
@@ -1314,6 +1373,28 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		priv->speed_input[1] = get_unaligned_be16(data + HIGHFLOWNEXT_WATER_QUALITY);
 		priv->speed_input[2] = get_unaligned_be16(data + HIGHFLOWNEXT_CONDUCTIVITY);
 		break;
+	case leakshield:
+		priv->speed_input[0] =
+		    ((s16)get_unaligned_be16(data + LEAKSHIELD_PRESSURE_ADJUSTED)) * 100;
+		priv->speed_input_min[0] = get_unaligned_be16(data + LEAKSHIELD_PRESSURE_MIN) * 100;
+		priv->speed_input_target[0] =
+		    get_unaligned_be16(data + LEAKSHIELD_PRESSURE_TARGET) * 100;
+		priv->speed_input_max[0] = get_unaligned_be16(data + LEAKSHIELD_PRESSURE_MAX) * 100;
+
+		priv->speed_input[1] = get_unaligned_be16(data + LEAKSHIELD_PUMP_RPM_IN);
+		if (priv->speed_input[1] == AQC_SENSOR_NA)
+			priv->speed_input[1] = -ENODATA;
+
+		priv->speed_input[2] = get_unaligned_be16(data + LEAKSHIELD_FLOW_IN);
+		if (priv->speed_input[2] == AQC_SENSOR_NA)
+			priv->speed_input[2] = -ENODATA;
+
+		priv->speed_input[3] = get_unaligned_be16(data + LEAKSHIELD_RESERVOIR_VOLUME);
+		priv->speed_input[4] = get_unaligned_be16(data + LEAKSHIELD_RESERVOIR_FILLED);
+
+		/* Second temp sensor is not positioned after the first one, read it here */
+		priv->temp_input[1] = get_unaligned_be16(data + LEAKSHIELD_TEMPERATURE_2) * 10;
+		break;
 	default:
 		break;
 	}
@@ -1571,6 +1652,25 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_highflownext_power;
 		priv->voltage_label = label_highflownext_voltage;
 		break;
+	case USB_PRODUCT_ID_LEAKSHIELD:
+		/*
+		 * Choose the right Leakshield device, because
+		 * the other one acts as a keyboard
+		 */
+		if (hdev->type != 2) {
+			ret = -ENODEV;
+			goto fail_and_close;
+		}
+
+		priv->kind = leakshield;
+
+		priv->num_fans = 0;
+		priv->num_temp_sensors = LEAKSHIELD_NUM_SENSORS;
+		priv->temp_sensor_start_offset = LEAKSHIELD_TEMPERATURE_1;
+
+		priv->temp_label = label_leakshield_temp_sensors;
+		priv->speed_label = label_leakshield_fan_speed;
+		break;
 	case USB_PRODUCT_ID_AQUASTREAMXT:
 		priv->kind = aquastreamxt;
 
@@ -1707,6 +1807,7 @@ static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_LEAKSHIELD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMXT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMULT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERADJUST3) },
-- 
2.40.1

