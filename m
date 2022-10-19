Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF3603A69
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJSHPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJSHPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:15:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF572604BB;
        Wed, 19 Oct 2022 00:15:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y10so12333100wma.0;
        Wed, 19 Oct 2022 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzG7rF/hL8AaILutgmFHP6Nzj7X2cB1iupzaPr0EybQ=;
        b=Hd1D8RDBZUiOgSklpaiMmMXGgKPJP7htFBWoSGkCxqDPip1mFLver9vAhpI/BudG4Y
         E6Tqf6+dOpiJwF708AlDuej6WaU/X33lqFanuH4Ic1057FwVfLFDLU/Axp5fR1g2iTZq
         1R4nYVewDuXIqd94yGenrt33+gW8w3+sjg8UJR2KDSf+MQae9vQFhwd2cItsUHpDV+Ri
         WXoIhFLy0ozob6V/FAmLdrX/3OqxPdrlYgUq2Zrl+z4ODNTzEMjPD+KQ1n/HueSVpg++
         2jYi7EWi2R/y3b33RGUfhAeztps642ZGufHet6lfjUf3yRts1l1n/OC2myMtPQ8xFKyU
         YsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzG7rF/hL8AaILutgmFHP6Nzj7X2cB1iupzaPr0EybQ=;
        b=WajYvoldXuvi67UFcFp1wRZ78uarpmTUEXq7NHZVP4iD0UJfVFAFojH0ECxtzF4AMx
         CILuPS7ZB/nZRNM2C6ZkfYW49RvSuw0S2tvG7MrlYL1pHey3ybkCsJJkEUbkdfHu6lgN
         dixuARCN7KmIldpJtntLKVfNxkeirUBwN4zH/NDk3ZBI5wYW62QPghCH0L2nLFatje3k
         KoYnoFojuyhJQAGD6ZSEfNr4F2NSu/ks9Jk/krJObcXvh4tq/S9+NDuRq3nCD9rWtXbw
         NO4u4Y3nwvNnz6nK8ktcFrZlIY4/ZYG+ELs4Biuk4h6z+lI10EIfDTQP5B0msUU79Kbb
         qZEw==
X-Gm-Message-State: ACrzQf35J+v6Mwrn+5p9CVeuyIuqjGrEpsHjQrofk6YP/hOoRrlw6im5
        Z0fUGNpULHUNpiqpBZWnarA=
X-Google-Smtp-Source: AMsMyM77uAhaOzr8WSUOTle4NC05TESdssMRf6wmJL4tpYpF7Ha9ugCvBiXdebOzOSl4APveHHHK2A==
X-Received: by 2002:a7b:c34a:0:b0:3c6:e069:d41c with SMTP id l10-20020a7bc34a000000b003c6e069d41cmr20834649wmj.180.1666163710295;
        Wed, 19 Oct 2022 00:15:10 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b003c6ee9e254dsm13468311wmo.32.2022.10.19.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 00:15:09 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: codecs: jz4725b: Fix spelling mistake "Sourc" -> "Source"
Date:   Wed, 19 Oct 2022 08:15:08 +0100
Message-Id: <20221019071508.1003680-1-colin.i.king@gmail.com>
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

There is a spelling mistake in codec routing description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
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
+	{"ADC Source Capture Routee", "Line In", "Line In"},
 	{"ADC Source Capture Route", "Mic 1", "Mic 1"},
 	{"ADC Source Capture Route", "Mic 2", "Mic 2"},
 	{"ADC", NULL, "ADC Source Capture Route"},
-- 
2.37.3

