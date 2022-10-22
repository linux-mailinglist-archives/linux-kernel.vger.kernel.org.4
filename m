Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E425B608F27
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJVTNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJVTNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:13:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5818075CE5;
        Sat, 22 Oct 2022 12:13:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so7329906wmc.4;
        Sat, 22 Oct 2022 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgkOKKf/r2OGCWExBVS97xfrlAiQor24qr6UWM7ySCA=;
        b=WOfoZi833xSQNoqbUva8zSvumFMNi4oN/hbLXs/rAC+Tt/M1dd0nB6yPDmVTXG+Wzk
         gOA9JlvWrvlbRBJ+inkmeR+iwuHv/m67bq2nYDGpx6PLPRQ8Fz7URRI4HUxZc+SbW/Ev
         4KJyAqDcYk7uqraz98JZHkF2ItMGF8TPVs3fnKAT0qkxPCBQz0j9MY2uWBPmvkYbPx4p
         TVjTwc2jaz5xW7OU8B/7viHC8T7BYDpsyEupy1DBfkjzjdkYlr3siyx3YiDvsnq1XibV
         sQpvfXmlGeTMmnh1WqnFIGsuuvQJ0mZXJfK1bB18uZeGTpvvKjgmFBS90xpVtjr3Kmeu
         ZvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgkOKKf/r2OGCWExBVS97xfrlAiQor24qr6UWM7ySCA=;
        b=mpdFKjEDtmFng4XVYd321zxYAFNymDscHDUaG5gBwurDgfGD2OR2FbTrd51KuL9jz0
         4WP2jpvsnC9Fr7gRs6c0QG2SQ/4K7C2iFgeBXT5Ed2wVzUybsro2RRM3eGorjvp0eGDs
         5GvCvOlHdE1dHs0Luhi7RS9BpI9mHFvipp6FgdGSE/En5ts5Cr2kQPrI4NiZzHTvrzrb
         gbHgjjav6C0HknrfNKDKjI8n/cHrZOl8oIDv9ce+wb2cMIN0j4dh/QyvXlzgA6cyVUFs
         o3vdRTExxT78CIDSxlJz/X8xy1I1GDr/HCVrsuMEZam4f6Mb2bBAmaTYOoCcHpV+J1B0
         N9rg==
X-Gm-Message-State: ACrzQf1PgpQRhBd+uhiTs/NdrzrTHBBD/TmiemkJEYMVhfNrWEFJcer8
        Gyx8ZzwJTe+DMteSm/hbyAQ=
X-Google-Smtp-Source: AMsMyM4Q3zLGnh37Z3bU3hmYSQozdNyFVL+JzyKDjLFE6v+O3DutgjJmzDp/B3LrouF8xSDpiJU5Hg==
X-Received: by 2002:a05:600c:4187:b0:3c6:fe18:b2a with SMTP id p7-20020a05600c418700b003c6fe180b2amr17601965wmh.41.1666466008979;
        Sat, 22 Oct 2022 12:13:28 -0700 (PDT)
Received: from localhost (94.197.1.68.threembb.co.uk. [94.197.1.68])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b003c7087f6c9asm3590947wmq.32.2022.10.22.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 12:13:28 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/9] ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
Date:   Sat, 22 Oct 2022 20:13:05 +0100
Message-Id: <20221022191308.82348-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio controller on JZ47xx SoCs can transfer 20- and 24-bit
samples in the FIFO, so allow those formats to be used with the
I2S driver. Although the FIFO doesn't care about the in-memory
sample format, we only support 4-byte format variants because the
DMA controller on these SoCs cannot transfer in 3-byte multiples.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index c3235e993ffb..fd35a8a51f60 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -237,9 +237,15 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S8:
 		sample_size = 0;
 		break;
-	case SNDRV_PCM_FORMAT_S16:
+	case SNDRV_PCM_FORMAT_S16_LE:
 		sample_size = 1;
 		break;
+	case SNDRV_PCM_FORMAT_S20_LE:
+		sample_size = 3;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		sample_size = 4;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -374,7 +380,9 @@ static const struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
 };
 
 #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
-		SNDRV_PCM_FMTBIT_S16_LE)
+			 SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
-- 
2.38.1

