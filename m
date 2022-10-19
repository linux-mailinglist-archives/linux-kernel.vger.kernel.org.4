Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6DB603A71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJSHQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJSHQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:16:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2BD642D1;
        Wed, 19 Oct 2022 00:16:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bv10so27484817wrb.4;
        Wed, 19 Oct 2022 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ysf/zEngfFxJwaRTUXhnPtM52VvGSDLZl+NVWHEroaU=;
        b=lMLFv7po/8jJjZkjh9Z/E+yB141KW96EzmZi0xvJZ1wxGQiR6wWIMGW97TkhtZhQ9B
         olMRJ3EQfFlFXESbGyn1tNtBDNjB5rCLqJr5RYl6ZcqF+b2pTY0S1OJN/xNq2Jwrnqq7
         hr567rZY8Juc+5gu47BTxDlm84OtFzRk949KgqgPW3FOxnP5iP0q5vArf5iElxdz6Fxr
         kwMthtKK5sM9gdgL+TMO53Bi/3BKnNujPWvR8gIBHrNrxittCWKo0XQmWrSh64Qwql+h
         9KLGGnIRkRkyHtD6ps9s5O9V7PpeXTxIVLDk3a9qwong8qg82p+Ao0RUHchD9oYRVG7E
         PzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ysf/zEngfFxJwaRTUXhnPtM52VvGSDLZl+NVWHEroaU=;
        b=1hRhy64Sajvgnu/A6n7m8DCASjrveYgFPROsQvO564ZD0mV2LjX3e3Lr63Fbt9VnZd
         2BxhJf/wdVi4ANOUKAfDHzkhpWlK5xM+63p16vhIyD5cnGdXvDtMquRjQseFVR1eX2Mi
         2HjSgd/zyqgw+FLjS0Xfl5hekJYvGSqGahzjX0z1cNTc8pjwhDiEVZu4eJJeb2pFYFol
         EvbhndJUjUqjmiDsuRTd1J2Lvr2rqPCT/9ko6euQYogs24nM9QpAQfn+ue15/oxT/mvg
         FZ60Jw549zXIFLilC5bmB3s7wQlxAPzEnHMs+2K4tdjKGmw0WmSCCUXFx/851n9pzK/7
         pg7w==
X-Gm-Message-State: ACrzQf1xmOUjGyiUY4H61bLm5047P2fA8N+FhsLCNgud/LNaTMfYqLku
        jMalv+AI07inOS6xvbKOmvQH8m6cmxj+h4FR
X-Google-Smtp-Source: AMsMyM4dwKmwe6ioEkSvwbefw+MiX9Z/Zh0ET0C4siBkA0rEKYqyfI+Vpyf0oRbeSYZdm/13uNUjBw==
X-Received: by 2002:a05:6000:154e:b0:230:45ad:fb87 with SMTP id 14-20020a056000154e00b0023045adfb87mr4246989wry.270.1666163800825;
        Wed, 19 Oct 2022 00:16:40 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c2ccc00b003c6f27d275dsm12285088wmc.33.2022.10.19.00.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 00:16:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] ASoC: codecs: jz4725b: Fix spelling mistake "Sourc" -> "Source", "Routee" -> "Route"
Date:   Wed, 19 Oct 2022 08:16:39 +0100
Message-Id: <20221019071639.1003730-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two spelling mistakes in codec routing description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: Fix "Routee" -> "Route" too
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 685ba1d3a644..64b14b1c74b9 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -359,7 +359,7 @@ static const struct snd_soc_dapm_route jz4725b_codec_dapm_routes[] = {
 
 	{"Mixer to ADC", NULL, "Mixer"},
 	{"ADC Source Capture Route", "Mixer", "Mixer to ADC"},
-	{"ADC Sourc Capture Routee", "Line In", "Line In"},
+	{"ADC Source Capture Route", "Line In", "Line In"},
 	{"ADC Source Capture Route", "Mic 1", "Mic 1"},
 	{"ADC Source Capture Route", "Mic 2", "Mic 2"},
 	{"ADC", NULL, "ADC Source Capture Route"},
-- 
2.37.3

