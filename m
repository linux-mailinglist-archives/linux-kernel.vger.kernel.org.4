Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB446932AF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBKQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBKQ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:59:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91226BD;
        Sat, 11 Feb 2023 08:59:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a2so8157518wrd.6;
        Sat, 11 Feb 2023 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8H+7AINgI/jSeO6Q1IIPfehvvwLhaBeqo0zrK6WmkI=;
        b=I7gLmbz/f4+259Xiaw35bd0ebOFt3voVdnioFgdpDAZ7pZgk4zdIpXKx8RpcTpwP2y
         9HH62/MDUaPdFcH6dxx67BRfanX8HUe0QvPQfaQnyatx1oD+y0HeysQP4znOV9VL0aKl
         An9+Gbhe7CQeEH3/8J6dMyxQ+dbF5qEo5e/4+hOMwi9m4S16ZPm52NeJ0tx2iDrLXEsQ
         rR27LRODx3uxfDrgXRWiHnVyxr4hNamLwWYPESK0f2WzHe9ELNztBCLx2Vlif//LEC5N
         Pe7B0tugTjH004HLn0Y2OgIRohkwHG67tJteDovibkMDPT71j/yJ3Vm37QnJ77bLE2yf
         5DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8H+7AINgI/jSeO6Q1IIPfehvvwLhaBeqo0zrK6WmkI=;
        b=OdhzFVgkljf6EEUGXxDZ0byPGQontH3GMqeZAqUxUyQDePRKbjl7+Ti0lMCHq9vmEv
         SL+wRtMyf6mZT7OJaV9sqjmW6yiuSyLBjzwc6Bskpc3QbcjimQLi+LG5/DCe1T+Y2hBe
         untcCMxglKYl1+ErutcfEXTOLOzl37BHNDCcvujxxZ2YO5nWZ/2AgeXrhfuLGC3wwJOH
         vQFO3F+31MZT7wukyukTUVsc9Qh0Q8PvwVMYbxhqPjtZf55V5nFeC7GvI+FsoyNY4foW
         EYdrXazqHJ5Gv67gs3y0gQzLUO87lG7I3gmbHp+TH45IuQm+67JZHn0EY1EsGpXBsYpq
         HPKw==
X-Gm-Message-State: AO0yUKUmNIzF4oyForoTJ65Jp9hd8W3k7WJUYhRbdmfoFIfHqpf89y+9
        NhLqRtZCmfhlXrCUKtcz26RVfCGdp8VT3w==
X-Google-Smtp-Source: AK7set+khXAQrtDghP+lf5bYXrAmWEDEoKrgaAv2fsmj1iAsb7w8JzNx3Cj5mIoe20THBOhrRVwwFQ==
X-Received: by 2002:a5d:5583:0:b0:2bf:bc75:1730 with SMTP id i3-20020a5d5583000000b002bfbc751730mr16555726wrv.70.1676134749152;
        Sat, 11 Feb 2023 08:59:09 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20d3:ac00:30d6:d4a1:e6f6:5876])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b002c54536c662sm5097893wrn.34.2023.02.11.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 08:59:08 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 1/5] hwmon: (aquacomputer_d5next) Support one byte control values
Date:   Sat, 11 Feb 2023 17:59:19 +0100
Message-Id: <20230211165923.17807-2-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211165923.17807-1-leonard.anderweit@gmail.com>
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
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

Add support for one byte control values. This extends aqc_set_ctrl_val() and
aqc_get_ctrl_val() with a type. Currently supported types are AQC_8 (one byte)
and AQC_BE16 (two bytes big endian). More types will be added in the future.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 47 +++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 12682a610ce7..d69c2396854c 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -70,6 +70,10 @@ static u8 secondary_ctrl_report[] = {
 /* Report IDs for legacy devices */
 #define POWERADJUST3_STATUS_REPORT_ID	0x03
 
+/* Data types for reading and writing control reports */
+#define AQC_8		0
+#define AQC_BE16	1
+
 /* Info, sensor sizes and offsets for most Aquacomputer devices */
 #define AQC_SERIAL_START		0x3
 #define AQC_FIRMWARE_VERSION		0xD
@@ -544,7 +548,7 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 }
 
 /* Refreshes the control buffer and stores value at offset in val */
-static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val)
+static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val, int type)
 {
 	int ret;
 
@@ -554,14 +558,23 @@ static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val)
 	if (ret < 0)
 		goto unlock_and_return;
 
-	*val = (s16)get_unaligned_be16(priv->buffer + offset);
+	switch (type) {
+	case AQC_BE16:
+		*val = (s16)get_unaligned_be16(priv->buffer + offset);
+		break;
+	case AQC_8:
+		*val = priv->buffer[offset];
+		break;
+	default:
+		ret = -EINVAL;
+	}
 
 unlock_and_return:
 	mutex_unlock(&priv->mutex);
 	return ret;
 }
 
-static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val)
+static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int type)
 {
 	int ret;
 
@@ -571,7 +584,18 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val)
 	if (ret < 0)
 		goto unlock_and_return;
 
-	put_unaligned_be16((s16)val, priv->buffer + offset);
+	switch (type) {
+	case AQC_BE16:
+		put_unaligned_be16((s16)val, priv->buffer + offset);
+		break;
+	case AQC_8:
+		priv->buffer[offset] = (u8)val;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	if (ret < 0)
+		goto unlock_and_return;
 
 	ret = aqc_send_ctrl_data(priv);
 
@@ -775,7 +799,7 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		case hwmon_temp_offset:
 			ret =
 			    aqc_get_ctrl_val(priv, priv->temp_ctrl_offset +
-					     channel * AQC_SENSOR_SIZE, val);
+					     channel * AQC_SENSOR_SIZE, val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 
@@ -791,7 +815,8 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			*val = priv->speed_input[channel];
 			break;
 		case hwmon_fan_pulses:
-			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
+			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset,
+					       val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 			break;
@@ -804,7 +829,8 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		break;
 	case hwmon_pwm:
 		if (priv->fan_ctrl_offsets) {
-			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel], val);
+			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
+					       val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 
@@ -877,7 +903,7 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			val = clamp_val(val, -15000, 15000) / 10;
 			ret =
 			    aqc_set_ctrl_val(priv, priv->temp_ctrl_offset +
-					     channel * AQC_SENSOR_SIZE, val);
+					     channel * AQC_SENSOR_SIZE, val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 			break;
@@ -889,7 +915,8 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		switch (attr) {
 		case hwmon_fan_pulses:
 			val = clamp_val(val, 10, 1000);
-			ret = aqc_set_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
+			ret = aqc_set_ctrl_val(priv, priv->flow_pulses_ctrl_offset,
+					       val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 			break;
@@ -906,7 +933,7 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 					return pwm_value;
 
 				ret = aqc_set_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
-						       pwm_value);
+						       pwm_value, AQC_BE16);
 				if (ret < 0)
 					return ret;
 			}
-- 
2.39.1

