Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A0F5F09B0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiI3LOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiI3LOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:14:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A231794AF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:53:52 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o5so2661640wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=O0OgJqiyZbyHgoVa58ck6r9CgJKpRkAVHS2RpaoIMr8=;
        b=k8x5iPv4ZY0jwFG1KZaZWMu4jPgXoEnV05IOaRGBPpc2JOMZWk+odlozwZuV9P73AV
         jqQAHgkfjMqrQcyD1eZm0Ib9rIvDs9i17KUVITVXcL5j9FWUAZ16JfyvOkzsz34s7k2r
         lqEghh+/5Z2HSUU9eqUJbFuoJ+87ru+LfWMbbdm6SjzAnR392wJtLBPYJ0Ay8BWqUBPy
         Cf3OOmwZ45jtCBZF1UbzR9gFQPjIf7ZpXEYXW/mya2gjUXirfIEXcyWKzuSFvJ+bbAMr
         dJ3RtExMx58eOSttLsyL11iJKVLFD2h3/4wXg0LTzZDbUPIrc0kfcQCazJZRuDvEcD3/
         sZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=O0OgJqiyZbyHgoVa58ck6r9CgJKpRkAVHS2RpaoIMr8=;
        b=XtbVygkf/ydqSDNQ8reRHynhNCVHEAuCJFP5ss2jfa3A491sbj+VpVHqTHmEy/ocg2
         eqmlI0qfpMARdhUmFWPcCerytX2ZQ/4BHMRglu1tUMnzD0lGI9cAReNaFzP81cb1/6jf
         R2SWU/A7VyHWzX5cJ4JskEgb3kG1PKTkMGv5QOVc3T06OLqxwW10YFLvkY9B2BGMKljd
         z3pCjYUSfr34WMbKpVRlvCKrJnfR1XaGQgVkuM6rrsBqhfIsJZ7f8Gx23dJXLgCjgMpk
         aQKJbEGBpzcFDy9okX75jhI4JnCzaF6VH0oNokiyxdEmYoSW5xOudLDLaF3jngXMbDqF
         YXhg==
X-Gm-Message-State: ACrzQf3NOzkRZqZTqDFHNHVLDBbop2tVVCnZld8eTOJ3rOcrz27Fwf7f
        auB/vNsMonqrCGvG1XrrtbWxew==
X-Google-Smtp-Source: AMsMyM7vKErwtHvUNHd6qph22gsXn98Eqq+GzNNYIK9sXZZITQLibWqMXx0wL3cR8R/VbS/WWX7EUQ==
X-Received: by 2002:a05:600c:1d89:b0:3b4:7554:defb with SMTP id p9-20020a05600c1d8900b003b47554defbmr5085710wms.21.1664535231079;
        Fri, 30 Sep 2022 03:53:51 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003b4c40378casm7315090wmb.39.2022.09.30.03.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:53:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: qcom: fix unmet direct dependencies for SND_SOC_QDSP6
Date:   Fri, 30 Sep 2022 11:53:47 +0100
Message-Id: <20220930105347.41127-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

SND_SOC_QDSP6 already has COMPILE_TEST so remove that from
SND_SOC_SC8280XP and also add QCOM_APR dependencies to
SND_SOC_SC8280XP like other Qualcomm machine drivers.

This should also fix below warning:
on x86_64, when QCOM_APR is not set and COMPILE_TEST=y:

WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]
	&& SND_SOC_QCOM [=y] && QCOM_APR [=n] && COMMON_CLK [=y]
  Selected by [y]:
  - SND_SOC_SC8280XP [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]
	&& SND_SOC_QCOM [=y] && (QCOM_APR [=n] || COMPILE_TEST [=y]) &&
	 SOUNDWIRE [=y] && COMMON_CLK [=y]

Fixes: 295aeea6646a ("ASoC: qcom: add machine driver for sc8280xp")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 1b0252ec4665..d0e59e07b1fc 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -175,8 +175,7 @@ config SND_SOC_SM8250
 
 config SND_SOC_SC8280XP
 	tristate "SoC Machine driver for SC8280XP boards"
-	depends on QCOM_APR || COMPILE_TEST
-	depends on SOUNDWIRE
+	depends on QCOM_APR && SOUNDWIRE
 	depends on COMMON_CLK
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
-- 
2.25.1

