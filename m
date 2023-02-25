Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5664D6A2B48
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 19:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBYSUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 13:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBYSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 13:20:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B568EC6F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:20:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bt28so2306102wrb.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677349235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAsMPynv8Bt+koPnerCzdUfaVHcGsUSJc1fCVIYNQFA=;
        b=J8J2hwqCf/p3DAyZsJuEvqex0XndijwDLiQWDEA5Ryr37gLIe6VsPUoAUQNaYbX6mi
         o8c07IzX1PwxQ/zoxvTHVFwEAS4nOGcC98Y/tvvyd37SMZv110xdBWxx0g8AzGfX8hmi
         vJxXZ9QTCLOfGBAJ2klBXnIHXNIzsCPGTus8F95po/OtPGzRqLhkqBGla6hXHX5SbBZq
         /Ca6e9LNED8G19DYP9FVWzOOrIMO9NNgtl4Vy3EFOdVX9NU+I8VyiJXJ2z2iCFrw+Cvt
         MCIA9K5D7iddN6SOKZcYTteELPqTT+nwFtEtCAmiKC7IBw9lsJT0N2eB4yJ5BqA+xigA
         7h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677349235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAsMPynv8Bt+koPnerCzdUfaVHcGsUSJc1fCVIYNQFA=;
        b=13c3p5CVCZ9QzLvVgH1YNE7wEj8D+lVieh+pATC2dAbTHRSDJOWC5OrNvPtmxE2daf
         scQIrK1i93PAZ9KVEDcABl0j1PcsXdonFxJR/KZWNA7lQxiXdTjc93YSygFfcdSBsodO
         NcBCo1tBO22X90S0iApF1x2Bg88Drqauch9rmkMFfj5Mu9dNq6579tbtFFcUv+HBbZHy
         LoihlRjRUFmzhWgOciQiCbu1HNvOKI7s2jzcnFhMZZBcemB8W7Zq/50PriH01RHZCK9W
         xRfzTCK3o9wB80xdk17AFZEXJLCtwuB7h4wpCpqibGORnCjI9fqhoTiQDvy5AOHeqgR3
         +ssw==
X-Gm-Message-State: AO0yUKVnXJeG6wGgsMRVJvsryiRliAYGXR4ngZj4o9DfJCZAb5aQAMcu
        76Nd5dreyU3uOHN3h6GX1YQdiP7W5A4=
X-Google-Smtp-Source: AK7set9H3Xy+t9aY/FGfoyHgAVUnS5XYXcZuaqpV9CPJ5twJrbJ6+xs1/3h/gvTKgK/qeMt3S35eXg==
X-Received: by 2002:a5d:4e11:0:b0:2c9:993a:f4cd with SMTP id p17-20020a5d4e11000000b002c9993af4cdmr1227626wrt.1.1677349235589;
        Sat, 25 Feb 2023 10:20:35 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d458a000000b002c559def236sm2375831wrq.57.2023.02.25.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 10:20:35 -0800 (PST)
Date:   Sat, 25 Feb 2023 19:20:33 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8192e: Remove checks of pointer to
 LeisureP.. and start_se..
Message-ID: <cd828bb1c8dfbb6d2a85d770c82afbb9889e0ea2.1677345331.git.philipp.g.hortmann@gmail.com>
References: <cover.1677345331.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677345331.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function pointers of LeisurePSLeave and start_send_beacons is set while
executing the probe function. Therefore a NULL pointer check is not
required. Remove checks as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c         | 3 +--
 drivers/staging/rtl8192e/rtllib_softmac.c    | 3 +--
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 35b36f7c0f28..c394c21beefb 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1214,8 +1214,7 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
 			    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
 			    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2)) {
-				if (ieee->LeisurePSLeave)
-					ieee->LeisurePSLeave(ieee->dev);
+				ieee->LeisurePSLeave(ieee->dev);
 			}
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index d697089e0cad..b06baf5ff6d4 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -669,8 +669,7 @@ EXPORT_SYMBOL(rtllib_stop_send_beacons);
 
 void rtllib_start_send_beacons(struct rtllib_device *ieee)
 {
-	if (ieee->start_send_beacons)
-		ieee->start_send_beacons(ieee->dev);
+	ieee->start_send_beacons(ieee->dev);
 	if (ieee->softmac_features & IEEE_SOFTMAC_BEACONS)
 		rtllib_beacons_start(ieee);
 }
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 06f3d75dc102..f90764d1d9ab 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -340,8 +340,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 
 	chan = ieee->current_network.channel;
 
-	if (ieee->LeisurePSLeave)
-		ieee->LeisurePSLeave(ieee->dev);
+	ieee->LeisurePSLeave(ieee->dev);
 	/* notify AP to be in PS mode */
 	rtllib_sta_ps_send_null_frame(ieee, 1);
 	rtllib_sta_ps_send_null_frame(ieee, 1);
-- 
2.39.2

