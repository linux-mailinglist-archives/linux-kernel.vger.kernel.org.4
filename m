Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B187165AADE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjAAR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjAAR5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:57:54 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A7A2DC6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:57:53 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id t17so62195089eju.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oblVMZgZfte7LXSyrB/POmBldgu6kOYgd6zW5q8+W0Y=;
        b=WnAI8GzdY3F+kPow26vjxB05/NUELNhF4b/lyGEm2/q1L5Ydpkp4dbTQvP3xcXBjBQ
         KWf/cVWJyVBfa5Pe3RGt2OaO6ST9YHba6ZhKrp02waugj1f8HBkMLgxgrevwXI1ixRlC
         //9HkRm5WYGzLDOhEXlQcqzH59VG6LD0ZfmqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oblVMZgZfte7LXSyrB/POmBldgu6kOYgd6zW5q8+W0Y=;
        b=Ju8oMInlcNTYU+6vB+iqfAF7d4dXWz1RYxZ725b8EmdvpTsa2C3t2lZAmRh5xhNkeU
         bCspWciWbqoZFDXFdtOuaRHO2kFv9Tx3Z5ULgLM9XmYq9d5SIBc9GWv5aPk0G/y2hRYM
         bxBM/paR1Fok92JUGWJS9559rUUOOiWPs27ZOr+0/piQKaJwL0ejcSCvXZCDMkS8tGLv
         Y4NOuXp08kUO4ORWH09YvZ41agKhNPkcelMMNDufEcmi8S3NIktxHIj4a5TWYFG3t40v
         tkGb36AWZCDZqndzH9wicLclajTM3nhbOqsMTK5JacOab9+4fRIg4FQy+aFLHQmk0yuJ
         cpCw==
X-Gm-Message-State: AFqh2kozAHV0J0KzJ/HX6MWhhOyGuGAdw0yIEEtM63O1tLLJ5YiBN7bf
        IiTLKsex2hE1pyXTJ/MtV13Za4Fx0zwdetMKYa4=
X-Google-Smtp-Source: AMrXdXv959ouvFb59L0yRtBCOCDcQZJT/7xjFOoD9JH1Rtl5aw9YuHks7ermR0EpSjEc3aFwnVrlPA==
X-Received: by 2002:a17:907:11cf:b0:7c2:3b8a:9f0d with SMTP id va15-20020a17090711cf00b007c23b8a9f0dmr33781690ejb.51.1672595871493;
        Sun, 01 Jan 2023 09:57:51 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709063d4200b0082ddfb47d06sm12273018ejf.148.2023.01.01.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:57:51 -0800 (PST)
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
Subject: [RFC PATCH v2 03/11] clk: imx8mn: add gate driver
Date:   Sun,  1 Jan 2023 18:57:32 +0100
Message-Id: <20230101175740.1010258-4-dario.binacchi@amarulasolutions.com>
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

The patch adds support for imx8mn gate clocks to be initialized directly
from the device tree. Currently all i.MX gate clocks are initialized by
legacy code with hardwired parameters. This approach has generated a
proliferation of setup functions with unclear names:

git grep "#define imx_clk_hw_gate" drivers/clk/imx/clk.h
drivers/clk/imx/clk.h:#define imx_clk_hw_gate(name, parent, reg, shift) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate2(name, parent, reg, shift) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate_dis(name, parent, reg, shift) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate_dis_flags(name, parent, reg, shift, flags) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate_flags(name, parent, reg, shift, flags) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate2_flags(name, parent, reg, shift, flags) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate2_shared(name, parent, reg, shift, shared_count) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate2_shared2(name, parent, reg, shift, shared_count) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate3(name, parent, reg, shift) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate3_flags(name, parent, reg, shift, flags) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate4(name, parent, reg, shift) \
drivers/clk/imx/clk.h:#define imx_clk_hw_gate4_flags(name, parent, reg, shift, flags) \

So, let's start with this specific clock driver and hope that other
variants can be handled in the future, causing the legacy code to be
removed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/Makefile   |   1 +
 drivers/clk/imx/clk-gate.c | 156 +++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 drivers/clk/imx/clk-gate.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index e8aacb0ee6ac..72e1f08d49dc 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -11,6 +11,7 @@ mxc-clk-objs += clk-divider-gate.o
 mxc-clk-objs += clk-fixup-div.o
 mxc-clk-objs += clk-fixup-mux.o
 mxc-clk-objs += clk-frac-pll.o
+mxc-clk-objs += clk-gate.o
 mxc-clk-objs += clk-gate2.o
 mxc-clk-objs += clk-gate-93.o
 mxc-clk-objs += clk-gate-exclusive.o
diff --git a/drivers/clk/imx/clk-gate.c b/drivers/clk/imx/clk-gate.c
new file mode 100644
index 000000000000..841ff9a37f30
--- /dev/null
+++ b/drivers/clk/imx/clk-gate.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Amarula Solutions
+ *
+ * Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+
+#include "clk.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#define to_clk_imx_gate(_hw) container_of(_hw, struct clk_imx_gate, hw)
+
+struct clk_imx_gate {
+	struct clk_hw hw;
+	struct imx_clk_reg reg;
+	u32 enable_mask;
+};
+
+static int imx_clk_gate_enable(struct clk_hw *hw)
+{
+	struct clk_imx_gate *gate = to_clk_imx_gate(hw);
+	struct imx_clk_reg *reg = &gate->reg;
+
+	return regmap_update_bits(reg->regmap, reg->offset, gate->enable_mask,
+				  gate->enable_mask);
+}
+
+static void imx_clk_gate_disable(struct clk_hw *hw)
+{
+	struct clk_imx_gate *gate = to_clk_imx_gate(hw);
+	struct imx_clk_reg *reg = &gate->reg;
+
+	regmap_update_bits(reg->regmap, reg->offset, gate->enable_mask, 0);
+}
+
+static int imx_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct clk_imx_gate *gate = to_clk_imx_gate(hw);
+	struct imx_clk_reg *reg = &gate->reg;
+	unsigned int val;
+
+	if (regmap_read(reg->regmap, reg->offset, &val))
+		return -EIO;
+
+	return !!(val & gate->enable_mask);
+}
+
+const struct clk_ops imx_clk_gate_ops = {
+	.enable	= &imx_clk_gate_enable,
+	.disable = &imx_clk_gate_disable,
+	.is_enabled = &imx_clk_gate_is_enabled,
+};
+
+static void imx_clk_hw_unregister_gate(struct clk_hw *hw)
+{
+	struct clk_imx_gate *gate = to_clk_imx_gate(hw);
+
+	clk_hw_unregister(hw);
+	kfree(gate);
+}
+
+static struct clk_hw *imx_clk_hw_register_gate(struct device_node *node,
+					       const char *name,
+					       unsigned long flags,
+					       struct imx_clk_reg *reg,
+					       u8 enable_bit)
+{
+	struct clk_parent_data pdata = { .index = 0 };
+	struct clk_init_data init = { NULL };
+	struct clk_imx_gate *gate;
+	struct clk_hw *hw;
+	int ret;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = flags;
+	init.ops = &imx_clk_gate_ops;
+	init.parent_data = &pdata;
+	init.num_parents = 1;
+
+	memcpy(&gate->reg, reg, sizeof(*reg));
+	gate->enable_mask = BIT(enable_bit);
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	ret = of_clk_hw_register(node, hw);
+	if (ret) {
+		kfree(gate);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+/**
+ * of_imx_gate_clk_setup() - Setup function for imx gate clock
+ * @node:	device node for the clock
+ */
+static void __init of_imx_gate_clk_setup(struct device_node *node)
+{
+	struct clk_hw *hw;
+	struct imx_clk_reg reg;
+	const char *name = node->name;
+	u8 enable_bit = 0;
+	u32 val;
+
+	reg.regmap = syscon_regmap_lookup_by_phandle(node, "fsl,anatop");
+	if (IS_ERR(reg.regmap)) {
+		pr_err("missing regmap for %pOFn\n", node);
+		return;
+	}
+
+	if (of_property_read_u32_index(node, "fsl,anatop", 1, &val)) {
+		pr_err("missing register offset for %pOFn\n", node);
+		return;
+	}
+
+	reg.offset = val;
+
+	if (!of_property_read_u32(node, "fsl,bit-shift", &val))
+		enable_bit = val;
+
+	if (of_clk_get_parent_count(node) != 1) {
+		pr_err("%pOFn must have 1 parent clock\n", node);
+		return;
+	}
+
+	of_property_read_string(node, "clock-output-names", &name);
+
+	hw = imx_clk_hw_register_gate(node, name, 0, &reg, enable_bit);
+	if (IS_ERR(hw))
+		return;
+
+	if (of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw)) {
+		imx_clk_hw_unregister_gate(hw);
+		return;
+	}
+
+	pr_debug("name: %s, offset: 0x%x, enable-bit: %d\n", name, reg.offset,
+		 enable_bit);
+}
+CLK_OF_DECLARE(fsl_imx8mn_gate_clk, "fsl,imx8mn-gate-clock",
+	       of_imx_gate_clk_setup);
-- 
2.32.0

