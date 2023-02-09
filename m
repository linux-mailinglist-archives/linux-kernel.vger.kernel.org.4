Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1106908C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBIM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBIM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:22 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F923C62
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:28:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a2so1590099wrd.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la+zSqZHnDH4NrBUp1B5sU6rN4yJdP2UMwQ4cL39N1A=;
        b=NjJeO8GgEt5hDiYdbv5bupUhixSFr+wUIsKkd+sY5GLYBTq3Hm+wfWYDNRbQCj3qyY
         lOCho4plKkO9xSwt3s6vP5IOL3mcbj0Ex52Mfmy1ajY5I7d5jaohXOg55uyzw2cgg3KI
         zgy84M8Q2FOmONb5dw8Q94MiDi+jbATkcD7EUUIhhDRYnFxgGTlyP3aKIr+4McvVWIGu
         STr+HyKJGeHESpFdQIBMdibvzGHzG6bf02K5nMsod7TWj1YZmiLmmXL3cwAnjnQVSnB3
         FMVlG4qroocbJHKg/bHiL9zWuyvnSsHQmeD/CtqPUwprP2y2DmVZaIuGXhyRuxevolhG
         7wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la+zSqZHnDH4NrBUp1B5sU6rN4yJdP2UMwQ4cL39N1A=;
        b=UnvmK6DUkOKqRYH848vIuWqlFVYj66Qc3ixVxfzSDeRUnG0qNb9wh3ZhO4uMA1kzBH
         JrQOsPSonmCv27fbGyQx36iH2CgDx4X7Wp3kRHuSyskyA6TCQbZIGgkeguw5oVS50cT6
         QTntz2MCnQeEqJbc09VRRj+kRW8XgftEJkR6RalmXgF+sneqxivdusCLvpCHEj9fO+lf
         XXzPwSFzU13Xla0zSnxep1vcqKzE2vmXxm5sV3zerf72eWXNqpaKMy33tSDmNl3IxYKR
         Ss0Y4kxN/u5iytQ3G4JghkXlicrOtrDVabWkJl/B+pGfjAuzW9JqCjkOZmU1VtHMgsBO
         7HJQ==
X-Gm-Message-State: AO0yUKXAehZMMmOQ66DJGgq3g9aMCGGKyPArn6RftIva4NGay2423Mva
        jv/sh+k+MBevWWrHhdRJaeK62A==
X-Google-Smtp-Source: AK7set/AU65Rnx4Ciaza1virFRj0oTjWBnjQjLYEOCtTb8yh6x2aof018UXZTiQsjFqaLAQSMVUJWQ==
X-Received: by 2002:adf:f9cc:0:b0:2c3:e7d8:245c with SMTP id w12-20020adff9cc000000b002c3e7d8245cmr10617613wrr.13.1675945699206;
        Thu, 09 Feb 2023 04:28:19 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/8]  ASoC: qcom: q6apm-dai: Add SNDRV_PCM_INFO_BATCH flag
Date:   Thu,  9 Feb 2023 12:28:01 +0000
Message-Id: <20230209122806.18923-4-srinivas.kandagatla@linaro.org>
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

At the moment, playing audio with PulseAudio with the qdsp6 driver
results in distorted sound. It seems like its timer-based scheduling
does not work properly with qdsp6 since setting tsched=0 in
the PulseAudio configuration avoids the issue.

Apparently this happens when the pointer() callback is not accurate
enough. There is a SNDRV_PCM_INFO_BATCH flag that can be used to stop
PulseAudio from using timer-based scheduling by default.

According to https://www.alsa-project.org/pipermail/alsa-devel/2014-March/073816.html:

The flag is being used in the sense explained in the previous audio
meeting -- the data transfer granularity isn't fine enough but aligned
to the period size (or less).

q6apm-dai reports the position as multiple of

prtd->pcm_count = snd_pcm_lib_period_bytes(substream)

so it indeed just a multiple of the period size.

Therefore adding the flag here seems appropriate and makes audio
work out of the box.

Comment log inspired by Stephan Gerhold sent for q6asm-dai.c few years back.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index bd35067a4052..7f02f5b2c33f 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -64,7 +64,8 @@ struct q6apm_dai_data {
 static struct snd_pcm_hardware q6apm_dai_hardware_capture = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_INTERLEAVED |
-				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
+				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				 SNDRV_PCM_INFO_BATCH),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE),
 	.rates =                SNDRV_PCM_RATE_8000_48000,
 	.rate_min =             8000,
@@ -82,7 +83,8 @@ static struct snd_pcm_hardware q6apm_dai_hardware_capture = {
 static struct snd_pcm_hardware q6apm_dai_hardware_playback = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_INTERLEAVED |
-				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
+				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				 SNDRV_PCM_INFO_BATCH),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE),
 	.rates =                SNDRV_PCM_RATE_8000_192000,
 	.rate_min =             8000,
-- 
2.21.0

