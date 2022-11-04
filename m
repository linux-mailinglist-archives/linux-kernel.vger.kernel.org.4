Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E261989E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiKDN5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiKDN5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:57:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18442F3B5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:57:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 4so4992863pli.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNFF0xwQukCs3t/Tcp1ZLLt+pMarR7751wvJ6nmpdnw=;
        b=AvpLIKqzh8Z7IGR1bHjIsdjNzwZeXvEUDsikM0w2+/gdPKQnVWd46Ttee+kJVmN7nu
         bNYKWXo1aGRU109CG3OssKJFbdvh95q9QvjgCQIdM6qnUkRmvtA+kaUcOoidYsXMQfNS
         Z1XTJ7WfyzuL2yw+LcPwGmyXhCNAtIzPwMBSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNFF0xwQukCs3t/Tcp1ZLLt+pMarR7751wvJ6nmpdnw=;
        b=V3GSO0ZYiKjAlUZssdF8lNpZqnanG+sBwfTYYHo4mLlGUnU3j0DTeIV/UUqajUIdlf
         VosRLOHUVQntu6AjkUx106JyHugfYjwwhHB9nwmtmeqvMGto2ETMBxYyRNA2S/8ZmupI
         +3NmKvhKcQnhchDIxEqvBPu245tJJhRZrAXT1hGY4yqCklmFcWWtmZKBI3qybh7VqE5/
         bJGxpZsmvb1phfy5RzfuPg82gJYtorhj/f/n5igmWRzKOQ2Ugnix35DR6IxEMHUyM3dE
         mXLppDk+BzglGEnpwxOHAX4bIJQIyPG3xpCSRIbt/Wz/tnbcbbSyuV0uMhTA0omUTayR
         ah1w==
X-Gm-Message-State: ACrzQf1TB6iJdyQRXZDWRnthwNAhVJm2Ayqoi0+unpD/rV1lmhpVUCc1
        GzQFnN1nHTCKqfOJPf97RirSCQ==
X-Google-Smtp-Source: AMsMyM7bD7tXBX9oUgBi0TcvLueD/nzbEF/pFTpdupo4Kc9UymOzr8rB3swM0aP8SCmVf5KtPgb7tw==
X-Received: by 2002:a17:90b:278b:b0:213:c2f2:6ca1 with SMTP id pw11-20020a17090b278b00b00213c2f26ca1mr31733384pjb.103.1667570223871;
        Fri, 04 Nov 2022 06:57:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5e74:f068:4840:3631])
        by smtp.gmail.com with ESMTPSA id m6-20020a62a206000000b0056bf29c9ba3sm2829367pff.146.2022.11.04.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:57:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: qcom: lpass-sc7180: Fix pm_runtime usage
Date:   Fri,  4 Nov 2022 06:56:29 -0700
Message-Id: <20221104064055.2.I49b25b9bda9430fc7ea21e5a708ca5a0aced2798@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221104064055.1.I00a0e4564a25489e85328ec41636497775627564@changeid>
References: <20221104064055.1.I00a0e4564a25489e85328ec41636497775627564@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc7180 lpass clock controller's pm_runtime usage wasn't broken
quite as spectacularly as the sc7280's pm_runtime usage, but it was
still broken. Putting some printouts in at boot showed me this (with
serial console enabled, which makes the prints slow and thus changes
timing):
  [    3.109951] DOUG: my_pm_clk_resume, usage=1
  [    3.114767] DOUG: my_pm_clk_resume, usage=1
  [    3.664443] DOUG: my_pm_clk_suspend, usage=0
  [    3.897566] DOUG: my_pm_clk_suspend, usage=0
  [    3.910137] DOUG: my_pm_clk_resume, usage=1
  [    3.923217] DOUG: my_pm_clk_resume, usage=0
  [    4.440116] DOUG: my_pm_clk_suspend, usage=-1
  [    4.444982] DOUG: my_pm_clk_suspend, usage=0
  [   14.170501] DOUG: my_pm_clk_resume, usage=1
  [   14.176245] DOUG: my_pm_clk_resume, usage=0

...or this w/out serial console:
  [    0.556139] DOUG: my_pm_clk_resume, usage=1
  [    0.556279] DOUG: my_pm_clk_resume, usage=1
  [    1.058422] DOUG: my_pm_clk_suspend, usage=-1
  [    1.058464] DOUG: my_pm_clk_suspend, usage=0
  [    1.186250] DOUG: my_pm_clk_resume, usage=1
  [    1.186292] DOUG: my_pm_clk_resume, usage=0
  [    1.731536] DOUG: my_pm_clk_suspend, usage=-1
  [    1.731557] DOUG: my_pm_clk_suspend, usage=0
  [   10.288910] DOUG: my_pm_clk_resume, usage=1
  [   10.289496] DOUG: my_pm_clk_resume, usage=0

It seems to be doing roughly the right sequence of calls, but just
like with sc7280 this is more by luck than anything. Having a usage of
-1 is just not OK.

Let's fix this like we did with sc7280.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/qcom/lpasscorecc-sc7180.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index ac09b7b840ab..a5731994cbed 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -356,7 +356,7 @@ static const struct qcom_cc_desc lpass_audio_hm_sc7180_desc = {
 	.num_gdscs = ARRAY_SIZE(lpass_audio_hm_sc7180_gdscs),
 };
 
-static int lpass_create_pm_clks(struct platform_device *pdev)
+static int lpass_setup_runtime_pm(struct platform_device *pdev)
 {
 	int ret;
 
@@ -375,7 +375,7 @@ static int lpass_create_pm_clks(struct platform_device *pdev)
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to acquire iface clock\n");
 
-	return ret;
+	return pm_runtime_resume_and_get(&pdev->dev);
 }
 
 static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
@@ -384,7 +384,7 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret;
 
-	ret = lpass_create_pm_clks(pdev);
+	ret = lpass_setup_runtime_pm(pdev);
 	if (ret)
 		return ret;
 
@@ -392,12 +392,14 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 	desc = &lpass_audio_hm_sc7180_desc;
 	ret = qcom_cc_probe_by_index(pdev, 1, desc);
 	if (ret)
-		return ret;
+		goto exit;
 
 	lpass_core_cc_sc7180_regmap_config.name = "lpass_core_cc";
 	regmap = qcom_cc_map(pdev, &lpass_core_cc_sc7180_desc);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto exit;
+	}
 
 	/*
 	 * Keep the CLK always-ON
@@ -415,6 +417,7 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 	ret = qcom_cc_really_probe(pdev, &lpass_core_cc_sc7180_desc, regmap);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
+exit:
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return ret;
@@ -425,14 +428,19 @@ static int lpass_hm_core_probe(struct platform_device *pdev)
 	const struct qcom_cc_desc *desc;
 	int ret;
 
-	ret = lpass_create_pm_clks(pdev);
+	ret = lpass_setup_runtime_pm(pdev);
 	if (ret)
 		return ret;
 
 	lpass_core_cc_sc7180_regmap_config.name = "lpass_hm_core";
 	desc = &lpass_core_hm_sc7180_desc;
 
-	return qcom_cc_probe_by_index(pdev, 0, desc);
+	ret = qcom_cc_probe_by_index(pdev, 0, desc);
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
+	return ret;
 }
 
 static const struct of_device_id lpass_hm_sc7180_match_table[] = {
-- 
2.38.1.431.g37b22c650d-goog

