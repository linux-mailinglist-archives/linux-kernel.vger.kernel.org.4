Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9B0622116
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiKIA5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiKIA4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:56:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8423164A3C;
        Tue,  8 Nov 2022 16:56:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk15so23480687wrb.13;
        Tue, 08 Nov 2022 16:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLJFXJ9wFjgZ8dt+15qgCZ9/qEqxsRiMINkokB1vgY4=;
        b=Uj2AXKFi2QKTH3RBZi4y2QP/H5if/0EtVJVe+dtsMVRg8LwRRyXAsNfLgrmhXD58xC
         CkBn9uUlMJs7eXlpxWsaV7/x4btzJc178OMxG6vLetQfGAeToc52xe3Tj/lq6/dctEyf
         kPzbHKkIE98ENHGeWAQInqoBgDmjaiwNKUYaYjy8ZxZ8+Vk0XkBHetKt5RsN+rZrrQqM
         DXRK2cui25wUZ/TIkVsJhiKlcbDLYoHb7KOUIMJQnYVgxtD6KN9t1A53RKID0wY4CEbY
         JMe4r/w+n4+gn5woZq9xWb0R1It+DhmNFPUVVLRXjqlKPI+mRMz6nUtILWuJvicIlszc
         EWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLJFXJ9wFjgZ8dt+15qgCZ9/qEqxsRiMINkokB1vgY4=;
        b=7UwZcOHeyEsILCe/pQMOHPdd9A2hzvsSTXiAyyolS8gL4K8lYavqTNU+H2n0tQvI/I
         waOR2JVIxVD9Smubx8CQaaowjTiF0I/z0LetAG2+A/KolJf15rYoAKAuwidIfsdNQT6N
         fHfFjHNUDj6HEMcY04kdq/tg72qgUVIckagQC/qyPLRRoNeWrziZXejQCxLr1j0wnPzJ
         CYJdrOExsyIFzmgYnlBlyYxJnZMYeJ+wZ8JoxJI7NSuby9g7FJOLjj8pK2ittOuGVh3U
         wRYEO5g84bs/6fxjTwwsKeTmZ/6IPuS8Y09t7uxqS7lYDgN3SCTaHMAYp4AefOPCfDqi
         g3Yw==
X-Gm-Message-State: ACrzQf0sPSWlrI2X7bsQKj+5NtMS15XS2zlPVk7QtgxjzXpaDKlYQee1
        kf/athCuDhMJf8CDPXySe/M=
X-Google-Smtp-Source: AMsMyM5q5r/doQfTmMv/40UtV3PqgvOp6Vqi2ietmfoA6VqtpYth5dcpMQcnNJKTh9AHkiwrbEwOTg==
X-Received: by 2002:adf:dd4d:0:b0:236:6e72:be17 with SMTP id u13-20020adfdd4d000000b002366e72be17mr35459956wrm.460.1667955400749;
        Tue, 08 Nov 2022 16:56:40 -0800 (PST)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id z14-20020adff74e000000b0022cdb687bf9sm14130285wrp.0.2022.11.08.16.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:56:40 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 5/5] clk: qcom: krait-cc: convert to parent_data API
Date:   Wed,  9 Nov 2022 01:56:31 +0100
Message-Id: <20221109005631.3189-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221109005631.3189-1-ansuelsmth@gmail.com>
References: <20221109005631.3189-1-ansuelsmth@gmail.com>
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

Modernize the krait-cc driver to parent-data API and refactor to drop
any use of parent_names. From Documentation all the required clocks should
be declared in DTS so fw_name can be correctly used to get the parents
for all the muxes. .name is also declared to save compatibility with old
DT.

While at it also drop some hardcoded index and introduce an enum to make
index values more clear.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 202 ++++++++++++++++++++----------------
 1 file changed, 112 insertions(+), 90 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 63322cb38aa8..0a15da568156 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -15,6 +15,16 @@
 
 #include "clk-krait.h"
 
+enum {
+	cpu0_mux = 0,
+	cpu1_mux,
+	cpu2_mux,
+	cpu3_mux,
+	l2_mux,
+
+	clks_max,
+};
+
 static unsigned int sec_mux_map[] = {
 	2,
 	0,
@@ -69,21 +79,23 @@ static int krait_notifier_register(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static int
+static struct clk_hw *
 krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 {
 	struct krait_div2_clk *div;
+	static struct clk_parent_data p_data[1];
 	struct clk_init_data init = {
-		.num_parents = 1,
+		.num_parents = ARRAY_SIZE(p_data),
 		.ops = &krait_div2_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
-	const char *p_names[1];
+	struct clk_hw *clk;
+	char *parent_name;
 	int cpu, ret;
 
 	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
 	if (!div)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	div->width = 2;
 	div->shift = 6;
@@ -93,18 +105,25 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 
 	init.name = kasprintf(GFP_KERNEL, "hfpll%s_div", s);
 	if (!init.name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	init.parent_names = p_names;
-	p_names[0] = kasprintf(GFP_KERNEL, "hfpll%s", s);
-	if (!p_names[0]) {
-		kfree(init.name);
-		return -ENOMEM;
+	init.parent_data = p_data;
+	parent_name = kasprintf(GFP_KERNEL, "hfpll%s", s);
+	if (!parent_name) {
+		clk = ERR_PTR(-ENOMEM);
+		goto err_parent_name;
 	}
 
+	p_data[0].fw_name = parent_name;
+	p_data[0].name = parent_name;
+
 	ret = devm_clk_hw_register(dev, &div->hw);
-	if (ret)
-		goto err;
+	if (ret) {
+		clk = ERR_PTR(ret);
+		goto err_clk;
+	}
+
+	clk = &div->hw;
 
 	/* clk-krait ignore any rate change if mux is not flagged as enabled */
 	if (id < 0)
@@ -113,33 +132,36 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 	else
 		clk_prepare_enable(div->hw.clk);
 
-err:
-	kfree(p_names[0]);
+err_clk:
+	kfree(parent_name);
+err_parent_name:
 	kfree(init.name);
 
-	return ret;
+	return clk;
 }
 
-static int
+static struct clk_hw *
 krait_add_sec_mux(struct device *dev, int id, const char *s,
 		  unsigned int offset, bool unique_aux)
 {
 	int cpu, ret;
 	struct krait_mux_clk *mux;
-	static const char *sec_mux_list[] = {
-		"qsb",
-		"acpu_aux",
+	static struct clk_parent_data sec_mux_list[2] = {
+		{ .name = "qsb", .fw_name = "qsb" },
+		{},
 	};
 	struct clk_init_data init = {
-		.parent_names = sec_mux_list,
+		.parent_data = sec_mux_list,
 		.num_parents = ARRAY_SIZE(sec_mux_list),
 		.ops = &krait_mux_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
+	struct clk_hw *clk;
+	char *parent_name;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	mux->offset = offset;
 	mux->lpl = id >= 0;
@@ -159,23 +181,33 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	if (unique_aux) {
-		sec_mux_list[0] = kasprintf(GFP_KERNEL, "acpu%s_aux", s);
-		if (!sec_mux_list[0]) {
-			ret = -ENOMEM;
+		parent_name = kasprintf(GFP_KERNEL, "acpu%s_aux", s);
+		if (!parent_name) {
+			clk = ERR_PTR(-ENOMEM);
 			goto err_aux;
 		}
+		sec_mux_list[1].fw_name = parent_name;
+		sec_mux_list[1].name = parent_name;
+	} else {
+		sec_mux_list[1].name = "apu_aux";
 	}
 
 	ret = devm_clk_hw_register(dev, &mux->hw);
-	if (ret)
-		goto unique_aux;
+	if (ret) {
+		clk = ERR_PTR(ret);
+		goto err_clk;
+	}
+
+	clk = &mux->hw;
 
 	ret = krait_notifier_register(dev, mux->hw.clk, mux);
-	if (ret)
-		goto unique_aux;
+	if (ret) {
+		clk = ERR_PTR(ret);
+		goto err_clk;
+	}
 
 	/* clk-krait ignore any rate change if mux is not flagged as enabled */
 	if (id < 0)
@@ -184,28 +216,29 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	else
 		clk_prepare_enable(mux->hw.clk);
 
-unique_aux:
+err_clk:
 	if (unique_aux)
-		kfree(sec_mux_list[0]);
+		kfree(parent_name);
 err_aux:
 	kfree(init.name);
-	return ret;
+	return clk;
 }
 
-static struct clk *
-krait_add_pri_mux(struct device *dev, int id, const char *s,
-		  unsigned int offset)
+static struct clk_hw *
+krait_add_pri_mux(struct device *dev, struct clk_hw *hfpll_div, struct clk_hw *sec_mux,
+		  int id, const char *s, unsigned int offset)
 {
 	int ret;
 	struct krait_mux_clk *mux;
-	const char *p_names[3];
+	static struct clk_parent_data p_data[3];
 	struct clk_init_data init = {
-		.parent_names = p_names,
-		.num_parents = ARRAY_SIZE(p_names),
+		.parent_data = p_data,
+		.num_parents = ARRAY_SIZE(p_data),
 		.ops = &krait_mux_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
-	struct clk *clk;
+	struct clk_hw *clk;
+	char *hfpll_name;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -223,55 +256,44 @@ krait_add_pri_mux(struct device *dev, int id, const char *s,
 	if (!init.name)
 		return ERR_PTR(-ENOMEM);
 
-	p_names[0] = kasprintf(GFP_KERNEL, "hfpll%s", s);
-	if (!p_names[0]) {
+	hfpll_name = kasprintf(GFP_KERNEL, "hfpll%s", s);
+	if (!hfpll_name) {
 		clk = ERR_PTR(-ENOMEM);
-		goto err_p0;
+		goto err_hfpll;
 	}
 
-	p_names[1] = kasprintf(GFP_KERNEL, "hfpll%s_div", s);
-	if (!p_names[1]) {
-		clk = ERR_PTR(-ENOMEM);
-		goto err_p1;
-	}
+	p_data[0].fw_name = hfpll_name;
+	p_data[0].name = hfpll_name;
 
-	p_names[2] = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
-	if (!p_names[2]) {
-		clk = ERR_PTR(-ENOMEM);
-		goto err_p2;
-	}
+	p_data[1].hw = hfpll_div;
+	p_data[2].hw = sec_mux;
 
 	ret = devm_clk_hw_register(dev, &mux->hw);
 	if (ret) {
 		clk = ERR_PTR(ret);
-		goto err_p3;
+		goto err_clk;
 	}
 
-	clk = mux->hw.clk;
+	clk = &mux->hw;
 
-	ret = krait_notifier_register(dev, clk, mux);
+	ret = krait_notifier_register(dev, mux->hw.clk, mux);
 	if (ret)
 		clk = ERR_PTR(ret);
 
-err_p3:
-	kfree(p_names[2]);
-err_p2:
-	kfree(p_names[1]);
-err_p1:
-	kfree(p_names[0]);
-err_p0:
+err_clk:
+	kfree(hfpll_name);
+err_hfpll:
 	kfree(init.name);
 	return clk;
 }
 
 /* id < 0 for L2, otherwise id == physical CPU number */
-static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
+static struct clk_hw *krait_add_clks(struct device *dev, int id, bool unique_aux)
 {
-	int ret;
+	struct clk_hw *hfpll_div, *sec_mux, *pri_mux;
 	unsigned int offset;
 	void *p = NULL;
 	const char *s;
-	struct clk *clk;
 
 	if (id >= 0) {
 		offset = 0x4501 + (0x1000 * id);
@@ -283,22 +305,23 @@ static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
 		s = "_l2";
 	}
 
-	ret = krait_add_div(dev, id, s, offset);
-	if (ret) {
-		clk = ERR_PTR(ret);
+	hfpll_div = krait_add_div(dev, id, s, offset);
+	if (IS_ERR(hfpll_div)) {
+		pri_mux = hfpll_div;
 		goto err;
 	}
 
-	ret = krait_add_sec_mux(dev, id, s, offset, unique_aux);
-	if (ret) {
-		clk = ERR_PTR(ret);
+	sec_mux = krait_add_sec_mux(dev, id, s, offset, unique_aux);
+	if (IS_ERR(sec_mux)) {
+		pri_mux = sec_mux;
 		goto err;
 	}
 
-	clk = krait_add_pri_mux(dev, id, s, offset);
+	pri_mux = krait_add_pri_mux(dev, hfpll_div, sec_mux, id, s, offset);
+
 err:
 	kfree(p);
-	return clk;
+	return pri_mux;
 }
 
 static struct clk *krait_of_get(struct of_phandle_args *clkspec, void *data)
@@ -306,7 +329,7 @@ static struct clk *krait_of_get(struct of_phandle_args *clkspec, void *data)
 	unsigned int idx = clkspec->args[0];
 	struct clk **clks = data;
 
-	if (idx >= 5) {
+	if (idx >= clks_max) {
 		pr_err("%s: invalid clock index %d\n", __func__, idx);
 		return ERR_PTR(-EINVAL);
 	}
@@ -327,9 +350,8 @@ static int krait_cc_probe(struct platform_device *pdev)
 	const struct of_device_id *id;
 	unsigned long cur_rate, aux_rate;
 	int cpu;
-	struct clk *clk;
-	struct clk **clks;
-	struct clk *l2_pri_mux_clk;
+	struct clk_hw *mux, *l2_pri_mux;
+	struct clk *clk, **clks;
 
 	id = of_match_device(krait_cc_match_table, dev);
 	if (!id)
@@ -348,21 +370,21 @@ static int krait_cc_probe(struct platform_device *pdev)
 	}
 
 	/* Krait configurations have at most 4 CPUs and one L2 */
-	clks = devm_kcalloc(dev, 5, sizeof(*clks), GFP_KERNEL);
+	clks = devm_kcalloc(dev, clks_max, sizeof(*clks), GFP_KERNEL);
 	if (!clks)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
-		clk = krait_add_clks(dev, cpu, id->data);
+		mux = krait_add_clks(dev, cpu, id->data);
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
-		clks[cpu] = clk;
+		clks[cpu] = mux->clk;
 	}
 
-	l2_pri_mux_clk = krait_add_clks(dev, -1, id->data);
-	if (IS_ERR(l2_pri_mux_clk))
-		return PTR_ERR(l2_pri_mux_clk);
-	clks[4] = l2_pri_mux_clk;
+	l2_pri_mux = krait_add_clks(dev, -1, id->data);
+	if (IS_ERR(l2_pri_mux))
+		return PTR_ERR(l2_pri_mux);
+	clks[l2_mux] = l2_pri_mux->clk;
 
 	/*
 	 * We don't want the CPU or L2 clocks to be turned off at late init
@@ -372,7 +394,7 @@ static int krait_cc_probe(struct platform_device *pdev)
 	 * they take over.
 	 */
 	for_each_online_cpu(cpu) {
-		clk_prepare_enable(l2_pri_mux_clk);
+		clk_prepare_enable(clks[l2_mux]);
 		WARN(clk_prepare_enable(clks[cpu]),
 		     "Unable to turn on CPU%d clock", cpu);
 	}
@@ -388,16 +410,16 @@ static int krait_cc_probe(struct platform_device *pdev)
 	 * two different rates to force a HFPLL reinit under all
 	 * circumstances.
 	 */
-	cur_rate = clk_get_rate(l2_pri_mux_clk);
+	cur_rate = clk_get_rate(clks[l2_mux]);
 	aux_rate = 384000000;
 	if (cur_rate < aux_rate) {
 		pr_info("L2 @ Undefined rate. Forcing new rate.\n");
 		cur_rate = aux_rate;
 	}
-	clk_set_rate(l2_pri_mux_clk, aux_rate);
-	clk_set_rate(l2_pri_mux_clk, 2);
-	clk_set_rate(l2_pri_mux_clk, cur_rate);
-	pr_info("L2 @ %lu KHz\n", clk_get_rate(l2_pri_mux_clk) / 1000);
+	clk_set_rate(clks[l2_mux], aux_rate);
+	clk_set_rate(clks[l2_mux], 2);
+	clk_set_rate(clks[l2_mux], cur_rate);
+	pr_info("L2 @ %lu KHz\n", clk_get_rate(clks[l2_mux]) / 1000);
 	for_each_possible_cpu(cpu) {
 		clk = clks[cpu];
 		cur_rate = clk_get_rate(clk);
-- 
2.37.2

