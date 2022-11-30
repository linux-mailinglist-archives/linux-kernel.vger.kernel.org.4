Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CA63D0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiK3IiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiK3Ih6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:37:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D901BEAB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:37:53 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id mv18so15094570pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POXigpl8APO9IUP53K10fp0GXszPMpqd75en0jJlNCI=;
        b=BKEb7vdqAI7Q9DB9QLXxAXPXGy0HSu3VCUUJO+kBh9DXhs9RShE0maxetIm2uaEfvF
         v/Eb5rGCEJus3URWVvtttM9RWHID8ZNd5d6DLcA+HZfUbgHKq4bDV1DVn2bJGXfqfE1H
         9ZkBU8e4wJjq+/WUYHdVZhuc05qAzdeypWGQ6+qUuxIeQh6nXVJDbVk2LpAMF3hSh4LN
         2ymjUXn0qPaLupxSJRLn2bp4jOrvuqzZ6uqnvZpZR4VLrmXCNSmmt6BeYSA31cc7J2PH
         ZQ4MwCEtAKowKrtwFq/jvfEH7nbHci7F92OxCTXaxnDmepS6pBBet6hnj5wvkHFVOyhi
         YTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POXigpl8APO9IUP53K10fp0GXszPMpqd75en0jJlNCI=;
        b=nk9lRTLCWAiTRm8HQvWNB7Te91lf+hbS9hOFH3lXMEU8VYSpomzTKir/WLpU6fPz+f
         Zbf8wjsQPk74DTah2F3CoE3kI0byEPOzblSXHyxcHJzLDfclsxJ6HmAPUbr9kbepBu9U
         ZBpESq42EgV0z2gwJgZJ/QQzLJaWBbhi+jQPwWPf/U82/phlr4/QdCuczk7zY0hTkgbw
         kjYxKphLEgE08tCe/D6WsShCa4IXPW6FurteEHVGo8ZLB6Gr9kWXbE85YnFxIfCRo4pn
         YUPN/PTmz8o5z4UvCNOkrUQuzIZG041hSOAX8GhAI7Az8Ix1vjXJFGHA2Bh14ug/TUE3
         43QA==
X-Gm-Message-State: ANoB5pmVaLJI0/0hXQVkkKQABJFkJBrdiGQmx1OzbX3McG66AyMgFFic
        nILxJIhDsk7mIWgoqmpB3u8=
X-Google-Smtp-Source: AA0mqf5WJiR8VoV02b5F/zM3g0jGxJVYY6WftuvLBETu2TT9GBNn3c+sOCMDgGX9NPeUP+QiFVQZbA==
X-Received: by 2002:a17:90a:4605:b0:218:7dd7:ad4c with SMTP id w5-20020a17090a460500b002187dd7ad4cmr61548048pjg.224.1669797473202;
        Wed, 30 Nov 2022 00:37:53 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:486:4b30:18c:3eab:7c3:c142])
        by smtp.gmail.com with ESMTPSA id c10-20020a056a00008a00b0057255b82bd1sm817583pfj.217.2022.11.30.00.37.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:37:52 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, lee@kernel.org, matthias.bgg@gmail.com,
        yangyingliang@huawei.com, chiaen_wu@richtek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 2/2] regulator: mt6370: Switch to use dev_err_probe() helper
Date:   Wed, 30 Nov 2022 16:37:43 +0800
Message-Id: <1669797463-24887-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669797463-24887-1-git-send-email-u0084500@gmail.com>
References: <1669797463-24887-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Use dev_err_probe helper to simplify the probe function.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/mt6370-regulator.c | 39 +++++++++++++-----------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/mt6370-regulator.c b/drivers/regulator/mt6370-regulator.c
index c2b589a..e090fbe 100644
--- a/drivers/regulator/mt6370-regulator.c
+++ b/drivers/regulator/mt6370-regulator.c
@@ -303,11 +303,9 @@ static int mt6370_regulator_irq_register(struct mt6370_priv *priv)
 		ret = devm_request_threaded_irq(priv->dev, irq, NULL,
 						mt6370_irqs[i].handler, 0,
 						mt6370_irqs[i].name, rdev);
-		if (ret) {
-			dev_err(priv->dev,
-				"Failed to register (%d) interrupt\n", i);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(priv->dev, ret,
+					     "Failed to register (%d) interrupt\n", i);
 	}
 
 	return 0;
@@ -329,20 +327,16 @@ static int mt6370_regualtor_register(struct mt6370_priv *priv)
 	int i, ret;
 
 	regulator_np = of_get_child_by_name(parent->of_node, "regulators");
-	if (!regulator_np) {
-		dev_err(dev, "Could not find parent 'regulators' node\n");
-		return -ENODEV;
-	}
+	if (!regulator_np)
+		return dev_err_probe(dev, -ENODEV, "Could not find parent 'regulators' node\n");
 
 	ret = of_regulator_match(dev, regulator_np, mt6370_regulator_match,
 				 ARRAY_SIZE(mt6370_regulator_match));
 
 	of_node_put(regulator_np);
 
-	if (ret < 0) {
-		dev_err(dev, "Error parsing regulator init data: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error parsing regulator init data\n");
 
 	for (i = 0; i < MT6370_MAX_IDX; i++) {
 		const struct regulator_desc *desc = mt6370_regulator_descs + i;
@@ -355,17 +349,14 @@ static int mt6370_regualtor_register(struct mt6370_priv *priv)
 
 		if (cfg.of_node && desc->of_parse_cb) {
 			ret = desc->of_parse_cb(cfg.of_node, desc, &cfg);
-			if (ret) {
-				dev_err(dev, "Failed in of_parse_cb\n");
-				return ret;
-			}
+			if (ret)
+				return dev_err_probe(dev, ret, "Failed in of_parse_cb\n");
 		}
 
 		rdev = devm_regulator_register(dev, desc, &cfg);
-		if (IS_ERR(rdev)) {
-			dev_err(dev, "Failed to register (%d) regulator\n", i);
-			return PTR_ERR(rdev);
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					     "Failed to register (%d) regulator\n", i);
 
 		priv->rdev[i] = rdev;
 	}
@@ -385,10 +376,8 @@ static int mt6370_regulator_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 
 	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!priv->regmap) {
-		dev_err(&pdev->dev, "Failed to init regmap\n");
-		return -ENODEV;
-	}
+	if (!priv->regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Failed to init regmap\n");
 
 	ret = mt6370_regualtor_register(priv);
 	if (ret)
-- 
2.7.4

