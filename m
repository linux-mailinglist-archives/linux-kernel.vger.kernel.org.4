Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6F64FEC0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiLRLcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiLRLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:32:05 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA64D6567;
        Sun, 18 Dec 2022 03:32:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay40so4695332wmb.2;
        Sun, 18 Dec 2022 03:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSetaWLPY2RzczT8dviu9hjeHMLZpPIw6Q1N0t2ZCKw=;
        b=Cyb93Jfpn/cMaA8CYCQBPt9rsFG9AEWjzj/F8ZsdNxUTs7KrhOq6x0u91KVY2DghTh
         4nb8dBHbyIkyWRHchu7MOtIclaYwHtbZZvrNs7uj1aXCJeXwqNMluJ1di2iRiH7KrW7X
         DrjJ23d4jmYJA6dKp+FTxoz7ayxr/KKdDHObJdYMf6Sh7/rh4v5En8OYS7+X1uEjehag
         XWA5eAAyGlj09ZQl5RjWPrFhzD4MAtq4uG2EBMLg7Rbvi4COpaJuT2PotbCLxjgZsir9
         7DqGLcYUFSGQ35G9YCNYCh5j+tll0XinvrAbklTVIT/59oOQ9XaPwe1TBY7eNcQlv4VY
         fIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSetaWLPY2RzczT8dviu9hjeHMLZpPIw6Q1N0t2ZCKw=;
        b=QV4mbSoGWX3hPdZMNJYUCcboFJoBXaTF0ZSusC67/ElgDL/hiM7DEwi11rc7wF59Ze
         GROP46ERtlqYtt9h7RYI4Fni5hFiPdUePT1tYTbX89CvSYEDU1y21jkRAsJTrpMJLEpE
         y/xDMUArmaeWl+xv7rjFdQiwLOAkxeBuuOrH3DweLmCo3mqY/hRMqFA7BtCovud2091n
         SFzJxbz7bxLvWTq7Bq21mk3AA5N69UGLWsvPhb8bPPOIW1oJN2SGdgwAxuinKyZkBvvX
         onn5otnwmNOVAxntXMpM5nU3otBy0Dt/jAvdvo90zS/BsqeABmW12K0Ar3Ek0rDYyzDA
         Ahxg==
X-Gm-Message-State: ANoB5pmKrXZNpBzTWrE/0TmHDSGHVV/6uzGiuyw9O/F8Dupc/tsXol2U
        HPLvM461cr3tvaTd+CcZXaPN/vGcYmXn8Vs+
X-Google-Smtp-Source: AA0mqf6srxtsltfnM3JV+Jqhe1JY4SS4cC1aPGdFTwViDIzKBg4EMrI3ip8OhvTDz9tWaSXlX/Bnqw==
X-Received: by 2002:a05:600c:3d06:b0:3c6:e60f:3f55 with SMTP id bh6-20020a05600c3d0600b003c6e60f3f55mr30077687wmb.12.1671363123289;
        Sun, 18 Dec 2022 03:32:03 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20fa:a700:21e9:9128:9ea2:3911])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003d069fc7372sm9440751wms.1.2022.12.18.03.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 03:32:02 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 3/6] hwmon: (aquacomputer_d5next) Add structure for fan layout
Date:   Sun, 18 Dec 2022 12:31:28 +0100
Message-Id: <20221218113131.3752-4-leonard.anderweit@gmail.com>
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

Introduce structure for per device fan sensor offsets. This allows
reading fan sensors in aqc_raw_event() from devices which use a
different sensor layout in their status HID report.  Currently only one
version is implemented as all supported devices use the same structure.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 388bf1e33e0d..1ea866fcd3ec 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -282,6 +282,21 @@ static const char *const label_highflownext_voltage[] = {
 	"+5V USB voltage"
 };
 
+struct aqc_fan_structure_offsets {
+	u8 voltage;
+	u8 curr;
+	u8 power;
+	u8 speed;
+};
+
+/* Fan structure offsets for all devices except Aquaero */
+static struct aqc_fan_structure_offsets aqc_general_fan_structure = {
+	.voltage = AQC_FAN_VOLTAGE_OFFSET,
+	.curr = AQC_FAN_CURRENT_OFFSET,
+	.power = AQC_FAN_POWER_OFFSET,
+	.speed = AQC_FAN_SPEED_OFFSET
+};
+
 struct aqc_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
@@ -308,6 +323,7 @@ struct aqc_data {
 	int num_flow_sensors;
 	u8 flow_sensors_start_offset;
 	u8 flow_pulses_ctrl_offset;
+	struct aqc_fan_structure_offsets *fan_structure;
 
 	/* General info, same across all devices */
 	u32 serial_number[2];
@@ -822,15 +838,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	/* Fan speed and related readings */
 	for (i = 0; i < priv->num_fans; i++) {
 		priv->speed_input[i] =
-		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] + AQC_FAN_SPEED_OFFSET);
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
+				       priv->fan_structure->speed);
 		priv->power_input[i] =
 		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
-				       AQC_FAN_POWER_OFFSET) * 10000;
+				       priv->fan_structure->power) * 10000;
 		priv->voltage_input[i] =
 		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
-				       AQC_FAN_VOLTAGE_OFFSET) * 10;
+				       priv->fan_structure->voltage) * 10;
 		priv->current_input[i] =
-		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] + AQC_FAN_CURRENT_OFFSET);
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
+				       priv->fan_structure->curr);
 	}
 
 	/* Flow sensor readings */
@@ -1078,6 +1096,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		break;
 	}
 
+	priv->fan_structure = &aqc_general_fan_structure;
+
 	if (priv->buffer_size != 0) {
 		priv->checksum_start = 0x01;
 		priv->checksum_length = priv->buffer_size - 3;
-- 
2.38.1

