Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45A8626DB4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiKMEgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiKMEfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:35:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5E512D1B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d9so6928952wrm.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5tZwItwL6s7lK3c+/8kCHb4udKHuff6wggT5kROdGK0=;
        b=PbWShGzBJPGbiRKsvmA0+Of1Q2hjrvNcZtQ9snSBkDjv3sUDgqR76LMQr3OmBfDKqJ
         miv/z/k4VMST+1xYB/goAtAoBoCsNCRILNbA3ye7MjOepB/ggksGF6JEADBY570MOOd1
         JoJMR02Zw27r5qE1znonwRLTOsNFt5AD7geOPudRuC/PA9aoWi05HIi/68qu6IsXReN8
         HMoQdWYuLIcZwRhRUIdbet1RDw4gfef1ZxrFYZAFdZNEt8SE8eSBwrEf3GHlq5SZspG1
         +mOjCYItnF+hoXz4G25QJ4a7IRAZvEWLULoXOGs9KkkGunGrs3iBWuBLCgFA3dly1Cwm
         nksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tZwItwL6s7lK3c+/8kCHb4udKHuff6wggT5kROdGK0=;
        b=GVgYLrtYxPUtLmFbcoFevzbSEQvLci4hL7bqippWiZ7c3ToNXqoHj4O/tTALD2JtUG
         5ncz0MwJnjfvOfrRI+uUEP3ljXp6C0O1pF5p4guy7Rrq6J8aqG3o2/BBAuNhnP/Ljo6s
         EBzA8oSsLlRrV/4qBYq1GV25oQRy6kFBvK1nSnyaX9sly90M+LOhFynHfBWIsK4ABra6
         YR+mXnUPgYuRF98UwOa+kX4TDAV4sQEAp5OXetMjHlKUnWVMpgEX5l9VQsu++ht/6goK
         TQkscCyL1E84uCrRPcAQpIoGgyXMoXhkAfPs/zo0YvAq3qoxiaN8EV5bNrc6CxiqAphb
         141A==
X-Gm-Message-State: ANoB5pnq4tNQtFptlvXqkNcdc+F1fOEVHhzUGl6L2L48EvhMateD78Us
        4wgIxsKGAqEp+4jaOIYazTA=
X-Google-Smtp-Source: AA0mqf7oX67XqqD1ToukRTizzMIUIX/MbWx1hSLaiCbk6tyoOxcQmTMzenLPcwkCfmASOwn7H9qIog==
X-Received: by 2002:a5d:688f:0:b0:236:70ab:52fb with SMTP id h15-20020a5d688f000000b0023670ab52fbmr4555451wru.557.1668314151144;
        Sat, 12 Nov 2022 20:35:51 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b00236722ebe66sm5967890wrn.75.2022.11.12.20.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:35:50 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:35:49 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Rename LinkDetectInfo
Message-ID: <48d043893fa755490e810af204e5b7ad2ba606de.1668313325.git.philipp.g.hortmann@gmail.com>
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

Rename variable LinkDetectInfo to link_detect_info to avoid CamelCase
which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 58 ++++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  2 +-
 drivers/staging/rtl8192e/rtllib.h            |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         | 14 ++---
 drivers/staging/rtl8192e/rtllib_softmac.c    | 26 ++++-----
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  8 +--
 6 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 1bf5e760d87a..3379b4229a85 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1250,15 +1250,15 @@ static void _rtl92e_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
 	*TotalRxBcnNum = 0;
 	*TotalRxDataNum = 0;
 
-	SlotIndex = (priv->rtllib->LinkDetectInfo.SlotIndex++) %
-			(priv->rtllib->LinkDetectInfo.SlotNum);
-	priv->rtllib->LinkDetectInfo.RxBcnNum[SlotIndex] =
-			priv->rtllib->LinkDetectInfo.NumRecvBcnInPeriod;
-	priv->rtllib->LinkDetectInfo.RxDataNum[SlotIndex] =
-			priv->rtllib->LinkDetectInfo.NumRecvDataInPeriod;
-	for (i = 0; i < priv->rtllib->LinkDetectInfo.SlotNum; i++) {
-		*TotalRxBcnNum += priv->rtllib->LinkDetectInfo.RxBcnNum[i];
-		*TotalRxDataNum += priv->rtllib->LinkDetectInfo.RxDataNum[i];
+	SlotIndex = (priv->rtllib->link_detect_info.SlotIndex++) %
+			(priv->rtllib->link_detect_info.SlotNum);
+	priv->rtllib->link_detect_info.RxBcnNum[SlotIndex] =
+			priv->rtllib->link_detect_info.NumRecvBcnInPeriod;
+	priv->rtllib->link_detect_info.RxDataNum[SlotIndex] =
+			priv->rtllib->link_detect_info.NumRecvDataInPeriod;
+	for (i = 0; i < priv->rtllib->link_detect_info.SlotNum; i++) {
+		*TotalRxBcnNum += priv->rtllib->link_detect_info.RxBcnNum[i];
+		*TotalRxDataNum += priv->rtllib->link_detect_info.RxDataNum[i];
 	}
 }
 
@@ -1304,22 +1304,22 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	}
 	if ((ieee->state == RTLLIB_LINKED) && (ieee->iw_mode ==
 	     IW_MODE_INFRA) && (!ieee->bNetPromiscuousMode)) {
-		if (ieee->LinkDetectInfo.NumRxOkInPeriod > 100 ||
-		ieee->LinkDetectInfo.NumTxOkInPeriod > 100)
+		if (ieee->link_detect_info.NumRxOkInPeriod > 100 ||
+		ieee->link_detect_info.NumTxOkInPeriod > 100)
 			bBusyTraffic = true;
 
-		if (ieee->LinkDetectInfo.NumRxOkInPeriod > 4000 ||
-		    ieee->LinkDetectInfo.NumTxOkInPeriod > 4000) {
+		if (ieee->link_detect_info.NumRxOkInPeriod > 4000 ||
+		    ieee->link_detect_info.NumTxOkInPeriod > 4000) {
 			bHigherBusyTraffic = true;
-			if (ieee->LinkDetectInfo.NumRxOkInPeriod > 5000)
+			if (ieee->link_detect_info.NumRxOkInPeriod > 5000)
 				bHigherBusyRxTraffic = true;
 			else
 				bHigherBusyRxTraffic = false;
 		}
 
-		if (((ieee->LinkDetectInfo.NumRxUnicastOkInPeriod +
-		    ieee->LinkDetectInfo.NumTxOkInPeriod) > 8) ||
-		    (ieee->LinkDetectInfo.NumRxUnicastOkInPeriod > 2))
+		if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
+		    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
+		    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2))
 			bEnterPS = false;
 		else
 			bEnterPS = true;
@@ -1336,13 +1336,13 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		rtl92e_leisure_ps_leave(dev);
 	}
 
-	ieee->LinkDetectInfo.NumRxOkInPeriod = 0;
-	ieee->LinkDetectInfo.NumTxOkInPeriod = 0;
-	ieee->LinkDetectInfo.NumRxUnicastOkInPeriod = 0;
-	ieee->LinkDetectInfo.bBusyTraffic = bBusyTraffic;
+	ieee->link_detect_info.NumRxOkInPeriod = 0;
+	ieee->link_detect_info.NumTxOkInPeriod = 0;
+	ieee->link_detect_info.NumRxUnicastOkInPeriod = 0;
+	ieee->link_detect_info.bBusyTraffic = bBusyTraffic;
 
-	ieee->LinkDetectInfo.bHigherBusyTraffic = bHigherBusyTraffic;
-	ieee->LinkDetectInfo.bHigherBusyRxTraffic = bHigherBusyRxTraffic;
+	ieee->link_detect_info.bHigherBusyTraffic = bHigherBusyTraffic;
+	ieee->link_detect_info.bHigherBusyRxTraffic = bHigherBusyRxTraffic;
 
 	if (ieee->state == RTLLIB_LINKED && ieee->iw_mode == IW_MODE_INFRA) {
 		u32	TotalRxBcnNum = 0;
@@ -1383,8 +1383,8 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 
 			priv->check_roaming_cnt = 0;
 		}
-		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 0;
-		ieee->LinkDetectInfo.NumRecvDataInPeriod = 0;
+		ieee->link_detect_info.NumRecvBcnInPeriod = 0;
+		ieee->link_detect_info.NumRecvDataInPeriod = 0;
 	}
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
@@ -2213,25 +2213,25 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 
 	if (inta & IMR_BKDOK) {
 		priv->stats.txbkokint++;
-		priv->rtllib->LinkDetectInfo.NumTxOkInPeriod++;
+		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, BK_QUEUE);
 	}
 
 	if (inta & IMR_BEDOK) {
 		priv->stats.txbeokint++;
-		priv->rtllib->LinkDetectInfo.NumTxOkInPeriod++;
+		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, BE_QUEUE);
 	}
 
 	if (inta & IMR_VIDOK) {
 		priv->stats.txviokint++;
-		priv->rtllib->LinkDetectInfo.NumTxOkInPeriod++;
+		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, VI_QUEUE);
 	}
 
 	if (inta & IMR_VODOK) {
 		priv->stats.txvookint++;
-		priv->rtllib->LinkDetectInfo.NumTxOkInPeriod++;
+		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, VO_QUEUE);
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index b200d53c8e3d..4f16c3d079cc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -393,7 +393,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 	rt_state = priv->rtllib->rf_power_state;
 	if (!priv->up)
 		return -ENETDOWN;
-	if (priv->rtllib->LinkDetectInfo.bBusyTraffic == true)
+	if (priv->rtllib->link_detect_info.bBusyTraffic == true)
 		return -EAGAIN;
 
 	if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6b7b2c887c34..b5313c1ea32d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1643,7 +1643,7 @@ struct rtllib_device {
 	struct bandwidth_autoswitch bandwidth_auto_switch;
 	bool FwRWRF;
 
-	struct rt_link_detect LinkDetectInfo;
+	struct rt_link_detect link_detect_info;
 	bool bIsAggregateFrame;
 	struct rt_pwr_save_ctrl pwr_save_ctrl;
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 46d75e925ee9..f9a35fcb1d1b 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1211,9 +1211,9 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 	if (unicast) {
 
 		if (ieee->state == RTLLIB_LINKED) {
-			if (((ieee->LinkDetectInfo.NumRxUnicastOkInPeriod +
-			    ieee->LinkDetectInfo.NumTxOkInPeriod) > 8) ||
-			    (ieee->LinkDetectInfo.NumRxUnicastOkInPeriod > 2)) {
+			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
+			    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
+			    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2)) {
 				if (ieee->LeisurePSLeave)
 					ieee->LeisurePSLeave(ieee->dev);
 			}
@@ -1355,8 +1355,8 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	/* Update statstics for AP roaming */
 	if (!bToOtherSTA) {
-		ieee->LinkDetectInfo.NumRecvDataInPeriod++;
-		ieee->LinkDetectInfo.NumRxOkInPeriod++;
+		ieee->link_detect_info.NumRecvDataInPeriod++;
+		ieee->link_detect_info.NumRxOkInPeriod++;
 	}
 
 	/* Data frame - extract src/dst addresses */
@@ -1437,7 +1437,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 		else
 			nr_subframes = 1;
 		if (unicast)
-			ieee->LinkDetectInfo.NumRxUnicastOkInPeriod += nr_subframes;
+			ieee->link_detect_info.NumRxUnicastOkInPeriod += nr_subframes;
 		rtllib_rx_check_leave_lps(ieee, unicast, nr_subframes);
 	}
 
@@ -2620,7 +2620,7 @@ static inline void rtllib_process_probe_response(
 		}
 		if (is_beacon(frame_ctl)) {
 			if (ieee->state >= RTLLIB_LINKED)
-				ieee->LinkDetectInfo.NumRecvBcnInPeriod++;
+				ieee->link_detect_info.NumRecvBcnInPeriod++;
 		}
 	}
 	list_for_each_entry(target, &ieee->network_list, list) {
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ac8132d8c45a..1d583e73d753 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1534,13 +1534,13 @@ static void rtllib_associate_complete_wq(void *data)
 			    ieee->pHTInfo->enable_ht);
 		memset(ieee->dot11ht_oper_rate_set, 0, 16);
 	}
-	ieee->LinkDetectInfo.SlotNum = 2 * (1 +
+	ieee->link_detect_info.SlotNum = 2 * (1 +
 				       ieee->current_network.beacon_interval /
 				       500);
-	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 ||
-	    ieee->LinkDetectInfo.NumRecvDataInPeriod == 0) {
-		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
-		ieee->LinkDetectInfo.NumRecvDataInPeriod = 1;
+	if (ieee->link_detect_info.NumRecvBcnInPeriod == 0 ||
+	    ieee->link_detect_info.NumRecvDataInPeriod == 0) {
+		ieee->link_detect_info.NumRecvBcnInPeriod = 1;
+		ieee->link_detect_info.NumRecvDataInPeriod = 1;
 	}
 	psc->LpsIdleCount = 0;
 	ieee->link_change(ieee->dev);
@@ -2369,7 +2369,7 @@ rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->state = RTLLIB_ASSOCIATING;
 		ieee->softmac_stats.reassoc++;
 		ieee->is_roaming = true;
-		ieee->LinkDetectInfo.bBusyTraffic = false;
+		ieee->link_detect_info.bBusyTraffic = false;
 		rtllib_disassociate(ieee);
 		RemovePeerTS(ieee, header->addr2);
 		if (ieee->LedControlHandler != NULL)
@@ -2963,13 +2963,13 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	if (!ieee->dot11d_info)
 		return -ENOMEM;
 
-	ieee->LinkDetectInfo.SlotIndex = 0;
-	ieee->LinkDetectInfo.SlotNum = 2;
-	ieee->LinkDetectInfo.NumRecvBcnInPeriod = 0;
-	ieee->LinkDetectInfo.NumRecvDataInPeriod = 0;
-	ieee->LinkDetectInfo.NumTxOkInPeriod = 0;
-	ieee->LinkDetectInfo.NumRxOkInPeriod = 0;
-	ieee->LinkDetectInfo.NumRxUnicastOkInPeriod = 0;
+	ieee->link_detect_info.SlotIndex = 0;
+	ieee->link_detect_info.SlotNum = 2;
+	ieee->link_detect_info.NumRecvBcnInPeriod = 0;
+	ieee->link_detect_info.NumRecvDataInPeriod = 0;
+	ieee->link_detect_info.NumTxOkInPeriod = 0;
+	ieee->link_detect_info.NumRxOkInPeriod = 0;
+	ieee->link_detect_info.NumRxUnicastOkInPeriod = 0;
 	ieee->bIsAggregateFrame = false;
 	ieee->assoc_id = 0;
 	ieee->queue_stop = 0;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 7bac30b87c93..e02e7d9566b2 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -391,10 +391,10 @@ void rtllib_wx_sync_scan_wq(void *data)
 	/* Notify AP that I wake up again */
 	rtllib_sta_ps_send_null_frame(ieee, 0);
 
-	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 ||
-	    ieee->LinkDetectInfo.NumRecvDataInPeriod == 0) {
-		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
-		ieee->LinkDetectInfo.NumRecvDataInPeriod = 1;
+	if (ieee->link_detect_info.NumRecvBcnInPeriod == 0 ||
+	    ieee->link_detect_info.NumRecvDataInPeriod == 0) {
+		ieee->link_detect_info.NumRecvBcnInPeriod = 1;
+		ieee->link_detect_info.NumRecvDataInPeriod = 1;
 	}
 
 	if (ieee->data_hard_resume)
-- 
2.37.3

