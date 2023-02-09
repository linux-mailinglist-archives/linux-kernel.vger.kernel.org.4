Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824696908C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjBIM26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjBIM21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBBC30C1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:28:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j23so1644832wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO9KJ117wKTOcC1OUg42YLZeFHf8xivZIBaKC4T0Ad8=;
        b=b9oygx40ldJo9LFfDxM4Te1QkbTRduIx2zVwXgfZZlw016ZqVoksT+wtVCQGunMT/J
         YjodNFj2pecm6xkX981QtGhSTVyPtLanuH3r+sXdTB0TcDZQXKNnaADCcOvzTHa1zj3j
         V7qtW6UTFA/Mvp2VPbdzlI+7RerZUVvD7KCQVI1+oGwJXR7PbS8vQHPluqqNvJFDTzfa
         6IOKqlub03jLkeKyoriFs6RIlaiTw8DuJAXG7RTu1jPbqEiLgZJ5OsCvS4MpoqI5HtFD
         qUh650ZARW0ePEJKErVcUo5+dpXXAoMX4YWQumZOAGbsUKlt7Qg1PYPPPYu5I001/x28
         RhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO9KJ117wKTOcC1OUg42YLZeFHf8xivZIBaKC4T0Ad8=;
        b=xK5EwQhm/VGy2zbm+kK2vDFn8ODwF4gYA7K7pls6ye+tqkeIrRpY5DZxpGwQNwyqKb
         OrdkfCOZdLr3VB2bjxDFrMIFRWhROz+cdXcurEH78uXvCBPA4wk2Y+C6ywz/+GkDDKJX
         AQqdt7W4ouphGkGLHiNbWqhvxhQng0YCa8IZsd/r/L94LXUxOwz9KItrJKQ+S0raSxdb
         +HPLUV/2P+V+exNhy/Vr3LZuw6ihxsUWBxcvWkbKKK+3RKnX56xsACSIGv1n+N8yfUAj
         rUzq1JVMEyt9+aJGupbczRlzbDa88oQoWiq84lVMPwHnllIWFaCQC+6PW2exn9kiQvLC
         kxZA==
X-Gm-Message-State: AO0yUKXOwY1iZehIDI2dZOhucuD5S6jrQ2aV6M4+ke+bdI3tdn515kYO
        x0oXaviYV8Ec/maZ6UzB79VXCw==
X-Google-Smtp-Source: AK7set+GamFipe+c8M1q6TLNFOo8pih+b9q2zXK486+LOUgbGRpEhNTbdAQDHNOVoUgWjdpJAGbahg==
X-Received: by 2002:a5d:4350:0:b0:2bf:d137:9945 with SMTP id u16-20020a5d4350000000b002bfd1379945mr9561299wrr.51.1675945705398;
        Thu, 09 Feb 2023 04:28:25 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:24 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 8/8] ASoC: codecs: lpass: remove not so useful verbose log
Date:   Thu,  9 Feb 2023 12:28:06 +0000
Message-Id: <20230209122806.18923-9-srinivas.kandagatla@linaro.org>
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

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c  | 4 +---
 sound/soc/codecs/lpass-wsa-macro.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index e0d891a67a12..a73a7d7a1c0a 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2296,10 +2296,8 @@ static int rx_macro_mux_put(struct snd_kcontrol *kcontrol,
 
 	aif_rst = rx->rx_port_value[widget->shift];
 	if (!rx_port_value) {
-		if (aif_rst == 0) {
-			dev_err(component->dev, "%s:AIF reset already\n", __func__);
+		if (aif_rst == 0)
 			return 0;
-		}
 		if (aif_rst > RX_MACRO_AIF4_PB) {
 			dev_err(component->dev, "%s: Invalid AIF reset\n", __func__);
 			return 0;
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index e6b85f3692ac..ba7480f3831e 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1856,10 +1856,8 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 
 	aif_rst = wsa->rx_port_value[widget->shift];
 	if (!rx_port_value) {
-		if (aif_rst == 0) {
-			dev_err(component->dev, "%s: AIF reset already\n", __func__);
+		if (aif_rst == 0)
 			return 0;
-		}
 		if (aif_rst >= WSA_MACRO_RX_MAX) {
 			dev_err(component->dev, "%s: Invalid AIF reset\n", __func__);
 			return 0;
-- 
2.21.0

