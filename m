Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7106E051D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjDMDUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 23:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDMDUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:20:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03054683
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:20:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id kh6so12058811plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681356017; x=1683948017;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4RSl7MgASHbzKIb7HhpZajJUXMszG/Shm2pafDVnjk=;
        b=qzaGpjnJ7PckXQI5bl8QNUYnqNY9xzcX8MolKXiByTmUx42X79Ec5E91+W+NB4IBBu
         Lj5fAZKHMS4mGloxAqwT/AL3IY4RP+RT+PKbKEpIEe2PgXE7HOMq9mq82QeLZFLG0bRh
         5YMe5dSOEd7BRFtnC7skjHVc0OZdt5AG/KIsJKNS8p4xZszonCCByHbBfEomtVtOfcoO
         g7zvC9+L/Uyy+nwnQESSZYt7/gXYJ696JLoeOs2hVL7oC2f4TeHo54vIFHfK5m2INQS9
         JKjr436yAp10Y2VumV8qbVNJwEhyHPlIYWfaw13UQQne5/zHgf/+QsTYa7V4U7H+6L3H
         /L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681356017; x=1683948017;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4RSl7MgASHbzKIb7HhpZajJUXMszG/Shm2pafDVnjk=;
        b=KCj5FPj/uQWSgYCuALFwrd1+/M/XlOJ74wcYHt1kHeogilxXl0+8TAeJ+DoZ5InRky
         iau9E07cGJSUy0phMpUxU188SVgvoYoIZffd0CT+J3K1n5VkKF1RcaTqP68GCF9roJav
         /bWDL+wOPVfr7336cW+o8d1YlJjzR6dYzpPsF7PXE/pUWgdS9dAyJmqblfJEKiBLUdC/
         uSfTU368gXx8z6WCBDEwn0HgT3wyHQ+uDRdj/7b9NY2e2bPJ0K77L1bpQ4couzmezKKI
         HdvoetGwgqfaSv6D8gWr8TPUiO/Z/c/xOrgEltymq5Xfi4JEYNkaWmkvHM1Qu6wgRIvx
         NrpQ==
X-Gm-Message-State: AAQBX9dyenGYRs/BOeJeSV33/LK+kQeux+9i1eJdM0puUxKQEqIkyoAu
        L6SZVS1p3NW2RN3FrDnG90o=
X-Google-Smtp-Source: AKy350aTx2d1dYj6keJNuEa8XSi9ScGAirAoqJwKAKDnJjmGAXV2NmXJIMg90mCFD9PHBxDIHHfqSQ==
X-Received: by 2002:a17:903:114:b0:1a5:2809:97f3 with SMTP id y20-20020a170903011400b001a5280997f3mr594763plc.14.1681356017131;
        Wed, 12 Apr 2023 20:20:17 -0700 (PDT)
Received: from Zephyrus-G14 ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902a60100b001a671a396efsm299493plq.214.2023.04.12.20.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 20:20:16 -0700 (PDT)
Date:   Thu, 13 Apr 2023 08:50:12 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH] staging: rtl8192u: Remove functions rtl8192_wx_get_sens and
 rtl8192_wx_set_sens
Message-ID: <ZDd07Hgfe+Dxlus8@Zephyrus-G14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of these functions depend on the function rf_set_sens, which is
declared but never defined. Hence calling this function will cause an
oops. Because there is no definition of the function, priv->rf_set_sens
will always be NULL.

As a result rtl8192_wx_set_sens and rtl8192_wx_get_sens will always
return -1.

Hence,
* Removed function definition rf_set_sens
* Removed usage of variable priv->rf_set_sens
* Removed functions rtl8192_wx_get_sens and rtl8192_wx_set_sens
* Cleaned up the variables sens and max_sens used in these functions

Suggested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h    |  3 ---
 drivers/staging/rtl8192u/r8192U_wx.c | 40 ++--------------------------
 2 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index ff0ada00bf41..7da15b03519c 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -842,8 +842,6 @@ typedef struct r8192_priv {
 
 	u16 irq_mask;
 	short chan;
-	short sens;
-	short max_sens;
 
 	short up;
 	/* If 1, allow bad crc frame, reception in monitor mode */
@@ -854,7 +852,6 @@ typedef struct r8192_priv {
 	enum rt_rf_type   rf_type;	    /* 0: 1T2R, 1: 2T4R */
 	RT_RF_TYPE_819xU rf_chip;
 
-	short (*rf_set_sens)(struct net_device *dev, short sens);
 	u8 (*rf_set_chan)(struct net_device *dev, u8 ch);
 	void (*rf_close)(struct net_device *dev);
 	void (*rf_init)(struct net_device *dev);
diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 203ea3bfc843..2852f79204c0 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -250,8 +250,6 @@ static int rtl8180_wx_get_range(struct net_device *dev,
 	/* range->old_num_channels; */
 	/* range->old_num_frequency; */
 	/* range->old_freq[6]; */ /* Filler to keep "version" at the same offset */
-	if (priv->rf_set_sens)
-		range->sensitivity = priv->max_sens;	/* signal level threshold range */
 
 	range->max_qual.qual = 100;
 	/* TODO: Find real max RSSI and stick here */
@@ -662,40 +660,6 @@ static int r8192_wx_get_retry(struct net_device *dev,
 	return 0;
 }
 
-static int r8192_wx_get_sens(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = ieee80211_priv(dev);
-
-	if (!priv->rf_set_sens)
-		return -1; /* we have not this support for this radio */
-	wrqu->sens.value = priv->sens;
-	return 0;
-}
-
-static int r8192_wx_set_sens(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = ieee80211_priv(dev);
-	short err = 0;
-
-	mutex_lock(&priv->wx_mutex);
-	if (!priv->rf_set_sens) {
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
 
 /* hw security need to reorganized. */
 static int r8192_wx_set_enc_ext(struct net_device *dev,
@@ -825,8 +789,8 @@ static iw_handler r8192_wx_handlers[] = {
 	r8192_wx_get_freq,        /* SIOCGIWFREQ */
 	r8192_wx_set_mode,        /* SIOCSIWMODE */
 	r8192_wx_get_mode,        /* SIOCGIWMODE */
-	r8192_wx_set_sens,        /* SIOCSIWSENS */
-	r8192_wx_get_sens,        /* SIOCGIWSENS */
+	NULL,                     /* SIOCSIWSENS */
+	NULL,                     /* SIOCGIWSENS */
 	NULL,                     /* SIOCSIWRANGE */
 	rtl8180_wx_get_range,	  /* SIOCGIWRANGE */
 	NULL,                     /* SIOCSIWPRIV */
-- 
2.34.1

