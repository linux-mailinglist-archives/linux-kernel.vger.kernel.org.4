Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEC16DC4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDJIuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDJIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:50:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75BD559F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:49:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-62e102cadc7so669227b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681116584; x=1683708584;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umDFBP5ADUurtK4IUTyxudUc2wuZVQg0JpEeV/qBi+I=;
        b=SHQYCqhum56VvZP3Q/lMEy7r75JNq87Dzq4OLQ4tUD0syNI3nflS2QTSo6BfR6D3qa
         syizqdVpso38tqGHxu9FncfyEmjxT/aV4jn04j50v66DBIGWfwzcA1mg24CNHo7Zoyzr
         ujw19hEwTDkBcRsFgO1aVjq8yfZpkoldX2NWQ8Hi6u5cLRGKryGzp8Fxs61BAuRNWNYJ
         TrfPChTLAaG7EcS1ybB4/HIrEChUtqDRvC4/H91+38cPBwCUT6VKrn3hArRuIk14yBgM
         hlhJex9LsPkbtYza2IvnFXcdiCzqAtK5UsxHaygaa/YAA4Sypx1x58TC3KtY407aBnem
         B7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681116584; x=1683708584;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umDFBP5ADUurtK4IUTyxudUc2wuZVQg0JpEeV/qBi+I=;
        b=bw9Cg33LfORkdq2xbfRoZHUseg2nHcTJ77wROcy9/uvSSRR762scRlFamBd2iOQ9UQ
         k8e4wBvQtY/9/vqwFGKUffeadKpqUP2EN5gh/BAM4TLlIhrQDXPteTh27XsDF2ayT62D
         s5xVp9ipSw28R5567chNnlHOZYJf36tZg7e4frvL8EHtOW0Gun0hqyTqta5X2TLFtWXW
         EQU7eW6J6UaaIT4/oo/QZyx/3tp7mDe0aPs4zly0fJX3tnPSLe1guvZGDmFwJKPo1pEw
         vfffgfGHj7N9LU1dDQhjwnuAWGVNq/D1URkwMoQ1H10hAqVC40kU0PszQ+4dVhzrr17w
         WS3g==
X-Gm-Message-State: AAQBX9fQNuXDI4kN0b3dhEy3FkINBGscvt47WtgD1Hk2f3IOAbF2lOkN
        PrjP9NwJo70IPxVR/6QRH8Y=
X-Google-Smtp-Source: AKy350YMFk+1vteUW1ylnR25fm6rXSHKvO6WhmdfPrVOV4BEibHm3vp9XTVvNtE0zuta0qNcsu+aWw==
X-Received: by 2002:a62:1850:0:b0:62d:8376:3712 with SMTP id 77-20020a621850000000b0062d83763712mr6383716pfy.28.1681116584239;
        Mon, 10 Apr 2023 01:49:44 -0700 (PDT)
Received: from Zephyrus-G14 ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id l19-20020a62be13000000b006249928aba2sm7318598pff.59.2023.04.10.01.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 01:49:43 -0700 (PDT)
Date:   Mon, 10 Apr 2023 14:19:39 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH] staging: rtl8192e: Remove functions _rtl92e_wx_get_sens and
 _rtl92e_wx_set_sens
Message-ID: <ZDPNo9HI1vrdyD64@Zephyrus-G14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of these functions depend on the function rf_set_sens, which is declared
but never defined. Hence calling this function will cause an oops.
Because there is no definition of the function priv->rf_set_sens will always be NULL.

As a result _rtl92e_wx_set_sens and _rtl92e_wx_get_sens will always return -1.

Hence,
* Removed function definition rf_set_sens
* Removed usage of variable priv->rf_set_sens
* Removed functions _rtl92e_wx_get_sens and _rtl92e_wx_set_sens
* Cleaned up the variables sens and max_sens used in these functions

This bug was pointed out by Philipp Hortmann[1].

[1]: https://lore.kernel.org/linux-staging/004210bd-0ed1-58d5-0315-47499c850444@gmail.com/

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  3 --
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 45 --------------------
 2 files changed, 48 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 2b2d8af4cf6e..a949a3833cca 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -234,7 +234,6 @@ struct r8192_priv {
 	struct rt_stats stats;
 	struct iw_statistics			wstats;
 
-	short (*rf_set_sens)(struct net_device *dev, short sens);
 	u8 (*rf_set_chan)(struct net_device *dev, u8 ch);
 
 	struct rx_desc *rx_ring[MAX_RX_QUEUE];
@@ -274,8 +273,6 @@ struct r8192_priv {
 	short	promisc;
 
 	short	chan;
-	short	sens;
-	short	max_sens;
 	bool ps_force;
 
 	u32 irq_mask[2];
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index cb28288a618b..0bb657fda06c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -311,10 +311,6 @@ static int _rtl92e_wx_get_range(struct net_device *dev,
 	/* ~130 Mb/s real (802.11n) */
 	range->throughput = 130 * 1000 * 1000;
 
-	if (priv->rf_set_sens != NULL)
-		/* signal level threshold range */
-		range->sensitivity = priv->max_sens;
-
 	range->max_qual.qual = 100;
 	range->max_qual.level = 0;
 	range->max_qual.noise = 0;
@@ -807,45 +803,6 @@ static int _rtl92e_wx_get_retry(struct net_device *dev,
 	return 0;
 }
 
-static int _rtl92e_wx_get_sens(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	if (priv->rf_set_sens == NULL)
-		return -1; /* we have not this support for this radio */
-	wrqu->sens.value = priv->sens;
-	return 0;
-}
-
-static int _rtl92e_wx_set_sens(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	short err = 0;
-
-	if (priv->hw_radio_off)
-		return 0;
-
-	mutex_lock(&priv->wx_mutex);
-	if (priv->rf_set_sens == NULL) {
-		err = -1; /* we have not this support for this radio */
-		goto exit;
-	}
-	if (priv->rf_set_sens(dev, wrqu->sens.value) == 0)
-		priv->sens = wrqu->sens.value;
-	else
-		err = -EINVAL;
-
-exit:
-	mutex_unlock(&priv->wx_mutex);
-
-	return err;
-}
-
 static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 				     struct iw_request_info *info,
 				     union iwreq_data *wrqu, char *extra)
@@ -1066,8 +1023,6 @@ static iw_handler r8192_wx_handlers[] = {
 	[IW_IOCTL(SIOCGIWFREQ)] = _rtl92e_wx_get_freq,
 	[IW_IOCTL(SIOCSIWMODE)] = _rtl92e_wx_set_mode,
 	[IW_IOCTL(SIOCGIWMODE)] = _rtl92e_wx_get_mode,
-	[IW_IOCTL(SIOCSIWSENS)] = _rtl92e_wx_set_sens,
-	[IW_IOCTL(SIOCGIWSENS)] = _rtl92e_wx_get_sens,
 	[IW_IOCTL(SIOCGIWRANGE)] = _rtl92e_wx_get_range,
 	[IW_IOCTL(SIOCSIWAP)] = _rtl92e_wx_set_wap,
 	[IW_IOCTL(SIOCGIWAP)] = _rtl92e_wx_get_wap,
-- 
2.34.1

