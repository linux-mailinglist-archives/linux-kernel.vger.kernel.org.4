Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC363A869
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiK1M3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiK1M2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:28:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C5E13CE0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:28:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g12so16508832wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xygosbCHnQsBNz0zkpEMKgeiwbCZG6bDktVazwmdVk=;
        b=uIZfVnzl68JoKwLiA0nNSNWC93/N6sse7uiYBQpJ1tWT9ojxDWYOXIpvbaNCW8R/xZ
         xwUo1gavr+j43jOypy4Kos5fnC3j7eakNdsOVmULyAnk+p0wpU++BkbPOzg2VkCZskdA
         SJnRC9JJZUgvlNNG5NSOvQVsgWscEdRWJooAqeZ5PKjn5wXHWgr5QGZNHlzo7pG9ntBi
         llvV93e52b9rZa/Vfo/tu/SpHd8bHu4DhIe2gEhlOZ3I5hCM47R3IwORH86GB0wbVEOC
         DsKrO0/w+D3h3yi7dZOgVARoI8JxyUt7Hqj4iuFZA/GxJ754w0r/RQzoraCjZhovDehS
         wDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xygosbCHnQsBNz0zkpEMKgeiwbCZG6bDktVazwmdVk=;
        b=3OQfiuVsYqdOC1SCUO5kCxwVpqReHkM/2QPzsYReZcxDzoyLh/RtGn5kJmTdtBisj2
         Ly0Q8SMWBm+SZxQJCg3uNci3qfZwCGwOfG9W9p2UBPdTePEx9sMdJW1/2Y+jEkB5ggZH
         pQOF/wgbwFnmfloIE64AJRdZKKfi1FdwA6AAV9lzkGu3G5KofR9mJlk8OnXw/fI7Qw+r
         Q6vbWCeK7v8rYmz+UhXYFx/QmsbXx71mD9o+kzziCacgXmTZae9ttBezZCpF516+ALPt
         N2tpwTV4CX7IR/peQyCMIK7yh2tPd4ucIxKROvxzLHov8gAyEDc1GRyQ5L+6tm7MHge3
         D6xA==
X-Gm-Message-State: ANoB5plhGX0qhqkddWXFxtK67gMyYA7WWL15DlzxwBDIRojKmb0gqiMY
        KHVv9D15Gq8Sx7W6F/KVJUJs8g==
X-Google-Smtp-Source: AA0mqf5OhkpRiEc/JnAHgzIp7jQeEBdG9gDXUXbDy6oR4paMmPUGcPew2yDiZFF+MI6TtZ9WxpyyGg==
X-Received: by 2002:adf:a1c8:0:b0:236:72f1:f124 with SMTP id v8-20020adfa1c8000000b0023672f1f124mr30678066wrv.161.1669638523710;
        Mon, 28 Nov 2022 04:28:43 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b002421db5f279sm598405wrm.78.2022.11.28.04.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:28:43 -0800 (PST)
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
Subject: [PATCH v3 8/9] clk: qcom: rpmh: Add support for SM8550 rpmh clocks
Date:   Mon, 28 Nov 2022 14:28:19 +0200
Message-Id: <20221128122820.798610-9-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128122820.798610-1-abel.vesa@linaro.org>
References: <20221128122820.798610-1-abel.vesa@linaro.org>
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

Adds the RPMH clocks present in SM8550 SoC.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---

Changes since v2:
 * Added Konrad's R-b tag

 drivers/clk/qcom/clk-rpmh.c | 110 +++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 0471bab82464..3204df3fda86 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -132,6 +132,36 @@ static DEFINE_MUTEX(rpmh_clk_lock);
 		},							\
 	}
 
+#define DEFINE_CLK_RPMH_FIXED(_platform, _name, _name_active,	\
+				  _parent_name, _name_active_parent,	\
+				  _div)					\
+	static struct clk_fixed_factor _platform##_##_name = {		\
+		.mult = 1,						\
+		.div = _div,						\
+		.hw.init = &(struct clk_init_data){			\
+			.ops = &clk_fixed_factor_ops,			\
+			.name = #_name,					\
+			.parent_data =  &(const struct clk_parent_data){ \
+					.fw_name = #_parent_name,	\
+					.name = #_parent_name,		\
+			},						\
+			.num_parents = 1,				\
+		},							\
+	};								\
+	static struct clk_fixed_factor _platform##_##_name_active = {	\
+		.mult = 1,						\
+		.div = _div,						\
+		.hw.init = &(struct clk_init_data){			\
+			.ops = &clk_fixed_factor_ops,			\
+			.name = #_name_active,				\
+			.parent_data =  &(const struct clk_parent_data){ \
+					.fw_name = #_name_active_parent,\
+					.name = #_name_active_parent,	\
+			},						\
+			.num_parents = 1,				\
+		},							\
+	}
+
 static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
 {
 	return container_of(_hw, struct clk_rpmh, hw);
@@ -579,6 +609,43 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
 	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
 };
 
+DEFINE_CLK_RPMH_ARC(sm8550, xo_pad, xo_pad_ao, "xo.lvl", 0x03, 2);
+DEFINE_CLK_RPMH_FIXED(sm8550, bi_tcxo, bi_tcxo_ao, xo_pad, xo_pad_ao, 2);
+DEFINE_CLK_RPMH_VRM(sm8550, rf_clk1, rf_clk1_ao, "clka1", 1);
+DEFINE_CLK_RPMH_VRM(sm8550, rf_clk2, rf_clk2_ao, "clka2", 1);
+DEFINE_CLK_RPMH_VRM(sm8550, rf_clk3, rf_clk3_ao, "clka3", 1);
+DEFINE_CLK_RPMH_VRM(sm8550, rf_clk4, rf_clk4_ao, "clka4", 1);
+DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk1, ln_bb_clk1_ao, "clka6", 2);
+DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk2, ln_bb_clk2_ao, "clka7", 2);
+DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk3, ln_bb_clk3_ao, "clka8", 2);
+
+static struct clk_hw *sm8550_rpmh_clocks[] = {
+	[RPMH_CXO_PAD_CLK]      = &sm8550_xo_pad.hw,
+	[RPMH_CXO_PAD_CLK_A]    = &sm8550_xo_pad_ao.hw,
+	[RPMH_CXO_CLK]		= &sm8550_bi_tcxo.hw,
+	[RPMH_CXO_CLK_A]	= &sm8550_bi_tcxo_ao.hw,
+	[RPMH_LN_BB_CLK1]	= &sm8550_ln_bb_clk1.hw,
+	[RPMH_LN_BB_CLK1_A]	= &sm8550_ln_bb_clk1_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &sm8550_ln_bb_clk2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &sm8550_ln_bb_clk2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &sm8550_ln_bb_clk3.hw,
+	[RPMH_LN_BB_CLK3_A]	= &sm8550_ln_bb_clk3_ao.hw,
+	[RPMH_RF_CLK1]		= &sm8550_rf_clk1.hw,
+	[RPMH_RF_CLK1_A]	= &sm8550_rf_clk1_ao.hw,
+	[RPMH_RF_CLK2]		= &sm8550_rf_clk2.hw,
+	[RPMH_RF_CLK2_A]	= &sm8550_rf_clk2_ao.hw,
+	[RPMH_RF_CLK3]		= &sm8550_rf_clk3.hw,
+	[RPMH_RF_CLK3_A]	= &sm8550_rf_clk3_ao.hw,
+	[RPMH_RF_CLK4]		= &sm8550_rf_clk4.hw,
+	[RPMH_RF_CLK4_A]	= &sm8550_rf_clk4_ao.hw,
+	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
+	.clks = sm8550_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
+};
+
 static struct clk_hw *sc7280_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]      = &sc7280_bi_tcxo.hw,
 	[RPMH_CXO_CLK_A]    = &sc7280_bi_tcxo_ao.hw,
@@ -682,29 +749,31 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 
 		name = hw_clks[i]->init->name;
 
-		rpmh_clk = to_clk_rpmh(hw_clks[i]);
-		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
-		if (!res_addr) {
-			dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
-				rpmh_clk->res_name);
-			return -ENODEV;
-		}
+		if (hw_clks[i]->init->ops != &clk_fixed_factor_ops) {
+			rpmh_clk = to_clk_rpmh(hw_clks[i]);
+			res_addr = cmd_db_read_addr(rpmh_clk->res_name);
+			if (!res_addr) {
+				dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
+					rpmh_clk->res_name);
+				return -ENODEV;
+			}
 
-		data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
-		if (IS_ERR(data)) {
-			ret = PTR_ERR(data);
-			dev_err(&pdev->dev,
-				"error reading RPMh aux data for %s (%d)\n",
-				rpmh_clk->res_name, ret);
-			return ret;
-		}
+			data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
+			if (IS_ERR(data)) {
+				ret = PTR_ERR(data);
+				dev_err(&pdev->dev,
+					"error reading RPMh aux data for %s (%d)\n",
+					rpmh_clk->res_name, ret);
+				return ret;
+			}
 
-		/* Convert unit from Khz to Hz */
-		if (aux_data_len == sizeof(*data))
-			rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
+			/* Convert unit from Khz to Hz */
+			if (aux_data_len == sizeof(*data))
+				rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
 
-		rpmh_clk->res_addr += res_addr;
-		rpmh_clk->dev = &pdev->dev;
+			rpmh_clk->res_addr += res_addr;
+			rpmh_clk->dev = &pdev->dev;
+		}
 
 		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
 		if (ret) {
@@ -739,6 +808,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
 	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
 	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
+	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
 	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
 	{ }
 };
-- 
2.34.1

