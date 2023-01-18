Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC836728DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjART7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjART7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:59:11 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D02F59B5F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso1930583wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YWGpjp9WhPu3wFT2RQ9cFpX+2v6QgNUzHNIXtdGMtQ=;
        b=Y2RrBrh25oozTn/2XGvvBF1ZCL2VWoYOZw3xdSWGIpR2O+mtAulQGLrDS2CjhpOgOP
         KtY5Lm61zvh3nNM195Z83247QpIobHQtZYcm23XBddNBr79hflBh4Ey5HuEkxSfkZ90m
         uYFDuZjj+yU71aeShj1XsolUTg7iP/9pe56XcK69AmSmhzqXyeusWnwO70C0Nx3I2Vqb
         rR129iwZsma/7SoOmDB6TyEcC9Eq6gR2wpYs8dQ9S/h2VyHUgGn0fl2nq3b9BcOgNTxa
         r602sbhqQSJAgGr6a+N/Rmdn3GPBIv7MjGlFNIgLFFFxZDUbLRauJ97RMTn/eZ0TdjAy
         bzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YWGpjp9WhPu3wFT2RQ9cFpX+2v6QgNUzHNIXtdGMtQ=;
        b=RiqS+mACTXw4A/rTw0Q12ERkWjXul22loeTpWejxgNWpnORCXUGFMZu+Z0pJQ4+fGV
         6B7gj9fBSxaboUIKVGKDXaB0WCM8C/wAzckCOOs6TSCCzBtFCBPrKQU+SCfVcYW3XWz8
         LhYtNq1N4Ss+PmFNIQ5sBYj6Pe97jvqS3gMktEyqXOm5hcdV52Ofq8eS311bAaUW+Wib
         NXy8KDIGtFxzMOr1Hwu3LZx5Gi+Ufhhr9PSRVWmFCWplEqVfQYHBggdSVuxEhhw9gAYH
         9+LXMrJRxI6YEX7cg/AOMdaNOEL1+1BrgRU/q9dqORP+/BPM12q9891q7w8uVgmHI3nt
         vq4g==
X-Gm-Message-State: AFqh2kpJM9X0jJwH3DlfUNhJX+XjxDZ/tGou+N7UII3aR+eZ2e38iELw
        fiTTVyAIfFqXOSnPg2Ys5ojGQC6kxVk=
X-Google-Smtp-Source: AMrXdXuXm2f3bbNcX8gBRF4Qi/Io7CrgM3Tq6MxmaKlJs7oQvEHVGbOw34cABrb9RPOhe4zzCTW45w==
X-Received: by 2002:a05:600c:1d13:b0:3da:fbd8:59bd with SMTP id l19-20020a05600c1d1300b003dafbd859bdmr2000328wms.4.1674071945751;
        Wed, 18 Jan 2023 11:59:05 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id a1-20020a5d4d41000000b002bdef155868sm12483366wru.106.2023.01.18.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:59:05 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:59:03 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] staging: rtl8192e: Rename PHYRegDef, CurrentChannelBW
 and CustomerID
Message-ID: <d609d1edfaa500a9512c2e3c950efc2e2a266a70.1674071236.git.philipp.g.hortmann@gmail.com>
References: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable PHYRegDef to phy_reg_def, CurrentChannelBW to
current_chnl_bw and CustomerID to customer_id to avoid CamelCase which is
not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |   4 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  28 +--
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 188 +++++++++---------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  36 ++--
 5 files changed, 131 insertions(+), 131 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 2c1a4392aeff..9ea281808128 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -70,7 +70,7 @@ bool rtl92e_config_rf(struct net_device *dev)
 		if (!rtl92e_is_legal_rf_path(dev, eRFPath))
 			continue;
 
-		pPhyReg = &priv->PHYRegDef[eRFPath];
+		pPhyReg = &priv->phy_reg_def[eRFPath];
 
 		switch (eRFPath) {
 		case RF90_PATH_A:
@@ -151,7 +151,7 @@ void rtl92e_set_cck_tx_power(struct net_device *dev, u8 powerlevel)
 
 	TxAGC = powerlevel;
 	if (priv->dynamic_tx_low_pwr) {
-		if (priv->CustomerID == RT_CID_819x_Netcore)
+		if (priv->customer_id == RT_CID_819x_Netcore)
 			TxAGC = 0x22;
 		else
 			TxAGC += priv->cck_pwr_enl;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index a0678c6bac72..fe985f4b8dbb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -478,36 +478,36 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->chnl_plan = priv->reg_chnl_plan;
 
 	if (priv->eeprom_vid == 0x1186 &&  priv->eeprom_did == 0x3304)
-		priv->CustomerID =  RT_CID_DLINK;
+		priv->customer_id =  RT_CID_DLINK;
 
 	switch (priv->eeprom_CustomerID) {
 	case EEPROM_CID_DEFAULT:
-		priv->CustomerID = RT_CID_DEFAULT;
+		priv->customer_id = RT_CID_DEFAULT;
 		break;
 	case EEPROM_CID_CAMEO:
-		priv->CustomerID = RT_CID_819x_CAMEO;
+		priv->customer_id = RT_CID_819x_CAMEO;
 		break;
 	case  EEPROM_CID_RUNTOP:
-		priv->CustomerID = RT_CID_819x_RUNTOP;
+		priv->customer_id = RT_CID_819x_RUNTOP;
 		break;
 	case EEPROM_CID_NetCore:
-		priv->CustomerID = RT_CID_819x_Netcore;
+		priv->customer_id = RT_CID_819x_Netcore;
 		break;
 	case EEPROM_CID_TOSHIBA:
-		priv->CustomerID = RT_CID_TOSHIBA;
+		priv->customer_id = RT_CID_TOSHIBA;
 		if (priv->eeprom_chnl_plan & 0x80)
 			priv->chnl_plan = priv->eeprom_chnl_plan & 0x7f;
 		else
 			priv->chnl_plan = 0x0;
 		break;
 	case EEPROM_CID_Nettronix:
-		priv->CustomerID = RT_CID_Nettronix;
+		priv->customer_id = RT_CID_Nettronix;
 		break;
 	case EEPROM_CID_Pronet:
-		priv->CustomerID = RT_CID_PRONET;
+		priv->customer_id = RT_CID_PRONET;
 		break;
 	case EEPROM_CID_DLINK:
-		priv->CustomerID = RT_CID_DLINK;
+		priv->customer_id = RT_CID_DLINK;
 		break;
 
 	case EEPROM_CID_WHQL:
@@ -1068,7 +1068,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	pTxFwInfo->RtsShort = (pTxFwInfo->RtsHT == 0) ?
 			  (cb_desc->bRTSUseShortPreamble ? 1 : 0) :
 			  (cb_desc->bRTSUseShortGI ? 1 : 0);
-	if (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20_40) {
+	if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20_40) {
 		if (cb_desc->bPacketBW) {
 			pTxFwInfo->TxBandwidth = 1;
 			pTxFwInfo->TxSubCarrier = 0;
@@ -2101,16 +2101,16 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	if (priv->undecorated_smoothed_pwdb >= (RateAdaptiveTH_High+5)) {
 		rx_chk_cnt = 0;
 	} else if ((priv->undecorated_smoothed_pwdb < (RateAdaptiveTH_High + 5))
-	  && (((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) &&
+	  && (((priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) &&
 	  (priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_40M))
-	  || ((priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20) &&
+	  || ((priv->current_chnl_bw == HT_CHANNEL_WIDTH_20) &&
 	  (priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_20M)))) {
 		if (rx_chk_cnt < 2)
 			return bStuck;
 		rx_chk_cnt = 0;
-	} else if ((((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) &&
+	} else if ((((priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) &&
 		  (priv->undecorated_smoothed_pwdb < RateAdaptiveTH_Low_40M)) ||
-		((priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20) &&
+		((priv->current_chnl_bw == HT_CHANNEL_WIDTH_20) &&
 		 (priv->undecorated_smoothed_pwdb < RateAdaptiveTH_Low_20M))) &&
 		priv->undecorated_smoothed_pwdb >= VeryLowRSSI) {
 		if (rx_chk_cnt < 4)
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 97e859425784..f7865d0c787a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -94,7 +94,7 @@ static u32 _rtl92e_phy_rf_read(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u32 ret = 0;
 	u32 NewOffset = 0;
-	struct bb_reg_definition *pPhyReg = &priv->PHYRegDef[eRFPath];
+	struct bb_reg_definition *pPhyReg = &priv->phy_reg_def[eRFPath];
 
 	Offset &= 0x3f;
 
@@ -149,7 +149,7 @@ static void _rtl92e_phy_rf_write(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u32 DataAndAddr = 0, NewOffset = 0;
-	struct bb_reg_definition *pPhyReg = &priv->PHYRegDef[eRFPath];
+	struct bb_reg_definition *pPhyReg = &priv->phy_reg_def[eRFPath];
 
 	Offset &= 0x3f;
 	if (priv->rf_chip == RF_8256) {
@@ -361,90 +361,90 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	priv->PHYRegDef[RF90_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW;
-	priv->PHYRegDef[RF90_PATH_B].rfintfs = rFPGA0_XAB_RFInterfaceSW;
-	priv->PHYRegDef[RF90_PATH_C].rfintfs = rFPGA0_XCD_RFInterfaceSW;
-	priv->PHYRegDef[RF90_PATH_D].rfintfs = rFPGA0_XCD_RFInterfaceSW;
-
-	priv->PHYRegDef[RF90_PATH_A].rfintfi = rFPGA0_XAB_RFInterfaceRB;
-	priv->PHYRegDef[RF90_PATH_B].rfintfi = rFPGA0_XAB_RFInterfaceRB;
-	priv->PHYRegDef[RF90_PATH_C].rfintfi = rFPGA0_XCD_RFInterfaceRB;
-	priv->PHYRegDef[RF90_PATH_D].rfintfi = rFPGA0_XCD_RFInterfaceRB;
-
-	priv->PHYRegDef[RF90_PATH_A].rfintfo = rFPGA0_XA_RFInterfaceOE;
-	priv->PHYRegDef[RF90_PATH_B].rfintfo = rFPGA0_XB_RFInterfaceOE;
-	priv->PHYRegDef[RF90_PATH_C].rfintfo = rFPGA0_XC_RFInterfaceOE;
-	priv->PHYRegDef[RF90_PATH_D].rfintfo = rFPGA0_XD_RFInterfaceOE;
-
-	priv->PHYRegDef[RF90_PATH_A].rfintfe = rFPGA0_XA_RFInterfaceOE;
-	priv->PHYRegDef[RF90_PATH_B].rfintfe = rFPGA0_XB_RFInterfaceOE;
-	priv->PHYRegDef[RF90_PATH_C].rfintfe = rFPGA0_XC_RFInterfaceOE;
-	priv->PHYRegDef[RF90_PATH_D].rfintfe = rFPGA0_XD_RFInterfaceOE;
-
-	priv->PHYRegDef[RF90_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter;
-	priv->PHYRegDef[RF90_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
-	priv->PHYRegDef[RF90_PATH_C].rf3wireOffset = rFPGA0_XC_LSSIParameter;
-	priv->PHYRegDef[RF90_PATH_D].rf3wireOffset = rFPGA0_XD_LSSIParameter;
-
-	priv->PHYRegDef[RF90_PATH_A].rfLSSI_Select = rFPGA0_XAB_RFParameter;
-	priv->PHYRegDef[RF90_PATH_B].rfLSSI_Select = rFPGA0_XAB_RFParameter;
-	priv->PHYRegDef[RF90_PATH_C].rfLSSI_Select = rFPGA0_XCD_RFParameter;
-	priv->PHYRegDef[RF90_PATH_D].rfLSSI_Select = rFPGA0_XCD_RFParameter;
-
-	priv->PHYRegDef[RF90_PATH_A].rfTxGainStage = rFPGA0_TxGainStage;
-	priv->PHYRegDef[RF90_PATH_B].rfTxGainStage = rFPGA0_TxGainStage;
-	priv->PHYRegDef[RF90_PATH_C].rfTxGainStage = rFPGA0_TxGainStage;
-	priv->PHYRegDef[RF90_PATH_D].rfTxGainStage = rFPGA0_TxGainStage;
-
-	priv->PHYRegDef[RF90_PATH_A].rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;
-	priv->PHYRegDef[RF90_PATH_B].rfHSSIPara1 = rFPGA0_XB_HSSIParameter1;
-	priv->PHYRegDef[RF90_PATH_C].rfHSSIPara1 = rFPGA0_XC_HSSIParameter1;
-	priv->PHYRegDef[RF90_PATH_D].rfHSSIPara1 = rFPGA0_XD_HSSIParameter1;
-
-	priv->PHYRegDef[RF90_PATH_A].rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;
-	priv->PHYRegDef[RF90_PATH_B].rfHSSIPara2 = rFPGA0_XB_HSSIParameter2;
-	priv->PHYRegDef[RF90_PATH_C].rfHSSIPara2 = rFPGA0_XC_HSSIParameter2;
-	priv->PHYRegDef[RF90_PATH_D].rfHSSIPara2 = rFPGA0_XD_HSSIParameter2;
-
-	priv->PHYRegDef[RF90_PATH_A].rfSwitchControl = rFPGA0_XAB_SwitchControl;
-	priv->PHYRegDef[RF90_PATH_B].rfSwitchControl = rFPGA0_XAB_SwitchControl;
-	priv->PHYRegDef[RF90_PATH_C].rfSwitchControl = rFPGA0_XCD_SwitchControl;
-	priv->PHYRegDef[RF90_PATH_D].rfSwitchControl = rFPGA0_XCD_SwitchControl;
-
-	priv->PHYRegDef[RF90_PATH_A].rfAGCControl1 = rOFDM0_XAAGCCore1;
-	priv->PHYRegDef[RF90_PATH_B].rfAGCControl1 = rOFDM0_XBAGCCore1;
-	priv->PHYRegDef[RF90_PATH_C].rfAGCControl1 = rOFDM0_XCAGCCore1;
-	priv->PHYRegDef[RF90_PATH_D].rfAGCControl1 = rOFDM0_XDAGCCore1;
-
-	priv->PHYRegDef[RF90_PATH_A].rfAGCControl2 = rOFDM0_XAAGCCore2;
-	priv->PHYRegDef[RF90_PATH_B].rfAGCControl2 = rOFDM0_XBAGCCore2;
-	priv->PHYRegDef[RF90_PATH_C].rfAGCControl2 = rOFDM0_XCAGCCore2;
-	priv->PHYRegDef[RF90_PATH_D].rfAGCControl2 = rOFDM0_XDAGCCore2;
-
-	priv->PHYRegDef[RF90_PATH_A].rfRxIQImbalance = rOFDM0_XARxIQImbalance;
-	priv->PHYRegDef[RF90_PATH_B].rfRxIQImbalance = rOFDM0_XBRxIQImbalance;
-	priv->PHYRegDef[RF90_PATH_C].rfRxIQImbalance = rOFDM0_XCRxIQImbalance;
-	priv->PHYRegDef[RF90_PATH_D].rfRxIQImbalance = rOFDM0_XDRxIQImbalance;
-
-	priv->PHYRegDef[RF90_PATH_A].rfRxAFE = rOFDM0_XARxAFE;
-	priv->PHYRegDef[RF90_PATH_B].rfRxAFE = rOFDM0_XBRxAFE;
-	priv->PHYRegDef[RF90_PATH_C].rfRxAFE = rOFDM0_XCRxAFE;
-	priv->PHYRegDef[RF90_PATH_D].rfRxAFE = rOFDM0_XDRxAFE;
-
-	priv->PHYRegDef[RF90_PATH_A].rfTxIQImbalance = rOFDM0_XATxIQImbalance;
-	priv->PHYRegDef[RF90_PATH_B].rfTxIQImbalance = rOFDM0_XBTxIQImbalance;
-	priv->PHYRegDef[RF90_PATH_C].rfTxIQImbalance = rOFDM0_XCTxIQImbalance;
-	priv->PHYRegDef[RF90_PATH_D].rfTxIQImbalance = rOFDM0_XDTxIQImbalance;
-
-	priv->PHYRegDef[RF90_PATH_A].rfTxAFE = rOFDM0_XATxAFE;
-	priv->PHYRegDef[RF90_PATH_B].rfTxAFE = rOFDM0_XBTxAFE;
-	priv->PHYRegDef[RF90_PATH_C].rfTxAFE = rOFDM0_XCTxAFE;
-	priv->PHYRegDef[RF90_PATH_D].rfTxAFE = rOFDM0_XDTxAFE;
-
-	priv->PHYRegDef[RF90_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
-	priv->PHYRegDef[RF90_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
-	priv->PHYRegDef[RF90_PATH_C].rfLSSIReadBack = rFPGA0_XC_LSSIReadBack;
-	priv->PHYRegDef[RF90_PATH_D].rfLSSIReadBack = rFPGA0_XD_LSSIReadBack;
+	priv->phy_reg_def[RF90_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW;
+	priv->phy_reg_def[RF90_PATH_B].rfintfs = rFPGA0_XAB_RFInterfaceSW;
+	priv->phy_reg_def[RF90_PATH_C].rfintfs = rFPGA0_XCD_RFInterfaceSW;
+	priv->phy_reg_def[RF90_PATH_D].rfintfs = rFPGA0_XCD_RFInterfaceSW;
+
+	priv->phy_reg_def[RF90_PATH_A].rfintfi = rFPGA0_XAB_RFInterfaceRB;
+	priv->phy_reg_def[RF90_PATH_B].rfintfi = rFPGA0_XAB_RFInterfaceRB;
+	priv->phy_reg_def[RF90_PATH_C].rfintfi = rFPGA0_XCD_RFInterfaceRB;
+	priv->phy_reg_def[RF90_PATH_D].rfintfi = rFPGA0_XCD_RFInterfaceRB;
+
+	priv->phy_reg_def[RF90_PATH_A].rfintfo = rFPGA0_XA_RFInterfaceOE;
+	priv->phy_reg_def[RF90_PATH_B].rfintfo = rFPGA0_XB_RFInterfaceOE;
+	priv->phy_reg_def[RF90_PATH_C].rfintfo = rFPGA0_XC_RFInterfaceOE;
+	priv->phy_reg_def[RF90_PATH_D].rfintfo = rFPGA0_XD_RFInterfaceOE;
+
+	priv->phy_reg_def[RF90_PATH_A].rfintfe = rFPGA0_XA_RFInterfaceOE;
+	priv->phy_reg_def[RF90_PATH_B].rfintfe = rFPGA0_XB_RFInterfaceOE;
+	priv->phy_reg_def[RF90_PATH_C].rfintfe = rFPGA0_XC_RFInterfaceOE;
+	priv->phy_reg_def[RF90_PATH_D].rfintfe = rFPGA0_XD_RFInterfaceOE;
+
+	priv->phy_reg_def[RF90_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter;
+	priv->phy_reg_def[RF90_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
+	priv->phy_reg_def[RF90_PATH_C].rf3wireOffset = rFPGA0_XC_LSSIParameter;
+	priv->phy_reg_def[RF90_PATH_D].rf3wireOffset = rFPGA0_XD_LSSIParameter;
+
+	priv->phy_reg_def[RF90_PATH_A].rfLSSI_Select = rFPGA0_XAB_RFParameter;
+	priv->phy_reg_def[RF90_PATH_B].rfLSSI_Select = rFPGA0_XAB_RFParameter;
+	priv->phy_reg_def[RF90_PATH_C].rfLSSI_Select = rFPGA0_XCD_RFParameter;
+	priv->phy_reg_def[RF90_PATH_D].rfLSSI_Select = rFPGA0_XCD_RFParameter;
+
+	priv->phy_reg_def[RF90_PATH_A].rfTxGainStage = rFPGA0_TxGainStage;
+	priv->phy_reg_def[RF90_PATH_B].rfTxGainStage = rFPGA0_TxGainStage;
+	priv->phy_reg_def[RF90_PATH_C].rfTxGainStage = rFPGA0_TxGainStage;
+	priv->phy_reg_def[RF90_PATH_D].rfTxGainStage = rFPGA0_TxGainStage;
+
+	priv->phy_reg_def[RF90_PATH_A].rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;
+	priv->phy_reg_def[RF90_PATH_B].rfHSSIPara1 = rFPGA0_XB_HSSIParameter1;
+	priv->phy_reg_def[RF90_PATH_C].rfHSSIPara1 = rFPGA0_XC_HSSIParameter1;
+	priv->phy_reg_def[RF90_PATH_D].rfHSSIPara1 = rFPGA0_XD_HSSIParameter1;
+
+	priv->phy_reg_def[RF90_PATH_A].rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;
+	priv->phy_reg_def[RF90_PATH_B].rfHSSIPara2 = rFPGA0_XB_HSSIParameter2;
+	priv->phy_reg_def[RF90_PATH_C].rfHSSIPara2 = rFPGA0_XC_HSSIParameter2;
+	priv->phy_reg_def[RF90_PATH_D].rfHSSIPara2 = rFPGA0_XD_HSSIParameter2;
+
+	priv->phy_reg_def[RF90_PATH_A].rfSwitchControl = rFPGA0_XAB_SwitchControl;
+	priv->phy_reg_def[RF90_PATH_B].rfSwitchControl = rFPGA0_XAB_SwitchControl;
+	priv->phy_reg_def[RF90_PATH_C].rfSwitchControl = rFPGA0_XCD_SwitchControl;
+	priv->phy_reg_def[RF90_PATH_D].rfSwitchControl = rFPGA0_XCD_SwitchControl;
+
+	priv->phy_reg_def[RF90_PATH_A].rfAGCControl1 = rOFDM0_XAAGCCore1;
+	priv->phy_reg_def[RF90_PATH_B].rfAGCControl1 = rOFDM0_XBAGCCore1;
+	priv->phy_reg_def[RF90_PATH_C].rfAGCControl1 = rOFDM0_XCAGCCore1;
+	priv->phy_reg_def[RF90_PATH_D].rfAGCControl1 = rOFDM0_XDAGCCore1;
+
+	priv->phy_reg_def[RF90_PATH_A].rfAGCControl2 = rOFDM0_XAAGCCore2;
+	priv->phy_reg_def[RF90_PATH_B].rfAGCControl2 = rOFDM0_XBAGCCore2;
+	priv->phy_reg_def[RF90_PATH_C].rfAGCControl2 = rOFDM0_XCAGCCore2;
+	priv->phy_reg_def[RF90_PATH_D].rfAGCControl2 = rOFDM0_XDAGCCore2;
+
+	priv->phy_reg_def[RF90_PATH_A].rfRxIQImbalance = rOFDM0_XARxIQImbalance;
+	priv->phy_reg_def[RF90_PATH_B].rfRxIQImbalance = rOFDM0_XBRxIQImbalance;
+	priv->phy_reg_def[RF90_PATH_C].rfRxIQImbalance = rOFDM0_XCRxIQImbalance;
+	priv->phy_reg_def[RF90_PATH_D].rfRxIQImbalance = rOFDM0_XDRxIQImbalance;
+
+	priv->phy_reg_def[RF90_PATH_A].rfRxAFE = rOFDM0_XARxAFE;
+	priv->phy_reg_def[RF90_PATH_B].rfRxAFE = rOFDM0_XBRxAFE;
+	priv->phy_reg_def[RF90_PATH_C].rfRxAFE = rOFDM0_XCRxAFE;
+	priv->phy_reg_def[RF90_PATH_D].rfRxAFE = rOFDM0_XDRxAFE;
+
+	priv->phy_reg_def[RF90_PATH_A].rfTxIQImbalance = rOFDM0_XATxIQImbalance;
+	priv->phy_reg_def[RF90_PATH_B].rfTxIQImbalance = rOFDM0_XBTxIQImbalance;
+	priv->phy_reg_def[RF90_PATH_C].rfTxIQImbalance = rOFDM0_XCTxIQImbalance;
+	priv->phy_reg_def[RF90_PATH_D].rfTxIQImbalance = rOFDM0_XDTxIQImbalance;
+
+	priv->phy_reg_def[RF90_PATH_A].rfTxAFE = rOFDM0_XATxAFE;
+	priv->phy_reg_def[RF90_PATH_B].rfTxAFE = rOFDM0_XBTxAFE;
+	priv->phy_reg_def[RF90_PATH_C].rfTxAFE = rOFDM0_XCTxAFE;
+	priv->phy_reg_def[RF90_PATH_D].rfTxAFE = rOFDM0_XDTxAFE;
+
+	priv->phy_reg_def[RF90_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
+	priv->phy_reg_def[RF90_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
+	priv->phy_reg_def[RF90_PATH_C].rfLSSIReadBack = rFPGA0_XC_LSSIReadBack;
+	priv->phy_reg_def[RF90_PATH_D].rfLSSIReadBack = rFPGA0_XD_LSSIReadBack;
 
 }
 
@@ -1006,7 +1006,7 @@ static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	switch (priv->CurrentChannelBW) {
+	switch (priv->current_chnl_bw) {
 	case HT_CHANNEL_WIDTH_20:
 		priv->cck_present_attn =
 			priv->cck_present_attn_20m_def +
@@ -1070,7 +1070,7 @@ static void _rtl92e_cck_tx_power_track_bw_switch_thermal(struct net_device *dev)
 		 priv->bcck_in_ch14)
 		priv->bcck_in_ch14 = false;
 
-	switch (priv->CurrentChannelBW) {
+	switch (priv->current_chnl_bw) {
 	case HT_CHANNEL_WIDTH_20:
 		if (priv->rec_cck_20m_idx == 0)
 			priv->rec_cck_20m_idx = 6;
@@ -1110,7 +1110,7 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 	}
 	regBwOpMode = rtl92e_readb(dev, BW_OPMODE);
 
-	switch (priv->CurrentChannelBW) {
+	switch (priv->current_chnl_bw) {
 	case HT_CHANNEL_WIDTH_20:
 		regBwOpMode |= BW_OPMODE_20MHZ;
 		rtl92e_writeb(dev, BW_OPMODE, regBwOpMode);
@@ -1123,11 +1123,11 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 
 	default:
 		netdev_err(dev, "%s(): unknown Bandwidth: %#X\n", __func__,
-			   priv->CurrentChannelBW);
+			   priv->current_chnl_bw);
 		break;
 	}
 
-	switch (priv->CurrentChannelBW) {
+	switch (priv->current_chnl_bw) {
 	case HT_CHANNEL_WIDTH_20:
 		rtl92e_set_bb_reg(dev, rFPGA0_RFMOD, bRFMOD, 0x0);
 		rtl92e_set_bb_reg(dev, rFPGA1_RFMOD, bRFMOD, 0x0);
@@ -1164,7 +1164,7 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 		break;
 	default:
 		netdev_err(dev, "%s(): unknown Bandwidth: %#X\n", __func__,
-			   priv->CurrentChannelBW);
+			   priv->current_chnl_bw);
 		break;
 
 	}
@@ -1174,7 +1174,7 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 		break;
 
 	case RF_8256:
-		rtl92e_set_bandwidth(dev, priv->CurrentChannelBW);
+		rtl92e_set_bandwidth(dev, priv->current_chnl_bw);
 		break;
 
 	case RF_8258:
@@ -1205,7 +1205,7 @@ void rtl92e_set_bw_mode(struct net_device *dev, enum ht_channel_width bandwidth,
 	atomic_inc(&(priv->rtllib->atm_swbw));
 	priv->set_bw_mode_in_progress = true;
 
-	priv->CurrentChannelBW = bandwidth;
+	priv->current_chnl_bw = bandwidth;
 
 	if (Offset == HT_EXTCHNL_OFFSET_LOWER)
 		priv->n_cur_40mhz_prime_sc = HAL_PRIME_CHNL_OFFSET_UPPER;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index da10835a987e..cbafbecb5ca5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -317,12 +317,12 @@ struct r8192_priv {
 
 	struct work_struct				reset_wq;
 
-	enum rt_customer_id CustomerID;
+	enum rt_customer_id customer_id;
 
 
 	enum rt_rf_type_819xu rf_chip;
-	enum ht_channel_width CurrentChannelBW;
-	struct bb_reg_definition PHYRegDef[4];
+	enum ht_channel_width current_chnl_bw;
+	struct bb_reg_definition phy_reg_def[4];
 	struct rate_adaptive rate_adaptive;
 
 	struct rt_firmware *fw_info;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 63be5f2872c6..cb55b6645674 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -292,7 +292,7 @@ void rtl92e_init_adaptive_rate(struct net_device *dev)
 	pra->low_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M;
 	pra->low_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M;
 
-	if (priv->CustomerID == RT_CID_819x_Netcore)
+	if (priv->customer_id == RT_CID_819x_Netcore)
 		pra->ping_rssi_enable = 1;
 	else
 		pra->ping_rssi_enable = 0;
@@ -353,7 +353,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 				(pra->middle_rssi_threshold_ratr & (~BIT31)) |
 				((bshort_gi_enabled) ? BIT31 : 0);
 
-		if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
+		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) {
 			pra->low_rssi_threshold_ratr =
 				(pra->low_rssi_threshold_ratr_40M & (~BIT31)) |
 				((bshort_gi_enabled) ? BIT31 : 0);
@@ -368,15 +368,15 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 
 		if (pra->ratr_state == DM_RATR_STA_HIGH) {
 			HighRSSIThreshForRA = pra->high2low_rssi_thresh_for_ra;
-			LowRSSIThreshForRA = (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) ?
+			LowRSSIThreshForRA = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
 					(pra->low_rssi_thresh_for_ra40M) : (pra->low_rssi_thresh_for_ra20M);
 		} else if (pra->ratr_state == DM_RATR_STA_LOW) {
 			HighRSSIThreshForRA = pra->high_rssi_thresh_for_ra;
-			LowRSSIThreshForRA = (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) ?
+			LowRSSIThreshForRA = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
 					(pra->low2high_rssi_thresh_for_ra40M) : (pra->low2high_rssi_thresh_for_ra20M);
 		} else {
 			HighRSSIThreshForRA = pra->high_rssi_thresh_for_ra;
-			LowRSSIThreshForRA = (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) ?
+			LowRSSIThreshForRA = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
 					(pra->low_rssi_thresh_for_ra40M) : (pra->low_rssi_thresh_for_ra20M);
 		}
 
@@ -443,8 +443,8 @@ static void _rtl92e_dm_bandwidth_autoswitch(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20 ||
-	   !priv->rtllib->bandwidth_auto_switch.bautoswitch_enable)
+	if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20 ||
+	    !priv->rtllib->bandwidth_auto_switch.bautoswitch_enable)
 		return;
 	if (!priv->rtllib->bandwidth_auto_switch.bforced_tx20Mhz) {
 		if (priv->undecorated_smoothed_pwdb <=
@@ -715,7 +715,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 					= priv->rfa_txpowertrackingindex_real - priv->rfa_txpowertracking_default;
 			}
 
-			if (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20)
+			if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20)
 				priv->cck_present_attn =
 					 priv->cck_present_attn_20m_def +
 					 priv->cck_present_attn_diff;
@@ -818,7 +818,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		}
 		tmpCCK40Mindex = 0;
 	}
-	if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)
+	if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
 		tmpCCKindex = tmpCCK40Mindex;
 	else
 		tmpCCKindex = tmpCCK20Mindex;
@@ -1150,7 +1150,7 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 	dm_digtable.rssi_val = 50;
 	dm_digtable.backoff_val = DM_DIG_BACKOFF;
 	dm_digtable.rx_gain_range_max = DM_DIG_MAX;
-	if (priv->CustomerID == RT_CID_819x_Netcore)
+	if (priv->customer_id == RT_CID_819x_Netcore)
 		dm_digtable.rx_gain_range_min = DM_DIG_MIN_Netcore;
 	else
 		dm_digtable.rx_gain_range_min = DM_DIG_MIN;
@@ -1260,7 +1260,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 		rtl92e_writeb(dev, rOFDM0_XCAGCCore1, 0x17);
 		rtl92e_writeb(dev, rOFDM0_XDAGCCore1, 0x17);
 
-		if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)
+		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
 			rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x00);
 		else
 			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x42);
@@ -1297,7 +1297,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 			rtl92e_writeb(dev, rOFDM0_XDAGCCore1, 0x20);
 		}
 
-		if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)
+		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
 			rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x20);
 		else
 			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x44);
@@ -1328,7 +1328,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 			return;
 		dm_digtable.dig_highpwr_state = DM_STA_DIG_ON;
 
-		if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)
+		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
 			rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x10);
 		else
 			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x43);
@@ -1342,7 +1342,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 		     dm_digtable.rssi_high_power_lowthresh) &&
 		    (priv->undecorated_smoothed_pwdb >=
 		    dm_digtable.rssi_high_thresh)) {
-			if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)
+			if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
 				rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x20);
 			else
 				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x44);
@@ -1453,18 +1453,18 @@ static void _rtl92e_dm_pd_th(struct net_device *dev)
 	if ((dm_digtable.prepd_thstate != dm_digtable.curpd_thstate) ||
 	    (initialized <= 3) || force_write) {
 		if (dm_digtable.curpd_thstate == DIG_PD_AT_LOW_POWER) {
-			if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)
+			if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
 				rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x00);
 			else
 				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x42);
 		} else if (dm_digtable.curpd_thstate ==
 			   DIG_PD_AT_NORMAL_POWER) {
-			if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)
+			if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
 				rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x20);
 			else
 				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x44);
 		} else if (dm_digtable.curpd_thstate == DIG_PD_AT_HIGH_POWER) {
-			if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)
+			if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
 				rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x10);
 			else
 				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x43);
@@ -1736,7 +1736,7 @@ static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev)
 	DM_RxPathSelTable.Enable = 1;
 	DM_RxPathSelTable.SS_TH_low = RxPathSelection_SS_TH_low;
 	DM_RxPathSelTable.diff_TH = RxPathSelection_diff_TH;
-	if (priv->CustomerID == RT_CID_819x_Netcore)
+	if (priv->customer_id == RT_CID_819x_Netcore)
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
 	else
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_1;
-- 
2.39.0

