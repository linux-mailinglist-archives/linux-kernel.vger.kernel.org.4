Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B516908C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBIM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBIM2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58059241F9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:28:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d14so1574487wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wrxQA0MT8PveUUiIj83RXA4CfwfsCaWsptgakRSOp4=;
        b=G7A7Y63Pa/o5zi3dcrirqZ5NuH8B040ZdYN9DhUJByd+Hhiiv8ctVZ3MC1y7llq/uO
         HMY9oArgm8x8oOqcHx2GQPd8noLxbflJEaj3MJrM7NLA3y5m7EgstDKSP7bdKdLssyER
         6XHp6wlCExu+KLTi4vkq9oX39jkWwjxzm45TZt0wwaU8SgrwgGS7VrQgiZSph9S/ZQs+
         tfHlpu+Gihil+1DOh+6ZgKcBuP1LvfhbFMl1nFK8jpqXDSKPTMRzj+vwRrJiBz2ICSgW
         dO0uRF6n+MgnWHjM8hsgujWZhMy378XvbLg5cWAn0suEpWhxHNoBShzR9W+59oHcfr59
         V3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wrxQA0MT8PveUUiIj83RXA4CfwfsCaWsptgakRSOp4=;
        b=GUbfm2Cb9V6+BbWBOfg4dkYznFTWugCqro214aJt9ziKC/WgBFUL/1k2IYlx/WZI0P
         CNdSwvlOXnEQR+OW3iDYhdf2VZKf+xmOM5B7p0yF4l7/5Edq/2rTfbJ1JinDDtlmaVwT
         P2OVT4TTipKpwEkMT1okz4ucME3TeGKYEG1oRhgxrsxjxScmy/VHemmufitEEtj7ARqT
         Yuo7RN3qvJXCWtp8B+xeZ9WvIJ+ePaSu8EOU7XRcqqjQuLn/NqfzXMIEsfguC/AxX7Bm
         DqPOi0U53qp7bYEognRg5RpU78rWNoBeXB2su/Nl0PcvgaA4zq7gnbcWJay6bcA+9eU9
         1+Ug==
X-Gm-Message-State: AO0yUKVbs5q8wB46YYErecq/CsF+VxqW8kjuP2OGgsrRJRj56cvQ52aw
        odg/K+IwspjWvotYhe1B5xVOCQ==
X-Google-Smtp-Source: AK7set8h/z/FCq4f7FbIxLwOO/bkyaNdkaxbyR9ezAhEOd+zfvRkunaEBG4oTCzgK8z3dqQj8FS/hA==
X-Received: by 2002:adf:fb05:0:b0:2bf:b199:c7ef with SMTP id c5-20020adffb05000000b002bfb199c7efmr9814157wrr.12.1675945702809;
        Thu, 09 Feb 2023 04:28:22 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/8] ASoC: codecs: lpass: fix incorrect mclk rate
Date:   Thu,  9 Feb 2023 12:28:04 +0000
Message-Id: <20230209122806.18923-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
References: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
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

For some reason we ended up with incorrect mclk rate which should be
1920000 instead of 96000, So far we were getting lucky as the same clk
is set to 192000 by wsa and va macro. This issue is discovered when there
is no wsa macro active and only rx or tx path is tested.
Fix this by setting correct rate.

Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass tx macro")
Fixes: af3d54b99764 ("ASoC: codecs: lpass-rx-macro: add support for lpass rx macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 4 ++--
 sound/soc/codecs/lpass-tx-macro.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index dd6970d5eb8d..8621cfabcf5b 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -366,7 +366,7 @@
 #define CDC_RX_DSD1_CFG2			(0x0F8C)
 #define RX_MAX_OFFSET				(0x0F8C)
 
-#define MCLK_FREQ		9600000
+#define MCLK_FREQ		19200000
 
 #define RX_MACRO_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
@@ -3579,7 +3579,7 @@ static int rx_macro_probe(struct platform_device *pdev)
 
 	/* set MCLK and NPL rates */
 	clk_set_rate(rx->mclk, MCLK_FREQ);
-	clk_set_rate(rx->npl, 2 * MCLK_FREQ);
+	clk_set_rate(rx->npl, MCLK_FREQ);
 
 	ret = clk_prepare_enable(rx->macro);
 	if (ret)
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index b9475ba55e20..2449a2df66df 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -203,7 +203,7 @@
 #define TX_MACRO_AMIC_UNMUTE_DELAY_MS	100
 #define TX_MACRO_DMIC_HPF_DELAY_MS	300
 #define TX_MACRO_AMIC_HPF_DELAY_MS	300
-#define MCLK_FREQ		9600000
+#define MCLK_FREQ		19200000
 
 enum {
 	TX_MACRO_AIF_INVALID = 0,
@@ -2014,7 +2014,7 @@ static int tx_macro_probe(struct platform_device *pdev)
 
 	/* set MCLK and NPL rates */
 	clk_set_rate(tx->mclk, MCLK_FREQ);
-	clk_set_rate(tx->npl, 2 * MCLK_FREQ);
+	clk_set_rate(tx->npl, MCLK_FREQ);
 
 	ret = clk_prepare_enable(tx->macro);
 	if (ret)
-- 
2.21.0

