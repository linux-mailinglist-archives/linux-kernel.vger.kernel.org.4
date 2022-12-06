Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE58643B93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiLFC70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiLFC7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:59:25 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7E2250A;
        Mon,  5 Dec 2022 18:59:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p24so12672188plw.1;
        Mon, 05 Dec 2022 18:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/4Cj9/05hjAE/KmGhJWxXDEiM3adoyVLnClbzSb1Z8=;
        b=FFFvWECPjGLnVyC1xHSAxk+j+228qCLvo8kybrm5bnCmzaC67KvmBX0un9mY0+kGHP
         xq116qzlCeV/O026EgTv4iDlnoUcEfCayjBXrmT7V48huVurbKHdvZUTiZcmy/LZpYH9
         VBrda2aaCFamlDih0z9Wq1kpGPmULrtIA2exdhMym21QO80bmAtnqomGjwvjRZHbcgDI
         NlpUfKhoxfe7LWsKwMVWollmCnpjFWcIu0LnRGeFMDLupgJpUwqsUNvoBHqa1ry9mxwh
         q8JyczeE4xuzM4z8VZQIVWICa3GeA10Y8AweKdti5nmPynrgMiMz6t0VykOGPztCz6CK
         8/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/4Cj9/05hjAE/KmGhJWxXDEiM3adoyVLnClbzSb1Z8=;
        b=Eni9OWZQ1RkeyJkoHKyumZpy5PTy3gfoYzzwxv3VQcnVk5a8ivnarZrreiX8Nt/Tc2
         g4N03VLBpgM2zIl3DFTgEmJXKdBP1LcOTwW3gR4sTjEvFhI1JSNZOg50g5BSZD6h69/b
         8p8ZI/PXVTJ/28g7+zvGyGnMhSozZ0Qj3cGjfv1sU3NR3kiA64VfzKVr5P3ApwcgJFhu
         QH/KL7JoJzs6sy/t0lEU48RdYhEb0Ju3MZjqCJLrf0/8Y4d1aE2h4AM/ylzX7Llybinh
         /lVs2I4hM1f/miDcaQtn+oCDcMQkSPlKH3d7lkFPgveZaNRU8TP4O1HCQfo26dV6CZDB
         Tstg==
X-Gm-Message-State: ANoB5pler/rw+/5FH5FadYNCgpRkAMjI26NiJaC7u0tLU4uoAx4HtBVn
        9XrF2T+CRsoULpaFJTavn2Q=
X-Google-Smtp-Source: AA0mqf5txxt8YXiv04XTW3H78mBdu/lkOdTzM4RB5w74XmUrgNdIVa3BIXgHhmtNBuBjwusRpIaANg==
X-Received: by 2002:a17:90a:5918:b0:213:df25:7e8a with SMTP id k24-20020a17090a591800b00213df257e8amr100059081pji.154.1670295563642;
        Mon, 05 Dec 2022 18:59:23 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:587:6b8b:a5d3:fc1e:41e4:9160])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b0017f72a430adsm11315090plg.71.2022.12.05.18.59.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 18:59:21 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     djrscally@gmail.com, hdegoede@redhat.com, markgross@kernel.org,
        lgirdwood@gmail.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, gene_chen@richtek.com,
        chiaen_wu@richtek.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH] regulator: core: Use different devices for resource allocation and DT lookup
Date:   Tue,  6 Dec 2022 10:59:08 +0800
Message-Id: <1670295548-19598-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
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

Following by the below discussion, there's the potential UAF issue
between regulator and mfd.
https://lore.kernel.org/all/20221128143601.1698148-1-yangyingliang@huawei.com/

From the analysis of Yingliang

CPU A				|CPU B
mt6370_probe()			|
  devm_mfd_add_devices()	|
				|mt6370_regulator_probe()
				|  regulator_register()
				|    //allocate init_data and add it to devres
				|    regulator_of_get_init_data()
i2c_unregister_device()		|
  device_del()			|
    devres_release_all()	|
      // init_data is freed	|
      release_nodes()		|
				|  // using init_data causes UAF
				|  regulator_register()

It's common to use mfd core to create child device for the regulator.
In order to do the DT lookup for init data, the child that registered
the regulator would pass its parent as the parameter. And this causes
init data resource allocated to its parent, not itself. The issue happen
when parent device is going to release and regulator core is still doing
some operation of init data constraint for the regulator of child device.

To fix it, this patch expand 'regulator_register' API to use the
different devices for init data allocation and DT lookup.

Reported-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi, Mark:

  I have already tested on MT6370. It works.
Due to 'regulator_register' API change, There're still two existing users use it.

I also modify it by the way.

---
 drivers/platform/x86/intel/int3472/clk_and_regulator.c | 3 ++-
 drivers/regulator/core.c                               | 8 ++++----
 drivers/regulator/devres.c                             | 2 +-
 drivers/regulator/of_regulator.c                       | 2 +-
 drivers/regulator/stm32-vrefbuf.c                      | 2 +-
 include/linux/regulator/driver.h                       | 3 ++-
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
index 1cf9589..c5e3e54d 100644
--- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
+++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
@@ -185,7 +185,8 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 	cfg.init_data = &init_data;
 	cfg.ena_gpiod = int3472->regulator.gpio;
 
-	int3472->regulator.rdev = regulator_register(&int3472->regulator.rdesc,
+	int3472->regulator.rdev = regulator_register(int3742->dev,
+						     &int3472->regulator.rdesc,
 						     &cfg);
 	if (IS_ERR(int3472->regulator.rdev)) {
 		ret = PTR_ERR(int3472->regulator.rdev);
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e8c00a8..ea4a720 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5396,6 +5396,7 @@ static struct regulator_coupler generic_regulator_coupler = {
 
 /**
  * regulator_register - register regulator
+ * @dev: the device that drive the regulator
  * @regulator_desc: regulator to register
  * @cfg: runtime configuration for regulator
  *
@@ -5404,7 +5405,8 @@ static struct regulator_coupler generic_regulator_coupler = {
  * or an ERR_PTR() on error.
  */
 struct regulator_dev *
-regulator_register(const struct regulator_desc *regulator_desc,
+regulator_register(struct device *dev,
+		   const struct regulator_desc *regulator_desc,
 		   const struct regulator_config *cfg)
 {
 	const struct regulator_init_data *init_data;
@@ -5413,7 +5415,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	struct regulator_dev *rdev;
 	bool dangling_cfg_gpiod = false;
 	bool dangling_of_gpiod = false;
-	struct device *dev;
 	int ret, i;
 	bool resolved_early = false;
 
@@ -5426,8 +5427,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		goto rinse;
 	}
 
-	dev = cfg->dev;
-	WARN_ON(!dev);
+	WARN_ON(!dev || !cfg->dev);
 
 	if (regulator_desc->name == NULL || regulator_desc->ops == NULL) {
 		ret = -EINVAL;
diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 3265e75..5c7ff9b 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -385,7 +385,7 @@ struct regulator_dev *devm_regulator_register(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	rdev = regulator_register(regulator_desc, config);
+	rdev = regulator_register(dev, regulator_desc, config);
 	if (!IS_ERR(rdev)) {
 		*ptr = rdev;
 		devres_add(dev, ptr);
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 0aff1c2..cd726d4 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -505,7 +505,7 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 	struct device_node *child;
 	struct regulator_init_data *init_data = NULL;
 
-	child = regulator_of_get_init_node(dev, desc);
+	child = regulator_of_get_init_node(config->dev, desc);
 	if (!child)
 		return NULL;
 
diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index 30ea3bc..7a454b7 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -210,7 +210,7 @@ static int stm32_vrefbuf_probe(struct platform_device *pdev)
 						      pdev->dev.of_node,
 						      &stm32_vrefbuf_regu);
 
-	rdev = regulator_register(&stm32_vrefbuf_regu, &config);
+	rdev = regulator_register(&pdev->dev, &stm32_vrefbuf_regu, &config);
 	if (IS_ERR(rdev)) {
 		ret = PTR_ERR(rdev);
 		dev_err(&pdev->dev, "register failed with error %d\n", ret);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index f9a7461..d3b4a3d 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -687,7 +687,8 @@ static inline int regulator_err2notif(int err)
 
 
 struct regulator_dev *
-regulator_register(const struct regulator_desc *regulator_desc,
+regulator_register(struct device *dev,
+		   const struct regulator_desc *regulator_desc,
 		   const struct regulator_config *config);
 struct regulator_dev *
 devm_regulator_register(struct device *dev,
-- 
2.7.4

