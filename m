Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A70D61F60F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiKGOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiKGO3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:29:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C0620340;
        Mon,  7 Nov 2022 06:25:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id q9so30679151ejd.0;
        Mon, 07 Nov 2022 06:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlpScT6F60pSrsogTaj9VnxNe1/Gb44ya536wXTLSMQ=;
        b=J1NkmOATv/g3GqPNlMXwpr363k2bqh7cQFPn11o4w3Td3IgbdXQrgcd+qeQGgppqPC
         N4xpQa7GnULDoTFNFdt9oxJuBvvrzb9/95GTJCDIvK3JYG88zfExrZlEU9auZtidrbRG
         NT7bHyQRA5Fyrj8rdwikUDWiYEbNkw0G5DKn5TT392gS0XJY7XCTebDlbTnYrCt9RaCV
         M9zWDo5GhusTkHKDzqCnfgD0l3/FkwzVOGr7nVMvo8LK3VVZIqBvAlVaZeSnKtDNfR5i
         mCf4F88xNlVzoYXDEmSrNV55AbxZtus73an8ApAKR2+XAEAJpTbP2E/eKnuHUJYtzTsU
         EqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlpScT6F60pSrsogTaj9VnxNe1/Gb44ya536wXTLSMQ=;
        b=s3p/VaM3vV8xuO+oGubp9T9r7FdaIO/IlE1k0f54HRrCgmaziAt+Fv0xinHEbae8bE
         mvgkmnIM1Vg7MjjUt/oD3AXT+lfddREhF/L8RAza9MdfGcApdmwWbqTUMjI3iIe6xZIc
         6qyB+ta1WHb7b9WGewzZjjQgRFny7Qbgt6us17Gsm/0Hoi9knFeydT9xiIXKnrJJ8Wlx
         /8G6j3o5BBfLy4rs7mShrSliVhRUQJ7rgU0u9l8eJqHbhjrQslCTjXAOL4SyU4PCBMIG
         1Hyjm1YiuM6XU5Ttgt4tYSNP3pH+xHkaz9zqyZLXMK2VL5tjVtdxmDD4v9U9IUBjswim
         l7jQ==
X-Gm-Message-State: ACrzQf2sxZBzOF/cnqlz1IwV7m8NmctQL3rHswmqHs7cCijVB6EBNzna
        UuyzDk7yj/PX5oyXBFGoFBFB+CuTlslisQ==
X-Google-Smtp-Source: AMsMyM6RMieTI78k+MwqWZF6jdWL2SBGgr++u1vvQWxrjZOpiTzlWYsLH2cCH/UDTSMDlUPHB6X6uA==
X-Received: by 2002:a17:906:328c:b0:780:7574:ced2 with SMTP id 12-20020a170906328c00b007807574ced2mr48354885ejw.634.1667831127043;
        Mon, 07 Nov 2022 06:25:27 -0800 (PST)
Received: from fedora.. ([87.116.164.153])
        by smtp.gmail.com with ESMTPSA id fy8-20020a170906b7c800b007877ad05b32sm3489265ejb.208.2022.11.07.06.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:25:26 -0800 (PST)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Clear up macros and comments
Date:   Mon,  7 Nov 2022 15:24:55 +0100
Message-Id: <20221107142455.655998-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganize macro definitions into sections for each supported
device, with additional comments on their purpose. This should
make it easier to follow what report each offset is coming
from. Also, reformat per-device initializations in
aqc_probe() to organize them into sections (fan info,
temp sensors, other parameters and lastly labels).

No functional changes.

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 97 +++++++++++++++++++----------
 1 file changed, 63 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 608f57f59cf9..49d3f9876fe8 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -59,7 +59,7 @@ static u8 secondary_ctrl_report[] = {
 	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
 };
 
-/* Register offsets for all Aquacomputer devices */
+/* Sensor sizes and offsets for all Aquacomputer devices */
 #define AQC_TEMP_SENSOR_SIZE		0x02
 #define AQC_TEMP_SENSOR_DISCONNECTED	0x7FFF
 #define AQC_FAN_PERCENT_OFFSET		0x00
@@ -68,67 +68,80 @@ static u8 secondary_ctrl_report[] = {
 #define AQC_FAN_POWER_OFFSET		0x06
 #define AQC_FAN_SPEED_OFFSET		0x08
 
-/* Register offsets for the D5 Next pump */
-#define D5NEXT_POWER_CYCLES		0x18
-#define D5NEXT_COOLANT_TEMP		0x57
+/* Specs of the D5 Next pump */
 #define D5NEXT_NUM_FANS			2
 #define D5NEXT_NUM_SENSORS		1
 #define D5NEXT_NUM_VIRTUAL_SENSORS	8
-#define D5NEXT_VIRTUAL_SENSORS_START	0x3f
+#define D5NEXT_CTRL_REPORT_SIZE		0x329
+
+/* Sensor report offsets for the D5 Next pump */
+#define D5NEXT_POWER_CYCLES		0x18
+#define D5NEXT_COOLANT_TEMP		0x57
 #define D5NEXT_PUMP_OFFSET		0x6c
 #define D5NEXT_FAN_OFFSET		0x5f
 #define D5NEXT_5V_VOLTAGE		0x39
 #define D5NEXT_12V_VOLTAGE		0x37
-#define D5NEXT_CTRL_REPORT_SIZE		0x329
-#define D5NEXT_TEMP_CTRL_OFFSET		0x2D
+#define D5NEXT_VIRTUAL_SENSORS_START	0x3f
 static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
 
-/* Pump and fan speed registers in D5 Next control report (from 0-100%) */
-static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
+/* Control report offsets for the D5 Next pump */
+#define D5NEXT_TEMP_CTRL_OFFSET		0x2D	/* Temperature sensor offsets location */
+static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };	/* Pump and fan speed (from 0-100%) */
 
-/* Register offsets for the Farbwerk RGB controller */
+/* Spec and sensor report offset for the Farbwerk RGB controller */
 #define FARBWERK_NUM_SENSORS		4
 #define FARBWERK_SENSOR_START		0x2f
 
-/* Register offsets for the Farbwerk 360 RGB controller */
+/* Specs of the Farbwerk 360 RGB controller */
 #define FARBWERK360_NUM_SENSORS			4
-#define FARBWERK360_SENSOR_START		0x32
 #define FARBWERK360_NUM_VIRTUAL_SENSORS		16
-#define FARBWERK360_VIRTUAL_SENSORS_START	0x3a
 #define FARBWERK360_CTRL_REPORT_SIZE		0x682
+
+/* Sensor report offsets for the Farbwerk 360 */
+#define FARBWERK360_SENSOR_START		0x32
+#define FARBWERK360_VIRTUAL_SENSORS_START	0x3a
+
+/* Control report offsets for the Farbwerk 360 */
 #define FARBWERK360_TEMP_CTRL_OFFSET		0x8
 
-/* Register offsets for the Octo fan controller */
-#define OCTO_POWER_CYCLES		0x18
+/* Specs of the Octo fan controller */
 #define OCTO_NUM_FANS			8
 #define OCTO_NUM_SENSORS		4
-#define OCTO_SENSOR_START		0x3D
 #define OCTO_NUM_VIRTUAL_SENSORS	16
-#define OCTO_VIRTUAL_SENSORS_START	0x45
 #define OCTO_CTRL_REPORT_SIZE		0x65F
-#define OCTO_TEMP_CTRL_OFFSET		0xA
+
+/* Sensor report offsets for the Octo */
+#define OCTO_POWER_CYCLES		0x18
+#define OCTO_SENSOR_START		0x3D
+#define OCTO_VIRTUAL_SENSORS_START	0x45
 static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
 
-/* Fan speed registers in Octo control report (from 0-100%) */
+/* Control report offsets for the Octo */
+#define OCTO_TEMP_CTRL_OFFSET		0xA
+/* Fan speed offsets (0-100%) */
 static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0x259, 0x2AE };
 
-/* Register offsets for the Quadro fan controller */
-#define QUADRO_POWER_CYCLES		0x18
+/* Specs of Quadro fan controller */
 #define QUADRO_NUM_FANS			4
 #define QUADRO_NUM_SENSORS		4
-#define QUADRO_SENSOR_START		0x34
 #define QUADRO_NUM_VIRTUAL_SENSORS	16
-#define QUADRO_VIRTUAL_SENSORS_START	0x3c
 #define QUADRO_CTRL_REPORT_SIZE		0x3c1
+
+/* Sensor report offsets for the Quadro */
+#define QUADRO_POWER_CYCLES		0x18
+#define QUADRO_SENSOR_START		0x34
+#define QUADRO_VIRTUAL_SENSORS_START	0x3c
 #define QUADRO_FLOW_SENSOR_OFFSET	0x6e
-#define QUADRO_TEMP_CTRL_OFFSET		0xA
 static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 
-/* Fan speed registers in Quadro control report (from 0-100%) */
-static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 };
+/* Control report offsets for the Quadro */
+#define QUADRO_TEMP_CTRL_OFFSET		0xA
+static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed offsets (0-100%) */
 
-/* Register offsets for the High Flow Next */
+/* Specs of High Flow Next flow sensor */
 #define HIGHFLOWNEXT_NUM_SENSORS	2
+
+/* Sensor report offsets for the High Flow Next */
 #define HIGHFLOWNEXT_SENSOR_START	85
 #define HIGHFLOWNEXT_FLOW		81
 #define HIGHFLOWNEXT_WATER_QUALITY	89
@@ -903,14 +916,17 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->num_fans = D5NEXT_NUM_FANS;
 		priv->fan_sensor_offsets = d5next_sensor_fan_offsets;
 		priv->fan_ctrl_offsets = d5next_ctrl_fan_offsets;
+
 		priv->num_temp_sensors = D5NEXT_NUM_SENSORS;
 		priv->temp_sensor_start_offset = D5NEXT_COOLANT_TEMP;
 		priv->num_virtual_temp_sensors = D5NEXT_NUM_VIRTUAL_SENSORS;
 		priv->virtual_temp_sensor_start_offset = D5NEXT_VIRTUAL_SENSORS_START;
-		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
-		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
 		priv->temp_ctrl_offset = D5NEXT_TEMP_CTRL_OFFSET;
 
+		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
+
+		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
+
 		priv->temp_label = label_d5next_temp;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
 		priv->speed_label = label_d5next_speeds;
@@ -922,20 +938,25 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->kind = farbwerk;
 
 		priv->num_fans = 0;
+
 		priv->num_temp_sensors = FARBWERK_NUM_SENSORS;
 		priv->temp_sensor_start_offset = FARBWERK_SENSOR_START;
+
 		priv->temp_label = label_temp_sensors;
 		break;
 	case USB_PRODUCT_ID_FARBWERK360:
 		priv->kind = farbwerk360;
 
 		priv->num_fans = 0;
+
 		priv->num_temp_sensors = FARBWERK360_NUM_SENSORS;
 		priv->temp_sensor_start_offset = FARBWERK360_SENSOR_START;
 		priv->num_virtual_temp_sensors = FARBWERK360_NUM_VIRTUAL_SENSORS;
 		priv->virtual_temp_sensor_start_offset = FARBWERK360_VIRTUAL_SENSORS_START;
-		priv->buffer_size = FARBWERK360_CTRL_REPORT_SIZE;
 		priv->temp_ctrl_offset = FARBWERK360_TEMP_CTRL_OFFSET;
+
+		priv->buffer_size = FARBWERK360_CTRL_REPORT_SIZE;
+
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
 		break;
@@ -945,14 +966,17 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->num_fans = OCTO_NUM_FANS;
 		priv->fan_sensor_offsets = octo_sensor_fan_offsets;
 		priv->fan_ctrl_offsets = octo_ctrl_fan_offsets;
+
 		priv->num_temp_sensors = OCTO_NUM_SENSORS;
 		priv->temp_sensor_start_offset = OCTO_SENSOR_START;
 		priv->num_virtual_temp_sensors = OCTO_NUM_VIRTUAL_SENSORS;
 		priv->virtual_temp_sensor_start_offset = OCTO_VIRTUAL_SENSORS_START;
-		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
-		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
 		priv->temp_ctrl_offset = OCTO_TEMP_CTRL_OFFSET;
 
+		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
+
+		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
+
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
 		priv->speed_label = label_fan_speed;
@@ -966,14 +990,17 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->num_fans = QUADRO_NUM_FANS;
 		priv->fan_sensor_offsets = quadro_sensor_fan_offsets;
 		priv->fan_ctrl_offsets = quadro_ctrl_fan_offsets;
+
 		priv->num_temp_sensors = QUADRO_NUM_SENSORS;
 		priv->temp_sensor_start_offset = QUADRO_SENSOR_START;
 		priv->num_virtual_temp_sensors = QUADRO_NUM_VIRTUAL_SENSORS;
 		priv->virtual_temp_sensor_start_offset = QUADRO_VIRTUAL_SENSORS_START;
-		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
+		priv->temp_ctrl_offset = QUADRO_TEMP_CTRL_OFFSET;
+
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
+
 		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
-		priv->temp_ctrl_offset = QUADRO_TEMP_CTRL_OFFSET;
+		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -986,8 +1013,10 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->kind = highflownext;
 
 		priv->num_fans = 0;
+
 		priv->num_temp_sensors = HIGHFLOWNEXT_NUM_SENSORS;
 		priv->temp_sensor_start_offset = HIGHFLOWNEXT_SENSOR_START;
+
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 
 		priv->temp_label = label_highflownext_temp_sensors;
-- 
2.38.1

