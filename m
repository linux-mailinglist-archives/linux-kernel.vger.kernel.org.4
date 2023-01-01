Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6801A65AAE7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjAAR6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjAAR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:58:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAAE3887
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:58:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m18so62166694eji.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 09:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ANQd6bXt3IGDoNEOc8NxJt3wMiyzrQXu+RqmVmBeDs=;
        b=mJe4b2RijturIL0i0gYMqhYyZrq5yE58888YGpw5SuKxqw11OTF1jgUQbEGXQes+Bj
         g08qD16XDp9EIy/dlYAv4mIM2+7uit24d067Y03rx7bIcXGOOp7XK9OLAX1o2yySiGkP
         C2cjT0tk2e8sJMMRCDKMq+lj+XjQjBLBXRzRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ANQd6bXt3IGDoNEOc8NxJt3wMiyzrQXu+RqmVmBeDs=;
        b=UBxmK3dLjmUR5ZJfVzCrMm1Z3Az+Kkk6Ew8w0wvmYszAWcbszH2Vp+Aec61leoFIXf
         gfNcjEafRfLsRWy9QG85uOg+Ihz5aEpAn1neagEyCMxS5yFKvfi26LO344lw5bnkQazH
         r3JFAtA+mBJW756k8KZx4q4Rd7Y9Nb2l1JStptsFgeHueE87TCLsHOA9K0IULNH2XWyO
         cr2v0C5TJxnSNlB8NgrinPthFSJ1l0dUinSi3zUEPdi02B6tmB99N7BNfZhJVzU46CBX
         79kbqWAz22ufVEDLU4K9V737oapYqhrRcjG2MAbo69mQ2qYsO4liNaXRBvgSKKrFnnqI
         ayZw==
X-Gm-Message-State: AFqh2kr6ACEmDqk81RuRSyZ8dTwhVCDqsVl8Y7THc+Nt4jcWZ545xPyq
        NlC5EMSypreN8hCWp0YNs88iWK2e+xj9+XPBKYE=
X-Google-Smtp-Source: AMrXdXso8nbBqMtt1gTfs/eQvnUDWYvkn4cvq16z7m5ZY+eEiCoFsgF/aVFX8u9ZgdaZ0F7gZ9a+6w==
X-Received: by 2002:a17:907:72d3:b0:7c0:fd1e:972e with SMTP id du19-20020a17090772d300b007c0fd1e972emr42553684ejc.46.1672595879577;
        Sun, 01 Jan 2023 09:57:59 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709063d4200b0082ddfb47d06sm12273018ejf.148.2023.01.01.09.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:57:59 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     angelo@amarulasolutions.com, michael@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH v2 09/11] clk: imx: cpu: add device tree support
Date:   Sun,  1 Jan 2023 18:57:38 +0100
Message-Id: <20230101175740.1010258-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
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

The patch, backwards compatible, extends the driver to initialize the
clock directly from the device tree.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-cpu.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/clk/imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
index cb6ca4cf0535..28fb75c6ecea 100644
--- a/drivers/clk/imx/clk-cpu.c
+++ b/drivers/clk/imx/clk-cpu.c
@@ -106,3 +106,57 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 	return hw;
 }
 EXPORT_SYMBOL_GPL(imx_clk_hw_cpu);
+
+/**
+ * of_imx_cpu_clk_setup - Setup function for imx low power gate
+ *                            clock
+ * @node:	device node for the clock
+ */
+static void __init of_imx_cpu_clk_setup(struct device_node *node)
+{
+	struct clk_hw *hw;
+	struct clk *parent_clk, *div, *mux, *pll, *step;
+	const char *name = node->name, *parent_name;
+
+	parent_clk = of_clk_get_by_name(node, "fck");
+	if (IS_ERR(parent_clk)) {
+		pr_err("failed to get parent clock for %pOFn\n", node);
+		return;
+	}
+
+	div = of_clk_get_by_name(node, "div-clk");
+	if (IS_ERR(div)) {
+		pr_err("failed to get div clock for %pOFn\n", node);
+		return;
+	}
+
+	mux = of_clk_get_by_name(node, "mux-clk");
+	if (IS_ERR(div)) {
+		pr_err("failed to get mux clock for %pOFn\n", node);
+		return;
+	}
+
+	pll = of_clk_get_by_name(node, "pll-clk");
+	if (IS_ERR(div)) {
+		pr_err("failed to get pll clock for %pOFn\n", node);
+		return;
+	}
+
+	step = of_clk_get_by_name(node, "step-clk");
+	if (IS_ERR(div)) {
+		pr_err("failed to get step clock for %pOFn\n", node);
+		return;
+	}
+
+	parent_name = __clk_get_name(parent_clk);
+	of_property_read_string(node, "clock-output-names", &name);
+
+	hw = imx_clk_hw_cpu(name, parent_name, div, mux, pll, step);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
+
+	pr_debug("name: %s, parent: %s, div: %s, mux: %s, pll: %s, step: %s\n",
+		 name, parent_name, __clk_get_name(div), __clk_get_name(mux),
+		 __clk_get_name(pll), __clk_get_name(step));
+}
+CLK_OF_DECLARE(fsl_cpu_clk, "fsl,cpu-clock", of_imx_cpu_clk_setup);
-- 
2.32.0

