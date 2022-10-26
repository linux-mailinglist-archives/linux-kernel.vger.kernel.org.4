Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10D60D8EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiJZBmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJZBml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:42:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8BDDA22;
        Tue, 25 Oct 2022 18:42:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l32so9255660wms.2;
        Tue, 25 Oct 2022 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgFR/jqDKTOAbF1Um/uB16BiixkxC3QBZn+DwYf+s1w=;
        b=h9v5NrHj/e5yrH5asc4huaQY7Mx9s1dD/qbsO+GGK2mA7SdDEOvmOVGFxlPuwuR1Vu
         EkZaoHuMfNj5W+rejBXzhk/PUa8JD+CHotZXn0fnA6hi5Z/8mBOCd1b/qFV+JM2XVy9l
         yZT53JW8cFRlzOdN7d7awnMpTrDxLSycbSFTV5X2OwtI1tU9G6dadgRJYexLWlYGxisE
         mWQujUObtVNNwY0sUeIoCQMwlVqTR0KCVD6zJa4gFdbhOxS46IsNZCAFlz8LliIvUJBp
         XELzZPTBTNPlVifHlTqQpzYIQEngn3mKFkZhpGzZfymoSldOVNyX9CHDJN5+uBwy/Jyf
         tAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgFR/jqDKTOAbF1Um/uB16BiixkxC3QBZn+DwYf+s1w=;
        b=ByqXO3vvwyXYfPvz7CoYEsJcc+NIuq0FuAwWu054/EUYmm0/NrczEoeveHSnZ/trrZ
         3MupIvy+G2QG8zbEFtO4nzjglXixRMFfJeu2KNfdiwvPw/eR2jwjes1Jqm3n9FbtB7U7
         ZZuPyNJAm7wY/5eJvrbwFx5aOfm6nnwKIcY1pwUXLQ2VuEV9hInwvSNvWlauDQKl/rqB
         9Qgc3dt+ZeFsjBriXnbHfaA0RLcTcCfhRHvi+5mhphs6KhLxkHSrfrZDtJi3qfg0yi5/
         my2QGh/5HudVe8kqCvxaSQyMitBZq+UdYQdnPj9DHjplodTMR7qm39oPfIWdgX093yJI
         NlBQ==
X-Gm-Message-State: ACrzQf2e5l5eEIDPrRemGqDM/MotXpov5uW+lGtEDpJyK9jolqhh9Ezi
        k4daiWk33A7mEgSQ/9+odW8=
X-Google-Smtp-Source: AMsMyM6dCOuFp/fWzzJjN6zubI8HboDZ7isKFKYOBASJ/RCRjRUnkgrFbL3ixDvqbBPZkU7T+d9d3Q==
X-Received: by 2002:a05:600c:4b2a:b0:3cf:148d:22cb with SMTP id i42-20020a05600c4b2a00b003cf148d22cbmr644677wmp.96.1666748559233;
        Tue, 25 Oct 2022 18:42:39 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:1d2a:d2a2:361e:a475])
        by smtp.gmail.com with ESMTPSA id x12-20020adff0cc000000b00236733f0f98sm3688956wro.107.2022.10.25.18.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 18:42:38 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
Date:   Wed, 26 Oct 2022 02:42:26 +0100
Message-Id: <20221026014227.162121-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026014227.162121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221026014227.162121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

There are cases where not all CPG_MOD clocks should be assumed to support
PM. For example on the CRU block there is a particular sequence that needs
to be followed to initialize the CSI-2 D-PHY in which individual clocks
need to be turned ON/OFF, due to which Runtime PM support wasn't used by
the CRU CSI-2 driver.

This patch adds support to allow indicating if PM is not supported by the
CPG_MOD clocks. Two new members no_pm_mod_clks and num_no_pm_mod_clks are
added to struct rzg2l_cpg_info so that MOD clocks which do not support PM
can be passed by no_pm_mod_clks[] array and when the driver uses Runtime
PM support the clk ID is matched against the no_pm_mod_clks[] array to see
if the clk is needed to be included as part of Runtime PM.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Dropped DEF_NO_PM() macro
* Added genpd member to struct rzg2l_cpg_priv
* Added no_pm_mod_clks and num_no_pm_mod_clks members
  to struct rzg2l_cpg_info
* Updated commit message

RFC->v1
* Added no_pm_mod_clks and num_no_pm_mod_clks members as part of
  struct rzg2l_cpg_priv
---
 drivers/clk/renesas/rzg2l-cpg.c | 37 ++++++++++++++++++++-------------
 drivers/clk/renesas/rzg2l-cpg.h |  4 ++++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index dfd676310ce9..66b909f31c77 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -95,6 +95,7 @@ struct rzg2l_pll5_mux_dsi_div_param {
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  * @info: Pointer to platform data
+ * @genpd: PM domain
  * @mux_dsi_div_params: pll5 mux and dsi div parameters
  */
 struct rzg2l_cpg_priv {
@@ -111,6 +112,8 @@ struct rzg2l_cpg_priv {
 
 	const struct rzg2l_cpg_info *info;
 
+	struct generic_pm_domain genpd;
+
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };
 
@@ -1223,22 +1226,31 @@ static int rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
 	return devm_reset_controller_register(priv->dev, &priv->rcdev);
 }
 
-static bool rzg2l_cpg_is_pm_clk(const struct of_phandle_args *clkspec)
+static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cpg_priv *priv,
+				const struct of_phandle_args *clkspec)
 {
+	const struct rzg2l_cpg_info *info = priv->info;
+	unsigned int id;
+	unsigned int i;
+
 	if (clkspec->args_count != 2)
 		return false;
 
-	switch (clkspec->args[0]) {
-	case CPG_MOD:
-		return true;
-
-	default:
+	if (clkspec->args[0] != CPG_MOD)
 		return false;
+
+	id = clkspec->args[1] + info->num_total_core_clks;
+	for (i = 0; i < info->num_no_pm_mod_clks; i++) {
+		if (info->no_pm_mod_clks[i] == id)
+			return false;
 	}
+
+	return true;
 }
 
 static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 {
+	struct rzg2l_cpg_priv *priv = container_of(unused, struct rzg2l_cpg_priv, genpd);
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args clkspec;
 	bool once = true;
@@ -1248,7 +1260,7 @@ static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device
 
 	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
 					   &clkspec)) {
-		if (rzg2l_cpg_is_pm_clk(&clkspec)) {
+		if (rzg2l_cpg_is_pm_clk(priv, &clkspec)) {
 			if (once) {
 				once = false;
 				error = pm_clk_create(dev);
@@ -1298,16 +1310,13 @@ static void rzg2l_cpg_genpd_remove(void *data)
 	pm_genpd_remove(data);
 }
 
-static int __init rzg2l_cpg_add_clk_domain(struct device *dev)
+static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
 {
+	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
-	struct generic_pm_domain *genpd;
+	struct generic_pm_domain *genpd = &priv->genpd;
 	int ret;
 
-	genpd = devm_kzalloc(dev, sizeof(*genpd), GFP_KERNEL);
-	if (!genpd)
-		return -ENOMEM;
-
 	genpd->name = np->name;
 	genpd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ALWAYS_ON |
 		       GENPD_FLAG_ACTIVE_WAKEUP;
@@ -1377,7 +1386,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = rzg2l_cpg_add_clk_domain(dev);
+	error = rzg2l_cpg_add_clk_domain(priv);
 	if (error)
 		return error;
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index cecbdf5e4f93..eee780276a9e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -256,6 +256,10 @@ struct rzg2l_cpg_info {
 	unsigned int num_mod_clks;
 	unsigned int num_hw_mod_clks;
 
+	/* No PM Module Clocks */
+	const unsigned int *no_pm_mod_clks;
+	unsigned int num_no_pm_mod_clks;
+
 	/* Resets */
 	const struct rzg2l_reset *resets;
 	unsigned int num_resets;
-- 
2.25.1

