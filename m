Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC44F5FFF9B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJPN2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJPN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:27:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E3F1A813;
        Sun, 16 Oct 2022 06:27:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s2so12694169edd.2;
        Sun, 16 Oct 2022 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqjTgeUd6gWhUWYVrTKOj3mTSf21kU7OjGiHvk8JsVI=;
        b=nnhEubGWYhDFWbs8jnu2ZsbffdvT/gOCsYhx0i17+WGLo3+P9CsnAUUN4ByFGjBKum
         IsSgxTK4Jbh+Z75eNSWa9BzjNX6rm/m27aECTaRsq4f6S2xTUFPfglDV6P0xpqeMfLAr
         36KldilDoSeXXtLnCnCeKMTs7GLMCGGqvDFFgkTJLB2MAF62ku9mwJLovpo5/56xuGco
         ShSuoxhuXM2bmiVldaRdh+7VNdncdQid8v/pqoIZymz3JVSt7LMfGHAjEEcVrdUKQpSq
         R3HGEx3ZGGEeLlBtCThUy31hZT0sCZ6sPCSSxsxRnomIa2Kxs0uYwVCMaENHNV99U4U6
         1YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqjTgeUd6gWhUWYVrTKOj3mTSf21kU7OjGiHvk8JsVI=;
        b=LV/CA6TI4cqCWlUcQuGQJmL++ise6nGB354r3LKEk4R74YrO6BWDfaldrsb4WKpeC4
         Uz/mODoRF57ZO1+KH+sjB6yaB8j8GmstT7+G28CU9k6OjubpXRy0lqnQDILEKgsDTKdZ
         KJZcmdd+qxIdryfN5W3r2CtnX5yJ/za+bdPs9A9DOG9w8+/1213NI5paKADRmYgMNfAU
         43u3tymHhhAk6+OutPM8GNhGHrzT1gIoIHvCNZtowMABqD+ggg8KWUGhgvNFRCVhy/kr
         iMaqMDwrf2dDcr5jX6HgfXLU0yad1SjsZyA4k9baTwvV0/FpRCDM4WkKrzwxhTGIhgUD
         VYHg==
X-Gm-Message-State: ACrzQf3LVOKYFelPpKQpEoLKs6RvMj8VbBiFEKPVvxswijCTUe328L2k
        jpUAJkQPN3EfWZGI+QmlNDA=
X-Google-Smtp-Source: AMsMyM4suZSAWgqPObYYUnsdjfTMP7uEvVdDuRDd5N912MwgTFrE4+Jo83pgDCd7mOf5mv/MFC4E8Q==
X-Received: by 2002:a05:6402:40c4:b0:45c:c718:54d1 with SMTP id z4-20020a05640240c400b0045cc71854d1mr6213755edb.319.1665926872430;
        Sun, 16 Oct 2022 06:27:52 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ce85000000b0045c72bba0bfsm5572057edv.4.2022.10.16.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 06:27:51 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] ASoC: codecs: jz4725b: use right control for Master Playback
Date:   Sun, 16 Oct 2022 16:26:46 +0300
Message-Id: <20221016132648.3011729-6-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016132648.3011729-1-lis8215@gmail.com>
References: <20221016132648.3011729-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment DAC control is used as Master Playback control, this is
incorrect as DAC's output goes to a Mixer.

The Mixer couples analog input from 4 sources (DAC, Line In, Mic 1,
 Mic 2) each input has its own gain & mute controls.

Output of the Mixer goes to Output Stage control which is the best suite
for the new Playback Master. However, it doesn't have mute capability.

The patch implements Output Stage control as a new master and renames
old Master to DAC. Rest of mixer inputs will be implemented in the next
patch in the series.

Manual states that Output stage control (16.6.3.5 Programmable output
amplifier: PGAT) gain varies from -33.5dB to +4.5dB, gain step isn't
fixed and has 3 opts.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index d57c2c6a3..c39398e0a 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -136,6 +136,12 @@ enum {
 #define REG_CGR3_GO1L_OFFSET		0
 #define REG_CGR3_GO1L_MASK		(0x1f << REG_CGR3_GO1L_OFFSET)
 
+#define REG_CGR8_GOR_OFFSET		0
+#define REG_CGR8_GOR_MASK		(0x1f << REG_CGR8_GOR_OFFSET)
+
+#define REG_CGR9_GOL_OFFSET		0
+#define REG_CGR9_GOL_MASK		(0x1f << REG_CGR9_GOL_OFFSET)
+
 #define REG_CGR10_GIL_OFFSET		0
 #define REG_CGR10_GIR_OFFSET		4
 
@@ -147,9 +153,14 @@ struct jz_icdc {
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_adc_tlv,     0, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_dac_tlv, -2250, 150, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(jz4725b_out_tlv,
+	 0, 11, TLV_DB_SCALE_ITEM(-3350, 200, 0),
+	12, 23, TLV_DB_SCALE_ITEM(-1050, 100, 0),
+	24, 31, TLV_DB_SCALE_ITEM(  100,  50, 0),
+);
 
 static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
-	SOC_DOUBLE_TLV("Master Playback Volume",
+	SOC_DOUBLE_TLV("DAC Playback Volume",
 		       JZ4725B_CODEC_REG_CGR1,
 		       REG_CGR1_GODL_OFFSET,
 		       REG_CGR1_GODR_OFFSET,
@@ -160,7 +171,13 @@ static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 		       REG_CGR10_GIR_OFFSET,
 		       0xf, 0, jz4725b_adc_tlv),
 
-	SOC_SINGLE("Master Playback Switch", JZ4725B_CODEC_REG_CR1,
+	SOC_DOUBLE_R_TLV("Master Playback Volume",
+			 JZ4725B_CODEC_REG_CGR9,
+			 JZ4725B_CODEC_REG_CGR8,
+			 REG_CGR8_GOR_OFFSET,
+			 0x1f, 1, jz4725b_out_tlv),
+
+	SOC_SINGLE("DAC Playback Switch", JZ4725B_CODEC_REG_CR1,
 		   REG_CR1_DAC_MUTE_OFFSET, 1, 1),
 
 	SOC_SINGLE("Deemphasize Filter Playback Switch",
-- 
2.36.1

