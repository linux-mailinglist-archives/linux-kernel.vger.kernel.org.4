Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6963D49E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiK3LaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiK3L3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:29:47 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966AC1C93D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:28 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id o13so2103781ejm.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDlfvZiCltaFwWrxIrbNKlhGCQpfErljR0Lh1JgpyPI=;
        b=agqc9Yr77sGb+cXNvT67wBV2QrwQ1szefEVCeSiVF/tiLlaMx3S154ISDUVsE/b3Eg
         QeEevrDtWTfr8FlFRx6pwinKNcpSLkUR5gIxGFz4d+UPT4GZQDww8ewtgqtq3abeQ2eT
         CMZ3A+KUnOcpBHh7DqKqtF9gBBo16MFvcxUEziY9hur0aovU1DnCNY2clS5AS8lN1Oc0
         OPq6pjLK3kJRWXl18VCGX4nIiCkW0v8+NiQfuupGQUw2erg0Wlq5V5dnnHOf5GGe4rwQ
         KQU4sLgzh6EpYpwicpDAQvYbhDwBGv9g893aNz8yharXzp+5t56iXVCw66+vX5cTvfg7
         A+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDlfvZiCltaFwWrxIrbNKlhGCQpfErljR0Lh1JgpyPI=;
        b=2L+b76pKKdZ2EukKX2icu+oL8bzrYI7f7AJFeCvpmtPtMbyC8BjegnC9sHZoRREYP1
         JxPk5OrJPodC0w2kCOqMrkRr4De6rnk7LKOqJFTOZTmGdet+fMYD0+tG9OztQ2iqy1WR
         qGYwpjBeoj9KAc2yqpdw4xdLPlrurxyDu0KkbIbk23Hjnwj74GzqqsNfWzV2eCH1I6v/
         ZqFraybAklTZfTUfCtNXu3z1DrK1RYZ17uNYB9jz4N5zllFNwLRFznt8ddj0GWgnqDoh
         eJWnDcbJ+vuYnQAtoRxjr1kBXnYzC1SKdgOw4sYqnyDXscQeX4vHipDsqO0hcvDjEPx0
         8YJA==
X-Gm-Message-State: ANoB5pl93wJzwfREwZ02HHhlhukIna1mZfjbhqw54ggoxKMBtHM934MA
        HUX2/C1Tkuc/aPBuby1uRXp43g==
X-Google-Smtp-Source: AA0mqf48KmpnhmwQReTdiO/3TkfX42KLxkoyrr7xr2FdQAQnxDaBKMoTMgohgRtrPYUVr247XCMhPg==
X-Received: by 2002:a17:906:a0d7:b0:7b2:7af0:c231 with SMTP id bh23-20020a170906a0d700b007b27af0c231mr9853452ejb.240.1669807768058;
        Wed, 30 Nov 2022 03:29:28 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b007c073be0127sm521593ejf.202.2022.11.30.03.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 03:29:27 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v4 9/9] clk: qcom: Add TCSR clock driver for SM8550
Date:   Wed, 30 Nov 2022 13:28:52 +0200
Message-Id: <20221130112852.2977816-10-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130112852.2977816-1-abel.vesa@linaro.org>
References: <20221130112852.2977816-1-abel.vesa@linaro.org>
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

The TCSR clock controller found on SM8550 provides refclks
for PCIE, USB and UFS. Add clock driver for it.

This patch is based on initial code downstream.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/Kconfig         |   7 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/tcsrcc-sm8550.c | 193 +++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/clk/qcom/tcsrcc-sm8550.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index e2cfa9c74bcf..67ce8c4d3ff9 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -779,6 +779,13 @@ config SM_GPUCC_8350
 	  Say Y if you want to support graphics controller devices and
 	  functionality such as 3D graphics.
 
+config SM_TCSRCC_8550
+	tristate "SM8550 TCSR Clock Controller"
+	select QCOM_GDSC
+	help
+	  Support for the TCSR clock controller on SM8550 devices.
+	  Say Y if you want to use peripheral devices such as SD/UFS.
+
 config SM_VIDEOCC_8150
 	tristate "SM8150 Video Clock Controller"
 	select SM_GCC_8150
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 06ae671bdea6..29469f1290e6 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
 obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
 obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
 obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
+obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
 obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
 obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
diff --git a/drivers/clk/qcom/tcsrcc-sm8550.c b/drivers/clk/qcom/tcsrcc-sm8550.c
new file mode 100644
index 000000000000..a1395d01a536
--- /dev/null
+++ b/drivers/clk/qcom/tcsrcc-sm8550.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm8550-tcsrcc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-pll.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "common.h"
+#include "reset.h"
+
+enum {
+	DT_BI_TCXO,
+	DT_BI_TCXO_PAD,
+};
+
+static struct clk_branch tcsr_pcie_0_clkref_en = {
+	.halt_reg = 0x15100,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15100,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_0_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_1_clkref_en = {
+	.halt_reg = 0x15114,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15114,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_1_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_ufs_clkref_en = {
+	.halt_reg = 0x15110,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15110,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_ufs_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_ufs_pad_clkref_en = {
+	.halt_reg = 0x15104,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15104,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_ufs_pad_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb2_clkref_en = {
+	.halt_reg = 0x15118,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15118,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb2_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb3_clkref_en = {
+	.halt_reg = 0x15108,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x15108,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb3_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *tcsr_cc_sm8550_clocks[] = {
+	[TCSR_PCIE_0_CLKREF_EN] = &tcsr_pcie_0_clkref_en.clkr,
+	[TCSR_PCIE_1_CLKREF_EN] = &tcsr_pcie_1_clkref_en.clkr,
+	[TCSR_UFS_CLKREF_EN] = &tcsr_ufs_clkref_en.clkr,
+	[TCSR_UFS_PAD_CLKREF_EN] = &tcsr_ufs_pad_clkref_en.clkr,
+	[TCSR_USB2_CLKREF_EN] = &tcsr_usb2_clkref_en.clkr,
+	[TCSR_USB3_CLKREF_EN] = &tcsr_usb3_clkref_en.clkr,
+};
+
+static const struct regmap_config tcsr_cc_sm8550_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2f000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc tcsr_cc_sm8550_desc = {
+	.config = &tcsr_cc_sm8550_regmap_config,
+	.clks = tcsr_cc_sm8550_clocks,
+	.num_clks = ARRAY_SIZE(tcsr_cc_sm8550_clocks),
+};
+
+static const struct of_device_id tcsr_cc_sm8550_match_table[] = {
+	{ .compatible = "qcom,sm8550-tcsrcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tcsr_cc_sm8550_match_table);
+
+static int tcsr_cc_sm8550_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &tcsr_cc_sm8550_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return qcom_cc_really_probe(pdev, &tcsr_cc_sm8550_desc, regmap);
+}
+
+static struct platform_driver tcsr_cc_sm8550_driver = {
+	.probe = tcsr_cc_sm8550_probe,
+	.driver = {
+		.name = "tcsr_cc-sm8550",
+		.of_match_table = tcsr_cc_sm8550_match_table,
+	},
+};
+
+static int __init tcsr_cc_sm8550_init(void)
+{
+	return platform_driver_register(&tcsr_cc_sm8550_driver);
+}
+subsys_initcall(tcsr_cc_sm8550_init);
+
+static void __exit tcsr_cc_sm8550_exit(void)
+{
+	platform_driver_unregister(&tcsr_cc_sm8550_driver);
+}
+module_exit(tcsr_cc_sm8550_exit);
+
+MODULE_DESCRIPTION("QTI TCSRCC SM8550 Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

