Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540F0626DAF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiKMEfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiKMEe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:34:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624F92708
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:34:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso8155638wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAWsbWp78QUbwJYkMpafVAHECF2EYb69Stx3JjLvYOQ=;
        b=nf81Mq/+xahfo8zf8EKAT/QdV1cKt7E9G/tSFG0mJxYlwVnM/wZFBBQwnVLq6kMieL
         0sPqFoSbV58vABF7JXnaVlHDZS3ftVA5+aAo/U/KQPdgPtefBPaJPyj+T9VUIMjOiPf3
         5LKJuTOFl0YuwJZ1n/9AdK33PUBVyBpIada6he634J+1LrEtb7FhRTlIwtOqd8fB52yl
         UNXXH1cSLdJ1+06A3dYBDY/QsCKX8GRoDC699jpzUXEtgOUk0EgwWj38YYP11Hmluz98
         iYPVCLTg9ciXUdaSSP10yXJ6xFFy8mdzOLBOW242MMkVMMspK75kqI0u8b+M2KYKScbR
         s/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAWsbWp78QUbwJYkMpafVAHECF2EYb69Stx3JjLvYOQ=;
        b=RjVlJXeasNw3BrX28FhLFSTnuNDn+Xt8O3rmqWuEpUZW6ML9M9xr/QQ/0DVB4gHAuf
         NDS6NR8DCIKanjHKWG+ksTXM8ORn7PD7zkokGyBRorlg5ob2re2DTBRN8Vle5VR8+tWm
         e/MLcok8EQsFpCmpOqzm7wA0dug8tUZwQpMMFy7cYp4klr55hr+jUOC1IolLuLFzsufb
         RdZsaM6KgGkCC/TTlkGEMFur3QspxeaTggz4C32KfuW8IvSzTwtl3Mvs3IpuCqjXI4g1
         1lnJpTkLBJ7aLFP4IBrRkQ97egbOQZUhmrn9sdlox/AKCJCLxskyNKFBtQokTCG5U8lb
         Hlew==
X-Gm-Message-State: ANoB5plEO9796r/k/cAF1T9B5yaRpdPY1XBZWRnpaoYlocehvPgV6kgv
        id4JFddNWnmPN03MlsvmJNo=
X-Google-Smtp-Source: AA0mqf40PHWzizxXwoZEMCCbXgQ0xHjuGvwiTwPZZunfTm9pIwmgo6xca2PBpEyJYKf8xRKMTY46ww==
X-Received: by 2002:a7b:cb97:0:b0:3cf:a359:de90 with SMTP id m23-20020a7bcb97000000b003cfa359de90mr4999369wmi.122.1668314096849;
        Sat, 12 Nov 2022 20:34:56 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id e1-20020adfe381000000b0023662d97130sm5881812wrm.20.2022.11.12.20.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:34:56 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:34:54 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Rename bTxDisableRate..,
 RegMaxLPSAwa.. and bTxUseD..
Message-ID: <092eb2dc73d37daf851ea9ef9cb7e4df6f766845.1668313325.git.philipp.g.hortmann@gmail.com>
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

Rename variable bTxDisableRateFallBack to tx_dis_rate_fallback,
RegMaxLPSAwakeIntvl to reg_max_lps_awake_intvl and
bTxUseDriverAssingedRate to tx_use_drv_assinged_rate to avoid CamelCase
which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 10 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  4 ++--
 drivers/staging/rtl8192e/rtllib.h             | 10 ++++----
 drivers/staging/rtl8192e/rtllib_softmac.c     | 14 +++++------
 drivers/staging/rtl8192e/rtllib_tx.c          | 24 +++++++++----------
 7 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 210b7ecc273a..39aac83d8960 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1136,8 +1136,8 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 							  cb_desc->priority);
 	pdesc->TxFWInfoSize = sizeof(struct tx_fwinfo_8190pci);
 
-	pdesc->DISFB = cb_desc->bTxDisableRateFallBack;
-	pdesc->USERATE = cb_desc->bTxUseDriverAssingedRate;
+	pdesc->DISFB = cb_desc->tx_dis_rate_fallback;
+	pdesc->USERATE = cb_desc->tx_use_drv_assinged_rate;
 
 	pdesc->FirstSeg = 1;
 	pdesc->LastSeg = 1;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 213aac943ef7..952fe8d7a7be 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -494,8 +494,8 @@ static void _rtl92e_prepare_beacon(struct tasklet_struct *t)
 	tcb_desc->queue_index = BEACON_QUEUE;
 	tcb_desc->data_rate = 2;
 	tcb_desc->RATRIndex = 7;
-	tcb_desc->bTxDisableRateFallBack = 1;
-	tcb_desc->bTxUseDriverAssingedRate = 1;
+	tcb_desc->tx_dis_rate_fallback = 1;
+	tcb_desc->tx_use_drv_assinged_rate = 1;
 	skb_push(pnewskb, priv->rtllib->tx_headroom);
 
 	pdesc = &ring->desc[0];
@@ -822,7 +822,7 @@ static void _rtl92e_init_priv_constant(struct net_device *dev)
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
 					&priv->rtllib->PowerSaveControl;
 
-	pPSC->RegMaxLPSAwakeIntvl = 5;
+	pPSC->reg_max_lps_awake_intvl = 5;
 }
 
 static void _rtl92e_init_priv_variable(struct net_device *dev)
@@ -1538,8 +1538,8 @@ static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	tcb_desc->RATRIndex = 7;
-	tcb_desc->bTxDisableRateFallBack = 1;
-	tcb_desc->bTxUseDriverAssingedRate = 1;
+	tcb_desc->tx_dis_rate_fallback = 1;
+	tcb_desc->tx_use_drv_assinged_rate = 1;
 	tcb_desc->bTxEnableFwCalcDur = 1;
 	skb_push(skb, priv->rtllib->tx_headroom);
 	ret = _rtl92e_tx(dev, skb);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 12eea4fcb9dd..ffef63e8dcae 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -196,7 +196,7 @@ static int _rtl92e_wx_set_lps_awake_interval(struct net_device *dev,
 	netdev_info(dev, "%s(): set lps awake interval ! extra is %d\n",
 		    __func__, *extra);
 
-	pPSC->RegMaxLPSAwakeIntvl = *extra;
+	pPSC->reg_max_lps_awake_intvl = *extra;
 	mutex_unlock(&priv->wx_mutex);
 	return 0;
 }
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 2c0a8d5c8f27..7fad983ad4be 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -91,8 +91,8 @@ void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 	pHTInfo->self_mimo_ps = 3;
 	if (pHTInfo->self_mimo_ps == 2)
 		pHTInfo->self_mimo_ps = 3;
-	ieee->bTxDisableRateFallBack = 0;
-	ieee->bTxUseDriverAssingedRate = 0;
+	ieee->tx_dis_rate_fallback = 0;
+	ieee->tx_use_drv_assinged_rate = 0;
 
 	ieee->bTxEnableFwCalcDur = 1;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e0fa87b12ceb..ca9e016ffa9f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -126,8 +126,8 @@ struct cb_desc {
 	u8 bFirstSeg:1;
 	u8 bLastSeg:1;
 	u8 bEncrypt:1;
-	u8 bTxDisableRateFallBack:1;
-	u8 bTxUseDriverAssingedRate:1;
+	u8 tx_dis_rate_fallback:1;
+	u8 tx_use_drv_assinged_rate:1;
 	u8 bHwSec:1;
 
 	u8 nStuckCount;
@@ -1256,7 +1256,7 @@ struct rt_pwr_save_ctrl {
 
 	bool				bLeisurePs;
 	u8				LpsIdleCount;
-	u8				RegMaxLPSAwakeIntvl;
+	u8				reg_max_lps_awake_intvl;
 	u8				LPSAwakeIntvl;
 
 	u32				CurPsLevel;
@@ -1441,8 +1441,8 @@ struct rtllib_device {
 	u8	RegHTSuppRateSet[16];
 	u8	HTCurrentOperaRate;
 	u8	HTHighestOperaRate;
-	u8	bTxDisableRateFallBack;
-	u8	bTxUseDriverAssingedRate;
+	u8	tx_dis_rate_fallback;
+	u8	tx_use_drv_assinged_rate;
 	u8	bTxEnableFwCalcDur;
 	atomic_t	atm_swbw;
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 1253de481805..604d4fd7e2cd 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -220,8 +220,8 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 
 	tcb_desc->data_rate = MgntQuery_MgntFrameTxRate(ieee);
 	tcb_desc->RATRIndex = 7;
-	tcb_desc->bTxDisableRateFallBack = 1;
-	tcb_desc->bTxUseDriverAssingedRate = 1;
+	tcb_desc->tx_dis_rate_fallback = 1;
+	tcb_desc->tx_use_drv_assinged_rate = 1;
 	if (single) {
 		if (ieee->queue_stop) {
 			enqueue_mgmt(ieee, skb);
@@ -298,8 +298,8 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 
 	tcb_desc->data_rate = MgntQuery_MgntFrameTxRate(ieee);
 	tcb_desc->RATRIndex = 7;
-	tcb_desc->bTxDisableRateFallBack = 1;
-	tcb_desc->bTxUseDriverAssingedRate = 1;
+	tcb_desc->tx_dis_rate_fallback = 1;
+	tcb_desc->tx_use_drv_assinged_rate = 1;
 	if (single) {
 		if (type != RTLLIB_FTYPE_CTL) {
 			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
@@ -1996,12 +1996,12 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 
 			if (pPSC->LPSAwakeIntvl == 0)
 				pPSC->LPSAwakeIntvl = 1;
-			if (pPSC->RegMaxLPSAwakeIntvl == 0)
+			if (pPSC->reg_max_lps_awake_intvl == 0)
 				MaxPeriod = 1;
-			else if (pPSC->RegMaxLPSAwakeIntvl == 0xFF)
+			else if (pPSC->reg_max_lps_awake_intvl == 0xFF)
 				MaxPeriod = ieee->current_network.dtim_period;
 			else
-				MaxPeriod = pPSC->RegMaxLPSAwakeIntvl;
+				MaxPeriod = pPSC->reg_max_lps_awake_intvl;
 			pPSC->LPSAwakeIntvl = (pPSC->LPSAwakeIntvl >=
 					       MaxPeriod) ? MaxPeriod :
 					       (pPSC->LPSAwakeIntvl + 1);
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 101f44129145..be3779efcd23 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -477,13 +477,13 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 static void rtllib_txrate_selectmode(struct rtllib_device *ieee,
 				     struct cb_desc *tcb_desc)
 {
-	if (ieee->bTxDisableRateFallBack)
-		tcb_desc->bTxDisableRateFallBack = true;
+	if (ieee->tx_dis_rate_fallback)
+		tcb_desc->tx_dis_rate_fallback = true;
 
-	if (ieee->bTxUseDriverAssingedRate)
-		tcb_desc->bTxUseDriverAssingedRate = true;
-	if (!tcb_desc->bTxDisableRateFallBack ||
-	    !tcb_desc->bTxUseDriverAssingedRate) {
+	if (ieee->tx_use_drv_assinged_rate)
+		tcb_desc->tx_use_drv_assinged_rate = true;
+	if (!tcb_desc->tx_dis_rate_fallback ||
+	    !tcb_desc->tx_use_drv_assinged_rate) {
 		if (ieee->iw_mode == IW_MODE_INFRA ||
 		    ieee->iw_mode == IW_MODE_ADHOC)
 			tcb_desc->RATRIndex = 0;
@@ -886,14 +886,14 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			    HT_IOT_ACT_WA_IOT_Broadcom) {
 				tcb_desc->data_rate =
 					 MgntQuery_TxRateExcludeCCKRates(ieee);
-				tcb_desc->bTxDisableRateFallBack = false;
+				tcb_desc->tx_dis_rate_fallback = false;
 			} else {
 				tcb_desc->data_rate = ieee->basic_rate;
-				tcb_desc->bTxDisableRateFallBack = 1;
+				tcb_desc->tx_dis_rate_fallback = 1;
 			}
 
 			tcb_desc->RATRIndex = 7;
-			tcb_desc->bTxUseDriverAssingedRate = 1;
+			tcb_desc->tx_use_drv_assinged_rate = 1;
 		} else {
 			if (is_multicast_ether_addr(header.addr1))
 				tcb_desc->bMulticast = 1;
@@ -910,14 +910,14 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				    HT_IOT_ACT_WA_IOT_Broadcom) {
 					tcb_desc->data_rate =
 					   MgntQuery_TxRateExcludeCCKRates(ieee);
-					tcb_desc->bTxDisableRateFallBack = false;
+					tcb_desc->tx_dis_rate_fallback = false;
 				} else {
 					tcb_desc->data_rate = MGN_1M;
-					tcb_desc->bTxDisableRateFallBack = 1;
+					tcb_desc->tx_dis_rate_fallback = 1;
 				}
 
 				tcb_desc->RATRIndex = 7;
-				tcb_desc->bTxUseDriverAssingedRate = 1;
+				tcb_desc->tx_use_drv_assinged_rate = 1;
 				tcb_desc->bdhcp = 1;
 			}
 
-- 
2.37.3

