Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9913C5F1B7D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJAJk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJAJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:40:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FC34AD5F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:40:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c30so8806195edn.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=0UpbusMjYi3AOMkTCv2sFWZZfqa+P6NDlaD0VD5CbS0=;
        b=RZZ7IFnakfw1dGSC5/xOBYjytSIw85PBc/aHnqetPZWiCBu7lJhvtjlHFUF7hKYwHw
         RQ6nWidfy6SUzeBhPPu+QZ9UOsTHLR6PsAWAJBkoa2qbZYqEduVkEvqj7qd1866DnaAb
         C2+hlAMrYtPkgXBLe1yKiJVOEBa+wkVJf8kwKQFPN8gsvXmhZm2kXBSnnpjJXy37HVhR
         Kk5HLp/1lltTZm1FAoOj6IKoBkoHdTcxOkNDTYog1VShriSWBVxG0JwjxPKeKyMuC628
         GdZYKAT51fb4x4cej6yNiV1VdNYQukEJ3zsIc0nfHbWrORo3Me3kejGJfTVAe+IA+oU/
         LpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0UpbusMjYi3AOMkTCv2sFWZZfqa+P6NDlaD0VD5CbS0=;
        b=oTg1fc8NKAwHZ6zv4v/nR+16KBHFJAKULFcwtE3EVyDPNbMap4YLGJ0OmT1GaVEsLk
         S8VSqeYtKHYOnFxkgXxJO+ky3SwuPRMarNJzsnUtgZv+ShIkWU2MIfJrtdhmKjeqAfla
         RM5xkAXvFqgSqA3SCXDFJKXvHRFmDXoMe8XGDWsoYu+xJBbFQbPvzCEd9GB2lykNVvDC
         I93PiNRv1u6sYKHiwmqNQvB+rXKfNDxlRBad45drkp9Z5nD9mLHiJPvTigU00pm5+WF9
         Z8LjYVvZPKgZnmirxvvDzvyWXFvYYRK+WGzShuYfE6lvWvrxu636zt3GJsPvR7S85cLZ
         M30w==
X-Gm-Message-State: ACrzQf2TG3q2BAIGvEOugHaZf/VEZxYSB/xvdhdqipI/vKzPIFvMJuMi
        QR5ZOo9wVii1Au0AMTCYICIypFH4AgQ=
X-Google-Smtp-Source: AMsMyM7Bu5QkwQXRQnmQ9nhmPWVlZXFC8AFljaIxu+cZ3JgtypgDEFvKkoSrKAgNMSMimNTV8KCGHA==
X-Received: by 2002:a05:6402:5419:b0:457:c955:a40f with SMTP id ev25-20020a056402541900b00457c955a40fmr10774769edb.391.1664617238908;
        Sat, 01 Oct 2022 02:40:38 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id c63-20020a509fc5000000b00456f569f31dsm3184415edf.75.2022.10.01.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:40:38 -0700 (PDT)
Date:   Sat, 1 Oct 2022 11:40:36 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Remove unchanged variable
 bInactivePs
Message-ID: <9f46eebf8220a06a1889eaf2d6bac74dd08cfd1f.1664616227.git.philipp.g.hortmann@gmail.com>
References: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bInactivePs is just once initialized and never changed. The evaluation
will always have the same result. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c  | 18 ++++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   | 49 +++++++++-----------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 48 +++++++++----------
 drivers/staging/rtl8192e/rtllib.h            |  2 -
 5 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 41faeb4b9b9b..8c3ce6cc2541 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -81,17 +81,15 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	enum rt_rf_power_state rt_state;
 
 	rt_state = priv->rtllib->rf_power_state;
-	if (priv->rtllib->PowerSaveControl.bInactivePs) {
-		if (rt_state == rf_off) {
-			if (priv->rtllib->rf_off_reason > RF_CHANGE_BY_IPS) {
-				netdev_warn(dev, "%s(): RF is OFF.\n",
-					    __func__);
-				return;
-			}
-			mutex_lock(&priv->rtllib->ips_mutex);
-			rtl92e_ips_leave(dev);
-			mutex_unlock(&priv->rtllib->ips_mutex);
+	if (rt_state == rf_off) {
+		if (priv->rtllib->rf_off_reason > RF_CHANGE_BY_IPS) {
+			netdev_warn(dev, "%s(): RF is OFF.\n",
+				    __func__);
+			return;
 		}
+		mutex_lock(&priv->rtllib->ips_mutex);
+		rtl92e_ips_leave(dev);
+		mutex_unlock(&priv->rtllib->ips_mutex);
 	}
 	priv->rtllib->is_set_key = true;
 	if (EntryNo >= TOTAL_CAM_ENTRY) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 10b79003c633..7c0fd2bce923 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -886,7 +886,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rf_change_in_progress = false;
 	priv->bHwRfOffAction = 0;
 	priv->SetRFPowerStateInProgress = false;
-	priv->rtllib->PowerSaveControl.bInactivePs = true;
 	priv->rtllib->PowerSaveControl.bIPSModeBackup = false;
 	priv->rtllib->PowerSaveControl.bLeisurePs = true;
 	priv->rtllib->LPSDelayCnt = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 49c50ec21d04..fba86ef730b5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -116,16 +116,14 @@ void rtl92e_ips_enter(struct net_device *dev)
 					&(priv->rtllib->PowerSaveControl);
 	enum rt_rf_power_state rt_state;
 
-	if (pPSC->bInactivePs) {
-		rt_state = priv->rtllib->rf_power_state;
-		if (rt_state == rf_on && !pPSC->bSwRfProcessing &&
-			(priv->rtllib->state != RTLLIB_LINKED) &&
-			(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
-			pPSC->eInactivePowerState = rf_off;
-			priv->isRFOff = true;
-			priv->bInPowerSaveMode = true;
-			_rtl92e_ps_update_rf_state(dev);
-		}
+	rt_state = priv->rtllib->rf_power_state;
+	if (rt_state == rf_on && !pPSC->bSwRfProcessing &&
+		(priv->rtllib->state != RTLLIB_LINKED) &&
+		(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
+		pPSC->eInactivePowerState = rf_off;
+		priv->isRFOff = true;
+		priv->bInPowerSaveMode = true;
+		_rtl92e_ps_update_rf_state(dev);
 	}
 }
 
@@ -136,14 +134,12 @@ void rtl92e_ips_leave(struct net_device *dev)
 					&(priv->rtllib->PowerSaveControl);
 	enum rt_rf_power_state rt_state;
 
-	if (pPSC->bInactivePs) {
-		rt_state = priv->rtllib->rf_power_state;
-		if (rt_state != rf_on  && !pPSC->bSwRfProcessing &&
-		    priv->rtllib->rf_off_reason <= RF_CHANGE_BY_IPS) {
-			pPSC->eInactivePowerState = rf_on;
-			priv->bInPowerSaveMode = false;
-			_rtl92e_ps_update_rf_state(dev);
-		}
+	rt_state = priv->rtllib->rf_power_state;
+	if (rt_state != rf_on  && !pPSC->bSwRfProcessing &&
+	    priv->rtllib->rf_off_reason <= RF_CHANGE_BY_IPS) {
+		pPSC->eInactivePowerState = rf_on;
+		priv->bInPowerSaveMode = false;
+		_rtl92e_ps_update_rf_state(dev);
 	}
 }
 
@@ -165,18 +161,15 @@ void rtl92e_rtllib_ips_leave_wq(struct net_device *dev)
 	enum rt_rf_power_state rt_state;
 
 	rt_state = priv->rtllib->rf_power_state;
-
-	if (priv->rtllib->PowerSaveControl.bInactivePs) {
-		if (rt_state == rf_off) {
-			if (priv->rtllib->rf_off_reason > RF_CHANGE_BY_IPS) {
-				netdev_warn(dev, "%s(): RF is OFF.\n",
-					    __func__);
-				return;
-			}
-			netdev_info(dev, "=========>%s(): rtl92e_ips_leave\n",
+	if (rt_state == rf_off) {
+		if (priv->rtllib->rf_off_reason > RF_CHANGE_BY_IPS) {
+			netdev_warn(dev, "%s(): RF is OFF.\n",
 				    __func__);
-			schedule_work(&priv->rtllib->ips_leave_wq);
+			return;
 		}
+		netdev_info(dev, "=========>%s(): rtl92e_ips_leave\n",
+			    __func__);
+		schedule_work(&priv->rtllib->ips_leave_wq);
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 4920cb49e381..12eea4fcb9dd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -252,22 +252,20 @@ static int _rtl92e_wx_set_mode(struct net_device *dev,
 	mutex_lock(&priv->wx_mutex);
 	if (wrqu->mode == IW_MODE_ADHOC || wrqu->mode == IW_MODE_MONITOR ||
 	    ieee->bNetPromiscuousMode) {
-		if (priv->rtllib->PowerSaveControl.bInactivePs) {
-			if (rt_state == rf_off) {
-				if (priv->rtllib->rf_off_reason >
-				    RF_CHANGE_BY_IPS) {
-					netdev_warn(dev, "%s(): RF is OFF.\n",
-						    __func__);
-					mutex_unlock(&priv->wx_mutex);
-					return -1;
-				}
-				netdev_info(dev,
-					    "=========>%s(): rtl92e_ips_leave\n",
+		if (rt_state == rf_off) {
+			if (priv->rtllib->rf_off_reason >
+			    RF_CHANGE_BY_IPS) {
+				netdev_warn(dev, "%s(): RF is OFF.\n",
 					    __func__);
-				mutex_lock(&priv->rtllib->ips_mutex);
-				rtl92e_ips_leave(dev);
-				mutex_unlock(&priv->rtllib->ips_mutex);
+				mutex_unlock(&priv->wx_mutex);
+				return -1;
 			}
+			netdev_info(dev,
+				    "=========>%s(): rtl92e_ips_leave\n",
+				    __func__);
+			mutex_lock(&priv->rtllib->ips_mutex);
+			rtl92e_ips_leave(dev);
+			mutex_unlock(&priv->rtllib->ips_mutex);
 		}
 	}
 	ret = rtllib_wx_set_mode(priv->rtllib, a, wrqu, b);
@@ -414,19 +412,17 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 	priv->rtllib->FirstIe_InScan = true;
 
 	if (priv->rtllib->state != RTLLIB_LINKED) {
-		if (priv->rtllib->PowerSaveControl.bInactivePs) {
-			if (rt_state == rf_off) {
-				if (priv->rtllib->rf_off_reason >
-				    RF_CHANGE_BY_IPS) {
-					netdev_warn(dev, "%s(): RF is OFF.\n",
-						    __func__);
-					mutex_unlock(&priv->wx_mutex);
-					return -1;
-				}
-				mutex_lock(&priv->rtllib->ips_mutex);
-				rtl92e_ips_leave(dev);
-				mutex_unlock(&priv->rtllib->ips_mutex);
+		if (rt_state == rf_off) {
+			if (priv->rtllib->rf_off_reason >
+			    RF_CHANGE_BY_IPS) {
+				netdev_warn(dev, "%s(): RF is OFF.\n",
+					    __func__);
+				mutex_unlock(&priv->wx_mutex);
+				return -1;
 			}
+			mutex_lock(&priv->rtllib->ips_mutex);
+			rtl92e_ips_leave(dev);
+			mutex_unlock(&priv->rtllib->ips_mutex);
 		}
 		rtllib_stop_scan(priv->rtllib);
 		if (priv->rtllib->LedControlHandler)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 40bea71bcb22..d23d1c3ce39b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1250,8 +1250,6 @@ enum rt_rf_power_state {
 };
 
 struct rt_pwr_save_ctrl {
-
-	bool				bInactivePs;
 	bool				bIPSModeBackup;
 	bool				bSwRfProcessing;
 	enum rt_rf_power_state eInactivePowerState;
-- 
2.37.3

