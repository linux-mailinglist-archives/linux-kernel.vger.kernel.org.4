Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D058E633D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiKVNYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiKVNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:23:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4D81A07D;
        Tue, 22 Nov 2022 05:23:51 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m22so35688067eji.10;
        Tue, 22 Nov 2022 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV4i7O8BzgnNi9s3HIsw9M8JIdyfTKAykF37RMUEeDI=;
        b=FmwPwbnr0QiwbN9cFi0HeIzq91QfJ9NAmquz0Iv6i36HQBqvOLp7Xbg/fMhtUACapS
         2W5H6W73OAc6rbsdatD8MTqCkgrmhxEPVkoQwhbQwq7frlPhDLzqs7IWxoWcEcmlZAOt
         hZPaLY0H6iDWRRpzclVQuU8j/nK0rI7fWRYG5uaHTCpz8W6UhCP2WpdQXBd1kFC5ZglH
         OH/pWbbGqFRMuIZkp9PeHgOlTUuGf8mBarEUFQvkfarXgHildhXmJzv0/R7ZX4bMB9aS
         XPkuXpLV7mDnnF5mxRoJRm1OuiwRmL1/PJGZ0UxNKkdWkTHtRPIopDZziAAA7DnxWNLm
         UaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV4i7O8BzgnNi9s3HIsw9M8JIdyfTKAykF37RMUEeDI=;
        b=SeoH4GLIMknVVJ67q8a4MeO7+K5Iq4uufNvAxVuTGDp40SBob0hAuodzzJznL3Q0n7
         BzC9loyhnfjls0OqyebgWfsLAZW08DoQrOhwSCdyceFsKoSm7NPGm5KQIc68KLdrGhxZ
         JxUNfGJwCr5yEYSSD1exdPK0RN5Rw68FsvRbZb1ZBty3TJeOkW7drjnmqfWtSp3jGuIi
         UQQkMIteDX7Q4aYJHd3lKNtyLsiLG54V1FcI0Sa0W071lyN651nW5ZGWo5Hdm8BzMSNK
         ghyAYj1uFOrR+FiwsIuHhI7AzhZcODi8Fxa8wCn7vv9GBMPFsB+0m7Dzx4PITPnhePOU
         TvmA==
X-Gm-Message-State: ANoB5pnpeqsPcA4vOV8lnmyYdSylwEjWM6TTt77FFRd4YigdUxYqgkk0
        z6wirOGrakAu9RYKHuC9/Bk=
X-Google-Smtp-Source: AA0mqf5zQy0JMJm9xD6ZBOVIN5DHUP0heNHNJ5Y+eIMmNRJoeW2dTtMzPucyUyRkNu04MavtMVvUcA==
X-Received: by 2002:a17:906:1244:b0:78d:d4ca:21f7 with SMTP id u4-20020a170906124400b0078dd4ca21f7mr20059292eja.128.1669123430366;
        Tue, 22 Nov 2022 05:23:50 -0800 (PST)
Received: from felia.fritz.box (200116b8267b3700c41d4e99e424db57.dip.versatel-1u1.de. [2001:16b8:267b:3700:c41d:4e99:e424:db57])
        by smtp.gmail.com with ESMTPSA id bd27-20020a056402207b00b004585eba4baesm5429717edb.80.2022.11.22.05.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:23:49 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
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
Subject: [PATCH] media: imx: remove code for non-existing config IMX_GPT_ICAP
Date:   Tue, 22 Nov 2022 14:23:30 +0100
Message-Id: <20221122132330.30408-1-lukas.bulwahn@gmail.com>
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
 drivers/staging/media/imx/imx-media-fim.c | 54 -----------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
index 3a9182933508..19a48eb445fd 100644
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
@@ -435,14 +387,8 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
 		spin_unlock_irqrestore(&fim->lock, flags);
 
 		if (icap_enabled(fim)) {
-			ret = fim_request_input_capture(fim);
-			if (ret)
-				goto out;
 			fim_acquire_first_ts(fim);
 		}
-	} else {
-		if (icap_enabled(fim))
-			fim_free_input_capture(fim);
 	}
 
 	fim->stream_on = on;
-- 
2.17.1

