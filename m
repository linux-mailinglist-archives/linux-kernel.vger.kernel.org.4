Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733A95E903E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiIXWDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiIXWDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:03:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B853341B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:03:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id 13so7169754ejn.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=d8vVA7LCY08FZzjgVfkFGePEn4Ti/pmsWV+H+LOB/hs=;
        b=CUofn/74M6UBh0jXziN+l2pkrNyqT2HGhwRNgj15PqIu3+OPXTyth766Jn0pnAgWBx
         ts6DnrCvTXZy8dDM0mgdplyr6VpYgfdVeMYg1qRXZ+jt1M0LXOEQNAeb5QOZrUgLV0u0
         lSc7fZ+cXtmB+jeosdj7Hyvy1XYART5MBoM1BUIkh1va7hSjLZ1KdXYJhYKx7LYItjnp
         c3wjPBVfhW0htl+q2hx4ml62R2XtWpBVzUxA7H241fls0W2pq+xWtrc7Y0loam3N+86J
         WDpgjmafdCuBhvUH8iX9bsMt/FgNZQoLO7HlNtFrfmEDFjRoJRKbnko8uRBoOmlS1jt1
         D7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=d8vVA7LCY08FZzjgVfkFGePEn4Ti/pmsWV+H+LOB/hs=;
        b=sxh+c1P8UrSB0HZh0TaXFLxYUB7Y3DDNmZkx6EfXp8ILQxVKSvPOzsskX4lh3JWwcQ
         /IpbEqxPjYya/7T/H/P4XtE2jA7wnP5vETAmr4T8yVCA8NamtSutqmmkN4l2tLUO7FEb
         NDh47mMhbDxo8B5X/1Owiqzwlc38tuRhVQw+gGhZazWMhrrqrQ7Z4OJLIOb8Nc/eUlqE
         dMMEPg/tGPFx5C6F11nnkKUioQwpScOtOckuXcAVtQMjlDGHaDFGTDg9j12MZiYkYImi
         /D8K3IhFeM/vtANeoOoQacOEZCgWbryJEB0Ya4wCLNpe4hQSQCqvnAICrmmsBzd9q3Vb
         Cx1A==
X-Gm-Message-State: ACrzQf1CroI3sjHS+WK1ikHHK+MlrNW/bYofBE0KOolPoZSfU3dgPgw6
        oAOEnGWQmdoGuT/MhF24MbYxa712hZk=
X-Google-Smtp-Source: AMsMyM7W6gJVOcB9zELJw6hUtNm5npgCZacQ83cm8u/w/EMA4h8TJWlTD31JW73GaWDV4LvilWwp/g==
X-Received: by 2002:a17:907:b0e:b0:77a:d97d:9afc with SMTP id h14-20020a1709070b0e00b0077ad97d9afcmr12273390ejl.199.1664057014168;
        Sat, 24 Sep 2022 15:03:34 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id kv6-20020a17090778c600b0076f0ab594e9sm5952191ejc.73.2022.09.24.15.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 15:03:33 -0700 (PDT)
Date:   Sun, 25 Sep 2022 00:03:31 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Rename bSwBwInPro...,
 bRegRT2RTAg... and bCurrentRT...
Message-ID: <868f9db0e29bd170129f90bdbcc14238a750c440.1664055213.git.philipp.g.hortmann@gmail.com>
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

Rename variable bSwBwInProgress to sw_bw_in_progress, bRegRT2RTAggregation
to reg_rt2rt_aggregation and bCurrentRT2RTAggregation to
current_rt2rt_aggregation to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  6 +++---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 24 +++++++++++------------
 drivers/staging/rtl8192e/rtllib_softmac.c |  6 +++---
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 2ab04469ef4b..5399931786b8 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -151,12 +151,12 @@ struct rt_hi_throughput {
 	u8 cur_tx_bw40mhz;
 	u8				PeerBandwidth;
 
-	u8				bSwBwInProgress;
+	u8 sw_bw_in_progress;
 	u8				SwBwStep;
 
-	u8				bRegRT2RTAggregation;
+	u8 reg_rt2rt_aggregation;
 	u8				RT2RT_HT_Mode;
-	u8				bCurrentRT2RTAggregation;
+	u8 current_rt2rt_aggregation;
 	u8 current_rt2rt_long_slot_time;
 	u8				szRT2RTAggBuffer[10];
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 1e1364c56163..cde64b123ced 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -98,7 +98,7 @@ void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 
 	ieee->bTxEnableFwCalcDur = 1;
 
-	pHTInfo->bRegRT2RTAggregation = 1;
+	pHTInfo->reg_rt2rt_aggregation = 1;
 
 	pHTInfo->bRegRxReorderEnable = 1;
 	pHTInfo->RxReorderWinSize = 64;
@@ -574,7 +574,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 			pHTInfo->bCurrentAMPDUEnable = false;
 	}
 
-	if (!pHTInfo->bRegRT2RTAggregation) {
+	if (!pHTInfo->reg_rt2rt_aggregation) {
 		if (pHTInfo->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
 			pHTInfo->CurrentAMPDUFactor =
 						 pPeerHTCap->MaxRxAMPDUFactor;
@@ -655,11 +655,11 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0,
 		sizeof(pHTInfo->PeerHTInfoBuf));
 
-	pHTInfo->bSwBwInProgress = false;
+	pHTInfo->sw_bw_in_progress = false;
 
 	pHTInfo->ePeerHTSpecVer = HT_SPEC_VER_IEEE;
 
-	pHTInfo->bCurrentRT2RTAggregation = false;
+	pHTInfo->current_rt2rt_aggregation = false;
 	pHTInfo->current_rt2rt_long_slot_time = false;
 	pHTInfo->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 
@@ -717,14 +717,14 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 			       pNetwork->bssht.bd_ht_info_buf,
 			       pNetwork->bssht.bd_ht_info_len);
 
-		if (pHTInfo->bRegRT2RTAggregation) {
-			pHTInfo->bCurrentRT2RTAggregation =
+		if (pHTInfo->reg_rt2rt_aggregation) {
+			pHTInfo->current_rt2rt_aggregation =
 				 pNetwork->bssht.bd_rt2rt_aggregation;
 			pHTInfo->current_rt2rt_long_slot_time =
 				 pNetwork->bssht.bd_rt2rt_long_slot_time;
 			pHTInfo->RT2RT_HT_Mode = pNetwork->bssht.rt2rt_ht_mode;
 		} else {
-			pHTInfo->bCurrentRT2RTAggregation = false;
+			pHTInfo->current_rt2rt_aggregation = false;
 			pHTInfo->current_rt2rt_long_slot_time = false;
 			pHTInfo->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 		}
@@ -756,7 +756,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 			pHTInfo->IOTAction |= HT_IOT_ACT_CDD_FSYNC;
 	} else {
 		pHTInfo->bCurrentHTSupport = false;
-		pHTInfo->bCurrentRT2RTAggregation = false;
+		pHTInfo->current_rt2rt_aggregation = false;
 		pHTInfo->current_rt2rt_long_slot_time = false;
 		pHTInfo->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 
@@ -850,7 +850,7 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
 
-	pHTInfo->bSwBwInProgress = false;
+	pHTInfo->sw_bw_in_progress = false;
 }
 
 void HTSetConnectBwMode(struct rtllib_device *ieee,
@@ -865,8 +865,8 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		Bandwidth = HT_CHANNEL_WIDTH_20;
 
-	if (pHTInfo->bSwBwInProgress) {
-		pr_info("%s: bSwBwInProgress!!\n", __func__);
+	if (pHTInfo->sw_bw_in_progress) {
+		pr_info("%s: sw_bw_in_progress!!\n", __func__);
 		return;
 	}
 	if (Bandwidth == HT_CHANNEL_WIDTH_20_40) {
@@ -889,7 +889,7 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 	netdev_dbg(ieee->dev, "%s():pHTInfo->bCurBW40MHz:%x\n", __func__,
 		   pHTInfo->bCurBW40MHz);
 
-	pHTInfo->bSwBwInProgress = true;
+	pHTInfo->sw_bw_in_progress = true;
 
 	HTSetConnectBwModeCallback(ieee);
 }
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9a5dd031d3ff..9d38c35ecf9d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -865,7 +865,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 		HTConstructInfoElement(ieee, tmp_ht_info_buf, &tmp_ht_info_len,
 				       encrypt);
 
-		if (pHTInfo->bRegRT2RTAggregation) {
+		if (pHTInfo->reg_rt2rt_aggregation) {
 			tmp_generic_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
 			tmp_generic_ie_len =
 				 sizeof(ieee->pHTInfo->szRT2RTAggBuffer);
@@ -1189,7 +1189,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
 		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len,
 					     encrypt, true);
-		if (ieee->pHTInfo->bCurrentRT2RTAggregation) {
+		if (ieee->pHTInfo->current_rt2rt_aggregation) {
 			realtek_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
 			realtek_ie_len =
 				 sizeof(ieee->pHTInfo->szRT2RTAggBuffer);
@@ -1368,7 +1368,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 			tag += ht_cap_len - 2;
 		}
 
-		if (ieee->pHTInfo->bCurrentRT2RTAggregation) {
+		if (ieee->pHTInfo->current_rt2rt_aggregation) {
 			tag = skb_put(skb, realtek_ie_len);
 			*tag++ = MFIE_TYPE_GENERIC;
 			*tag++ = realtek_ie_len - 2;
-- 
2.37.3

