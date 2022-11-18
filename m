Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12B962EE2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbiKRHTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240943AbiKRHS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:18:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835F87343E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:18:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w14so7891343wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5HJML9y11R46OtDRqClWdXS2bPj3NqH8YWdkAW2AqU=;
        b=vehHn/Vw/9TXfh7L4TosD4ihMHZH/NB/MEGLeKv62iak0qOdKU9xf9JojCGVMUgXhZ
         VaXjZagbTPvMnAaqbyUviDH3MluJCiHdlHPwJzC5WvFE/cFfwZI48OfJVeS4KdtauJEC
         DV4z59mH2o+iLxLS+5KuMFoCZYNFZXD58fbQWghJJQbwnhfVNbuZwMvjx64mh18wo8kC
         a2tOSTlTYgKl3DQIwPP1Ziwr90kcMPXRaHLERlfVVwhWoUWvp7xbck9E+cugx0gVrmdY
         NOhKJUZgjE1PkN0XPsPFIKaaT5lAnfP7Ro+PLJhcLyOlMgZSER5T3uHjJ8hyhYmOrG1c
         d76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5HJML9y11R46OtDRqClWdXS2bPj3NqH8YWdkAW2AqU=;
        b=0JvGt7wvSz3JfIMBCO/5zc3AooK9u6xm3hfpIWYzVCxROy/xtfrYDsk0zsulhNuZWG
         G4RYzakaCwKAjI7HGYzC1NYZhreQWXmtIpF+b5gJ+r9PJSLlWr/z/1YYUYfE28FdzESO
         VRwkBeh40TcL9smEFwFOCjLzOuPuc8LUZkcSzqXOi3Uob1ZExHpsjJbhrRkRwGyKIziY
         klkhwh5f0ibnju3k2AZSi6i1PwO59w5yfZiz4w+/6dtJH4kfdLn0Gt13KpoYHFyFumpS
         px8vOJX0s4UDLXrfuqH05VXnOp70qt1FzJ7ayYubGev1u2jJ9S66b+P8lxsJW44QT14w
         3CGQ==
X-Gm-Message-State: ANoB5pluHWg19wypDEpFTOOFCosRogvTYV8fQgEXMevWVNaH3gOf+Plm
        TdCCdtkr52RndPkILC3Xeq8R8A==
X-Google-Smtp-Source: AA0mqf56CJ26kLueuIdSHI5Va9mNO3O4FkA0Hh3vNp+3FpyeQCH8CIMFyNEqEE8MVJCD9u8V8mHofQ==
X-Received: by 2002:a5d:6b0c:0:b0:241:c595:9f05 with SMTP id v12-20020a5d6b0c000000b00241c5959f05mr16601wrw.439.1668755937028;
        Thu, 17 Nov 2022 23:18:57 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j16-20020adff010000000b002302dc43d77sm2754349wro.115.2022.11.17.23.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:18:56 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] ASoC: codecs: va-macro: add npl clk
Date:   Fri, 18 Nov 2022 07:18:49 +0000
Message-Id: <20221118071849.25506-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118071849.25506-1-srinivas.kandagatla@linaro.org>
References: <20221118071849.25506-1-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-va-macro.c | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index b0b6cf29cba3..eef8dd5d58f8 100644
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
@@ -1332,6 +1333,12 @@ static int fsgen_gate_enable(struct clk_hw *hw)
 	struct regmap *regmap = va->regmap;
 	int ret;
 
+	if (va->has_swr_master) {
+		ret = clk_prepare_enable(va->mclk);
+		if (ret)
+			return ret;
+	}
+
 	ret = va_macro_mclk_enable(va, true);
 	if (!va->has_swr_master)
 		return ret;
@@ -1358,6 +1365,8 @@ static void fsgen_gate_disable(struct clk_hw *hw)
 			   CDC_VA_SWR_CLK_EN_MASK, 0x0);
 
 	va_macro_mclk_enable(va, false);
+	if (va->has_swr_master)
+		clk_disable_unprepare(va->mclk);
 }
 
 static int fsgen_gate_is_enabled(struct clk_hw *hw)
@@ -1386,6 +1395,9 @@ static int va_macro_register_fsgen_output(struct va_macro *va)
 	struct clk_init_data init;
 	int ret;
 
+	if (va->has_swr_master)
+		parent = va->npl;
+
 	parent_clk_name = __clk_get_name(parent);
 
 	of_property_read_string(np, "clock-output-names", &clk_name);
@@ -1512,6 +1524,16 @@ static int va_macro_probe(struct platform_device *pdev)
 	/* mclk rate */
 	clk_set_rate(va->mclk, 2 * VA_MACRO_MCLK_FREQ);
 
+	if (va->has_swr_master) {
+		va->npl = devm_clk_get(dev, "npl");
+		if (IS_ERR(va->npl)) {
+			ret = PTR_ERR(va->npl);
+			goto err;
+		}
+
+		clk_set_rate(va->npl, 2 * VA_MACRO_MCLK_FREQ);
+	}
+
 	ret = clk_prepare_enable(va->macro);
 	if (ret)
 		goto err;
@@ -1524,6 +1546,12 @@ static int va_macro_probe(struct platform_device *pdev)
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
@@ -1563,6 +1591,9 @@ static int va_macro_probe(struct platform_device *pdev)
 	return 0;
 
 err_clkout:
+	if (va->has_swr_master)
+		clk_disable_unprepare(va->npl);
+err_npl:
 	clk_disable_unprepare(va->mclk);
 err_mclk:
 	clk_disable_unprepare(va->dcodec);
@@ -1578,6 +1609,9 @@ static int va_macro_remove(struct platform_device *pdev)
 {
 	struct va_macro *va = dev_get_drvdata(&pdev->dev);
 
+	if (va->has_swr_master)
+		clk_disable_unprepare(va->npl);
+
 	clk_disable_unprepare(va->mclk);
 	clk_disable_unprepare(va->dcodec);
 	clk_disable_unprepare(va->macro);
@@ -1594,6 +1628,9 @@ static int __maybe_unused va_macro_runtime_suspend(struct device *dev)
 	regcache_cache_only(va->regmap, true);
 	regcache_mark_dirty(va->regmap);
 
+	if (va->has_swr_master)
+		clk_disable_unprepare(va->npl);
+
 	clk_disable_unprepare(va->mclk);
 
 	return 0;
@@ -1610,6 +1647,15 @@ static int __maybe_unused va_macro_runtime_resume(struct device *dev)
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

