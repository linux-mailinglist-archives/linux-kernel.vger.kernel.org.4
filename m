Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13950639424
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 08:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKZHOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 02:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZHOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 02:14:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8E5252B8;
        Fri, 25 Nov 2022 23:14:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h131-20020a1c2189000000b003d02dd48c45so1841451wmh.0;
        Fri, 25 Nov 2022 23:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YjO/YanQ08EW5m6oz06sLtS1VFAqUK5vxgHKpPCOEpA=;
        b=I0/o2vnVy4DADgQq9T2sBU0BqgDrCOKyJJaUHSQWtkWH+Qar4P955TrcibYuX9VHnN
         gcFpayMisGlJetKQIgfcDebPrT+l5HOnG2u/Y46hmtGKTxgbHrjxttEi098v7uieksu+
         p8sc55VdInr8ttEfGkx5/XD+p2JGRy4/GLlVNRvBvkdwsJB7SbkHQQzNTgLiHaUHvsvD
         lBzB9W2GKIrSVKIMyCJMjZaUJjDYNmrN7CPHpImHGStNa5qifKEsMtGjfCkcRCbg7XjE
         y1ZrRkIIIWJcaHCbMEtIC3swO5eNQLHXTahEYTst7W3vw+PHwjyzlDPYRsIpgyUvT+Rx
         PviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjO/YanQ08EW5m6oz06sLtS1VFAqUK5vxgHKpPCOEpA=;
        b=J/E2oXnR+7Xr6lmgz7x79zY4bf9Z6OULkn0bhOl6nYcp9ifNSA3Y2bt1+OlICx2nLg
         Vo+ZdM1wRRNRb563Un/lZEhqCxAXtbi/+cxuepbNgiil/P8A5EXjGH1i01yho9DiTD1U
         KWfhRNfmzrxH6lxh3iAM0Dh6z+Il/bRFrrscWWwoWcpTpIDA5xGtCizEFjCp0AyqHYQO
         eIMtwSgStDv5sk/6U7ynMQg+VEYKtVHWng00Vl23jsf3kn6SbSqFbIRgPUU0YI8emy4L
         vb7tl65qK8+Qvq9J3yMklLebTunq9xjFj7q49Tnwi9pkiIDW/DgPS7uzB62lFl8W9GHy
         PMww==
X-Gm-Message-State: ANoB5plp27y40bkc72xHHcFSbq/SM2CriTDA3uTSo3e9hLW4/O6WRGO8
        r474rAVCKooDJoMgbXIDuJRCXM39t/3jvw==
X-Google-Smtp-Source: AA0mqf6g23SdGtyXd4WXDpHCfWeKdO9cMuWeJxA0k9qywiSoZagg1Unx0IJ213oAmJOOKixGr91kiw==
X-Received: by 2002:a05:600c:a0d:b0:3cf:6c0d:a27 with SMTP id z13-20020a05600c0a0d00b003cf6c0d0a27mr30456211wmp.196.1669446881286;
        Fri, 25 Nov 2022 23:14:41 -0800 (PST)
Received: from fedora.. ([87.116.166.89])
        by smtp.gmail.com with ESMTPSA id i19-20020a1c5413000000b003cfc02ab8basm11917943wmb.33.2022.11.25.23.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 23:14:40 -0800 (PST)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     leonard.anderweit@gmail.com,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (aquacomputer_d5next) Add support for Quadro flow sensor pulses
Date:   Sat, 26 Nov 2022 08:13:13 +0100
Message-Id: <20221126071313.34356-1-savicaleksa83@gmail.com>
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

Add support for reading and writing flow sensor pulses value on
the Aquacomputer Quadro. Implemented by Leonard Anderweit [1].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/45

Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v2:
- Added missing default: in aqc_is_visible()
---
 Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
 drivers/hwmon/aquacomputer_d5next.c         | 66 +++++++++++++++++----
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 15226346434d..637bdbc8fcad 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -39,7 +39,7 @@ current.
 
 The Quadro exposes four physical and sixteen virtual temperature sensors, a flow
 sensor and four PWM controllable fans, along with their speed (in RPM), power,
-voltage and current.
+voltage and current. Flow sensor pulses are also available.
 
 The Farbwerk and Farbwerk 360 expose four temperature sensors. Additionally,
 sixteen virtual temperature sensors of the Farbwerk 360 are exposed.
@@ -64,6 +64,7 @@ Sysfs entries
 temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
 temp[1-4]_offset Temperature sensor correction offset (in millidegrees Celsius)
 fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
+fan5_pulses      Quadro flow sensor pulses
 power[1-8]_input Pump/fan power (in micro Watts)
 in[0-7]_input    Pump/fan voltage (in milli Volts)
 curr[1-8]_input  Pump/fan current (in milli Amperes)
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 49d3f9876fe8..9cc10080160b 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -136,6 +136,7 @@ static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 
 /* Control report offsets for the Quadro */
 #define QUADRO_TEMP_CTRL_OFFSET		0xA
+#define QUADRO_FLOW_PULSES_CTRL_OFFSET	0x6
 static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed offsets (0-100%) */
 
 /* Specs of High Flow Next flow sensor */
@@ -303,6 +304,7 @@ struct aqc_data {
 	u16 temp_ctrl_offset;
 	u16 power_cycle_count_offset;
 	u8 flow_sensor_offset;
+	u8 flow_pulses_ctrl_offset;
 
 	/* General info, same across all devices */
 	u32 serial_number[2];
@@ -461,20 +463,34 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 		}
 		break;
 	case hwmon_fan:
-		switch (priv->kind) {
-		case highflownext:
-			/* Special case to support flow sensor, water quality and conductivity */
-			if (channel < 3)
-				return 0444;
+		switch (attr) {
+		case hwmon_fan_input:
+		case hwmon_fan_label:
+			switch (priv->kind) {
+			case highflownext:
+				/* Special case to support flow sensor, water quality
+				 * and conductivity
+				 */
+				if (channel < 3)
+					return 0444;
+				break;
+			case quadro:
+				/* Special case to support flow sensor */
+				if (channel < priv->num_fans + 1)
+					return 0444;
+				break;
+			default:
+				if (channel < priv->num_fans)
+					return 0444;
+				break;
+			}
 			break;
-		case quadro:
-			/* Special case to support flow sensor */
-			if (channel < priv->num_fans + 1)
-				return 0444;
+		case hwmon_fan_pulses:
+			/* Special case for Quadro flow sensor */
+			if (priv->kind == quadro && channel == priv->num_fans)
+				return 0644;
 			break;
 		default:
-			if (channel < priv->num_fans)
-				return 0444;
 			break;
 		}
 		break;
@@ -552,7 +568,18 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		}
 		break;
 	case hwmon_fan:
-		*val = priv->speed_input[channel];
+		switch (attr) {
+		case hwmon_fan_input:
+			*val = priv->speed_input[channel];
+			break;
+		case hwmon_fan_pulses:
+			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			break;
+		}
 		break;
 	case hwmon_power:
 		*val = priv->power_input[channel];
@@ -632,6 +659,18 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			return -EOPNOTSUPP;
 		}
 		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_pulses:
+			val = clamp_val(val, 10, 1000);
+			ret = aqc_set_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			break;
+		}
+		break;
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
@@ -691,7 +730,7 @@ static const struct hwmon_channel_info *aqc_info[] = {
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_PULSES,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL),
@@ -1000,6 +1039,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
 
 		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
+		priv->flow_pulses_ctrl_offset = QUADRO_FLOW_PULSES_CTRL_OFFSET;
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 
 		priv->temp_label = label_temp_sensors;
-- 
2.38.1

