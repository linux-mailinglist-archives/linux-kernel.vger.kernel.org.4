Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCAC619898
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKDN51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiKDN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:57:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5592F3A3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:57:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gw22so4571826pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XPBXRa9w7YK7/mX5TsWakQgciRU5D3ll2jqB5IqI2G0=;
        b=XrWseRGDX/666oj7zxpWUZ59i7mlMuNt+zLtA+mT+5ZFDMOrzDCKzoLrCXfYZGut9p
         HU0xr7K/MflpEV76tvyrBADQftwgoYj2BwchTPnDyg8dKm9l6NjrUXSBhepRU5r1mbvi
         38IZfsDxw3QQLlDN+cBVxOwqMpEsurI1C3n5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPBXRa9w7YK7/mX5TsWakQgciRU5D3ll2jqB5IqI2G0=;
        b=RiS1IZOm08GG/XkKapzVAC7F/1Ly8cNMDyqbTwI5fx0ykOtalMT6zyeFkFwtk9btyA
         oqtU8zka6H4TEJKUgsG4Vv7iQDh0hkfFfmEwHL5rCfvRvCKohOz9EkZcMcqZKs3Gl5qi
         0rRa3JYjbpjjBn34+Rs1JfKMpW3X+j7NqF6iSfpSL7EdgRC8Xa2iQrwMLcYzbxDNsM9R
         lWzQadAf/UddlNqV3+VcFfuRzO0CPgWuXSMPjQm2k+5FPGy3TRaxQlo1k3jSjCwvFPqE
         2lmQC00GBvdrP1dqtufmB8Fo2Ym/YtxiZr4H3SB/nJzICujbS5rDKjVcVvX89k5ZFduQ
         /mqw==
X-Gm-Message-State: ACrzQf3S+5/BvCoBZxcMnQvVt/RbAAQJv25m14PXW0D75g4/0WGLsd3K
        IsGGKZpMjx1HW2wAhPSPuS4n9g==
X-Google-Smtp-Source: AMsMyM5bJ5JuDXM35109KHkeAOPwSNVq1zbsNH9g1O9EhMk7qkuZYEsfp3MvFY6cS9Gr8VB8ow92dw==
X-Received: by 2002:a17:903:240a:b0:183:6555:7a89 with SMTP id e10-20020a170903240a00b0018365557a89mr35545147plo.68.1667570222142;
        Fri, 04 Nov 2022 06:57:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5e74:f068:4840:3631])
        by smtp.gmail.com with ESMTPSA id m6-20020a62a206000000b0056bf29c9ba3sm2829367pff.146.2022.11.04.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:57:00 -0700 (PDT)
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
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: qcom: lpass-sc7280: Fix pm_runtime usage
Date:   Fri,  4 Nov 2022 06:56:28 -0700
Message-Id: <20221104064055.1.I00a0e4564a25489e85328ec41636497775627564@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

The pm_runtime usage in lpass-sc7280 was broken in quite a few
ways. Specifically:

1. At the end of probe it called "put" twice. This is a no-no and will
   end us up with a negative usage count. Even worse than calling
   "put" twice, it never called "get" once. Thus after bootup it could
   be seen that the runtime usage of the devices managed by this
   driver was -2.
2. In some error cases it manually called pm_runtime_disable() even
   though it had previously used devm_add_action_or_reset() to set
   this up to be called automatically. This meant that in these error
   cases we'd double-call pm_runtime_disable().
3. It forgot to call undo pm_runtime_use_autosuspend(), which can
   sometimes have subtle problems (and the docs specifically mention
   that you need to undo this function).

Overall the above seriously calls into question how this driver is
working. It seems like a combination of "it doesn't", "by luck", and
"because of the weirdness of runtime_pm". Specifically I put a
printout to the serial console every time the runtime suspend/resume
was called for the two devices created by this driver (I wrapped the
pm_clk calls). When I had serial console enabled, I found that the
calls got resumed at bootup (when the clk core probed and before our
double-put) and then never touched again. That's no good.
  [    0.829997] DOUG: my_pm_clk_resume, usage=1
  [    0.835487] DOUG: my_pm_clk_resume, usage=1

When I disabled serial console (speeding up boot), I got a different
pattern, which I guess (?) is better:
  [    0.089767] DOUG: my_pm_clk_resume, usage=1
  [    0.090507] DOUG: my_pm_clk_resume, usage=1
  [    0.151885] DOUG: my_pm_clk_suspend, usage=-2
  [    0.151914] DOUG: my_pm_clk_suspend, usage=-2
  [    1.825747] DOUG: my_pm_clk_resume, usage=-1
  [    1.825774] DOUG: my_pm_clk_resume, usage=-1
  [    1.888269] DOUG: my_pm_clk_suspend, usage=-2
  [    1.888282] DOUG: my_pm_clk_suspend, usage=-2

These different patterns have to do with the fact that the core PM
Runtime code really isn't designed to be robust to negative usage
counts and sometimes may happen to stumble upon a behavior that
happens to "work". For instance, you can see that
__pm_runtime_suspend() will treat any non-zero value (including
negative numbers) as if the device is in use.

In any case, let's fix the driver to be correct. We'll hold a
pm_runtime reference for the whole probe and then drop it (once!) at
the end. We'll get rid of manual pm_runtime_disable() calls in the
error handling. We'll also switch to devm_pm_runtime_enable(), which
magically handles undoing pm_runtime_use_autosuspend() as of commit
b4060db9251f ("PM: runtime: Have devm_pm_runtime_enable() handle
pm_runtime_dont_use_autosuspend()").

While we're at this, let's also use devm_pm_clk_create() instead of
rolling it ourselves.

Note that the above changes make it obvious that
lpassaudio_create_pm_clks() was doing more than just creating
clocks. It was also setting up pm_runtime parameters. Let's rename it.

All of these problems were found by code inspection. I started looking
at this driver because it was involved in a deadlock that I reported a
while ago [1]. Though I bisected the deadlock to commit 1b771839de05
("clk: qcom: gdsc: enable optional power domain support"), it was
never really clear why that patch affected it other than a luck of
timing changes. I'll also note that by fixing the timing (as done in
this change) we also seem to aboid the deadlock, which is a nice
benefit.

Also note that some of the fixes here are much the same type of stuff
that Dmitry did in commit 72cfc73f4663 ("clk: qcom: use
devm_pm_runtime_enable and devm_pm_clk_create"), but I guess
lpassaudiocc-sc7280.c didn't exist then.

[1] https://lore.kernel.org/r/20220922154354.2486595-1-dianders@chromium.org

Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock controller for SC7280")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/qcom/lpassaudiocc-sc7280.c | 55 ++++++++++----------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 063e0365f311..1339f9211a14 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -722,33 +722,17 @@ static const struct of_device_id lpass_audio_cc_sc7280_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, lpass_audio_cc_sc7280_match_table);
 
-static void lpassaudio_pm_runtime_disable(void *data)
-{
-	pm_runtime_disable(data);
-}
-
-static void lpassaudio_pm_clk_destroy(void *data)
-{
-	pm_clk_destroy(data);
-}
-
-static int lpassaudio_create_pm_clks(struct platform_device *pdev)
+static int lpass_audio_setup_runtime_pm(struct platform_device *pdev)
 {
 	int ret;
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
-	pm_runtime_enable(&pdev->dev);
-
-	ret = devm_add_action_or_reset(&pdev->dev, lpassaudio_pm_runtime_disable, &pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = pm_clk_create(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&pdev->dev, lpassaudio_pm_clk_destroy, &pdev->dev);
+	ret = devm_pm_clk_create(&pdev->dev);
 	if (ret)
 		return ret;
 
@@ -756,7 +740,7 @@ static int lpassaudio_create_pm_clks(struct platform_device *pdev)
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to acquire iface clock\n");
 
-	return ret;
+	return pm_runtime_resume_and_get(&pdev->dev);
 }
 
 static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
@@ -765,7 +749,7 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret;
 
-	ret = lpassaudio_create_pm_clks(pdev);
+	ret = lpass_audio_setup_runtime_pm(pdev);
 	if (ret)
 		return ret;
 
@@ -775,8 +759,8 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
 
 	regmap = qcom_cc_map(pdev, desc);
 	if (IS_ERR(regmap)) {
-		pm_runtime_disable(&pdev->dev);
-		return PTR_ERR(regmap);
+		ret = PTR_ERR(regmap);
+		goto exit;
 	}
 
 	clk_zonda_pll_configure(&lpass_audio_cc_pll, regmap, &lpass_audio_cc_pll_config);
@@ -788,20 +772,18 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
 	ret = qcom_cc_really_probe(pdev, &lpass_audio_cc_sc7280_desc, regmap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC clocks\n");
-		pm_runtime_disable(&pdev->dev);
-		return ret;
+		goto exit;
 	}
 
 	ret = qcom_cc_probe_by_index(pdev, 1, &lpass_audio_cc_reset_sc7280_desc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC Resets\n");
-		pm_runtime_disable(&pdev->dev);
-		return ret;
+		goto exit;
 	}
 
 	pm_runtime_mark_last_busy(&pdev->dev);
+exit:
 	pm_runtime_put_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
 
 	return ret;
 }
@@ -839,14 +821,15 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret;
 
-	ret = lpassaudio_create_pm_clks(pdev);
+	ret = lpass_audio_setup_runtime_pm(pdev);
 	if (ret)
 		return ret;
 
 	if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
 		lpass_audio_cc_sc7280_regmap_config.name = "cc";
 		desc = &lpass_cc_sc7280_desc;
-		return qcom_cc_probe(pdev, desc);
+		ret = qcom_cc_probe(pdev, desc);
+		goto exit;
 	}
 
 	lpass_audio_cc_sc7280_regmap_config.name = "lpasscc_aon";
@@ -854,18 +837,22 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 	desc = &lpass_aon_cc_sc7280_desc;
 
 	regmap = qcom_cc_map(pdev, desc);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto exit;
+	}
 
 	clk_lucid_pll_configure(&lpass_aon_cc_pll, regmap, &lpass_aon_cc_pll_config);
 
 	ret = qcom_cc_really_probe(pdev, &lpass_aon_cc_sc7280_desc, regmap);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "Failed to register LPASS AON CC clocks\n");
+		goto exit;
+	}
 
 	pm_runtime_mark_last_busy(&pdev->dev);
+exit:
 	pm_runtime_put_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
 
 	return ret;
 }
-- 
2.38.1.431.g37b22c650d-goog

