Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08E35B3F69
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIITV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiIITVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:21:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44FA142D99
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:21:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so6306937ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=fbruvI1As45J13rcrmiazfUwyKfsk6pI2SAj2MWbjgE=;
        b=aGF+CJr6wNyEQKJVyFclWWITvrZBrP3oYL+CYmYFT6thU7M7CPhRlVaRmJ7C+TxauL
         FQ5p8+XhGizOQLebpxB02Zze3SoTX+qvpgDsU3cYEMxZdRIJu04wNmCa5J1qKgdEInK7
         gUIQY60tkopkfgPtabtKoM1L9isqeW9VDkjDuN0o4iu+nwIcOW2DWoFiTFmbfSuGtjL/
         Qb8S48/5CXaZvG60nNj6sYltd6rWZdyENanIFzO9VB+U/7cIvd+MKU41YgYe9MdkWUQ2
         pi05wGrn4nkXqnlglCseLvZSNrahfaMGrKzdjZCkkaTEaSqMZ4Z81fvikhLm3865BnYS
         K0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fbruvI1As45J13rcrmiazfUwyKfsk6pI2SAj2MWbjgE=;
        b=aGDsxl3GZXWqVnE77bxT7wzLlvujdUxS0ihtVu0DTRIC/vAEgcMd7pzi92FJecvcZq
         a5qTyo/KOG6beAsWjGkzaz3GwpWD3pNdJAYN4NMZeeoSqQeZcH8xWPp1/Zt1irEUWpCl
         Or36+vvxbrc7Nw5f6Mo2zwFpEhnUhr6yVw+yUXYCsthdMTjZ8CCARVEUl5EBwAgEsFhd
         aAzsCQSsGN/ntIpv3RySC2rXITjux+7y8DvwCAr+AyLS/wlrklfubqtlLEdoQEbHUYAT
         NUwQMOmRsP2cCHRvDwdo6C78dVo9risK7/W82Y/7gKU8U43NUQAnfNr0NApKzQlKKdei
         Z9vQ==
X-Gm-Message-State: ACgBeo3ldQ5hm/rkzaoA66xWik9u0qtcixKSO5U4AiUT+kCiaTFRq1YL
        31yI/607cjkTZjmSCE03lorUlOAr4WM=
X-Google-Smtp-Source: AA6agR4vQh1iuufeUhKnUOmdkWrY1EzcLK7faGciuGOGFswzl8JVlQqq3JOX3Nxy3Anv2lmJTQY5Lw==
X-Received: by 2002:a17:907:1dd9:b0:77a:341b:88cb with SMTP id og25-20020a1709071dd900b0077a341b88cbmr2351401ejc.753.1662751297451;
        Fri, 09 Sep 2022 12:21:37 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906310a00b0073d6d6e698bsm635740ejx.187.2022.09.09.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:21:37 -0700 (PDT)
Date:   Fri, 9 Sep 2022 21:21:35 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: rtl8192e: Rename rtState
Message-ID: <e888fa7e6edaa68e741236ea012f8230f6817882.1662402870.git.philipp.g.hortmann@gmail.com>
References: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable rtState to rt_state to avoid CamelCase which
is not accepted by checkpatch.pl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c  |  6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   | 18 +++++++++---------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 12 ++++++------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index d7630f02a910..6b372b0dd6bc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -86,11 +86,11 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	u16 usConfig = 0;
 	u8 i;
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
-	enum rt_rf_power_state rtState;
+	enum rt_rf_power_state rt_state;
 
-	rtState = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->eRFPowerState;
 	if (priv->rtllib->PowerSaveControl.bInactivePs) {
-		if (rtState == eRfOff) {
+		if (rt_state == eRfOff) {
 			if (priv->rtllib->RfOffReason > RF_CHANGE_BY_IPS) {
 				netdev_warn(dev, "%s(): RF is OFF.\n",
 					    __func__);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index b1f5a63790c8..bc8aca808e99 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -139,7 +139,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	struct rtllib_device *ieee = priv->rtllib;
 	bool action_allowed = false;
 	bool connect_by_ssid = false;
-	enum rt_rf_power_state rtState;
+	enum rt_rf_power_state rt_state;
 	u16			RFWaitCounter = 0;
 	unsigned long flag;
 
@@ -166,7 +166,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 		}
 	}
 
-	rtState = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->eRFPowerState;
 
 	switch (state_to_set) {
 	case eRfOn:
@@ -179,7 +179,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 			priv->rtllib->RfOffReason = 0;
 			action_allowed = true;
 
-			if (rtState == eRfOff &&
+			if (rt_state == eRfOff &&
 			    change_source >= RF_CHANGE_BY_HW)
 				connect_by_ssid = true;
 		}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index c5e89eb40342..3333ce3e88a8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -126,11 +126,11 @@ void rtl92e_ips_enter(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
 					&(priv->rtllib->PowerSaveControl);
-	enum rt_rf_power_state rtState;
+	enum rt_rf_power_state rt_state;
 
 	if (pPSC->bInactivePs) {
-		rtState = priv->rtllib->eRFPowerState;
-		if (rtState == eRfOn && !pPSC->bSwRfProcessing &&
+		rt_state = priv->rtllib->eRFPowerState;
+		if (rt_state == eRfOn && !pPSC->bSwRfProcessing &&
 			(priv->rtllib->state != RTLLIB_LINKED) &&
 			(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
 			RT_TRACE(COMP_PS, "%s(): Turn off RF.\n", __func__);
@@ -147,11 +147,11 @@ void rtl92e_ips_leave(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
 					&(priv->rtllib->PowerSaveControl);
-	enum rt_rf_power_state rtState;
+	enum rt_rf_power_state rt_state;
 
 	if (pPSC->bInactivePs) {
-		rtState = priv->rtllib->eRFPowerState;
-		if (rtState != eRfOn  && !pPSC->bSwRfProcessing &&
+		rt_state = priv->rtllib->eRFPowerState;
+		if (rt_state != eRfOn  && !pPSC->bSwRfProcessing &&
 		    priv->rtllib->RfOffReason <= RF_CHANGE_BY_IPS) {
 			RT_TRACE(COMP_PS, "%s(): Turn on RF.\n", __func__);
 			pPSC->eInactivePowerState = eRfOn;
@@ -176,12 +176,12 @@ void rtl92e_ips_leave_wq(void *data)
 void rtl92e_rtllib_ips_leave_wq(struct net_device *dev)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
-	enum rt_rf_power_state rtState;
+	enum rt_rf_power_state rt_state;
 
-	rtState = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->eRFPowerState;
 
 	if (priv->rtllib->PowerSaveControl.bInactivePs) {
-		if (rtState == eRfOff) {
+		if (rt_state == eRfOff) {
 			if (priv->rtllib->RfOffReason > RF_CHANGE_BY_IPS) {
 				netdev_warn(dev, "%s(): RF is OFF.\n",
 					    __func__);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 407effde5e71..70aa47568f3a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -247,17 +247,17 @@ static int _rtl92e_wx_set_mode(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = netdev_priv_rsl(dev);
 
-	enum rt_rf_power_state rtState;
+	enum rt_rf_power_state rt_state;
 	int ret;
 
 	if (priv->bHwRadioOff)
 		return 0;
-	rtState = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->eRFPowerState;
 	mutex_lock(&priv->wx_mutex);
 	if (wrqu->mode == IW_MODE_ADHOC || wrqu->mode == IW_MODE_MONITOR ||
 	    ieee->bNetPromiscuousMode) {
 		if (priv->rtllib->PowerSaveControl.bInactivePs) {
-			if (rtState == eRfOff) {
+			if (rt_state == eRfOff) {
 				if (priv->rtllib->RfOffReason >
 				    RF_CHANGE_BY_IPS) {
 					netdev_warn(dev, "%s(): RF is OFF.\n",
@@ -379,7 +379,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
-	enum rt_rf_power_state rtState;
+	enum rt_rf_power_state rt_state;
 	int ret;
 
 	if (!(ieee->softmac_features & IEEE_SOFTMAC_SCAN)) {
@@ -396,7 +396,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 			    __func__);
 		return 0;
 	}
-	rtState = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->eRFPowerState;
 	if (!priv->up)
 		return -ENETDOWN;
 	if (priv->rtllib->LinkDetectInfo.bBusyTraffic == true)
@@ -419,7 +419,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 
 	if (priv->rtllib->state != RTLLIB_LINKED) {
 		if (priv->rtllib->PowerSaveControl.bInactivePs) {
-			if (rtState == eRfOff) {
+			if (rt_state == eRfOff) {
 				if (priv->rtllib->RfOffReason >
 				    RF_CHANGE_BY_IPS) {
 					netdev_warn(dev, "%s(): RF is OFF.\n",
-- 
2.37.2

