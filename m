Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C659963C4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiK2QML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiK2QLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:11:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0559146
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:11:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bx10so10802417wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GkxjaYCl5kBL8H34o0ftGAJpJpWJlL66QXMFziDPlI=;
        b=ELlHzcvZWs5mVk9olyN/g6e0EHE+TUsWercDrV8hpdEDeP2y/KnDISOptRWoAt/oD9
         DrSj9gNaBk7763Qwfnlqbpos17Wwga1Bdd1rwYaYRpe/5SGVFaImiAo7Ka8ecUgBB4Nf
         AqzuAMsqtfgSFEZBmHutgI756hddotjKAzH1fkav8KlEWCsau8uxkSOLTxMhyTrhVCPy
         zlSqA+STK+jIDQOp4crAAo8Y+UTeOJUzUPyvUsfFA2g4b2EIm6HLnuI+Nka0zeCT4LQA
         PJ8n/Bs3rjZ++Nk5Y4euUfGpFD7FTmUIW6zR4Wy1gRHMf0on24hlCcSrwUD9jvsUaY5p
         PZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GkxjaYCl5kBL8H34o0ftGAJpJpWJlL66QXMFziDPlI=;
        b=jS2nve84NkyopRS+oXyG6wCNZpLjfnGNzV+NGhUEbNMTmuZibn/LB0UxxPt4nwYLYW
         ZF5pSTQepwzU/rhk05Gu5BnqwVPVHGBqOv32DnW0gNTZQpiCmIWd7Zinvipt5Z4P+QU3
         xzhFBZ8lU0I1QJqU+vgiGg+n1f81FyX3a6Uh3h8F5EBbRCqUpdyhwH/Yb6g+u8LA61Nn
         BNEYPN+XcZvl9Q3AaJwxHBOX/+tMJWuob/jAf0blotQOJZWFIn81N7TUXlH02Ve2ulYq
         ZTmPfIwL/nm4yXUmHs7Fvr26kv+Ge/8CUNTC7bJHNCukFBmb+kHQfJTPiOtMhYHYRHL5
         AHNw==
X-Gm-Message-State: ANoB5plRCnSgD9b3jTet8j1jYybNW85MCccM+zEAiOrCPSju24elLw48
        OGlWTS5UAfjN7BsDhywp9ndtEg==
X-Google-Smtp-Source: AA0mqf4pk7yR9FBq3rcmGMbMzP+Q2wg6zAbDsXCusNTTU3KHdvZa/1CUFFvYw2oS8jVamF7sOUP1wg==
X-Received: by 2002:adf:f288:0:b0:242:1ab:2cbe with SMTP id k8-20020adff288000000b0024201ab2cbemr15909983wro.573.1669738304484;
        Tue, 29 Nov 2022 08:11:44 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b003c6b70a4d69sm3144522wms.42.2022.11.29.08.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 08:11:44 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v8 3/4] hwmon: (max6639) Change from pdata to dt configuration
Date:   Tue, 29 Nov 2022 17:11:33 +0100
Message-Id: <20221129161134.2672474-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
References: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcello Sylvester Bauer <sylv@sylv.io>

max6639_platform_data is not used by any in-kernel driver and does not
address the MAX6639 fans separately.
Move to device tree configuration with explicit properties to configure
each fan.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/max6639.c               | 122 +++++++++++++++++++-------
 include/linux/platform_data/max6639.h |  15 ----
 2 files changed, 90 insertions(+), 47 deletions(-)
 delete mode 100644 include/linux/platform_data/max6639.h

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 9b895402c80d..e09358713bef 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -19,7 +19,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/platform_data/max6639.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -85,8 +84,8 @@ struct max6639_data {
 	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
 
 	/* Register values initialized only once */
-	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
-	u8 rpm_range;		/* Index in above rpm_ranges table */
+	u8 ppr[2];		/* Pulses per rotation 0..3 for 1..4 ppr */
+	u8 rpm_range[2];	/* Index in above rpm_ranges table */
 
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
@@ -319,7 +318,7 @@ static ssize_t fan_input_show(struct device *dev,
 		return PTR_ERR(data);
 
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->rpm_range));
+		       data->rpm_range[attr->index]));
 }
 
 static ssize_t alarm_show(struct device *dev,
@@ -404,11 +403,7 @@ static int rpm_range_to_reg(int range)
 static int max6639_init_client(struct i2c_client *client,
 			       struct max6639_data *data)
 {
-	struct max6639_platform_data *max6639_info =
-		dev_get_platdata(&client->dev);
-	int i;
-	int rpm_range = 1; /* default: 4000 RPM */
-	int err;
+	int i, err;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
@@ -416,43 +411,22 @@ static int max6639_init_client(struct i2c_client *client,
 	if (err)
 		goto exit;
 
-	/* Fans pulse per revolution is 2 by default */
-	if (max6639_info && max6639_info->ppr > 0 &&
-			max6639_info->ppr < 5)
-		data->ppr = max6639_info->ppr;
-	else
-		data->ppr = 2;
-	data->ppr -= 1;
-
-	if (max6639_info)
-		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
-	data->rpm_range = rpm_range;
-
 	for (i = 0; i < 2; i++) {
 
 		/* Set Fan pulse per revolution */
 		err = i2c_smbus_write_byte_data(client,
 				MAX6639_REG_FAN_PPR(i),
-				data->ppr << 6);
+				data->ppr[i] << 6);
 		if (err)
 			goto exit;
 
 		/* Fans config PWM, RPM */
 		err = i2c_smbus_write_byte_data(client,
 			MAX6639_REG_FAN_CONFIG1(i),
-			MAX6639_FAN_CONFIG1_PWM | rpm_range);
+			MAX6639_FAN_CONFIG1_PWM | data->rpm_range[i]);
 		if (err)
 			goto exit;
 
-		/* Fans PWM polarity high by default */
-		if (max6639_info && max6639_info->pwm_polarity == 0)
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x00);
-		else
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x02);
-		if (err)
-			goto exit;
 
 		/*
 		 * /THERM full speed enable,
@@ -524,6 +498,76 @@ static void max6639_regulator_disable(void *data)
 	regulator_disable(data);
 }
 
+static int max6639_probe_child_from_dt(struct i2c_client *client,
+				      struct device_node *child,
+				      struct max6639_data *data)
+
+{
+	struct device *dev = &client->dev;
+	u32 i, maxrpm;
+	int val, err;
+
+	err = of_property_read_u32(child, "reg", &i);
+	if (err) {
+		dev_err(dev, "missing reg property of %pOFn\n", child);
+		return err;
+	}
+
+	if (i >= 2) {
+		dev_err(dev, "invalid reg %d of %pOFn\n", i, child);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32(child, "pulses-per-revolution", &val);
+	if (err) {
+		dev_err(dev, "missing pulses-per-revolution property of %pOFn",
+			child);
+		return err;
+	}
+
+	if (val < 0 || val > 5) {
+		dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val,
+			child);
+		return -EINVAL;
+	}
+	data->ppr[i] = val;
+
+	err = of_property_read_u32(child, "max-rpm", &maxrpm);
+	if (err) {
+		dev_err(dev, "missing max-rpm property of %pOFn\n", child);
+		return err;
+	}
+
+	data->rpm_range[i] = rpm_range_to_reg(maxrpm);
+
+	return 0;
+}
+static int max6639_probe_from_dt(struct i2c_client *client,
+				struct max6639_data *data)
+{
+	struct device *dev = &client->dev;
+	const struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int err;
+
+	/* Compatible with non-DT platforms */
+	if (!np)
+		return 0;
+
+	for_each_child_of_node(np, child) {
+		if (strcmp(child->name, "fan"))
+			continue;
+
+		err = max6639_probe_child_from_dt(client, child, data);
+		if (err) {
+			of_node_put(child);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int max6639_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -560,6 +604,11 @@ static int max6639_probe(struct i2c_client *client)
 
 	mutex_init(&data->update_lock);
 
+	/* Probe from DT to get configuration */
+	err = max6639_probe_from_dt(client, data);
+	if (err)
+		return err;
+
 	/* Initialize the max6639 chip */
 	err = max6639_init_client(client, data);
 	if (err < 0)
@@ -616,6 +665,14 @@ static const struct i2c_device_id max6639_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, max6639_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id maxim_of_platform_match[] = {
+	{.compatible = "maxim,max6639"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, maxim_of_platform_match);
+#endif
+
 static DEFINE_SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
 
 static struct i2c_driver max6639_driver = {
@@ -623,6 +680,7 @@ static struct i2c_driver max6639_driver = {
 	.driver = {
 		   .name = "max6639",
 		   .pm = pm_sleep_ptr(&max6639_pm_ops),
+		   .of_match_table = of_match_ptr(maxim_of_platform_match),
 		   },
 	.probe_new = max6639_probe,
 	.id_table = max6639_id,
diff --git a/include/linux/platform_data/max6639.h b/include/linux/platform_data/max6639.h
deleted file mode 100644
index 65bfdb4fdc15..000000000000
--- a/include/linux/platform_data/max6639.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_MAX6639_H
-#define _LINUX_MAX6639_H
-
-#include <linux/types.h>
-
-/* platform data for the MAX6639 temperature sensor and fan control */
-
-struct max6639_platform_data {
-	bool pwm_polarity;	/* Polarity low (0) or high (1, default) */
-	int ppr;		/* Pulses per rotation 1..4 (default == 2) */
-	int rpm_range;		/* 2000, 4000 (default), 8000 or 16000 */
-};
-
-#endif /* _LINUX_MAX6639_H */
-- 
2.37.3

