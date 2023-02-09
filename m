Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5126908C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBIM2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBIM2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E108986AD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:28:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y1so1609704wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEzXaR05SusPPC1DvCjjsQFeMd90WYnfj1cUKYhegZE=;
        b=Ro8BWxNHoJAvx5SGpTR7yXMmlpv09d9Nj0eJZjJSW3/ZEazepb0uXgN9ztasMc+Cll
         dVA3pJPtNyAV8yMVsPb1/TtSYV000KqkVbzrwx5tu0Q0nqTqgcGh2iHU07/c5xTFUmBy
         0svc7agcaOFDVVa7bbpvCq9uugf0iFY7YMvlWhCk73OJx4Wm7GVU2U8hyKeNKg6qXqYk
         G+Zt+bZVSrnmatVQNw02P5i7Mhfk+BYH2ekpfHjDxoJ6U2csb921an3zMk1NGtAa9ImR
         Lbft66T1ISERPELJc1zb4cC/QzgDS9y9Do+HZCFR/bk4kWbwzvzjUw0DJQ2jq2DNQkOf
         MHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEzXaR05SusPPC1DvCjjsQFeMd90WYnfj1cUKYhegZE=;
        b=IurW85unG1M73SIoodih1+TSSgc1ZQ8kHO0nyxDh8dx4clHpd3MiQGj4M8oE9Wcn+V
         lX4Qed68SPLQnjBZK7N2sqG8kGQ61P0L9592F3z29q/s8LTn/QOA/rFfRB76Rs5vGKBS
         SXv1VMhDfHj+jVTcitN3tLimmpllEXlMDUqH3k3doHIoou5/IiSVQodUCSq5xgqxa0xX
         Us6pCrC16dUBxIMIi0Dx0ZF6iOvu4TDj5daAaxoBV08pfUcVh2Ahs1E1gZEhdz3kwGY4
         Wa0sBDf+yN9UqcA8YyMDoRa+OwOdG+qHftEiC274OAd/FKCIZARqPmwa8Q4f4W4UXlZV
         37UA==
X-Gm-Message-State: AO0yUKWpsviGJD/rs0dD9XT3dpKUfddZG7Wb36c8/9U3SwECENN/Xn3A
        2bBN/ce/r8H+ahLwE5HFGTBy1g==
X-Google-Smtp-Source: AK7set/w5TMutzbY7TMwqS2Sdy2AZrf0aaxC5Vh9Ec926w/x34Wooj0jRJGk5yU9H7y61AKa3/HnVA==
X-Received: by 2002:a5d:6dd2:0:b0:2c4:b152:9ae with SMTP id d18-20020a5d6dd2000000b002c4b15209aemr1704298wrz.31.1675945696476;
        Thu, 09 Feb 2023 04:28:16 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/8] ASoC: qcom: q6apm-lpass-dai: unprepare stream if its already prepared
Date:   Thu,  9 Feb 2023 12:27:59 +0000
Message-Id: <20230209122806.18923-2-srinivas.kandagatla@linaro.org>
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

prepare callback can be called multiple times, so unprepare the stream
if its already prepared.

Without this DSP is not happy to setting the params on a already
prepared graph.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index ce9e5646d8f3..23d23bc6fbaa 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -127,6 +127,11 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 	int graph_id = dai->id;
 	int rc;
 
+	if (dai_data->is_port_started[dai->id]) {
+		q6apm_graph_stop(dai_data->graph[dai->id]);
+		dai_data->is_port_started[dai->id] = false;
+	}
+
 	/**
 	 * It is recommend to load DSP with source graph first and then sink
 	 * graph, so sequence for playback and capture will be different
-- 
2.21.0

