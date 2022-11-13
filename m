Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC796626DB2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiKMEf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiKMEfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:35:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572C13CD1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so6928583wrm.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRX3eE2HdBt1z4bDSGuk1t5Mi99j8zw3bmMFn1kRYTI=;
        b=o8B9MRnRo0c+D/p5/V2igXjad+/H43wBAqZl4DvpsS1tLELu0k/VZweMBjzyB8cFUS
         nvFqH2mXgZx90QDm9aAk3HVztOOqQ4UpBCgTZHZKYjpWxQgXcyPJOk8Nwpuj3dzTNq1G
         mrwW+BxfmQKioNJ4I/oIpFjjt7CPFiNJ0DZ2J5WFmZ81TDqZmbd+KycrfJP3Vy4rd8LQ
         e0etKRlLGTW/xAMH9zU3UDPMql8TWq4o8mSr09+iwXj8qeCrHTwoN7IlhiOL8hYLQieb
         0PLBl+jTF6oQ8E/LaVsUwpPjbBuRKIuVtX+0VuN/d9DS/xm3j6VNQRO6agvpu7IHUcGZ
         VPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRX3eE2HdBt1z4bDSGuk1t5Mi99j8zw3bmMFn1kRYTI=;
        b=fJlfUyXkuXqsKmdCiFPYc9rEYkDUZqru7rtvArRut0UA9ZWR47I4/0cDswxIpCy1t+
         lLnLkWBBLtZWpG4139di0O87/kyMQ/1M303ucSoDxNwoICvvMpAIv57H71yhwzeuoU36
         tFTufZGi+OePVMa2+r/MmM6U3HA9Tq2FjvDbAQarL89qfvwadhbgstNkY9ZpDplZ4Hi+
         FvaCQ68sBk7yFGTmPKurBaL04TLufNN0cSkUcnEGXHcgY+tsDwiVEjhUh73uifX5wBxH
         IZyF2SrfeHbb9VTRuJ+evTc7QwMVP4GpmTCHGkN0UoGwhjJND865FU+xeLxjozBTFX7g
         swhA==
X-Gm-Message-State: ANoB5pk6FSqjQTV3ww2PbD/N7REDsnrVzJHNEq5jyonvAEDcyOi2sTAP
        pGQ5lMulpobvWv92Wzf0uVM=
X-Google-Smtp-Source: AA0mqf6UyJZqxT8k8dUMA4zxqkvN6GbWy+RKukJ8ScYNp+wyVpMwX5ZlqGzBtyCPX2K5S1z42jNfBA==
X-Received: by 2002:adf:dcc3:0:b0:235:14dc:5e14 with SMTP id x3-20020adfdcc3000000b0023514dc5e14mr4749909wrm.252.1668314136691;
        Sat, 12 Nov 2022 20:35:36 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003b435c41103sm17880764wmo.0.2022.11.12.20.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:35:36 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:35:34 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Rename pPSC
Message-ID: <47ded8a906e55d6f09b51cd8f2dfb78b7b92c1cc.1668313325.git.philipp.g.hortmann@gmail.com>
References: <cover.1668313325.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668313325.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pPSC to psc to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 14 +++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 16 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    | 32 ++++++++--------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    | 10 ++---
 drivers/staging/rtl8192e/rtllib.h             | 10 ++---
 drivers/staging/rtl8192e/rtllib_softmac.c     | 38 +++++++++----------
 6 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index b14497423cbf..c357adf95a3d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1303,7 +1303,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 				       enum rt_rf_power_state rf_power_state)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					(&priv->rtllib->pwr_save_ctrl);
 	bool bResult = true;
 	u8	i = 0, QueueID = 0;
@@ -1318,7 +1318,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 		switch (rf_power_state) {
 		case rf_on:
 			if ((priv->rtllib->rf_power_state == rf_off) &&
-			     RT_IN_PS_LEVEL(pPSC, RT_RF_OFF_LEVL_HALT_NIC)) {
+			     RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
 				bool rtstatus;
 				u32 InitilizeCount = 3;
 
@@ -1335,7 +1335,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 					return false;
 				}
 
-				RT_CLEAR_PS_LEVEL(pPSC,
+				RT_CLEAR_PS_LEVEL(psc,
 						  RT_RF_OFF_LEVL_HALT_NIC);
 			} else {
 				rtl92e_writeb(dev, ANAPAR, 0x37);
@@ -1399,11 +1399,11 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 					break;
 			}
 
-			if (pPSC->RegRfPsLevel & RT_RF_OFF_LEVL_HALT_NIC &&
-			    !RT_IN_PS_LEVEL(pPSC, RT_RF_OFF_LEVL_HALT_NIC)) {
+			if (psc->RegRfPsLevel & RT_RF_OFF_LEVL_HALT_NIC &&
+			    !RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
 				rtl92e_disable_nic(dev);
-				RT_SET_PS_LEVEL(pPSC, RT_RF_OFF_LEVL_HALT_NIC);
-			} else if (!(pPSC->RegRfPsLevel &
+				RT_SET_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC);
+			} else if (!(psc->RegRfPsLevel &
 				   RT_RF_OFF_LEVL_HALT_NIC)) {
 				rtl92e_set_rf_off(dev);
 			}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index d5eec6d6b644..144bc7c9abd5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -682,7 +682,7 @@ void rtl92e_set_wireless_mode(struct net_device *dev, u8 wireless_mode)
 static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					(&priv->rtllib->pwr_save_ctrl);
 	bool init_status;
 
@@ -700,7 +700,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 		return -1;
 	}
 
-	RT_CLEAR_PS_LEVEL(pPSC, RT_RF_OFF_LEVL_HALT_NIC);
+	RT_CLEAR_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC);
 	priv->bfirst_init = false;
 
 	if (priv->polling_timer_on == 0)
@@ -819,10 +819,10 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 static void _rtl92e_init_priv_constant(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					&priv->rtllib->pwr_save_ctrl;
 
-	pPSC->reg_max_lps_awake_intvl = 5;
+	psc->reg_max_lps_awake_intvl = 5;
 }
 
 static void _rtl92e_init_priv_variable(struct net_device *dev)
@@ -1271,7 +1271,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	enum reset_type ResetType = RESET_TYPE_NORESET;
 	static u8 check_reset_cnt;
 	unsigned long flags;
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					(&priv->rtllib->pwr_save_ctrl);
 	bool bBusyTraffic = false;
 	bool	bHigherBusyTraffic = false;
@@ -1389,7 +1389,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
 	if ((check_reset_cnt++ >= 3) && (!ieee->is_roaming) &&
-	    (!priv->rf_change_in_progress) && (!pPSC->bSwRfProcessing)) {
+	    (!priv->rf_change_in_progress) && (!psc->bSwRfProcessing)) {
 		ResetType = _rtl92e_if_check_reset(dev);
 		check_reset_cnt = 3;
 	}
@@ -2421,7 +2421,7 @@ bool rtl92e_enable_nic(struct net_device *dev)
 {
 	bool init_status = true;
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					(&priv->rtllib->pwr_save_ctrl);
 
 	if (!priv->up) {
@@ -2437,7 +2437,7 @@ bool rtl92e_enable_nic(struct net_device *dev)
 		priv->bdisable_nic = false;
 		return false;
 	}
-	RT_CLEAR_PS_LEVEL(pPSC, RT_RF_OFF_LEVL_HALT_NIC);
+	RT_CLEAR_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC);
 	priv->bfirst_init = false;
 
 	rtl92e_irq_enable(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 8a6b7f58ebfd..ef4f736ce325 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -100,27 +100,27 @@ void rtl92e_enter_sleep(struct net_device *dev, u64 time)
 static void _rtl92e_ps_update_rf_state(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					&priv->rtllib->pwr_save_ctrl;
 
-	pPSC->bSwRfProcessing = true;
-	rtl92e_set_rf_state(dev, pPSC->eInactivePowerState, RF_CHANGE_BY_IPS);
+	psc->bSwRfProcessing = true;
+	rtl92e_set_rf_state(dev, psc->eInactivePowerState, RF_CHANGE_BY_IPS);
 
-	pPSC->bSwRfProcessing = false;
+	psc->bSwRfProcessing = false;
 }
 
 void rtl92e_ips_enter(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					&priv->rtllib->pwr_save_ctrl;
 	enum rt_rf_power_state rt_state;
 
 	rt_state = priv->rtllib->rf_power_state;
-	if (rt_state == rf_on && !pPSC->bSwRfProcessing &&
+	if (rt_state == rf_on && !psc->bSwRfProcessing &&
 		(priv->rtllib->state != RTLLIB_LINKED) &&
 		(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
-		pPSC->eInactivePowerState = rf_off;
+		psc->eInactivePowerState = rf_off;
 		_rtl92e_ps_update_rf_state(dev);
 	}
 }
@@ -128,14 +128,14 @@ void rtl92e_ips_enter(struct net_device *dev)
 void rtl92e_ips_leave(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					&priv->rtllib->pwr_save_ctrl;
 	enum rt_rf_power_state rt_state;
 
 	rt_state = priv->rtllib->rf_power_state;
-	if (rt_state != rf_on  && !pPSC->bSwRfProcessing &&
+	if (rt_state != rf_on  && !psc->bSwRfProcessing &&
 	    priv->rtllib->rf_off_reason <= RF_CHANGE_BY_IPS) {
-		pPSC->eInactivePowerState = rf_on;
+		psc->eInactivePowerState = rf_on;
 		_rtl92e_ps_update_rf_state(dev);
 	}
 }
@@ -206,7 +206,7 @@ static bool _rtl92e_ps_set_mode(struct net_device *dev, u8 rtPsMode)
 void rtl92e_leisure_ps_enter(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					&priv->rtllib->pwr_save_ctrl;
 
 	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
@@ -215,8 +215,8 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 	    (priv->rtllib->iw_mode == IW_MODE_MASTER))
 		return;
 
-	if (pPSC->bLeisurePs) {
-		if (pPSC->LpsIdleCount >= RT_CHECK_FOR_HANG_PERIOD) {
+	if (psc->bLeisurePs) {
+		if (psc->LpsIdleCount >= RT_CHECK_FOR_HANG_PERIOD) {
 
 			if (priv->rtllib->ps == RTLLIB_PS_DISABLED) {
 				if (priv->rtllib->SetFwCmdHandler)
@@ -225,17 +225,17 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 							 RTLLIB_PS_UNICAST);
 			}
 		} else
-			pPSC->LpsIdleCount++;
+			psc->LpsIdleCount++;
 	}
 }
 
 void rtl92e_leisure_ps_leave(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					&priv->rtllib->pwr_save_ctrl;
 
-	if (pPSC->bLeisurePs) {
+	if (psc->bLeisurePs) {
 		if (priv->rtllib->ps != RTLLIB_PS_DISABLED) {
 			_rtl92e_ps_set_mode(dev, RTLLIB_PS_DISABLED);
 			if (priv->rtllib->SetFwCmdHandler)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index d68f8f5902c8..b200d53c8e3d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -159,7 +159,7 @@ static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 					   union iwreq_data *wrqu, char *extra)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					(&priv->rtllib->pwr_save_ctrl);
 	struct rtllib_device *ieee = priv->rtllib;
 
@@ -167,13 +167,13 @@ static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 
 	if (*extra || priv->force_lps) {
 		priv->ps_force = false;
-		pPSC->bLeisurePs = true;
+		psc->bLeisurePs = true;
 	} else {
 		if (priv->rtllib->state == RTLLIB_LINKED)
 			rtl92e_leisure_ps_leave(dev);
 
 		priv->ps_force = true;
-		pPSC->bLeisurePs = false;
+		psc->bLeisurePs = false;
 		ieee->ps = *extra;
 	}
 
@@ -188,7 +188,7 @@ static int _rtl92e_wx_set_lps_awake_interval(struct net_device *dev,
 					     char *extra)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
+	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
 					(&priv->rtllib->pwr_save_ctrl);
 
 	mutex_lock(&priv->wx_mutex);
@@ -196,7 +196,7 @@ static int _rtl92e_wx_set_lps_awake_interval(struct net_device *dev,
 	netdev_info(dev, "%s(): set lps awake interval ! extra is %d\n",
 		    __func__, *extra);
 
-	pPSC->reg_max_lps_awake_intvl = *extra;
+	psc->reg_max_lps_awake_intvl = *extra;
 	mutex_unlock(&priv->wx_mutex);
 	return 0;
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 487aa337eafa..6b7b2c887c34 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -111,11 +111,11 @@ static inline void *netdev_priv_rsl(struct net_device *dev)
 #define SUPPORT_CKIP_MIC			0x08
 #define SUPPORT_CKIP_PK			0x10
 #define	RT_RF_OFF_LEVL_HALT_NIC		BIT3
-#define	RT_IN_PS_LEVEL(pPSC, _PS_FLAG)		\
-	((pPSC->CurPsLevel & _PS_FLAG) ? true : false)
-#define	RT_CLEAR_PS_LEVEL(pPSC, _PS_FLAG)	\
-	(pPSC->CurPsLevel &= (~(_PS_FLAG)))
-#define	RT_SET_PS_LEVEL(pPSC, _PS_FLAG)	(pPSC->CurPsLevel |= _PS_FLAG)
+#define	RT_IN_PS_LEVEL(psc, _PS_FLAG)		\
+	((psc->CurPsLevel & _PS_FLAG) ? true : false)
+#define	RT_CLEAR_PS_LEVEL(psc, _PS_FLAG)	\
+	(psc->CurPsLevel &= (~(_PS_FLAG)))
+#define	RT_SET_PS_LEVEL(psc, _PS_FLAG)	(psc->CurPsLevel |= _PS_FLAG)
 
 /* defined for skb cb field */
 /* At most 28 byte */
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 09cc3b3068cc..ee4173a6ade0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1504,7 +1504,7 @@ static void rtllib_associate_complete_wq(void *data)
 				     container_of_work_rsl(data,
 				     struct rtllib_device,
 				     associate_complete_wq);
-	struct rt_pwr_save_ctrl *pPSC = &ieee->pwr_save_ctrl;
+	struct rt_pwr_save_ctrl *psc = &ieee->pwr_save_ctrl;
 
 	netdev_info(ieee->dev, "Associated successfully with %pM\n",
 		    ieee->current_network.bssid);
@@ -1542,7 +1542,7 @@ static void rtllib_associate_complete_wq(void *data)
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
 		ieee->LinkDetectInfo.NumRecvDataInPeriod = 1;
 	}
-	pPSC->LpsIdleCount = 0;
+	psc->LpsIdleCount = 0;
 	ieee->link_change(ieee->dev);
 
 	if (ieee->is_silent_reset) {
@@ -1960,7 +1960,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 {
 	int timeout;
 	u8 dtim;
-	struct rt_pwr_save_ctrl *pPSC = &ieee->pwr_save_ctrl;
+	struct rt_pwr_save_ctrl *psc = &ieee->pwr_save_ctrl;
 
 	if (ieee->LPSDelayCnt) {
 		ieee->LPSDelayCnt--;
@@ -1990,21 +1990,21 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 
 	if (time) {
 		if (ieee->bAwakePktSent) {
-			pPSC->LPSAwakeIntvl = 1;
+			psc->LPSAwakeIntvl = 1;
 		} else {
 			u8 MaxPeriod = 1;
 
-			if (pPSC->LPSAwakeIntvl == 0)
-				pPSC->LPSAwakeIntvl = 1;
-			if (pPSC->reg_max_lps_awake_intvl == 0)
+			if (psc->LPSAwakeIntvl == 0)
+				psc->LPSAwakeIntvl = 1;
+			if (psc->reg_max_lps_awake_intvl == 0)
 				MaxPeriod = 1;
-			else if (pPSC->reg_max_lps_awake_intvl == 0xFF)
+			else if (psc->reg_max_lps_awake_intvl == 0xFF)
 				MaxPeriod = ieee->current_network.dtim_period;
 			else
-				MaxPeriod = pPSC->reg_max_lps_awake_intvl;
-			pPSC->LPSAwakeIntvl = (pPSC->LPSAwakeIntvl >=
+				MaxPeriod = psc->reg_max_lps_awake_intvl;
+			psc->LPSAwakeIntvl = (psc->LPSAwakeIntvl >=
 					       MaxPeriod) ? MaxPeriod :
-					       (pPSC->LPSAwakeIntvl + 1);
+					       (psc->LPSAwakeIntvl + 1);
 		}
 		{
 			u8 LPSAwakeIntvl_tmp = 0;
@@ -2012,23 +2012,23 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 			u8 count = ieee->current_network.tim.tim_count;
 
 			if (count == 0) {
-				if (pPSC->LPSAwakeIntvl > period)
+				if (psc->LPSAwakeIntvl > period)
 					LPSAwakeIntvl_tmp = period +
-						 (pPSC->LPSAwakeIntvl -
+						 (psc->LPSAwakeIntvl -
 						 period) -
-						 ((pPSC->LPSAwakeIntvl-period) %
+						 ((psc->LPSAwakeIntvl-period) %
 						 period);
 				else
-					LPSAwakeIntvl_tmp = pPSC->LPSAwakeIntvl;
+					LPSAwakeIntvl_tmp = psc->LPSAwakeIntvl;
 
 			} else {
-				if (pPSC->LPSAwakeIntvl >
+				if (psc->LPSAwakeIntvl >
 				    ieee->current_network.tim.tim_count)
 					LPSAwakeIntvl_tmp = count +
-					(pPSC->LPSAwakeIntvl - count) -
-					((pPSC->LPSAwakeIntvl-count)%period);
+					(psc->LPSAwakeIntvl - count) -
+					((psc->LPSAwakeIntvl-count)%period);
 				else
-					LPSAwakeIntvl_tmp = pPSC->LPSAwakeIntvl;
+					LPSAwakeIntvl_tmp = psc->LPSAwakeIntvl;
 			}
 
 		*time = ieee->current_network.last_dtim_sta_time
-- 
2.37.3

