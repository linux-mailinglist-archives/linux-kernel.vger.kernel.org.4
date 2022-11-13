Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FF4627184
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiKMSL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiKMSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:11:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5722186
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:11:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a5so14265882edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPd68FUR79AWkIadeZ82I56QkegjFyI8hy7EtJLKFIQ=;
        b=nF4YR/N2uPYi863sndOW7/nF5upKGd/hcZQx+JSVlAnqI8Y52OIzTPC1ciM9Q7lUVJ
         enMUigG9/BPHg+DNKucXvWH/JEvUta8hGkxE/bAgKQFau6gHBt5/NCjbQbJ1RMqH9f0I
         uSx1BRVuHp7KjfQGnIhlw1A/z4yJj5IF1adPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPd68FUR79AWkIadeZ82I56QkegjFyI8hy7EtJLKFIQ=;
        b=qGHnbumZxV7CccAlppa2vwmx8BJMWkEXihFCQqFDEuuEdLSKQCcHuUldj0p6wm8VWr
         SA7tFHp61v8slemq1TWvBcUuPQ647VAaH1I6MuTIBX8r9ZSECen4YK8TxNuTLQcw+KLl
         VGicUJCfxFKLIoEEZZvau+flEg+ljr5KqEq8oJRmiRc18cRhLlAu5m1exTkD5YgX5VqG
         68T/JH23Pa3KBapu6Ycz0S0mFGtY5y5E776ZSFfy0Lgxs7Uh32/z9J4sA9ELxqrglECJ
         Nr5aEQGUeo/okccnFhgq35BoCr3ita/FLMPbcZESS4lnXl3E1ZzAlkdTp05f2y7vG2UN
         hlPw==
X-Gm-Message-State: ANoB5pm5PVhZ1OoK8Nt0z1RyepvSAMt7POqdBXqxxLr+FpsBUEWs+Vbp
        xwcjJhWdvgJcuRLOPhTUZYGbqXLdUOFBPg==
X-Google-Smtp-Source: AA0mqf73dOuytdASpTLLcS7rg27Nadju5LEOwyPZGQFztscyYAI+3KTinLt0EGTkfaEctd3wi7okSQ==
X-Received: by 2002:a05:6402:298a:b0:461:4c59:12d6 with SMTP id eq10-20020a056402298a00b004614c5912d6mr8806556edb.250.1668363112156;
        Sun, 13 Nov 2022 10:11:52 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-103-33.business.telecomitalia.it. [79.40.103.33])
        by smtp.gmail.com with ESMTPSA id i20-20020a50fd14000000b004618a89d273sm3753534eds.36.2022.11.13.10.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 10:11:51 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Len Baker <len.baker@gmx.com>, Liang He <windhl@126.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v4 1/2] clk: ti: change ti_clk_register[_omap_hw]() API
Date:   Sun, 13 Nov 2022 19:11:46 +0100
Message-Id: <20221113181147.1626585-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti_clk_register() and ti_clk_register_omap_hw() functions are always
called with the parameter of type "struct device" set to NULL, since the
functions from which they are called always have a parameter of type
"struct device_node". Replacing "struct device" type parameter with
"struct device_node" will allow you to register a TI clock to the common
clock framework by taking advantage of the facilities provided by the
"struct device_node" type. Further, adding the "of_" prefix to the name
of these functions explicitly binds them to the "struct device_node"
type.

The patch has been tested on a Beaglebone board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v4:
- Extend the patch to ti_clk_register_omap_hw() function. Replace
  ti_clk_register[_omap_hw]() functions with of_ti_clk_register[_omap_hw]().
- Change commit title and description.

 drivers/clk/ti/apll.c         |  4 ++--
 drivers/clk/ti/clk-dra7-atl.c |  2 +-
 drivers/clk/ti/clk.c          | 34 ++++++++++++++++------------------
 drivers/clk/ti/clkctrl.c      |  4 ++--
 drivers/clk/ti/clock.h        | 10 +++++-----
 drivers/clk/ti/composite.c    |  2 +-
 drivers/clk/ti/divider.c      |  2 +-
 drivers/clk/ti/dpll.c         |  4 ++--
 drivers/clk/ti/fixed-factor.c |  2 +-
 drivers/clk/ti/gate.c         |  6 +++---
 drivers/clk/ti/interface.c    |  7 ++++---
 drivers/clk/ti/mux.c          |  6 +++---
 12 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index dd0709c9c249..93183287c58d 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -160,7 +160,7 @@ static void __init omap_clk_register_apll(void *user,
 	ad->clk_bypass = __clk_get_hw(clk);
 
 	name = ti_dt_clk_name(node);
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(init->parent_names);
@@ -400,7 +400,7 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 		goto cleanup;
 
 	name = ti_dt_clk_name(node);
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(init);
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index ff4d6a951681..1c576599f6db 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -197,7 +197,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 
 	init.parent_names = parent_names;
 
-	clk = ti_clk_register(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register(node, &clk_hw->hw, name);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 1dc2f15fb75b..269355010cdc 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -475,7 +475,7 @@ void __init ti_clk_add_aliases(void)
 		clkspec.np = np;
 		clk = of_clk_get_from_provider(&clkspec);
 
-		ti_clk_add_alias(NULL, clk, ti_dt_clk_name(np));
+		ti_clk_add_alias(clk, ti_dt_clk_name(np));
 	}
 }
 
@@ -528,7 +528,6 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
 
 /**
  * ti_clk_add_alias - add a clock alias for a TI clock
- * @dev: device alias for this clock
  * @clk: clock handle to create alias for
  * @con: connection ID for this clock
  *
@@ -536,7 +535,7 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
  * and assigns the data to it. Returns 0 if successful, negative error
  * value otherwise.
  */
-int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
+int ti_clk_add_alias(struct clk *clk, const char *con)
 {
 	struct clk_lookup *cl;
 
@@ -550,8 +549,6 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
 	if (!cl)
 		return -ENOMEM;
 
-	if (dev)
-		cl->dev_id = dev_name(dev);
 	cl->con_id = con;
 	cl->clk = clk;
 
@@ -561,8 +558,8 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
 }
 
 /**
- * ti_clk_register - register a TI clock to the common clock framework
- * @dev: device for this clock
+ * of_ti_clk_register - register a TI clock to the common clock framework
+ * @node: device node for this clock
  * @hw: hardware clock handle
  * @con: connection ID for this clock
  *
@@ -570,17 +567,18 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
  * alias for it. Returns a handle to the registered clock if successful,
  * ERR_PTR value in failure.
  */
-struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
-			    const char *con)
+struct clk *of_ti_clk_register(struct device_node *node, struct clk_hw *hw,
+			       const char *con)
 {
 	struct clk *clk;
 	int ret;
 
-	clk = clk_register(dev, hw);
-	if (IS_ERR(clk))
-		return clk;
+	ret = of_clk_hw_register(node, hw);
+	if (ret)
+		return ERR_PTR(ret);
 
-	ret = ti_clk_add_alias(dev, clk, con);
+	clk = hw->clk;
+	ret = ti_clk_add_alias(clk, con);
 	if (ret) {
 		clk_unregister(clk);
 		return ERR_PTR(ret);
@@ -590,8 +588,8 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 }
 
 /**
- * ti_clk_register_omap_hw - register a clk_hw_omap to the clock framework
- * @dev: device for this clock
+ * of_ti_clk_register_omap_hw - register a clk_hw_omap to the clock framework
+ * @node: device node for this clock
  * @hw: hardware clock handle
  * @con: connection ID for this clock
  *
@@ -600,13 +598,13 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
  * Returns a handle to the registered clock if successful, ERR_PTR value
  * in failure.
  */
-struct clk *ti_clk_register_omap_hw(struct device *dev, struct clk_hw *hw,
-				    const char *con)
+struct clk *of_ti_clk_register_omap_hw(struct device_node *node,
+				       struct clk_hw *hw, const char *con)
 {
 	struct clk *clk;
 	struct clk_hw_omap *oclk;
 
-	clk = ti_clk_register(dev, hw, con);
+	clk = of_ti_clk_register(node, hw, con);
 	if (IS_ERR(clk))
 		return clk;
 
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index ae5862879417..f73f402ff7de 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -305,7 +305,7 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provider *provider,
 	init.ops = ops;
 	init.flags = 0;
 
-	clk = ti_clk_register(NULL, clk_hw, init.name);
+	clk = of_ti_clk_register(node, clk_hw, init.name);
 	if (IS_ERR_OR_NULL(clk)) {
 		ret = -EINVAL;
 		goto cleanup;
@@ -682,7 +682,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		init.ops = &omap4_clkctrl_clk_ops;
 		hw->hw.init = &init;
 
-		clk = ti_clk_register_omap_hw(NULL, &hw->hw, init.name);
+		clk = of_ti_clk_register_omap_hw(node, &hw->hw, init.name);
 		if (IS_ERR_OR_NULL(clk))
 			goto cleanup;
 
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 37ab53339a9b..16a9f7c2280a 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -199,12 +199,12 @@ extern const struct omap_clkctrl_data dm816_clkctrl_data[];
 
 typedef void (*ti_of_clk_init_cb_t)(void *, struct device_node *);
 
-struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
-			    const char *con);
-struct clk *ti_clk_register_omap_hw(struct device *dev, struct clk_hw *hw,
-				    const char *con);
+struct clk *of_ti_clk_register(struct device_node *node, struct clk_hw *hw,
+			       const char *con);
+struct clk *of_ti_clk_register_omap_hw(struct device_node *node,
+				       struct clk_hw *hw, const char *con);
 const char *ti_dt_clk_name(struct device_node *np);
-int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con);
+int ti_clk_add_alias(struct clk *clk, const char *con);
 void ti_clk_add_aliases(void);
 
 void ti_clk_latch(struct clk_omap_reg *reg, s8 shift);
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 77b771dd050a..b85382c370f7 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -176,7 +176,7 @@ static void __init _register_composite(void *user,
 				     &ti_composite_gate_ops, 0);
 
 	if (!IS_ERR(clk)) {
-		ret = ti_clk_add_alias(NULL, clk, name);
+		ret = ti_clk_add_alias(clk, name);
 		if (ret) {
 			clk_unregister(clk);
 			goto cleanup;
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 488d3da60c31..768a1f3398b4 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -326,7 +326,7 @@ static struct clk *_register_divider(struct device_node *node,
 	div->hw.init = &init;
 
 	/* register the clock */
-	clk = ti_clk_register(NULL, &div->hw, name);
+	clk = of_ti_clk_register(node, &div->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(div);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 8ed43bc6b7cc..403ec81f561b 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -187,7 +187,7 @@ static void __init _register_dpll(void *user,
 
 	/* register the clock */
 	name = ti_dt_clk_name(node);
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -259,7 +259,7 @@ static void _register_dpll_x2(struct device_node *node,
 #endif
 
 	/* register the clock */
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
index c80cee0f5d3d..c102c5320168 100644
--- a/drivers/clk/ti/fixed-factor.c
+++ b/drivers/clk/ti/fixed-factor.c
@@ -54,7 +54,7 @@ static void __init of_ti_fixed_factor_clk_setup(struct device_node *node)
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		of_ti_clk_autoidle_setup(node);
-		ti_clk_add_alias(NULL, clk, clk_name);
+		ti_clk_add_alias(clk, clk_name);
 	}
 }
 CLK_OF_DECLARE(ti_fixed_factor_clk, "ti,fixed-factor-clock",
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 307702921431..8e477d50d0fd 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -85,7 +85,7 @@ static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *hw)
 	return ret;
 }
 
-static struct clk *_register_gate(struct device *dev, const char *name,
+static struct clk *_register_gate(struct device_node *node, const char *name,
 				  const char *parent_name, unsigned long flags,
 				  struct clk_omap_reg *reg, u8 bit_idx,
 				  u8 clk_gate_flags, const struct clk_ops *ops,
@@ -115,7 +115,7 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 
 	init.flags = flags;
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
@@ -158,7 +158,7 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 		clk_gate_flags |= INVERT_ENABLE;
 
 	name = ti_dt_clk_name(node);
-	clk = _register_gate(NULL, name, parent_name, flags, &reg,
+	clk = _register_gate(node, name, parent_name, flags, &reg,
 			     enable_bit, clk_gate_flags, ops, hw_ops);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index f47beeea211e..172301c646f8 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -24,7 +24,8 @@ static const struct clk_ops ti_interface_clk_ops = {
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
-static struct clk *_register_interface(struct device *dev, const char *name,
+static struct clk *_register_interface(struct device_node *node,
+				       const char *name,
 				       const char *parent_name,
 				       struct clk_omap_reg *reg, u8 bit_idx,
 				       const struct clk_hw_omap_ops *ops)
@@ -49,7 +50,7 @@ static struct clk *_register_interface(struct device *dev, const char *name,
 	init.num_parents = 1;
 	init.parent_names = &parent_name;
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
@@ -80,7 +81,7 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
 	}
 
 	name = ti_dt_clk_name(node);
-	clk = _register_interface(NULL, name, parent_name, &reg,
+	clk = _register_interface(node, name, parent_name, &reg,
 				  enable_bit, ops);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 46b45b3e8319..1ebafa386be6 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -118,7 +118,7 @@ const struct clk_ops ti_clk_mux_ops = {
 	.restore_context = clk_mux_restore_context,
 };
 
-static struct clk *_register_mux(struct device *dev, const char *name,
+static struct clk *_register_mux(struct device_node *node, const char *name,
 				 const char * const *parent_names,
 				 u8 num_parents, unsigned long flags,
 				 struct clk_omap_reg *reg, u8 shift, u32 mask,
@@ -148,7 +148,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	mux->table = table;
 	mux->hw.init = &init;
 
-	clk = ti_clk_register(dev, &mux->hw, name);
+	clk = of_ti_clk_register(node, &mux->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(mux);
@@ -207,7 +207,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	mask = (1 << fls(mask)) - 1;
 
 	name = ti_dt_clk_name(node);
-	clk = _register_mux(NULL, name, parent_names, num_parents,
+	clk = _register_mux(node, name, parent_names, num_parents,
 			    flags, &reg, shift, mask, latch, clk_mux_flags,
 			    NULL);
 
-- 
2.32.0

