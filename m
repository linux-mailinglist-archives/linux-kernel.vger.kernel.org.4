Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08667223D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjFEKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFEKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:48:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02849EA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:48:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-652d76be8c2so3726934b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962137; x=1688554137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybIVKhIMvG4X9VWsC5FMi4iXqxRG06/FeOW8owPbVV4=;
        b=YGMZoenSFKA3na/YkT8NkgrMs4UVwYex/On9Riu+OXPxpbzEWu1GHbpZ+SwrqurJZc
         6AqPQG9NIvzqsuWA3zhDkTkDtWoXortJuO/66N6j2soNcFKLC6LX5Shg+41VWMXGR+aQ
         XYCh+0icZeQjL/qGE1MfArqQ1DTkbINADCwZ/sV7XFeW+ThRNo/hmRyU6z6bh/dZ/Tuj
         WmjKOt63YS29cXjXOH0p3Fa3SwsYk+Swpt3qA4gHjde2OSs6rJMl1+BAmmZ96+yTuNob
         3oy4ckPAtZL6TUZ5R/9XpXg42DOzLVkiJ3GdHGBN1e0NjOwGAEMhQjvZXsP4y4R0K1Lb
         meTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962137; x=1688554137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybIVKhIMvG4X9VWsC5FMi4iXqxRG06/FeOW8owPbVV4=;
        b=DCDpJSPqcQe/byf2r1IV+epM4rveNSjadS/E3sNjJs0iD7QmGHTDIfUoo4jmgoD0is
         dw/prMGLemtePrBHpwTIaIDIUxGSKACX6oVk98siK1wVMb2vALeqHBAReoaKWntAjChJ
         3/2o2H5vhyqIBD/X1hIgS8l5FzpZ2h+JwyHfhfMk69xwHi+iim2DrJdlayYYHb/JZsBd
         Ac1S9ONwTQNOunoSDUPApNd3+rBO0+HmwiqRWYsg/ZkNLBjSCsjT44iiH+Vf9ogndtQ2
         DQ7UFkTzeunoEZ3kvYYtx74J+lpKa01bS+wprFxYzTuiPJL7jMhz3mBbnsabpLwGhLNZ
         VnMA==
X-Gm-Message-State: AC+VfDzE0pycK30jv9oPzULyqEfTYYnCSzzcET4S/h08E+KTiNkOzXJy
        TmJeG7CmS8J26nysuXAIA6Q=
X-Google-Smtp-Source: ACHHUZ76QJyT9zBKdA4WnQVH1bjKpx683fZTw5txI7OE9pG2L8oN8H/kkQIgYM8P9nqP6OIdXTS9nA==
X-Received: by 2002:a05:6a00:856:b0:64b:f03b:2642 with SMTP id q22-20020a056a00085600b0064bf03b2642mr22950761pfk.23.1685962137469;
        Mon, 05 Jun 2023 03:48:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:2003:b135:89cf:b185:51e1:ed4b])
        by smtp.gmail.com with ESMTPSA id w7-20020aa78587000000b0064d681c753csm4935442pfn.40.2023.06.05.03.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:48:57 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH 2/2] regulator: act8945a: get rid of redundant structure
Date:   Mon,  5 Jun 2023 16:18:30 +0530
Message-Id: <20230605104830.68552-2-raagjadav@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605104830.68552-1-raagjadav@gmail.com>
References: <20230605104830.68552-1-raagjadav@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove struct act8945a_pmic, as we no longer need drvdata.

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 drivers/regulator/act8945a-regulator.c | 29 ++++++++------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index bd54d76efcbc..73504253acc9 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -67,10 +67,6 @@ enum {
 	ACT8945A_ID_LDO4,
 };
 
-struct act8945a_pmic {
-	struct regmap *regmap;
-};
-
 static const struct linear_range act8945a_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 23, 25000),
 	REGULATOR_LINEAR_RANGE(1200000, 24, 47, 50000),
@@ -301,17 +297,13 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 {
 	struct regulator_config config = { };
 	const struct regulator_desc *regulators;
-	struct act8945a_pmic *act8945a;
 	struct regulator_dev *rdev;
+	struct regmap *regmap;
 	int i, num_regulators;
 	bool voltage_select;
 
-	act8945a = devm_kzalloc(&pdev->dev, sizeof(*act8945a), GFP_KERNEL);
-	if (!act8945a)
-		return -ENOMEM;
-
-	act8945a->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!act8945a->regmap) {
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
 		dev_err(&pdev->dev,
 			"could not retrieve regmap from parent device\n");
 		return -EINVAL;
@@ -330,7 +322,6 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 
 	config.dev = &pdev->dev;
 	config.dev->of_node = pdev->dev.parent->of_node;
-	config.driver_data = act8945a;
 	for (i = 0; i < num_regulators; i++) {
 		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
 					       &config);
@@ -342,33 +333,31 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, act8945a);
-
 	/* Unlock expert registers. */
-	return regmap_write(act8945a->regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
+	return regmap_write(regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
 }
 
-static int __maybe_unused act8945a_suspend(struct device *pdev)
+static int __maybe_unused act8945a_suspend(struct device *dev)
 {
-	struct act8945a_pmic *act8945a = dev_get_drvdata(pdev);
+	struct regmap *regmap = dev_get_regmap(dev->parent, NULL);
 
 	/*
 	 * Ask the PMIC to enter the suspend mode on the next PWRHLD
 	 * transition.
 	 */
-	return regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x42);
+	return regmap_write(regmap, ACT8945A_SYS_CTRL, 0x42);
 }
 
 static SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
 
 static void act8945a_pmic_shutdown(struct platform_device *pdev)
 {
-	struct act8945a_pmic *act8945a = platform_get_drvdata(pdev);
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
 
 	/*
 	 * Ask the PMIC to shutdown everything on the next PWRHLD transition.
 	 */
-	regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x0);
+	regmap_write(regmap, ACT8945A_SYS_CTRL, 0x0);
 }
 
 static struct platform_driver act8945a_pmic_driver = {
-- 
2.25.1

