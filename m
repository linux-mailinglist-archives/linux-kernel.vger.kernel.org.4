Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21B163F852
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiLATb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiLATal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:30:41 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E5CA16D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:30:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ml11so6617503ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RnyrrQe9Eok5DqIvUFEy0a61qYm6BHFyKDyCC1oYjg=;
        b=e+bLOFonetP2HdOnP8n/c6Gm+QqVqCobaEemCltMt4hyrSppEym5opqSZWjSrB98HO
         jEZSTNd1YtCWlfMCrTm9ARtqrrvc8U7tu7lgiCT5ITLd0eCw74M+5EZ4wjCrq4EStIfQ
         TGJrUEkZhbfttV255uU/UK3mkt2OGcnopFdjtpdJhhwFSVWIEfglhbUCtanOPQ/scqG3
         qoSb3KhFWAUMf9O7xRq3LbeARzzNY2C8jZBkuVOfkgAIijxNZz/VHLk3oNqOfTy1t37B
         mTsWU+Kq2LJyrU5bn/YGN7QqAkSYspqx9ps43Yq5z0ZVQnHB4KLB22ch/wV0Cpj4iaan
         D3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RnyrrQe9Eok5DqIvUFEy0a61qYm6BHFyKDyCC1oYjg=;
        b=x1oID3WX5VbF/yps6+JnEO+LjTVJEwvmPq/xvgnS7EQy7N+QHB1ZjIsp8GKeBknIvY
         wj3Uzi1UTAVoHT/TNLh6G63z6whELZphB92l/SoBanlkktMiA/ABJ+MmP0MYnH2+e/vk
         OEvupwPSPVia9FCBrCkPFLdRu3OClubr4GbJ4OZi3TQwBHGP58BFS8MGLFSuMFVUnjeJ
         FQUtvdXXt0H7v4mU7SpMjpDrBURukcIlQtuQYsU7mntP/dlxDXgD4vmsFfNXyl98YCIR
         lzm8FBmEgNPrA4V+GA2Z13f7m5v0zvGzbewEXeXACxawmtu11eZhpwpI8RmJT2SsdmUR
         h0Aw==
X-Gm-Message-State: ANoB5pn+kkAdzwZLykeuXBfrUwr1i92nfuxV6AQl6t+E4R01Zf0SqOMd
        IfSyLmbAj2NGuSwsyk4hu5vT9A==
X-Google-Smtp-Source: AA0mqf55uiA9d/tZ5QiIxxOqG9g7PCCBwt3ASYo3UsVHG+4RIqcDmQ84vM3oJUeyxP9KnK+Xne8wQQ==
X-Received: by 2002:a17:906:6c86:b0:78d:4ba6:f65a with SMTP id s6-20020a1709066c8600b0078d4ba6f65amr58210840ejr.186.1669923032873;
        Thu, 01 Dec 2022 11:30:32 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7c84f000000b004619f024864sm2054110edt.81.2022.12.01.11.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:30:32 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v5 3/5] hwmon: (pmbus/core): Notify hwmon events
Date:   Thu,  1 Dec 2022 20:30:22 +0100
Message-Id: <20221201193025.1584365-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
References: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
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

Notify hwmon events using the pmbus irq handler.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 46 +++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 6a3a3fd59b8e..ad3c0cc884a4 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2782,7 +2782,35 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 	},
 };
 
-static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+#define to_dev_attr(_dev_attr) \
+	container_of(_dev_attr, struct device_attribute, attr)
+
+static void pmbus_notify(struct pmbus_data *data, int page, int reg, int flags)
+{
+	int i;
+
+	for (i = 0; i < data->num_attributes; i++) {
+		struct device_attribute *da = to_dev_attr(data->group.attrs[i]);
+		struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+		int index = attr->index;
+		u16 smask = pb_index_to_mask(index);
+		u8 spage = pb_index_to_page(index);
+		u16 sreg = pb_index_to_reg(index);
+
+		if (reg == sreg && page == spage && (smask & flags)) {
+			dev_dbg(data->dev, "sysfs notify: %s", da->attr.name);
+			sysfs_notify(&data->dev->kobj, NULL, da->attr.name);
+			kobject_uevent(&data->dev->kobj, KOBJ_CHANGE);
+			flags &= ~smask;
+		}
+
+		if (!flags)
+			break;
+	}
+}
+
+static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *error,
+				    bool notify)
 {
 	int i, status;
 	const struct pmbus_regulator_status_category *cat;
@@ -2812,6 +2840,9 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 			if (status & bit->pflag)
 				*flags |= bit->rflag;
 		}
+
+		if (notify && status)
+			pmbus_notify(data, page, cat->reg, status);
 	}
 
 	/*
@@ -2856,6 +2887,11 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	return 0;
 }
 
+static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	return pmbus_regulator_get_flags(rdev, flags, false);
+}
+
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
 {
 	struct device *dev = rdev_get_dev(rdev);
@@ -3087,7 +3123,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	int i, status;
+	int i, ret = IRQ_NONE, status;
 	u8 page;
 
 	for (i = 0; i < data->info->num_regulators; i++) {
@@ -3095,6 +3131,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 		if (!data->rdevs[i])
 			continue;
 
+		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, true);
+		if (ret)
+			return ret;
+
 		page = rdev_get_id(data->rdevs[i]);
 		mutex_lock(&data->update_lock);
 		status = pmbus_read_status_word(client, page);
@@ -3109,7 +3149,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 		mutex_unlock(&data->update_lock);
 	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
-- 
2.37.3

