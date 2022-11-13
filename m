Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91256626DB5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiKMEgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiKMEgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:36:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCA913D4E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g12so11599540wrs.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4lHrdyZ1OUai3OcgSWAkeaePSfKre0ZQFniV/1r+XE=;
        b=IeXwsq2CEqFze2oocqsQt5ErcQl37/diyh7GaRX1+p86++EAMWrNg0cbJcbRJp0VKb
         x0M1hHpJE+rvc/rDGluGt1+VK1/EBCCgycJF5XI6f1aS6BONr/n39Gkx4WN4srMzNpD9
         a2c16sx34aOi8bUMZy7SeyL8nl4que75etyHdAN/lWX7qUvs+6l05CgBBOoT0jhkMUS4
         2S9aFQtWT0KRUWX3ZJnWUH3juaH9w2SEVI1DU3HceflNrZYrD6kBw8xpti1Zahp0pOGf
         Zj9s2XYlrhwDYkXvXPx0wCONn5uod7lBd7IIS1nMzVAIn4NMXlDKiDRYkH8DZtSTrQhr
         enow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4lHrdyZ1OUai3OcgSWAkeaePSfKre0ZQFniV/1r+XE=;
        b=T2VB7rmKhMCFO3OUiAuzb4/bsxM0StnfLFkZeH02x2XZ9QvZJOuKHKXgn/ArKn3U2X
         Kqql+i/MRekvK8H7gllR5dyFiAMFCPOw4C4pmMMklIW6/jibxBdycG4t0z1OyvQmPh1a
         R2DVEFtiTCXOBuedAzoqxthXaKqQ8iSs6sy6FXAqwYSL1o5po+dkG0nycF/uV5x9zWdq
         EA3NXwUZIuI3PLOS8GUqDJFu2Nv9a9VEs1osTsf852n3+glqhlJgw/jRfnW3jgKl+8Gy
         oNI14KpEHP/I0nJufn1p/NTYhk3Mtzeqg/afvzsVcPZgF71BObTP/whypq5aHH/YlBsa
         Bh2Q==
X-Gm-Message-State: ANoB5pnjI9ewbOhASVTa6/5WSGImmxngYtFcuzdXFHIkW8oD7X4lwvDz
        rhP2o9GLVgUypJDXvuTux6gROg7Q9K0=
X-Google-Smtp-Source: AA0mqf5uxvhh67S6SjHE0i0/bVxuZ45nc1bRfnWqDNN/j3KfPJ0/qq5yCscppChxly4kcbqsCm0yXQ==
X-Received: by 2002:adf:f6ca:0:b0:236:6e2a:ac12 with SMTP id y10-20020adff6ca000000b002366e2aac12mr4386420wrp.366.1668314157951;
        Sat, 12 Nov 2022 20:35:57 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c2cda00b003cf774c31a0sm14627087wmc.16.2022.11.12.20.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:35:57 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:35:55 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Rename bNetPromisc..,
 IntelPromiscu.. and bPromiscu..
Message-ID: <69d9998a30ce2286c3ae6cb4510174e1255b3f9e.1668313325.git.philipp.g.hortmann@gmail.com>
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

Rename variable bNetPromiscuousMode to net_promiscuous_md,
IntelPromiscuousModeInfo to intel_promiscuous_md_info and bPromiscuousOn
to promiscuous_on to avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    | 20 +++++++++----------
 drivers/staging/rtl8192e/rtllib.h             |  6 +++---
 drivers/staging/rtl8192e/rtllib_rx.c          |  8 ++++----
 drivers/staging/rtl8192e/rtllib_softmac.c     |  4 ++--
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index d0ce89837073..2ccd1e0542c2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -859,7 +859,7 @@ void rtl92e_link_change(struct net_device *dev)
 
 		reg = rtl92e_readl(dev, RCR);
 		if (priv->rtllib->state == RTLLIB_LINKED) {
-			if (ieee->IntelPromiscuousModeInfo.bPromiscuousOn)
+			if (ieee->intel_promiscuous_md_info.promiscuous_on)
 				;
 			else
 				priv->ReceiveConfig = reg |= RCR_CBSSID;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 3379b4229a85..94b8ed2e3489 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -848,9 +848,9 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->reg_chnl_plan = 0xf;
 	priv->rtllib->mode = WIRELESS_MODE_AUTO;
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
-	priv->rtllib->bNetPromiscuousMode = false;
-	priv->rtllib->IntelPromiscuousModeInfo.bPromiscuousOn = false;
-	priv->rtllib->IntelPromiscuousModeInfo.bFilterSourceStationFrame =
+	priv->rtllib->net_promiscuous_md = false;
+	priv->rtllib->intel_promiscuous_md_info.promiscuous_on = false;
+	priv->rtllib->intel_promiscuous_md_info.bFilterSourceStationFrame =
 								 false;
 	priv->rtllib->ieee_up = 0;
 	priv->retry_rts = DEFAULT_RETRY_RTS;
@@ -1297,13 +1297,13 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		     (!ieee->proto_stoppping) && !ieee->wx_set_enc) {
 			if ((ieee->pwr_save_ctrl.ReturnPoint ==
 			     IPS_CALLBACK_NONE) &&
-			     (!ieee->bNetPromiscuousMode)) {
+			     (!ieee->net_promiscuous_md)) {
 				rtl92e_ips_enter(dev);
 			}
 		}
 	}
 	if ((ieee->state == RTLLIB_LINKED) && (ieee->iw_mode ==
-	     IW_MODE_INFRA) && (!ieee->bNetPromiscuousMode)) {
+	     IW_MODE_INFRA) && (!ieee->net_promiscuous_md)) {
 		if (ieee->link_detect_info.NumRxOkInPeriod > 100 ||
 		ieee->link_detect_info.NumTxOkInPeriod > 100)
 			bBusyTraffic = true;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 4f16c3d079cc..c31e5b572e9e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -251,7 +251,7 @@ static int _rtl92e_wx_set_mode(struct net_device *dev,
 	rt_state = priv->rtllib->rf_power_state;
 	mutex_lock(&priv->wx_mutex);
 	if (wrqu->mode == IW_MODE_ADHOC || wrqu->mode == IW_MODE_MONITOR ||
-	    ieee->bNetPromiscuousMode) {
+	    ieee->net_promiscuous_md) {
 		if (rt_state == rf_off) {
 			if (priv->rtllib->rf_off_reason >
 			    RF_CHANGE_BY_IPS) {
@@ -1014,28 +1014,28 @@ static int _rtl92e_wx_set_promisc_mode(struct net_device *dev,
 	u32 info_buf[3];
 
 	u32 oid;
-	u32 bPromiscuousOn;
+	u32 promiscuous_on;
 	u32 bFilterSourceStationFrame;
 
 	if (copy_from_user(info_buf, wrqu->data.pointer, sizeof(info_buf)))
 		return -EFAULT;
 
 	oid = info_buf[0];
-	bPromiscuousOn = info_buf[1];
+	promiscuous_on = info_buf[1];
 	bFilterSourceStationFrame = info_buf[2];
 
 	if (oid == OID_RT_INTEL_PROMISCUOUS_MODE) {
-		ieee->IntelPromiscuousModeInfo.bPromiscuousOn =
-					(bPromiscuousOn) ? (true) : (false);
-		ieee->IntelPromiscuousModeInfo.bFilterSourceStationFrame =
+		ieee->intel_promiscuous_md_info.promiscuous_on =
+					(promiscuous_on) ? (true) : (false);
+		ieee->intel_promiscuous_md_info.bFilterSourceStationFrame =
 			(bFilterSourceStationFrame) ? (true) : (false);
-		(bPromiscuousOn) ?
+		(promiscuous_on) ?
 		(rtllib_EnableIntelPromiscuousMode(dev, false)) :
 		(rtllib_DisableIntelPromiscuousMode(dev, false));
 
 		netdev_info(dev,
 			    "=======>%s(), on = %d, filter src sta = %d\n",
-			    __func__, bPromiscuousOn,
+			    __func__, promiscuous_on,
 			    bFilterSourceStationFrame);
 	} else {
 		return -1;
@@ -1054,8 +1054,8 @@ static int _rtl92e_wx_get_promisc_mode(struct net_device *dev,
 	mutex_lock(&priv->wx_mutex);
 
 	snprintf(extra, 45, "PromiscuousMode:%d, FilterSrcSTAFrame:%d",
-		 ieee->IntelPromiscuousModeInfo.bPromiscuousOn,
-		 ieee->IntelPromiscuousModeInfo.bFilterSourceStationFrame);
+		 ieee->intel_promiscuous_md_info.promiscuous_on,
+		 ieee->intel_promiscuous_md_info.bFilterSourceStationFrame);
 	wrqu->data.length = strlen(extra) + 1;
 
 	mutex_unlock(&priv->wx_mutex);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b5313c1ea32d..493759cc6ccf 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1384,7 +1384,7 @@ struct rt_pmkid_list {
 };
 
 struct rt_intel_promisc_mode {
-	bool bPromiscuousOn;
+	bool promiscuous_on;
 	bool bFilterSourceStationFrame;
 };
 
@@ -1470,8 +1470,8 @@ struct rtllib_device {
 	int scan_age;
 
 	int iw_mode; /* operating mode (IW_MODE_*) */
-	bool bNetPromiscuousMode;
-	struct rt_intel_promisc_mode IntelPromiscuousModeInfo;
+	bool net_promiscuous_md;
+	struct rt_intel_promisc_mode intel_promiscuous_md_info;
 
 	spinlock_t lock;
 	spinlock_t wpax_suitlist_lock;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index f9a35fcb1d1b..ccb61d8decd3 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -999,8 +999,8 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, u16 fc,
 	}
 
 	/* Filter packets sent by an STA that will be forwarded by AP */
-	if (ieee->IntelPromiscuousModeInfo.bPromiscuousOn  &&
-		ieee->IntelPromiscuousModeInfo.bFilterSourceStationFrame) {
+	if (ieee->intel_promiscuous_md_info.promiscuous_on  &&
+		ieee->intel_promiscuous_md_info.bFilterSourceStationFrame) {
 		if ((fc & RTLLIB_FCTL_TODS) && !(fc & RTLLIB_FCTL_FROMDS) &&
 		    !ether_addr_equal(dst, ieee->current_network.bssid) &&
 		    ether_addr_equal(bssid, ieee->current_network.bssid)) {
@@ -1011,7 +1011,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, u16 fc,
 	/* Nullfunc frames may have PS-bit set, so they must be passed to
 	 * hostap_handle_sta_rx() before being dropped here.
 	 */
-	if (!ieee->IntelPromiscuousModeInfo.bPromiscuousOn) {
+	if (!ieee->intel_promiscuous_md_info.promiscuous_on) {
 		if (stype != RTLLIB_STYPE_DATA &&
 		    stype != RTLLIB_STYPE_DATA_CFACK &&
 		    stype != RTLLIB_STYPE_DATA_CFPOLL &&
@@ -1317,7 +1317,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	multicast = is_multicast_ether_addr(hdr->addr1);
 	unicast = !multicast;
 	if (unicast && !ether_addr_equal(dev->dev_addr, hdr->addr1)) {
-		if (ieee->bNetPromiscuousMode)
+		if (ieee->net_promiscuous_md)
 			bToOtherSTA = true;
 		else
 			goto rx_dropped;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 1d583e73d753..8b1d88061125 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -445,7 +445,7 @@ void rtllib_EnableIntelPromiscuousMode(struct net_device *dev,
 	ieee->SetHwRegHandler(dev, HW_VAR_CECHK_BSSID,
 			     (u8 *)&bFilterOutNonAssociatedBSSID);
 
-	ieee->bNetPromiscuousMode = true;
+	ieee->net_promiscuous_md = true;
 }
 EXPORT_SYMBOL(rtllib_EnableIntelPromiscuousMode);
 
@@ -466,7 +466,7 @@ void rtllib_DisableIntelPromiscuousMode(struct net_device *dev,
 	ieee->SetHwRegHandler(dev, HW_VAR_CECHK_BSSID,
 			     (u8 *)&bFilterOutNonAssociatedBSSID);
 
-	ieee->bNetPromiscuousMode = false;
+	ieee->net_promiscuous_md = false;
 }
 EXPORT_SYMBOL(rtllib_DisableIntelPromiscuousMode);
 
-- 
2.37.3

