Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C663867981D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjAXMa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjAXMaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:30:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778A8170F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:30:54 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y1so9225610wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/edt5p2gptX1Yr8iTGEIPIaPkWv+29GnkFExbVNe7+Q=;
        b=SwP1b453lPpB8Bk2UiqxslsCzhUb7NEApaNdDthpaijuJwAiREKdtBQ3nle2qbSIYl
         nvPE/Vc/BRQxVivmhzJ4aTkBgahNfC6WxSFsBj1p/EFDf6+QIYvcyaXkOav6uoCpJy+m
         qDvZF94+bCBVS+nvXXp9cEzretOSETfN5QyZvT6pJ0466/Yg8N7dpRISbjkBMhtQ6SFo
         jl5Iz1AMoQtb2KrpNfKiu6NeIFfWHf2vid7gWxv2ZioSWdGlcfYmxE0khSlbCiUFAs+9
         RuBZcWFM2fW4rSaV0DSPSzTkrJEbUGJqxLrgcG9wkbXclNiSVZMAsZSffwqyZfajMXpH
         TI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/edt5p2gptX1Yr8iTGEIPIaPkWv+29GnkFExbVNe7+Q=;
        b=TeKXWbFmwGQ20wmTvP1T7SRqhnucOwdxYVo8ulPOD0gnGAAB6kZNVYnHeuSoctzK1v
         wxOn6G5pSIvDdi/N7wD8npayo2bSm5Wmc0I3/KrrWS3BVPo9bg6TZmo8/blWOh5Ze+L0
         rYncfT+B1wthQbPzpAxzqiDKNezV84icjn5IKB+N+PGEMbOgTJGZcjTlL622uJJ8jwzM
         8cEtOl+SJ09LfzOGWB7Ab6sO6emeItokKwckGeFhUy/GedM2+/fRuJyAIP8LWtDjd1xx
         LAdFY6Oq1/n8JCi1K02YzjiBICWchD5+bDByjSEiTfuJwWCd6otIrpkQmM7gGdL5DRlJ
         VKrw==
X-Gm-Message-State: AFqh2ko6KF3yVwJEf0L5f81vqVTHVo4LAr+Sa1C2zLRX8iW6cwoNXOcM
        6Mj8k0ygVEaFqiBNVXlu6gOygg==
X-Google-Smtp-Source: AMrXdXsyPMQsKO5fS3S0xgCOvOH6nAUs+ZJsTXIY7pPzkFIz3d/QKi9ld/O97coP9iIoK+1NM33cQg==
X-Received: by 2002:a5d:5f06:0:b0:2bd:d1be:ec99 with SMTP id cl6-20020a5d5f06000000b002bdd1beec99mr18750958wrb.66.1674563452973;
        Tue, 24 Jan 2023 04:30:52 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f9-20020a5d4dc9000000b002ba2646fd30sm2127613wru.36.2023.01.24.04.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 04:30:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wsa883x: correct playback min/max rates
Date:   Tue, 24 Jan 2023 13:30:49 +0100
Message-Id: <20230124123049.285395-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct reversed values used in min/max rates, leading to incorrect
playback constraints.

Cc: <stable@vger.kernel.org>
Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 8d69ed340e83..be211422d38f 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1359,8 +1359,8 @@ static struct snd_soc_dai_driver wsa883x_dais[] = {
 			.stream_name = "SPKR Playback",
 			.rates = WSA883X_RATES | WSA883X_FRAC_RATES,
 			.formats = WSA883X_FORMATS,
-			.rate_max = 8000,
-			.rate_min = 352800,
+			.rate_min = 8000,
+			.rate_max = 352800,
 			.channels_min = 1,
 			.channels_max = 1,
 		},
-- 
2.34.1

