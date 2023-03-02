Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC56A8036
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCBKqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCBKqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:46:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B393771B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:46:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so1218943wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677753993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GO6tJSKGhuKgdHNgP3IEYgtiqFiDG7WtsDPxWBs+xKc=;
        b=E6+g09byyy+IW3IG+Z9rsgrNe2X8rBBoRl7EopRxtys36mVnmVl5GRdCVC8JuNM10g
         GT3Zmpbo3cfkeicd92FRIGrMY4kLlwlRc+r0MLqTH//P1e0uI/ZOnYhkoUsr5csmBALM
         FI7a9REbNUHREnzPKLZWtmQBSSRLg/JCf+oAus7LGmxe21A002xt2d8X5o7Ph7P3TqlC
         TZhVS0Bqu6H1GBQiW+itYbN/QoNQ1p8jf+vOoAmbQAsjIDnkTyaWMz/5QniNcaSTnj/X
         beYJCZbaKW8ELycRSIW1cCBDA6EaNd48Hi6e4iF3F/qnkHCIEEPbt2WFPipyg/y9KC8k
         TwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677753993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GO6tJSKGhuKgdHNgP3IEYgtiqFiDG7WtsDPxWBs+xKc=;
        b=pN3Ts/0jA3Zcid4stW2/A9szIzvqxH4xmPPpPVDfnMecgBSDJyr6B8yAOjRdfSXeT9
         Q+7S11uT9AhhYHner4mQeTIPYe6ri2P3inZCb6ocFFG8yVYi3/LzpedBDpk5W1yTjyYA
         AFjZw05xOzHdi7LmcemfW8+7rSVxkH2QSf55iiWoo3z6GCUV6MDIikn1U4ZXOU9g2KoS
         WgtVWMmjeLm5afXIeJvPNhFxgikAUnErdhYj6+emVhWSZUDLly7rBfohwe8bMHWrniUK
         Xx1RzmCDbtee2F3G4mnkop7TNW6Rl7jwPlNSqodRAO5D4yZ+Mm9lBpRX26e5z0N3zxlZ
         ADYw==
X-Gm-Message-State: AO0yUKUv468X0Gw+vwcqS+/csv7IYK6btpyZ3+ImHVUsZP/8k+u0e8A+
        uTIP39GzYUJG+Ud/AD9hQzLftA==
X-Google-Smtp-Source: AK7set9Djd/6Vxw96gglKjfyYL7bSnZSB5gVDpn5iQoeb4+SPKAZKAF6cOCxFs2oRJeyQX9fIQIPeA==
X-Received: by 2002:a05:600c:1608:b0:3df:e41f:8396 with SMTP id m8-20020a05600c160800b003dfe41f8396mr7078567wmn.37.1677753993153;
        Thu, 02 Mar 2023 02:46:33 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id iz2-20020a05600c554200b003e11ad0750csm2522592wmb.47.2023.03.02.02.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:46:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: common: add kcontrol to jack pins
Date:   Thu,  2 Mar 2023 10:46:16 +0000
Message-Id: <20230302104616.26318-1-srinivas.kandagatla@linaro.org>
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

Add Kcontrol to jack pins so that device switch in ucm can be done correctly.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 96fe80241fb4..c1f24af17506 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -180,6 +180,18 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_GPL(qcom_snd_parse_of);
 
+static struct snd_soc_jack_pin qcom_headset_jack_pins[] = {
+	/* Headset */
+	{
+		.pin = "Mic Jack",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
 int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 			    struct snd_soc_jack *jack, bool *jack_setup)
 {
@@ -189,13 +201,14 @@ int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 	int rval, i;
 
 	if (!*jack_setup) {
-		rval = snd_soc_card_jack_new(card, "Headset Jack",
+		rval = snd_soc_card_jack_new_pins(card, "Headset Jack",
 					     SND_JACK_HEADSET | SND_JACK_LINEOUT |
 					     SND_JACK_MECHANICAL |
 					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
 					     SND_JACK_BTN_4 | SND_JACK_BTN_5,
-					     jack);
+					     jack, qcom_headset_jack_pins,
+					     ARRAY_SIZE(qcom_headset_jack_pins));
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headphone Jack\n");
-- 
2.21.0

