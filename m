Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5CC6A81D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCBMDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCBMDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:03:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B78BF96F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:03:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bx12so13123672wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 04:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677758619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=//nTMjC91UXahku8+Tdgj1LSFzE35LjlMWcyU1qZ1CQ=;
        b=xC3lGcWemHgD69Qa6SjC7iLvsWcoyMqrRP2tbnso0lWItT3NJRh97pgog8qb12RHPd
         vcYzmy4CqHGya/xFYdqheKBrfkkMNCDsdpfECVxn/sOr07JdI+bN8RQzQipunChja1SW
         THeCPlrarcDbbQ2ghM3lMuli9UboDI5yFER6FuoxnqVQw52CGhvNSzPB74o1RZ2iY5VC
         55EBjwBlSKzE2/5qIwbkbSHrG3Q7Ty+Qb5kT+CRJ7LM3Z9PBmoQfFtyh3zkZU1IOHzNh
         P3Gxz9Vvvbga2/CjT2Y+BjNSO2yfAAgbnrKzt6vKAAL4EXJq0dEBNHqH2lbiEN+ivuMl
         bfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677758619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//nTMjC91UXahku8+Tdgj1LSFzE35LjlMWcyU1qZ1CQ=;
        b=HzALXiQSPy+J/nK1HkVPdCFAXX/4HPbcQTpd4OrogiSElwT2uQPcLLRfi5G5newx1q
         ZSBJFdn+4/2tMFas5abCFgZVbsxBuyeBvR0lgq3akROKemu2kIsQqyYDNjbyYcbwRR2j
         dRYExTx6C3RBIdYraSvyGdLD3DTkoq6/4bmUUmUbyvZhy8SSTjJBGZv/umqTf7BBHA8v
         DeFMGlVkkkx+z4XbBScNHy0lj/vyImQZzK6rCQKLUpJT+86x3S+2wULZEy9Ps96a4mfD
         FHNasjL0T6ARDSgLjXOH69pyQscCNEsq8PWliRMxH79RHWei/y2cEhJxQvFx1BcOyMHH
         6TaQ==
X-Gm-Message-State: AO0yUKWzAVAFcKOBBx26yJd6sshK6tjlNYAc/T4GgsSQhFvIxfCTmat4
        VzZFJK6ZYR0Lp8VVdUELD1xVpA==
X-Google-Smtp-Source: AK7set/cuxTBk2fSWYhYU5b2FKv5Yqgg6rOXfNsTT+RpLAGnq0BSBmhWdoPN6utwXYOimmwl91XfaA==
X-Received: by 2002:adf:f6c5:0:b0:2c7:148c:b04f with SMTP id y5-20020adff6c5000000b002c7148cb04fmr7122753wrp.37.1677758619031;
        Thu, 02 Mar 2023 04:03:39 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm15293422wrv.10.2023.03.02.04.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:03:38 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: common: add default jack dapm pins
Date:   Thu,  2 Mar 2023 12:03:27 +0000
Message-Id: <20230302120327.10823-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

If the soundcard does not specify the dapm pins, let the common
code add these pins for jack.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index c1f24af17506..555feb845c41 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -8,6 +8,11 @@
 #include "qdsp6/q6afe.h"
 #include "common.h"
 
+static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
 int qcom_snd_parse_of(struct snd_soc_card *card)
 {
 	struct device_node *np;
@@ -169,6 +174,11 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		of_node_put(platform);
 	}
 
+	if (!card->dapm_widgets) {
+		card->dapm_widgets = qcom_jack_snd_widgets;
+		card->num_dapm_widgets = ARRAY_SIZE(qcom_jack_snd_widgets);
+	}
+
 	return 0;
 err:
 	of_node_put(cpu);
-- 
2.21.0

