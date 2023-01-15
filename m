Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3750466B3C9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjAOUUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjAOUUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:20:01 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AEC12F26
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:19:59 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id v6so20692335ejg.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDFl1W46f2cV4qdUFqvY9KWQZn/TRnQQe1hsN+H8lHs=;
        b=PvIZbY87D0mRbiY8FzjH2sdm7HLeqz/4AAtnXWEKMm5/rH1DJARloa+W4o6HCvV1l5
         hOrsa/oVmR9OLrPbQ46rl7QdsX0+kocsKV8fsc3NaE92WAK1JL7MUPpcOilXkcD47kGP
         k9aQhxWORMGkdG15+ZpvAPWjIRvZWXvkEcIOVmFBCXJqP56nkuoFQpNADN6yROWuhWhr
         /0NRMdbtE6C/uNwdwv1eF4t+E8LU2KtwzOJOCk8mc56jv7okEZfamEtPelWuvzpN34Ot
         Tvfj5LWDh7yX36OemeH36IZLQ3cqohUbMUE6a3EGZK8JhEsEz9pQNfW3MIaJBZC5beAl
         XbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDFl1W46f2cV4qdUFqvY9KWQZn/TRnQQe1hsN+H8lHs=;
        b=lwEBGUDP81RsEie3C7M+Y9E0Hk6Bi80HZQY4iJUZ8692lhW06HhK5dytg9B8ZDaedy
         /ERJ68L5lWZweD1HksfXyBeXJH3LieobjT2uYdTXYwHf8mySNsqL/q78JiRfRt2EivTe
         N6sKnyhbp6sJ+KFJUPLzbgsSo1Dlss/jbqVzyCNzSxLZJMIPJq3XzYtOLTz8NQ10uSNd
         59SrxTAq0e4BDQzRaUgaCVtlHS6Ziv9mmIjbSzalrBHuxybGnqH1Nr/IXFAqnDf0puDa
         4GNZRNreIvtjHoHyDO7cc9vp5t4iRNpYdjr+mK2ihySJoyf6QEsrVd0raD70rfSwfOXR
         1SPQ==
X-Gm-Message-State: AFqh2krgBN6OhfBvO57A6rwvocC402G/J2QcjU/CYrXk2OPZvMcR+z3D
        RHUusdSC5NbsZs+l9V2mFIE=
X-Google-Smtp-Source: AMrXdXtwWQ9b5zCpE72Vt2XCzEgNHaBj1qa3P1wAJsF0HxLzpE/W4LarYDTuAqoIQZy9fht5rdzvQw==
X-Received: by 2002:a17:906:2857:b0:7c0:a4b5:babf with SMTP id s23-20020a170906285700b007c0a4b5babfmr16745747ejc.3.1673813998434;
        Sun, 15 Jan 2023 12:19:58 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906970200b0073dbaeb50f6sm10863061ejx.169.2023.01.15.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 12:19:57 -0800 (PST)
Date:   Sun, 15 Jan 2023 21:19:56 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Rename bLastDTPFlag_Low, OFDM_index
 and CCK_index
Message-ID: <1058b8be954b634f5c2cd9d4a46c33dbbe9459c5.1673812849.git.philipp.g.hortmann@gmail.com>
References: <cover.1673812849.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673812849.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable bLastDTPFlag_Low to last_dtp_flag_low, OFDM_index to
ofdm_index and CCK_index to cck_index to avoid CamelCase which is not
accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  6 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 52 +++++++++----------
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 2e9932a26382..7ba60d93b9b3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1074,11 +1074,11 @@ static void _rtl92e_cck_tx_power_track_bw_switch_thermal(struct net_device *dev)
 	case HT_CHANNEL_WIDTH_20:
 		if (priv->Record_CCK_20Mindex == 0)
 			priv->Record_CCK_20Mindex = 6;
-		priv->CCK_index = priv->Record_CCK_20Mindex;
+		priv->cck_index = priv->Record_CCK_20Mindex;
 	break;
 
 	case HT_CHANNEL_WIDTH_20_40:
-		priv->CCK_index = priv->Record_CCK_40Mindex;
+		priv->cck_index = priv->Record_CCK_40Mindex;
 	break;
 	}
 	rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 1f8bfe83b8ef..fea5f547b7be 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -483,7 +483,7 @@ struct r8192_priv {
 	bool		dynamic_tx_high_pwr;
 	bool		dynamic_tx_low_pwr;
 	bool		last_dtp_flag_high;
-	bool		bLastDTPFlag_Low;
+	bool		last_dtp_flag_low;
 
 	u8		rfa_txpowertrackingindex;
 	u8		rfa_txpowertrackingindex_real;
@@ -496,8 +496,8 @@ struct r8192_priv {
 	u8		txpower_count;
 	bool		btxpower_trackingInit;
 
-	u8		OFDM_index[2];
-	u8		CCK_index;
+	u8		ofdm_index[2];
+	u8		cck_index;
 
 	u8		Record_CCK_20Mindex;
 	u8		Record_CCK_40Mindex;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 09ea3a6f373c..f03b479a9143 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -775,13 +775,13 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 					    bMaskDWord);
 		for (i = 0; i < OFDM_Table_Length; i++) {
 			if (tmpRegA == OFDMSwingTable[i])
-				priv->OFDM_index[0] = i;
+				priv->ofdm_index[0] = i;
 		}
 
 		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
 		for (i = 0; i < CCK_Table_length; i++) {
 			if (TempCCk == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
-				priv->CCK_index = i;
+				priv->cck_index = i;
 				break;
 			}
 		}
@@ -836,17 +836,17 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		CCKSwingNeedUpdate = 1;
 	}
 
-	if (priv->CCK_index != tmpCCKindex) {
-		priv->CCK_index = tmpCCKindex;
+	if (priv->cck_index != tmpCCKindex) {
+		priv->cck_index = tmpCCKindex;
 		CCKSwingNeedUpdate = 1;
 	}
 
 	if (CCKSwingNeedUpdate)
 		rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
-	if (priv->OFDM_index[0] != tmpOFDMindex) {
-		priv->OFDM_index[0] = tmpOFDMindex;
+	if (priv->ofdm_index[0] != tmpOFDMindex) {
+		priv->ofdm_index[0] = tmpOFDMindex;
 		rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance, bMaskDWord,
-				  OFDMSwingTable[priv->OFDM_index[0]]);
+				  OFDMSwingTable[priv->ofdm_index[0]]);
 	}
 	priv->txpower_count = 0;
 }
@@ -1005,30 +1005,30 @@ static void _rtl92e_dm_cck_tx_power_adjust_thermal_meter(struct net_device *dev,
 
 	TempVal = 0;
 	if (!bInCH14) {
-		TempVal = CCKSwingTable_Ch1_Ch13[priv->CCK_index][0] +
-			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][1] << 8);
+		TempVal = CCKSwingTable_Ch1_Ch13[priv->cck_index][0] +
+			  (CCKSwingTable_Ch1_Ch13[priv->cck_index][1] << 8);
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter1, bMaskHWord, TempVal);
-		TempVal = CCKSwingTable_Ch1_Ch13[priv->CCK_index][2] +
-			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][3] << 8) +
-			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][4] << 16)+
-			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][5] << 24);
+		TempVal = CCKSwingTable_Ch1_Ch13[priv->cck_index][2] +
+			  (CCKSwingTable_Ch1_Ch13[priv->cck_index][3] << 8) +
+			  (CCKSwingTable_Ch1_Ch13[priv->cck_index][4] << 16)+
+			  (CCKSwingTable_Ch1_Ch13[priv->cck_index][5] << 24);
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter2, bMaskDWord, TempVal);
-		TempVal = CCKSwingTable_Ch1_Ch13[priv->CCK_index][6] +
-			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][7] << 8);
+		TempVal = CCKSwingTable_Ch1_Ch13[priv->cck_index][6] +
+			  (CCKSwingTable_Ch1_Ch13[priv->cck_index][7] << 8);
 
 		rtl92e_set_bb_reg(dev, rCCK0_DebugPort, bMaskLWord, TempVal);
 	} else {
-		TempVal = CCKSwingTable_Ch14[priv->CCK_index][0] +
-			  (CCKSwingTable_Ch14[priv->CCK_index][1] << 8);
+		TempVal = CCKSwingTable_Ch14[priv->cck_index][0] +
+			  (CCKSwingTable_Ch14[priv->cck_index][1] << 8);
 
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter1, bMaskHWord, TempVal);
-		TempVal = CCKSwingTable_Ch14[priv->CCK_index][2] +
-			  (CCKSwingTable_Ch14[priv->CCK_index][3] << 8) +
-			  (CCKSwingTable_Ch14[priv->CCK_index][4] << 16)+
-			  (CCKSwingTable_Ch14[priv->CCK_index][5] << 24);
+		TempVal = CCKSwingTable_Ch14[priv->cck_index][2] +
+			  (CCKSwingTable_Ch14[priv->cck_index][3] << 8) +
+			  (CCKSwingTable_Ch14[priv->cck_index][4] << 16)+
+			  (CCKSwingTable_Ch14[priv->cck_index][5] << 24);
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter2, bMaskDWord, TempVal);
-		TempVal = CCKSwingTable_Ch14[priv->CCK_index][6] +
-			  (CCKSwingTable_Ch14[priv->CCK_index][7]<<8);
+		TempVal = CCKSwingTable_Ch14[priv->cck_index][6] +
+			  (CCKSwingTable_Ch14[priv->cck_index][7]<<8);
 
 		rtl92e_set_bb_reg(dev, rCCK0_DebugPort, bMaskLWord, TempVal);
 	}
@@ -2272,7 +2272,7 @@ static void _rtl92e_dm_init_dynamic_tx_power(struct net_device *dev)
 
 	priv->rtllib->bdynamic_txpower_enable = true;
 	priv->last_dtp_flag_high = false;
-	priv->bLastDTPFlag_Low = false;
+	priv->last_dtp_flag_low = false;
 	priv->dynamic_tx_high_pwr = false;
 	priv->dynamic_tx_low_pwr = false;
 }
@@ -2316,11 +2316,11 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 	}
 
 	if ((priv->dynamic_tx_high_pwr != priv->last_dtp_flag_high) ||
-	    (priv->dynamic_tx_low_pwr != priv->bLastDTPFlag_Low)) {
+	    (priv->dynamic_tx_low_pwr != priv->last_dtp_flag_low)) {
 		rtl92e_set_tx_power(dev, priv->rtllib->current_network.channel);
 	}
 	priv->last_dtp_flag_high = priv->dynamic_tx_high_pwr;
-	priv->bLastDTPFlag_Low = priv->dynamic_tx_low_pwr;
+	priv->last_dtp_flag_low = priv->dynamic_tx_low_pwr;
 
 }
 
-- 
2.39.0

