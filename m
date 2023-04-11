Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35486DD8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDKLIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDKLIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:08:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A833A87
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:08:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q5so4269051wmo.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681211319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/ulLRRaOTMlKM2fPLAgU/c7cE1SCIWwAyoxBGX8u7o=;
        b=wg+0sAEtsMuiVoa4tsE7w3YEDYFC3KeYcJxS04nkURzr8KSPhhUYG9ls8FoIldLKSr
         Fu0quq51STGr8UxZRZa6Oe8Wyy3dnOC73Fuhif8C8s7E4nMTdOEYGz56nqmGqMy7/hq1
         HAqcFieCk7fp9C84F92KHsI6syktBCUyZ1TnXYY+W4VrT6ZZDvSxVcc/WwH5H9K6cDbw
         O6sdEIAsdfeMHq50nHsRTTDcaZcxzIO8/Iv+ufcDcf6GUwMixVBp1UPYcwELM+TlYQSF
         UNbKWpPvBqs2PF3dxj5AgcV9KMDwRvZybYgltOkhWqpd0dQBTbfA+6KKgRwXQCxx90DN
         CxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/ulLRRaOTMlKM2fPLAgU/c7cE1SCIWwAyoxBGX8u7o=;
        b=LQAYZTuAPVFeTnRaLVjYnGBVxi0/MFFeZE+AVl2rpKTSCyfVFIqfijVr3Wrd8iIMy7
         WHp87MZCK88vYfgzDkbEhRXaazo8p54ja4HfgLtglaqfPpZypTl9G5oheqMh3zeAOPNs
         0IDNFd+eaKQktVwB+4wEpHHlOQ/mrUh7WQoNDmJTOTBI2pVyELpvZ0195kdTR/BBnnMl
         7Arwpa8Q2TOIi1xMLYYpUBRYlZMR2/054+jFD6Y8rabnZHV/nCKBWVR1pqNYtqMoRVlf
         CAx86X0qUxoO4Z9wIVSrAQaJF0butMQo9CqLupQq3eoVhiUtIE527GjQIz56UjuF4HhJ
         Km8g==
X-Gm-Message-State: AAQBX9eDBBQ9ob+7gSBO0R3D33b9sxB/wIJTEE6NBzncVYTqLzO6pdpw
        KCa/UBRT4w1prICbNtUhQ+Gc1g==
X-Google-Smtp-Source: AKy350bnhiC44ZvjBP5VkUOAxrTV8xOky580Spgj1yerM7yOGxAvg2z2PKl9RnyaNIOItNgVQcQdsQ==
X-Received: by 2002:a1c:4b06:0:b0:3ee:6cdf:c357 with SMTP id y6-20020a1c4b06000000b003ee6cdfc357mr8605975wma.20.1681211319641;
        Tue, 11 Apr 2023 04:08:39 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003eae73f0fc1sm16650750wme.18.2023.04.11.04.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:08:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH] ASoC: soc-compress: set pcm nonatomic flag from dai_link
Date:   Tue, 11 Apr 2023 12:08:31 +0100
Message-Id: <20230411110831.813-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In compress offload case we never set nonatomic flag on a new pcm. This triggers
below configuration error with DPCM on Qualcomm setup where dai_links are marked
as nonatomic.

"FE is atomic but BE is nonatomic, invalid configuration"

Fix this by Updating the pcm nonatomic flag correcly from the respective dai_link.

CC: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/soc-compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 554c329ec87f..a8d70274cab8 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -615,6 +615,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 			return ret;
 		}
 
+		be_pcm->nonatomic = rtd->dai_link->nonatomic;
 		rtd->pcm = be_pcm;
 		rtd->fe_compr = 1;
 		if (rtd->dai_link->dpcm_playback)
-- 
2.21.0

