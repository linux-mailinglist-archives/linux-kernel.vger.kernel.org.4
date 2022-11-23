Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1827B6351A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiKWHzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiKWHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:55:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7C6720AA;
        Tue, 22 Nov 2022 23:52:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b8so12948625edf.11;
        Tue, 22 Nov 2022 23:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0yfirNFzSWzAhcJFMcFEJmgVxDm9YhSShEjcea986w=;
        b=mVj/FwhVcYMzmmP6AxFi7yqc+VHmkYbSfU6P2CcX2UFk13En38/5mWgcINrhK99rF0
         AqyVrj3uUWsdJ4Uk2CZjdSWHoyv0IvJidNtBFdKNHIla8e0WGA3rxv8iq3cuUuOMEu+q
         /+yeU10agp17Su3tYED3qb4kvtY/1fs9s4BZDXc1Zc5EdkBaH3mzScuut8bO+5bW4FkJ
         yavleHZfZCG0rqUFCOJzmFJj99LXdrlaLgGX/erQHjs3uHJBO89l88m64D7ekF/6T+XQ
         w1dc5kNBvuEGG25my1Wz7AbUoyBOQIizysbrnKk74jbAWkPQhAiolNjeIVz0OcSWRioJ
         EWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0yfirNFzSWzAhcJFMcFEJmgVxDm9YhSShEjcea986w=;
        b=fPSe4ygY9sWWWySruNZmv69FxF0VpeCSdOyS8oSEdWwzx8zhHONmnqmxUWYcOR20Sp
         j95YYhNux7/w80uyh7rnx//8ncXWFXk7ZJruV2irQ4bxdWj8QwiN1bg39QEtUUpQQdk4
         hrTGWFTeHBa6BrbRzXK1egHHG/ldKsqpH3iihaOjmKf6qtf7O21o7MdZ00aI+yqVD+op
         rgl2eo6PpDwKbhk3z8Xw4ACc8GSxzh1Ey+KOTKc1rhxCBJr6DSnX2p7ktUKNmiiLnKcn
         DD5fudB80lM03S0jd3SGd46q+7t/k+oiZYJyHbWQTgDS5Ooms22f5ODQExGFwrXSxGIp
         NKmQ==
X-Gm-Message-State: ANoB5plrIeoBxSIvAfyz9h6kRveE1bCrhvwnTpBo1Ccy7wHFc7uRauPO
        stJ0Ie8NGcTiUWFOmK92FEMIuujVPEQ=
X-Google-Smtp-Source: AA0mqf5Xvi3z9Sp5yVfGgZrxfUb2PGtJP+JBHOpfXSH2C8Ujhc7Qtn9CkEBRCV0uOdixgrRjfeTo6A==
X-Received: by 2002:a05:6402:12d5:b0:469:885b:fcfd with SMTP id k21-20020a05640212d500b00469885bfcfdmr9646583edx.177.1669189976429;
        Tue, 22 Nov 2022 23:52:56 -0800 (PST)
Received: from felia.fritz.box (200116b826997500d517ac74edd630a9.dip.versatel-1u1.de. [2001:16b8:2699:7500:d517:ac74:edd6:30a9])
        by smtp.gmail.com with ESMTPSA id w14-20020a056402070e00b004691de0e25bsm6112889edx.54.2022.11.22.23.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:52:55 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] media: imx: remove code for non-existing config IMX_GPT_ICAP
Date:   Wed, 23 Nov 2022 08:52:16 +0100
Message-Id: <20221123075216.28193-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There never was a config IMX_GPT_ICAP in the repository. So remove the code
conditional on this config and simplify the callers that just called empty
functions.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/all/20221122132330.30408-1-lukas.bulwahn@gmail.com/

v1 -> v2:
  - addressed Tommaso's feedback: remove braces for single statement blocks

 drivers/staging/media/imx/imx-media-fim.c | 57 +----------------------
 1 file changed, 1 insertion(+), 56 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
index 3a9182933508..fb6590dcfc36 100644
--- a/drivers/staging/media/imx/imx-media-fim.c
+++ b/drivers/staging/media/imx/imx-media-fim.c
@@ -187,54 +187,6 @@ static void frame_interval_monitor(struct imx_media_fim *fim,
 		send_fim_event(fim, error_avg);
 }
 
-#ifdef CONFIG_IMX_GPT_ICAP
-/*
- * Input Capture method of measuring frame intervals. Not subject
- * to interrupt latency.
- */
-static void fim_input_capture_handler(int channel, void *dev_id,
-				      ktime_t timestamp)
-{
-	struct imx_media_fim *fim = dev_id;
-	unsigned long flags;
-
-	spin_lock_irqsave(&fim->lock, flags);
-
-	frame_interval_monitor(fim, timestamp);
-
-	if (!completion_done(&fim->icap_first_event))
-		complete(&fim->icap_first_event);
-
-	spin_unlock_irqrestore(&fim->lock, flags);
-}
-
-static int fim_request_input_capture(struct imx_media_fim *fim)
-{
-	init_completion(&fim->icap_first_event);
-
-	return mxc_request_input_capture(fim->icap_channel,
-					 fim_input_capture_handler,
-					 fim->icap_flags, fim);
-}
-
-static void fim_free_input_capture(struct imx_media_fim *fim)
-{
-	mxc_free_input_capture(fim->icap_channel, fim);
-}
-
-#else /* CONFIG_IMX_GPT_ICAP */
-
-static int fim_request_input_capture(struct imx_media_fim *fim)
-{
-	return 0;
-}
-
-static void fim_free_input_capture(struct imx_media_fim *fim)
-{
-}
-
-#endif /* CONFIG_IMX_GPT_ICAP */
-
 /*
  * In case we are monitoring the first frame interval after streamon
  * (when fim->num_skip = 0), we need a valid fim->last_ts before we
@@ -434,15 +386,8 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
 		update_fim_nominal(fim, fi);
 		spin_unlock_irqrestore(&fim->lock, flags);
 
-		if (icap_enabled(fim)) {
-			ret = fim_request_input_capture(fim);
-			if (ret)
-				goto out;
-			fim_acquire_first_ts(fim);
-		}
-	} else {
 		if (icap_enabled(fim))
-			fim_free_input_capture(fim);
+			fim_acquire_first_ts(fim);
 	}
 
 	fim->stream_on = on;
-- 
2.17.1

