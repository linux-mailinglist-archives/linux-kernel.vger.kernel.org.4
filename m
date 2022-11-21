Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9C3632208
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiKUMaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiKUM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:29:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3310F56EC4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso12626711wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sZJN35ods+Qowc2iCb3TEaJfa54ky/OFZY2lgkGNrc=;
        b=e7AJD8UnpRNjowdB/gRYlQ89bcIeX3qRJACQjIm9D3ZzhICuK7XSPAvZjAr89Q8BKM
         l/76T0x/12/WoGJpooOeRTEZ4NnGvodn0R+2trLP06/iqWqywNIy4L7eRZepb239Wmw0
         hnT7yu/sU53G9TYX33LwLg/D24jeZSqGCsEdJcPJk/pk3ZlnIAqg+wEk8+x8OZHW3Ylf
         OOFwK6WwvpEAeW8QnBXc4/stj+vxg/8AiIFKZWCF8LzCexXR8jCMx0pb+yfZFwRGgYR+
         SvZSUtkGXd9T+ooEAV0TpeyR/W6H9M+nxpET/pQ4efp8KPUEgAbsMXTroW7IT1k4Y4jC
         r9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sZJN35ods+Qowc2iCb3TEaJfa54ky/OFZY2lgkGNrc=;
        b=5O9ciebR1ldTixuSeyVmsdpMlHFdR/liKY93MleCHewGFeLTv4THK61rIHQSjDnRZg
         PXekhI60OUn+6eds5etK4d6N62pEPP4RNJTwy0w3z7Qw5Vum7ckbxjNuQlZjNYCkk+gO
         gF+/mh5IT8PbxFtLlnXIaqMbZlxelE88HdSsm0Fok4ZknGGviPOvLFhZchaAj3sZ6Xnr
         4gvbxaRMRUaVksn6VqGjaeYK43I7EADj/yvh2N3tcwbEs5fBtOvEB40ksKyA021ECNSi
         fvWBubSUEf65ELFRd5oDqg7Av886fuQUJtZ8iPULDPqrQ1KyW6ps8MJS2DH7MHLWC81A
         I9YQ==
X-Gm-Message-State: ANoB5pnDCsx9USgA4ADOfhfYebfu1wKwAGigD8Wt19IR+hdt/uNdBI8Z
        WK8OGiw1Re7Ox08GSxqLPMT0aw==
X-Google-Smtp-Source: AA0mqf5d5psAhcTJ5v9ARrqU65V0m3D0w8GSrpaayIuRLTODSaE+5xkIDBY0e+5g1XrjbRlEtTnj5g==
X-Received: by 2002:a05:600c:4194:b0:3cf:5080:412c with SMTP id p20-20020a05600c419400b003cf5080412cmr15381772wmh.99.1669033785708;
        Mon, 21 Nov 2022 04:29:45 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id dn12-20020a05600c654c00b003cf6c2f9513sm13929015wmb.2.2022.11.21.04.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:29:45 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v7 3/4] hwmon: (max6639) Change from pdata to dt configuration
Date:   Mon, 21 Nov 2022 13:29:31 +0100
Message-Id: <20221121122932.2493174-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
References: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max6639_platform_data is not used by any in-kernel driver and does not
address the MAX6639 fans separately.
Move to device tree configuration with explicit properties to configure
each fan.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/max6639.c               | 246 +++++++++++++++++++-------
 include/linux/platform_data/max6639.h |  15 --
 2 files changed, 178 insertions(+), 83 deletions(-)
 delete mode 100644 include/linux/platform_data/max6639.h

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 9b895402c80d..feafa3511297 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -19,7 +19,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/platform_data/max6639.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -54,9 +53,12 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 #define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
 
 #define MAX6639_FAN_CONFIG1_PWM			0x80
-
+#define MAX6639_REG_FAN_CONFIG2a_PWM_POL	0x02
 #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
+#define MAX6639_FAN_CONFIG3_FREQ_MASK		0x03
+#define MAX6639_REG_TARGTDUTY_SLOT		120
 
+/* Tach supported range. This internally controls tach frequency */
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
 #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
@@ -76,18 +78,21 @@ struct max6639_data {
 	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
 	bool temp_fault[2];	/* Detected temperature diode failure */
 	u8 fan[2];		/* Register value: TACH count for fans >=30 */
+	u32 target_rpm[2];
+	u32 max_rpm[2];
+	u8 pwm[2];
+
 	u8 status;		/* Detected channel alarms and fan failures */
 
 	/* Register values only written to */
-	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
 	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
 	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
 	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
 
 	/* Register values initialized only once */
-	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
-	u8 rpm_range;		/* Index in above rpm_ranges table */
-
+	u8 ppr[2];		/* Pulses per rotation 0..3 for 1..4 ppr */
+	u8 rpm_range[2];	/* Index in above rpm_ranges table */
+	u8 pwm_polarity[2];
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
 };
@@ -282,6 +287,7 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
 	struct max6639_data *data = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
+
 }
 
 static ssize_t pwm_store(struct device *dev,
@@ -302,10 +308,10 @@ static ssize_t pwm_store(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	data->pwm[attr->index] = (u8)(val * 120 / 255);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_TARGTDUTY(attr->index),
-				  data->pwm[attr->index]);
+	i2c_smbus_write_byte_data(client, MAX6639_REG_TARGTDUTY(attr->index),
+				 data->pwm[attr->index]);
 	mutex_unlock(&data->update_lock);
+
 	return count;
 }
 
@@ -319,7 +325,7 @@ static ssize_t fan_input_show(struct device *dev,
 		return PTR_ERR(data);
 
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->rpm_range));
+		       data->rpm_range[attr->index]));
 }
 
 static ssize_t alarm_show(struct device *dev,
@@ -386,29 +392,40 @@ static struct attribute *max6639_attrs[] = {
 ATTRIBUTE_GROUPS(max6639);
 
 /*
- *  returns respective index in rpm_ranges table
- *  1 by default on invalid range
+ *  Get respective index in rpm_ranges table
  */
-static int rpm_range_to_reg(int range)
+static int rpm_range_to_index(struct device *dev, u8 *index, int rpm)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(rpm_ranges); i++) {
-		if (rpm_ranges[i] == range)
-			return i;
+	if (rpm < 0)
+		return -EINVAL;
+
+	/* Set index based on chip support */
+	switch (rpm) {
+	case 0 ... 2000:
+		*index = 0;
+		break;
+	case 2001 ... 4000:
+		*index = 1;
+		break;
+	case 4001 ... 8000:
+		*index = 2;
+		break;
+	case 8001 ... 16000:
+		*index = 3;
+		break;
+	default:
+		/* Use max range for higher RPM */
+		dev_warn(dev,
+		    "RPM higher than supported range. Default to 16000 RPM");
+		*index = 3;
 	}
-
-	return 1; /* default: 4000 RPM */
+	return 0;
 }
 
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
@@ -416,51 +433,29 @@ static int max6639_init_client(struct i2c_client *client,
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
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_PPR(i),
-				data->ppr << 6);
+		err = i2c_smbus_write_byte_data(client,	MAX6639_REG_FAN_PPR(i),
+						data->ppr[i] << 6);
 		if (err)
 			goto exit;
 
 		/* Fans config PWM, RPM */
 		err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG1(i),
-			MAX6639_FAN_CONFIG1_PWM | rpm_range);
-		if (err)
-			goto exit;
-
-		/* Fans PWM polarity high by default */
-		if (max6639_info && max6639_info->pwm_polarity == 0)
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x00);
-		else
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x02);
+						MAX6639_REG_FAN_CONFIG1(i),
+						MAX6639_FAN_CONFIG1_PWM |
+						data->rpm_range[i]);
 		if (err)
 			goto exit;
 
 		/*
-		 * /THERM full speed enable,
+		 * /THERM full speed disable,
 		 * PWM frequency 25kHz, see also GCONFIG below
 		 */
 		err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG3(i),
-			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
+						MAX6639_REG_FAN_CONFIG3(i),
+						0x03);
 		if (err)
 			goto exit;
 
@@ -469,31 +464,34 @@ static int max6639_init_client(struct i2c_client *client,
 		data->temp_alert[i] = 90;
 		data->temp_ot[i] = 100;
 		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_THERM_LIMIT(i),
-				data->temp_therm[i]);
+						MAX6639_REG_THERM_LIMIT(i),
+						data->temp_therm[i]);
 		if (err)
 			goto exit;
 		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_ALERT_LIMIT(i),
-				data->temp_alert[i]);
+						MAX6639_REG_ALERT_LIMIT(i),
+						data->temp_alert[i]);
 		if (err)
 			goto exit;
 		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
+						MAX6639_REG_OT_LIMIT(i),
+						data->temp_ot[i]);
 		if (err)
 			goto exit;
 
 		/* PWM 120/120 (i.e. 100%) */
-		data->pwm[i] = 120;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
+		data->pwm[i] = data->target_rpm[i];
+		err = i2c_smbus_write_byte_data(client, MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
+
 		if (err)
 			goto exit;
+
 	}
 	/* Start monitoring */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
 		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
 		MAX6639_GCONFIG_PWM_FREQ_HI);
+
 exit:
 	return err;
 }
@@ -524,12 +522,95 @@ static void max6639_regulator_disable(void *data)
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
+	err = rpm_range_to_index(dev, &data->rpm_range[i], maxrpm);
+	if (err) {
+		dev_err(dev, "invalid max-rpm %d of %pOFn\n", maxrpm, child);
+		return err;
+	}
+	data->max_rpm[i] = maxrpm;
+
+	err = of_property_read_u32(child, "target-rpm", &val);
+	/* Use provided target RPM else default to maxrpm */
+	if (!err)
+		data->target_rpm[i] = val;
+	else
+		data->target_rpm[i] = maxrpm;
+
+	return 0;
+}
+
+static int max6639_probe_from_dt(struct i2c_client *client,
+				 struct max6639_data *data)
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
 	struct max6639_data *data;
 	struct device *hwmon_dev;
-	int err;
+	int err, i;
 
 	data = devm_kzalloc(dev, sizeof(struct max6639_data), GFP_KERNEL);
 	if (!data)
@@ -539,9 +620,11 @@ static int max6639_probe(struct i2c_client *client)
 
 	data->reg = devm_regulator_get_optional(dev, "fan");
 	if (IS_ERR(data->reg)) {
-		if (PTR_ERR(data->reg) != -ENODEV)
-			return PTR_ERR(data->reg);
-
+		if (PTR_ERR(data->reg) != -ENODEV) {
+			err = (int)PTR_ERR(data->reg);
+			return dev_err_probe(dev, err,
+					     "Failed looking up fan supply\n");
+		}
 		data->reg = NULL;
 	} else {
 		/* Spin up fans */
@@ -560,6 +643,22 @@ static int max6639_probe(struct i2c_client *client)
 
 	mutex_init(&data->update_lock);
 
+	/* Below are defaults later overridden by DT properties */
+	for (i = 0; i < 2; i++) {
+		/* 4000 RPM */
+		data->rpm_range[i] = 1;
+		data->ppr[i] = 2;
+		/* Max. temp. 80C/90C/100C */
+		data->temp_therm[i] = 80;
+		data->temp_alert[i] = 90;
+		data->temp_ot[i] = 100;
+	}
+
+	/* Probe from DT to get configuration */
+	err = max6639_probe_from_dt(client, data);
+	if (err)
+		return err;
+
 	/* Initialize the max6639 chip */
 	err = max6639_init_client(client, data);
 	if (err < 0)
@@ -571,6 +670,7 @@ static int max6639_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+#if IS_ENABLED(CONFIG_PM_SLEEP)
 static int max6639_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -608,6 +708,7 @@ static int max6639_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(client,
 			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
 }
+#endif
 
 static const struct i2c_device_id max6639_id[] = {
 	{"max6639", 0},
@@ -616,13 +717,22 @@ static const struct i2c_device_id max6639_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, max6639_id);
 
-static DEFINE_SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
+#ifdef CONFIG_OF
+static const struct of_device_id maxim_of_platform_match[] = {
+	{.compatible = "maxim,max6639"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, maxim_of_platform_match);
+#endif
+
+static SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
 
 static struct i2c_driver max6639_driver = {
 	.class = I2C_CLASS_HWMON,
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

