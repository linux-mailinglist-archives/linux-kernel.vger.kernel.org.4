Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638AE5E9041
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiIXWEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiIXWEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:04:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E535532EF8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:04:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a41so4477791edf.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=iq1GBh/tdBvUDeAvwq2njyOnzoIpEC5Or1BTX3YZ5xM=;
        b=ZnPUoz8cMb+CdT44ri7FiPTk2b0i3XC9MvixBdVdrZUJW6nzg856ZKfDDCuqLitXUN
         aT6cA3BP56/DR+VupfOFwOqVwkCDBIS6Yh7KP9FrBy3ijTEme+nx0XWA5xDWyG80eZcl
         zbwbj8cVrMalXDF3i7KaXpoaveb2zwMEiQdr5JjWIOh7mQ1jLy2f6A+vSoLjMUvEDSEY
         BLG5qpJxrr+Ng1E5ty/X7N2M3ripO2pwzW/WFadZZDOfALSUApKszY7B4UwmirOy2C4q
         sSQmJi39PoUp05J23uUO3Frssy5AEP1lTQ+IASo3ShSrtuXwFaxV0+BCe3G8mxiwbYyZ
         4Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iq1GBh/tdBvUDeAvwq2njyOnzoIpEC5Or1BTX3YZ5xM=;
        b=TQF3/evPRWNg+U+Sp9Bn2NyhRdpL+pHLXJGFPcRSfJHwrNKfE33ArWiLtmWj4RG8y2
         s9LLvbdTx5QbXNFWspRN3hZbvVj/mw267zETCTINP6fjjc/Qb8ytXlNBgl467M902Wfr
         rzJ2HYCGzPRQhV1Mj9J3vWsqIQK4Sc9MgrwtbvzfFKW0fkdFzBK7d5OZWx/YzarJ9/CU
         U832zte1W+pq+9/A7F/0cTEm34Kjx8aGjo9qyDllElbhrnK/g3hxgI85+tj5TIdYxH7w
         Pdv+RHhmsfOcWDudTIHlzUbygn847d45fPURkT6cX2cf1eXWNxc94ygOHsKTqYsMN5XX
         Hs3g==
X-Gm-Message-State: ACrzQf0wRD+MyoVTjch1IiT25FkxL6414imj8ilofFbzGLCpmXFfDuGh
        7ws+0jsbx60s18zjaskzFAtDafd5Leo=
X-Google-Smtp-Source: AMsMyM5GDECHBtU/iAOMe4+jRClRIBhwPQce489aTFHYmSxGZ90if7eeBSt/IEvCwE29Ghy1sGKXOg==
X-Received: by 2002:a05:6402:d47:b0:454:e621:3b3f with SMTP id ec7-20020a0564020d4700b00454e6213b3fmr15075254edb.5.1664057039362;
        Sat, 24 Sep 2022 15:03:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7dd54000000b0044e1b4bca41sm3844324edw.79.2022.09.24.15.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 15:03:58 -0700 (PDT)
Date:   Sun, 25 Sep 2022 00:03:56 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Rename PeerMimoPs, IOTAction and
 IOTRaFunc
Message-ID: <2a8ce7bff9a00fe44c057242cedb27ca91219137.1664055213.git.philipp.g.hortmann@gmail.com>
References: <cover.1664055213.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664055213.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable PeerMimoPs to peer_mimo_ps, IOTAction to iot_action and
IOTRaFunc to iot_ra_func to avoid CamelCase which is not accepted by
checkpatch. Added spaces around '&' as proposed by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 12 ++---
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |  4 +-
 drivers/staging/rtl8192e/rtl819x_HT.h         |  6 +--
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 48 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 12 ++---
 drivers/staging/rtl8192e/rtllib_tx.c          | 10 ++--
 8 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 7391d7cb7a58..18e4e5d84878 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1985,7 +1985,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 		break;
 	case IEEE_N_24G:
 	case IEEE_N_5G:
-		if (ieee->pHTInfo->PeerMimoPs == 0) {
+		if (ieee->pHTInfo->peer_mimo_ps == 0) {
 			ratr_value &= 0x0007F007;
 		} else {
 			if (priv->rf_type == RF_1T2R)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 4226bbaaca44..41faeb4b9b9b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -42,7 +42,7 @@ void rtl92e_enable_hw_security_config(struct net_device *dev)
 
 
 	ieee->hwsec_active = 1;
-	if ((ieee->pHTInfo->IOTAction&HT_IOT_ACT_PURE_N_MODE) || !hwwep) {
+	if ((ieee->pHTInfo->iot_action & HT_IOT_ACT_PURE_N_MODE) || !hwwep) {
 		ieee->hwsec_active = 0;
 		SECR_value &= ~SCR_RxDecEnable;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 2394faba3940..3e46ac02c10e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1548,13 +1548,13 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 		goto dm_CheckEdcaTurbo_EXIT;
 	if (priv->rtllib->state != RTLLIB_LINKED)
 		goto dm_CheckEdcaTurbo_EXIT;
-	if (priv->rtllib->pHTInfo->IOTAction & HT_IOT_ACT_DISABLE_EDCA_TURBO)
+	if (priv->rtllib->pHTInfo->iot_action & HT_IOT_ACT_DISABLE_EDCA_TURBO)
 		goto dm_CheckEdcaTurbo_EXIT;
 
 	if (!priv->rtllib->bis_any_nonbepkts) {
 		curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
-		if (pHTInfo->IOTAction & HT_IOT_ACT_EDCA_BIAS_ON_RX) {
+		if (pHTInfo->iot_action & HT_IOT_ACT_EDCA_BIAS_ON_RX) {
 			if (curTxOkCnt > 4*curRxOkCnt) {
 				if (priv->bis_cur_rdlstate ||
 				    !priv->bcurrent_turbo_EDCA) {
@@ -1633,16 +1633,16 @@ static void _rtl92e_dm_cts_to_self(struct net_device *dev)
 	unsigned long curRxOkCnt = 0;
 
 	if (!priv->rtllib->bCTSToSelfEnable) {
-		pHTInfo->IOTAction &= ~HT_IOT_ACT_FORCED_CTS2SELF;
+		pHTInfo->iot_action &= ~HT_IOT_ACT_FORCED_CTS2SELF;
 		return;
 	}
 	if (pHTInfo->IOTPeer == HT_IOT_PEER_BROADCOM) {
 		curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 		if (curRxOkCnt > 4*curTxOkCnt)
-			pHTInfo->IOTAction &= ~HT_IOT_ACT_FORCED_CTS2SELF;
+			pHTInfo->iot_action &= ~HT_IOT_ACT_FORCED_CTS2SELF;
 		else
-			pHTInfo->IOTAction |= HT_IOT_ACT_FORCED_CTS2SELF;
+			pHTInfo->iot_action |= HT_IOT_ACT_FORCED_CTS2SELF;
 
 		lastTxOkCnt = priv->stats.txbytesunicast;
 		lastRxOkCnt = priv->stats.rxbytesunicast;
@@ -1997,7 +1997,7 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
 
 	if (priv->rtllib->state == RTLLIB_LINKED &&
 	    priv->rtllib->bfsync_enable &&
-	    (priv->rtllib->pHTInfo->IOTAction & HT_IOT_ACT_CDD_FSYNC)) {
+	    (priv->rtllib->pHTInfo->iot_action & HT_IOT_ACT_CDD_FSYNC)) {
 		u32 rate_bitmap;
 
 		for (rate_index = 0; rate_index <= 27; rate_index++) {
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 4c907fb16253..19d13b3fcecf 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -246,7 +246,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	if (!ieee->current_network.qos_data.active ||
 	    !ieee->pHTInfo->bCurrentHTSupport ||
-	    (ieee->pHTInfo->IOTAction & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
+	    (ieee->pHTInfo->iot_action & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev,
 			    "Failed to reply on ADDBA_REQ as some capability is not ready(%d, %d)\n",
@@ -278,7 +278,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBA->ba_start_seq_ctrl = *pBaStartSeqCtrl;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
-	   (ieee->pHTInfo->IOTAction & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
+	   (ieee->pHTInfo->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
 		pBA->ba_param_set.field.buffer_size = 1;
 	else
 		pBA->ba_param_set.field.buffer_size = 32;
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 7380df65959b..f656869523fa 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -145,7 +145,7 @@ struct rt_hi_throughput {
 	u8				CurrentOpMode;
 
 	u8				SelfMimoPs;
-	u8				PeerMimoPs;
+	u8 peer_mimo_ps;
 
 	enum ht_extchnl_offset CurSTAExtChnlOffset;
 	u8 cur_tx_bw40mhz;
@@ -169,8 +169,8 @@ struct rt_hi_throughput {
 	u8				bIsPeerBcm;
 
 	u8				IOTPeer;
-	u32				IOTAction;
-	u8				IOTRaFunc;
+	u32 iot_action;
+	u8 iot_ra_func;
 
 	u8	bWAIotBroadcom;
 	u8	WAIotTH;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index a7ccdee57a1b..0f275b6333b2 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -254,20 +254,20 @@ static void HTIOTActDetermineRaFunc(struct rtllib_device *ieee, bool bPeerRx2ss)
 {
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
 
-	pHTInfo->IOTRaFunc &= HT_IOT_RAFUNC_DISABLE_ALL;
+	pHTInfo->iot_ra_func &= HT_IOT_RAFUNC_DISABLE_ALL;
 
 	if (pHTInfo->IOTPeer == HT_IOT_PEER_RALINK && !bPeerRx2ss)
-		pHTInfo->IOTRaFunc |= HT_IOT_RAFUNC_PEER_1R;
+		pHTInfo->iot_ra_func |= HT_IOT_RAFUNC_PEER_1R;
 
-	if (pHTInfo->IOTAction & HT_IOT_ACT_AMSDU_ENABLE)
-		pHTInfo->IOTRaFunc |= HT_IOT_RAFUNC_TX_AMSDU;
+	if (pHTInfo->iot_action & HT_IOT_ACT_AMSDU_ENABLE)
+		pHTInfo->iot_ra_func |= HT_IOT_RAFUNC_TX_AMSDU;
 }
 
 void HTResetIOTSetting(struct rt_hi_throughput *pHTInfo)
 {
-	pHTInfo->IOTAction = 0;
+	pHTInfo->iot_action = 0;
 	pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
-	pHTInfo->IOTRaFunc = 0;
+	pHTInfo->iot_ra_func = 0;
 }
 
 void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
@@ -332,16 +332,16 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	pCapELE->ASCap = 0;
 
 	if (bAssoc) {
-		if (pHT->IOTAction & HT_IOT_ACT_DISABLE_MCS15)
+		if (pHT->iot_action & HT_IOT_ACT_DISABLE_MCS15)
 			pCapELE->MCS[1] &= 0x7f;
 
-		if (pHT->IOTAction & HT_IOT_ACT_DISABLE_MCS14)
+		if (pHT->iot_action & HT_IOT_ACT_DISABLE_MCS14)
 			pCapELE->MCS[1] &= 0xbf;
 
-		if (pHT->IOTAction & HT_IOT_ACT_DISABLE_ALL_2SS)
+		if (pHT->iot_action & HT_IOT_ACT_DISABLE_ALL_2SS)
 			pCapELE->MCS[1] &= 0x00;
 
-		if (pHT->IOTAction & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
+		if (pHT->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
 			pCapELE->ShortGI40Mhz		= 0;
 
 		if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
@@ -600,7 +600,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 		pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	else
 		pHTInfo->CurrentMPDUDensity = pPeerHTCap->MPDUDensity;
-	if (pHTInfo->IOTAction & HT_IOT_ACT_TX_USE_AMSDU_8K) {
+	if (pHTInfo->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
 		pHTInfo->bCurrentAMPDUEnable = false;
 		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
 		pHTInfo->ForcedAMSDUMaxSize = 7935;
@@ -614,8 +614,8 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 
 	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11HTOperationalRateSet);
 
-	pHTInfo->PeerMimoPs = pPeerHTCap->MimoPwrSave;
-	if (pHTInfo->PeerMimoPs == MIMO_PS_STATIC)
+	pHTInfo->peer_mimo_ps = pPeerHTCap->MimoPwrSave;
+	if (pHTInfo->peer_mimo_ps == MIMO_PS_STATIC)
 		pMcsFilter = MCS_FILTER_1SS;
 	else
 		pMcsFilter = MCS_FILTER_ALL;
@@ -664,8 +664,8 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 
 	pHTInfo->IOTPeer = 0;
-	pHTInfo->IOTAction = 0;
-	pHTInfo->IOTRaFunc = 0;
+	pHTInfo->iot_action = 0;
+	pHTInfo->iot_ra_func = 0;
 
 	{
 		u8 *RegHTSuppRateSets = &(ieee->RegHTSuppRateSet[0]);
@@ -731,37 +731,37 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 
 		HTIOTPeerDetermine(ieee);
 
-		pHTInfo->IOTAction = 0;
+		pHTInfo->iot_action = 0;
 		bIOTAction = HTIOTActIsDisableMCS14(ieee, pNetwork->bssid);
 		if (bIOTAction)
-			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_MCS14;
+			pHTInfo->iot_action |= HT_IOT_ACT_DISABLE_MCS14;
 
 		bIOTAction = HTIOTActIsDisableMCS15(ieee);
 		if (bIOTAction)
-			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_MCS15;
+			pHTInfo->iot_action |= HT_IOT_ACT_DISABLE_MCS15;
 
 		bIOTAction = HTIOTActIsDisableMCSTwoSpatialStream(ieee);
 		if (bIOTAction)
-			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_ALL_2SS;
+			pHTInfo->iot_action |= HT_IOT_ACT_DISABLE_ALL_2SS;
 
 		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
 		if (bIOTAction)
-			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
+			pHTInfo->iot_action |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
 
 		bIOTAction = HTIOTActIsMgntUseCCK6M(ieee, pNetwork);
 		if (bIOTAction)
-			pHTInfo->IOTAction |= HT_IOT_ACT_MGNT_USE_CCK_6M;
+			pHTInfo->iot_action |= HT_IOT_ACT_MGNT_USE_CCK_6M;
 		bIOTAction = HTIOTActIsCCDFsync(ieee);
 		if (bIOTAction)
-			pHTInfo->IOTAction |= HT_IOT_ACT_CDD_FSYNC;
+			pHTInfo->iot_action |= HT_IOT_ACT_CDD_FSYNC;
 	} else {
 		pHTInfo->bCurrentHTSupport = false;
 		pHTInfo->current_rt2rt_aggregation = false;
 		pHTInfo->current_rt2rt_long_slot_time = false;
 		pHTInfo->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 
-		pHTInfo->IOTAction = 0;
-		pHTInfo->IOTRaFunc = 0;
+		pHTInfo->iot_action = 0;
+		pHTInfo->iot_ra_func = 0;
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 4708aa9752ed..1a3ca3e57623 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -180,7 +180,7 @@ static u8 MgntQuery_MgntFrameTxRate(struct rtllib_device *ieee)
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
 	u8 rate;
 
-	if (pHTInfo->IOTAction & HT_IOT_ACT_MGNT_USE_CCK_6M)
+	if (pHTInfo->iot_action & HT_IOT_ACT_MGNT_USE_CCK_6M)
 		rate = 0x0c;
 	else
 		rate = ieee->basic_rate & 0x7f;
@@ -1894,7 +1894,7 @@ static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	   ((ieee->mode == IEEE_G) &&
 	   (ieee->current_network.mode == IEEE_N_24G) &&
 	   (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT-1)))) {
-		ieee->pHTInfo->IOTAction |= HT_IOT_ACT_PURE_N_MODE;
+		ieee->pHTInfo->iot_action |= HT_IOT_ACT_PURE_N_MODE;
 	} else {
 		ieee->AsocRetryCount = 0;
 	}
@@ -2101,7 +2101,7 @@ static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl)
 {
 	if (ieee->sta_sleep == LPS_IS_WAKE) {
 		if (nl) {
-			if (ieee->pHTInfo->IOTAction &
+			if (ieee->pHTInfo->iot_action &
 			    HT_IOT_ACT_NULL_DATA_POWER_SAVING) {
 				ieee->ack_tx_to_ieee = 1;
 				rtllib_sta_ps_send_null_frame(ieee, 0);
@@ -2117,7 +2117,7 @@ static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl)
 	if (ieee->sta_sleep == LPS_IS_SLEEP)
 		ieee->sta_wake_up(ieee->dev);
 	if (nl) {
-		if (ieee->pHTInfo->IOTAction &
+		if (ieee->pHTInfo->iot_action &
 		    HT_IOT_ACT_NULL_DATA_POWER_SAVING) {
 			ieee->ack_tx_to_ieee = 1;
 			rtllib_sta_ps_send_null_frame(ieee, 0);
@@ -2152,7 +2152,7 @@ void rtllib_ps_tx_ack(struct rtllib_device *ieee, short success)
 
 		if ((ieee->sta_sleep == LPS_IS_WAKE) && !success) {
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
-			if (ieee->pHTInfo->IOTAction &
+			if (ieee->pHTInfo->iot_action &
 			    HT_IOT_ACT_NULL_DATA_POWER_SAVING)
 				rtllib_sta_ps_send_null_frame(ieee, 0);
 			else
@@ -2296,7 +2296,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 	if (ieee->open_wep || !challenge) {
 		ieee->state = RTLLIB_ASSOCIATING_AUTHENTICATED;
 		ieee->softmac_stats.rx_auth_rs_ok++;
-		if (!(ieee->pHTInfo->IOTAction & HT_IOT_ACT_PURE_N_MODE)) {
+		if (!(ieee->pHTInfo->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
 				if (IsHTHalfNmodeAPs(ieee)) {
 					bSupportNmode = true;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 595f9b92ac83..5aad9263bed1 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -284,7 +284,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	if (tcb_desc->bdhcp || ieee->CntAfterLink < 2)
 		return;
 
-	if (pHTInfo->IOTAction & HT_IOT_ACT_TX_NO_AGGREGATION)
+	if (pHTInfo->iot_action & HT_IOT_ACT_TX_NO_AGGREGATION)
 		return;
 
 	if (!ieee->GetNmodeSupportBySecCfg(ieee->dev))
@@ -422,12 +422,12 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	pHTInfo = ieee->pHTInfo;
 
 	while (true) {
-		if (pHTInfo->IOTAction & HT_IOT_ACT_FORCED_CTS2SELF) {
+		if (pHTInfo->iot_action & HT_IOT_ACT_FORCED_CTS2SELF) {
 			tcb_desc->bCTSEnable	= true;
 			tcb_desc->rts_rate  =	MGN_24M;
 			tcb_desc->bRTSEnable = true;
 			break;
-		} else if (pHTInfo->IOTAction & (HT_IOT_ACT_FORCED_RTS |
+		} else if (pHTInfo->iot_action & (HT_IOT_ACT_FORCED_RTS |
 			   HT_IOT_ACT_PURE_N_MODE)) {
 			tcb_desc->bRTSEnable = true;
 			tcb_desc->rts_rate  =	MGN_24M;
@@ -885,7 +885,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		tcb_desc->priority = skb->priority;
 
 		if (ether_type == ETH_P_PAE) {
-			if (ieee->pHTInfo->IOTAction &
+			if (ieee->pHTInfo->iot_action &
 			    HT_IOT_ACT_WA_IOT_Broadcom) {
 				tcb_desc->data_rate =
 					 MgntQuery_TxRateExcludeCCKRates(ieee);
@@ -910,7 +910,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				tcb_desc->data_rate = rtllib_current_rate(ieee);
 
 			if (bdhcp) {
-				if (ieee->pHTInfo->IOTAction &
+				if (ieee->pHTInfo->iot_action &
 				    HT_IOT_ACT_WA_IOT_Broadcom) {
 					tcb_desc->data_rate =
 					   MgntQuery_TxRateExcludeCCKRates(ieee);
-- 
2.37.3

