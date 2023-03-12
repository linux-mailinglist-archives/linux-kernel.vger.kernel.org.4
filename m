Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C886B6BF6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCLW3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCLW3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:29:00 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2092529D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:28:59 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id ks17so7200614qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678660139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bm8357knKBz2M26Sj/9hOvriOOgO862bSiwrgatoRU=;
        b=SdNC01QvISkfUd6mLyOxMYpMiwmohWX04EGJAd2LdJQUqBvKn34hqgFX+/kqLRhr2T
         ea3DWFMAUIW33aTPAVp+t40D5y6yzgqvmlsx8qqIm05cq6ZcUEw4s1CFCDNLbEKT1QDr
         1UvQEoIbGif4Ihb7LEMu1rsdXDjcXWSMwDZM/kZr540WMJJNTQbDaV+L1qyRU4mDSDd4
         zUJFcGPoZhoLfvTIZdZHLHsWnQlNBzRieoZJLYUeW7a1BpU2HREPgf91DdiAitWw4+lh
         minpXg+W/qbA7aA+WI5J984ZcNd7izX31GEkq9ucaVs5eYDEPB0JWfT3vT9B2nG+J27O
         +qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678660139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Bm8357knKBz2M26Sj/9hOvriOOgO862bSiwrgatoRU=;
        b=E0By7oA06H/39X6p2CXNF8q7rSiewATOJUTPLqaPVsni0fJrwEvbA4hqXIbfepMVwI
         dsJHLZoyRjO4lUBN/8K4a94lbKBtWSI5cSd24s0QV/hXcsbdi4aogZIihPqUlcKHdkMM
         dCiKiMTqDisMWly+ZlPhjEH8MwTR7GfShB1BZ1mG4nGz9OyZb7OCtKI0iPQBsAzd7ovT
         dcdFmTd6KPOvWn4ei22DEzObQv3+yrfJMRxKzHC8ZDwSNW1a6WzBnKGEe40Nn4KLNIev
         Gw6FHBVfNyGtHYodE6fVzHKfGRfuA+/U/QBdVgJLxf/rkbXC01inVhwTng1WYP5pvTCc
         yGdA==
X-Gm-Message-State: AO0yUKW3VKsXjOTYfJZkgHv84kzviAq1kNfOJI8pFO3/b8RUcvodsG/4
        oalE5zN+Wtdu/qC24H7VbFg=
X-Google-Smtp-Source: AK7set+AEA4x5zoXDBLqU0q2A2fxnkrHDdCSS2ejWSQY+y6StT7fu+Z/pZ6GaUMrC0zLC1KZQcXOBA==
X-Received: by 2002:a05:6214:1bc7:b0:57f:5ab1:a42b with SMTP id m7-20020a0562141bc700b0057f5ab1a42bmr11877192qvc.32.1678660138951;
        Sun, 12 Mar 2023 15:28:58 -0700 (PDT)
Received: from localhost ([72.138.97.66])
        by smtp.gmail.com with ESMTPSA id r200-20020a3744d1000000b0074305413c73sm4183807qka.95.2023.03.12.15.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 15:28:58 -0700 (PDT)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: usb: remove Wireless USB dead code
Date:   Sun, 12 Mar 2023 18:28:57 -0400
Message-Id: <20230312222857.296623-1-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

Wireless USB host controller support has been removed
from Linux Kernel more than 3 years ago in commit
caa6772db4c1 ("Staging: remove wusbcore and UWB from the
kernel tree."), and the associated code in the
snd-usb-audio driver became unused and untested.

If in the future somebody will return WUSB/UWB support
back to the kernel, the snd-usb-audio driver will reject
Wireless USB audio devices at probe stage, and this patch
should be reverted.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/card.c     |  1 -
 sound/usb/endpoint.c | 16 +---------------
 sound/usb/helper.c   |  1 -
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 26268ffb8274..f6e99ced8068 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -609,7 +609,6 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	case USB_SPEED_LOW:
 	case USB_SPEED_FULL:
 	case USB_SPEED_HIGH:
-	case USB_SPEED_WIRELESS:
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
 		break;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 419302e2057e..1e0af1179ca8 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1173,22 +1173,8 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
 	 */
 	if (usb_pipein(ep->pipe) || ep->implicit_fb_sync) {
 
-		urb_packs = packs_per_ms;
-		/*
-		 * Wireless devices can poll at a max rate of once per 4ms.
-		 * For dataintervals less than 5, increase the packet count to
-		 * allow the host controller to use bursting to fill in the
-		 * gaps.
-		 */
-		if (snd_usb_get_speed(chip->dev) == USB_SPEED_WIRELESS) {
-			int interval = ep->datainterval;
-			while (interval < 5) {
-				urb_packs <<= 1;
-				++interval;
-			}
-		}
 		/* make capture URBs <= 1 ms and smaller than a period */
-		urb_packs = min(max_packs_per_urb, urb_packs);
+		urb_packs = min(max_packs_per_urb, packs_per_ms);
 		while (urb_packs > 1 && urb_packs * maxsize >= ep->cur_period_bytes)
 			urb_packs >>= 1;
 		ep->nurbs = MAX_URBS;
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index a4410267bf70..bf80e55d013a 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -108,7 +108,6 @@ unsigned char snd_usb_parse_datainterval(struct snd_usb_audio *chip,
 {
 	switch (snd_usb_get_speed(chip->dev)) {
 	case USB_SPEED_HIGH:
-	case USB_SPEED_WIRELESS:
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
 		if (get_endpoint(alts, 0)->bInterval >= 1 &&
-- 
2.39.2

