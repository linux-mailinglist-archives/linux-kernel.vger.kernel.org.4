Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75836E3AA4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDPRfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDPRe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:34:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24826B2;
        Sun, 16 Apr 2023 10:34:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so747718b3a.2;
        Sun, 16 Apr 2023 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681666478; x=1684258478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxfOnlh1gWPz4ECc5+gyXwuy61sNCNvLdcJJf29rWhA=;
        b=hPd8h+vf5YhJGTgRERaLgALldhgleev+V0wqIC4AzrE8ng92mX9Nhi98I3AzaYNiz6
         jR8I62aILyO6oIAaxofOc0JbJC2WqXRXuQPD3Q1cgGY1I9JCxBz+RYK7bn3862a1nINC
         kTkqgnIyN9jv1xzBR+mKuzmB3YT70V7nytrgRUd8CpI8wHusTu31FZbUDiT1y+dZNVPO
         y8UgYR2t8D5vXE+5FlzZmBe8N4bxLmVdSTk3uO3cK8V++7Wi6zVdvgeBVV/LONAAUTPK
         FQhrl7OXgNSq9au67KH6e4xeyV7S6GJLp2NswMtfSd8wlYPT31S9UsjU+95OpixHFK88
         vOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681666478; x=1684258478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxfOnlh1gWPz4ECc5+gyXwuy61sNCNvLdcJJf29rWhA=;
        b=f1dAfj8392xlmavW3p0FM6iGJw/a5HMnVhucWPHKjaE7q89TfgUsMqKnVZ+WL2eu9t
         Q6ftQjuZXguVrfP+9Fj/v8DY/SurKTfW8mNGhl5NyCpxTDsd4vzV4BXd+xz6t3DBbyTz
         7bEt7uNPTs69WZQqq4ShUcSab4a71aa2BfZNKLXVkCjctc3BS3zUJynM3CKEI6jjLsDt
         wiUPHnn/W5yC6EIytVdGluSxY4B+nBDs/X5xkUX7Zvygta8bWLYrTAClgTzsYX6J33a/
         e8TkwyEZxnV5a/5r8nw7+VYZFXmXvXzv1APzoj6dXZOlDjanZgN/f2LCEq/7FypD9pBZ
         9Rnw==
X-Gm-Message-State: AAQBX9d/H2YcmQybfG2Y+ep1lAZpqDionyx/rgoe14Hb8Hz3yycoy9xx
        dU7HfVh6rt7YKkvMyIOzZxScsVJn/1aO9j+pH/M=
X-Google-Smtp-Source: AKy350YMmfJDtdMdCjBQlAMr3FKj0gbXI5/S7pqfHG2aKD6WhYFY+hKx1QoKx7o6B6c9hSxvbJuUzQ==
X-Received: by 2002:a05:6a00:890:b0:63a:fae3:9890 with SMTP id q16-20020a056a00089000b0063afae39890mr17928494pfj.24.1681666477842;
        Sun, 16 Apr 2023 10:34:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.200])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b0062d90f36d16sm6110973pff.88.2023.04.16.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:34:37 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] clk: gate: Add DT binding
Date:   Mon, 17 Apr 2023 01:33:02 +0800
Message-Id: <20230416173302.1185683-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416173302.1185683-1-mmyangfl@gmail.com>
References: <20230416173302.1185683-1-mmyangfl@gmail.com>
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

Add DT binding for gate clock as "gate-clock".

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/clk-gate.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 64283807600b..a70df4a2a9a7 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -12,8 +12,11 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/platform_device.h>
 #include <linux/string.h>
 
+#include "clk-of.h"
+
 /**
  * DOC: basic gatable clock which can gate and ungate it's ouput
  *
@@ -257,3 +260,81 @@ struct clk_hw *__devm_clk_hw_register_gate(struct device *dev,
 	return hw;
 }
 EXPORT_SYMBOL_GPL(__devm_clk_hw_register_gate);
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_clk_flag of_clk_gate_flags[] = {
+	{ "set-to-disable", CLK_GATE_SET_TO_DISABLE },
+	{ "hiword-mask", CLK_GATE_HIWORD_MASK },
+	{ "big-endian", CLK_GATE_BIG_ENDIAN },
+	{ }
+};
+
+static int of_clk_gate_setup(struct device_node *np)
+{
+	struct of_clk_ctrl *ctrl = np->parent->data;
+	const char *name;
+	void __iomem *reg;
+	u32 bit_idx;
+
+	const char *property;
+	struct clk_hw *hw;
+	int ret;
+
+	reg = of_clk_get_reg(np);
+	if (!reg)
+		return -ENOMEM;
+	name = of_clk_get_name(np);
+	if (!name)
+		return -EINVAL;
+
+	property = "bits";
+	if (of_property_read_u32(np, property, &bit_idx))
+		goto err_property;
+
+	hw = __clk_hw_register_gate(NULL, np, name,
+				    of_clk_get_parent_name(np, 0),
+				    NULL, NULL, of_clk_get_flags(np, NULL),
+				    reg, bit_idx,
+				    of_clk_get_flags(np, of_clk_gate_flags),
+				    &ctrl->lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	if (ret)
+		goto err_register;
+
+	np->data = hw;
+	return 0;
+
+err_register:
+	clk_hw_unregister(hw);
+	return ret;
+
+err_property:
+	pr_err("%s: clock %s missing required property \"%s\"\n",
+	       __func__, name, property);
+	return -EINVAL;
+}
+
+static void __init of_clk_gate_init(struct device_node *np)
+{
+	of_clk_gate_setup(np);
+}
+CLK_OF_DECLARE(of_clk_gate, "gate-clock", of_clk_gate_init);
+
+static const struct of_device_id of_clk_gate_ids[] = {
+	{ .compatible = "gate-clock", .data = of_clk_gate_setup },
+	{ }
+};
+
+static struct platform_driver of_clk_gate_driver = {
+	.driver = {
+		.name = "clk_gate",
+		.of_match_table = of_clk_gate_ids,
+	},
+	.probe = of_clk_probe,
+	.remove = of_clk_remove,
+};
+builtin_platform_driver(of_clk_gate_driver);
+#endif
-- 
2.39.2

