Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3F62968A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiKOK6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbiKOK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:57:54 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0683013D5E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:56:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j15so23608428wrq.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEZm7AO72PHR8XXAieuiGQq4vGYxo48R04rB6nNJWT4=;
        b=fJcHcyqOrrgOgwsSt2rCsZ/uwD3S/JL4d47KGHeh/Tf6mK9Vku8dZ/oXPmb0CQV71J
         P/s1aoBhCg2+b7c0tJIIg6yjtekcSENMpBdMa7u0QLrWoJ5Z7LeuFxaeC5Ho+z34MMmf
         gP3KVaSJePtzcW4nXsHWNIhsEd1Cl2J/HqN9nHxC9Tr29J/BWN15Gj0lqYGJ1EqmWoF3
         Th0R3cv0rglBYQ0SbQ8fWFTh0bkaU8d7P81eWas1KYEViDmobZWR0kMMAc8IDGcOhUlw
         Yf76wd8OZqbJZU4K0Bj5Y7/k/2x0bgW4EVD5s14hUlW3CKHzDos1A+sbmqn1fHios0lk
         EQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEZm7AO72PHR8XXAieuiGQq4vGYxo48R04rB6nNJWT4=;
        b=h76Xk07WzHxTxMEzaSC84nD+u0GGyW57Kt9V5oSJMwuqrMfgxkbaa0y8U4HGcczPur
         R+gbS4gNZPAj6eCJSbaoikiRc33M5P4+iI77ltvKlJYIHA6wM312XZvSGQM9xFuF9GdZ
         +ojsLaC8+vyfVS3oSX663cwFL6+O90064FD/FyLxNo3TtxkvslPqXeKuANsDX4lmrtYq
         Ge/RFsFvtHfUdLghJUjhoeFEgYOO+TTFtvkacFBEqSjyl57pL6cShpO7JOA4gTdpY1JC
         tPCrhNmVDhOCJOWnEZXxB56NlfTpE1V5KXvxcWaNhjnby+suJQEHB1uwq5mqemilk3UT
         1QJw==
X-Gm-Message-State: ANoB5pl2Ep7boby/PhW2oJ5C5ny341kHdgus5tNSif+/sqTRSxhOjrIB
        jNgqhjrCdzkj3RFRnLiDNG8OXqYQlu5cexaX
X-Google-Smtp-Source: AA0mqf7oQ489FlIYTfH3cZtinRIV71JUf+S41oATkJUojhgXTUN+VHbPv2Mnn1V6OHWujQnZGO4TkQ==
X-Received: by 2002:a5d:4290:0:b0:236:6e66:3447 with SMTP id k16-20020a5d4290000000b002366e663447mr10318548wrq.24.1668509764523;
        Tue, 15 Nov 2022 02:56:04 -0800 (PST)
Received: from localhost.localdomain ([185.201.60.217])
        by smtp.gmail.com with ESMTPSA id r18-20020adfe692000000b00238df11940fsm12185046wrm.16.2022.11.15.02.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:56:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: va-macro: add npl clk
Date:   Tue, 15 Nov 2022 10:55:41 +0000
Message-Id: <20221115105541.16322-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115105541.16322-1-srinivas.kandagatla@linaro.org>
References: <20221115105541.16322-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New versions of VA Macro has soundwire integrated, so handle the soundwire npl
clock correctly in the codec driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index b0b6cf29cba3..d59af6d69c34 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -205,6 +205,7 @@ struct va_macro {
 	int dec_mode[VA_MACRO_NUM_DECIMATORS];
 	struct regmap *regmap;
 	struct clk *mclk;
+	struct clk *npl;
 	struct clk *macro;
 	struct clk *dcodec;
 	struct clk *fsgen;
@@ -1332,6 +1333,9 @@ static int fsgen_gate_enable(struct clk_hw *hw)
 	struct regmap *regmap = va->regmap;
 	int ret;
 
+	if (va->has_swr_master)
+		clk_prepare_enable(va->mclk);
+
 	ret = va_macro_mclk_enable(va, true);
 	if (!va->has_swr_master)
 		return ret;
@@ -1358,6 +1362,8 @@ static void fsgen_gate_disable(struct clk_hw *hw)
 			   CDC_VA_SWR_CLK_EN_MASK, 0x0);
 
 	va_macro_mclk_enable(va, false);
+	if (va->has_swr_master)
+		clk_disable_unprepare(va->mclk);
 }
 
 static int fsgen_gate_is_enabled(struct clk_hw *hw)
@@ -1386,6 +1392,9 @@ static int va_macro_register_fsgen_output(struct va_macro *va)
 	struct clk_init_data init;
 	int ret;
 
+	if (va->has_swr_master)
+		parent = va->npl;
+
 	parent_clk_name = __clk_get_name(parent);
 
 	of_property_read_string(np, "clock-output-names", &clk_name);
@@ -1512,6 +1521,14 @@ static int va_macro_probe(struct platform_device *pdev)
 	/* mclk rate */
 	clk_set_rate(va->mclk, 2 * VA_MACRO_MCLK_FREQ);
 
+	if (va->has_swr_master) {
+		va->npl = devm_clk_get(dev, "npl");
+		if (IS_ERR(va->npl))
+			goto err;
+
+		clk_set_rate(va->npl, 2 * VA_MACRO_MCLK_FREQ);
+	}
+
 	ret = clk_prepare_enable(va->macro);
 	if (ret)
 		goto err;
@@ -1524,6 +1541,12 @@ static int va_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_mclk;
 
+	if (va->has_swr_master) {
+		ret = clk_prepare_enable(va->npl);
+		if (ret)
+			goto err_npl;
+	}
+
 	ret = va_macro_register_fsgen_output(va);
 	if (ret)
 		goto err_clkout;
@@ -1563,6 +1586,9 @@ static int va_macro_probe(struct platform_device *pdev)
 	return 0;
 
 err_clkout:
+	if (va->has_swr_master)
+		clk_disable_unprepare(va->npl);
+err_npl:
 	clk_disable_unprepare(va->mclk);
 err_mclk:
 	clk_disable_unprepare(va->dcodec);
@@ -1578,6 +1604,9 @@ static int va_macro_remove(struct platform_device *pdev)
 {
 	struct va_macro *va = dev_get_drvdata(&pdev->dev);
 
+	if (va->has_swr_master)
+		clk_disable_unprepare(va->npl);
+
 	clk_disable_unprepare(va->mclk);
 	clk_disable_unprepare(va->dcodec);
 	clk_disable_unprepare(va->macro);
@@ -1594,6 +1623,9 @@ static int __maybe_unused va_macro_runtime_suspend(struct device *dev)
 	regcache_cache_only(va->regmap, true);
 	regcache_mark_dirty(va->regmap);
 
+	if (va->has_swr_master)
+		clk_disable_unprepare(va->npl);
+
 	clk_disable_unprepare(va->mclk);
 
 	return 0;
@@ -1610,6 +1642,15 @@ static int __maybe_unused va_macro_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	if (va->has_swr_master) {
+		ret = clk_prepare_enable(va->npl);
+		if (ret) {
+			clk_disable_unprepare(va->mclk);
+			dev_err(va->dev, "unable to prepare npl\n");
+			return ret;
+		}
+	}
+
 	regcache_cache_only(va->regmap, false);
 	regcache_sync(va->regmap);
 
-- 
2.25.1

