Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E018698E12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBPHxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:53:12 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33FF3C282
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:53:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id t24so3144283eji.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Ep0BXASwqWNrGTh5bsy1iJcq0u5g0xO5vJDJaqCeM=;
        b=LSDdTheLMZheoIRYNVw7RYh7ce4cQPim+xjK2iFNGJjikDV8Ji6vZGlrFeFI+dOAde
         pC3SqsLeyYeIXCnK2X9AA8OurX91ZAdjk4CRd3zKjRrskvt96jOn3ObNrKIqu+2SBEQD
         oDdURgL5f9qLgUboPOyLW43zYPeYek77dkeylk7xo6HqxCCXazH0ssD8asqh3kx9pZAm
         /YEvrVjRSnniCqD9IhjUTyLUvCyTx7EJfBLBK2b71iRYc3lTnw22vPKhegh7dOzXcjWs
         vBPRoR+8CW61ey8nKTLYurbyTxDUJQwnCxTp/p3VkuNy8Aq9xFB/r8KZZ0+CAnENToIE
         Xs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5Ep0BXASwqWNrGTh5bsy1iJcq0u5g0xO5vJDJaqCeM=;
        b=MZSab8Y9V9KWELoBLipG/bppTjzm1LGcJn/J9h9R3WqX5C1iPFobSTo+ZwI1t1XKbn
         rbb8TEHhpfsE7w8xS771K5yBxOrPqjQ1PXM2SmaSXgogXg7huGG+qY6dwdCXvak00Kbx
         M20im2yF8KaDC3nThCgU2+umzBBtzXq6VUpaACntRr9kPa+OSHN9s58rihsuxYX1QkT4
         yA3QX4fmipGHpcuGKb5neWOa9x5u6xoKFTdJJAYy8HZmZA23EdLl5vf4W/N/0bgFtw7r
         n3Pg+NvjK2lmLRQB9urKURzxTxMWmQADbIz67wLgGWMbWS17Zf8Ooh3+WPa4DUJnLWPL
         ZNlA==
X-Gm-Message-State: AO0yUKWat4gDUxTtr3Dr8HGM4KJ7UFdJSkWaZOPnMQINHHyV5GXTqwgU
        YvQC3U2aKRhOJEXdrtC8UK19yDuQ8telXcTfzT8=
X-Google-Smtp-Source: AK7set8hbsNjbIDcGISJrjCu7+T4Jo6PHaQX2dTriPaUV58FxoD5YOW4lQAA01usYKssPy7pjim6Rw==
X-Received: by 2002:a17:906:ce31:b0:8ae:707:e129 with SMTP id sd17-20020a170906ce3100b008ae0707e129mr4958716ejb.19.1676533989238;
        Wed, 15 Feb 2023 23:53:09 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id qq12-20020a17090720cc00b0087f68a2681bsm456401ejb.96.2023.02.15.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 23:53:08 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] regulator: max597x: Align for simple_mfd_i2c driver
Date:   Thu, 16 Feb 2023 08:53:01 +0100
Message-Id: <20230216075302.68935-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
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

Use regmap provided by simple_mfd_i2c driver and remove unused variable.
Identify device variant by checking compatible property in DT.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/max597x-regulator.c | 46 +++++++++++++++++++--------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max597x-regulator.c
index ab9dc18f98e3..f0fb0f56e420 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max597x-regulator.c
@@ -425,41 +425,59 @@ static int max597x_setup_irq(struct device *dev,
 
 static int max597x_regulator_probe(struct platform_device *pdev)
 {
-
-
-	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
+	struct max597x_data *max597x;
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	struct max597x_regulator *data;
-
+	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
-	int num_switches = max597x->num_switches;
+	int num_switches;
 	int ret, i;
 
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	max597x = devm_kzalloc(&i2c->dev, sizeof(struct max597x_data), GFP_KERNEL);
+	if (!max597x)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, max597x);
+
+	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
+		max597x->num_switches = MAX597x_TYPE_MAX5978;
+	else if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5970"))
+		max597x->num_switches = MAX597x_TYPE_MAX5970;
+	else
+		return -ENODEV;
+
+	i2c_set_clientdata(i2c, max597x);
+	num_switches = max597x->num_switches;
+
 	for (i = 0; i < num_switches; i++) {
 		data =
-		    devm_kzalloc(max597x->dev, sizeof(struct max597x_regulator),
+		    devm_kzalloc(&i2c->dev, sizeof(struct max597x_regulator),
 				 GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
 		data->num_switches = num_switches;
-		data->regmap = max597x->regmap;
+		data->regmap = regmap;
 
-		ret = max597x_adc_range(data->regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
+		ret = max597x_adc_range(regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
 		if (ret < 0)
 			return ret;
 
 		data->irng = max597x->irng[i];
 		data->mon_rng = max597x->mon_rng[i];
 
-		config.dev = max597x->dev;
+		config.dev = &i2c->dev;
 		config.driver_data = (void *)data;
 		config.regmap = data->regmap;
-		rdev = devm_regulator_register(max597x->dev,
+		rdev = devm_regulator_register(&i2c->dev,
 					       &regulators[i], &config);
 		if (IS_ERR(rdev)) {
-			dev_err(max597x->dev, "failed to register regulator %s\n",
+			dev_err(&i2c->dev, "failed to register regulator %s\n",
 				regulators[i].name);
 			return PTR_ERR(rdev);
 		}
@@ -467,12 +485,12 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
 	}
 
-	if (max597x->irq) {
+	if (i2c->irq) {
 		ret =
-		    max597x_setup_irq(max597x->dev, max597x->irq, rdevs, num_switches,
+		    max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,
 				      data);
 		if (ret) {
-			dev_err(max597x->dev, "IRQ setup failed");
+			dev_err(&i2c->dev, "IRQ setup failed");
 			return ret;
 		}
 	}

base-commit: ea3efd52e96287ce8d93563b1084429686b6e824
-- 
2.39.1

