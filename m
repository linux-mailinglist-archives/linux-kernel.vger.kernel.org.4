Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C245763F84C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiLATbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiLATak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:30:40 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453BFC8D25
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:30:32 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id e27so6576032ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fKvZImztyAGYKm8N5WHEv0DzFDUrZgSaslqn8pXCp4=;
        b=EnlxFW2of+UDwHxryW+kMpzqGXuxTDwAoNmcTHslWecr9SBkZJdHuMHWFI08pKCaug
         1vntP/acflKa9IY5WkpTy7G5Mcv2izHZGHe6BPpGPSxCG/+eyzE8f3wJEoXjNZ/QsSr+
         VEtbfeSCQYFJwxPkqbb8gOICofHTknEtCusDwm6YpYDoy48e/MInC2BPOF4oNQ8dSvzw
         SG+q4W/qWaSoqaadUcg51bK6Ba1y6+PtskkmmZ1ujxihHD8Q42mMektfENTMx9PrMyUk
         cBgMwyLOauec7NlPc7jnpoUJQr7RUytiE+/uaBM0AN1VRsjJfzqgeW2qj0SSd8xBePRn
         pv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fKvZImztyAGYKm8N5WHEv0DzFDUrZgSaslqn8pXCp4=;
        b=FPc6x7kOYrwKov7sSQL+jQK85/TQ/usgARgdjN+i/Jor4RCfjx+BKXc9z5ewHg2ofj
         RC9FitYwcZbRvQ/CLrPxJDjIUqzmgScAA8jdKC/TwMEl+xGJHDOImwPOwrk8X6XmObV2
         A4aRJqYBRzeVhaPtwJKmOjhnxehSLyMbWlIVctmdcT5XigstZp/LGcqhp8NfUKHZcQRp
         j62s6pVkkbP16k/D4+l7jUxswdddv5O/1hSxQaTo9LGSHYiQc+t25lvxchOpcpZqVx89
         i11OZL3h14vC7s7hZomwcozQCqjn1MAsMdahG3trCZKE+TeiijBbACPWDxyDoCWAmkOB
         AjdA==
X-Gm-Message-State: ANoB5plqwqn4kuuZdhaIpeDo12x21iOZwfLwGUSXgY49bkMF1X2moRSD
        5tIF4ff0cWcJl0HpaVSdg4LrPg==
X-Google-Smtp-Source: AA0mqf4koTAajDL3O33f8A2i615xXP/JTt7Jmfrroko8lEHAPS5WgC+T5WvGS6IO0M31Ogsh1ZKGWg==
X-Received: by 2002:a17:906:f8cc:b0:7ad:92fa:589e with SMTP id lh12-20020a170906f8cc00b007ad92fa589emr40140822ejb.668.1669923030836;
        Thu, 01 Dec 2022 11:30:30 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7c84f000000b004619f024864sm2054110edt.81.2022.12.01.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:30:30 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v5 1/5] hwmon: (pmbus/core): Add rdev in pmbus_data struct
Date:   Thu,  1 Dec 2022 20:30:20 +0100
Message-Id: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
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

Add regulator device in pmbus_data & initialize the same during PMBus
regulator register.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

---
Change in V5:
- Fix error check for rdev
---
 drivers/hwmon/pmbus/pmbus_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 95e95783972a..a95f998ca247 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -81,6 +81,7 @@ struct pmbus_label {
 struct pmbus_data {
 	struct device *dev;
 	struct device *hwmon_dev;
+	struct regulator_dev **rdevs;
 
 	u32 flags;		/* from platform data */
 
@@ -3050,9 +3051,13 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 	struct device *dev = data->dev;
 	const struct pmbus_driver_info *info = data->info;
 	const struct pmbus_platform_data *pdata = dev_get_platdata(dev);
-	struct regulator_dev *rdev;
 	int i;
 
+	data->rdevs = devm_kzalloc(dev, sizeof(struct regulator_dev *) * info->num_regulators,
+				  GFP_KERNEL);
+	if (!data->rdevs)
+		return -ENOMEM;
+
 	for (i = 0; i < info->num_regulators; i++) {
 		struct regulator_config config = { };
 
@@ -3062,10 +3067,10 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 		if (pdata && pdata->reg_init_data)
 			config.init_data = &pdata->reg_init_data[i];
 
-		rdev = devm_regulator_register(dev, &info->reg_desc[i],
+		data->rdevs[i] = devm_regulator_register(dev, &info->reg_desc[i],
 					       &config);
-		if (IS_ERR(rdev))
-			return dev_err_probe(dev, PTR_ERR(rdev),
+		if (IS_ERR(data->rdevs[i]))
+			return dev_err_probe(dev, PTR_ERR(data->rdevs[i]),
 					     "Failed to register %s regulator\n",
 					     info->reg_desc[i].name);
 	}

base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
-- 
2.37.3

