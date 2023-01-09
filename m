Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7C7662FF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjAITJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjAITJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:09:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BE13D1FA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:09:09 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id az20so3566323ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjv16lVnrOe4MOuLDfPurVOd0YQaBZRZ/Lo343Vt4Hc=;
        b=kl7J2GBCUBGug/lBcnD09rnaH4OP5/pDhZdLaR5W9i2Gmk1lOvqXlJnAa+Hj85+gyL
         6ImsqFjdy7s3qwlVMH2el2pzx9yKvzBtryEkUKIbYKWwZ3Inm9UQlMhqHJgA6srSPubf
         2Fn65ZtxYW+xpptShGkhydi0iAnmZzbpetZzfsIAfil/mk1ujcrN79uRHuCekWwJbInl
         RXvGo9CKd19DWhykjhey+5TIS1wbICBnJpO0XAygpL8q0JFLGCOu4EgrExNp4MMaR1g2
         7D4Az5wGDeXgnSktjeRefNp2zoGAAEPdgKDavpqCHHcM1vS8ucXVUyPLKYhGa7F5IxmW
         x7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjv16lVnrOe4MOuLDfPurVOd0YQaBZRZ/Lo343Vt4Hc=;
        b=medIGxt0BlvfrHbxN859TvYstgjfS9KOxElwllRGSdZWCwKQHvrBMihnUX4FY2O19O
         iyR0hH3h/CabjQiRt1MDn3B+/464SU6DgtcTXqHvEC3mNwk36+iiRxAmjMDH6OUr921M
         sAXA0xRQ23jjvY64ySGPBiNIjEEjc8Tu4EPruQtNXrdbdnzBrufmsDuWUEtPhu9w+YO2
         JZ5Ro3YVOjjvZeA/sKm4uMMK7XxoYtrX+WMNNeCTHUvfRAHHMKuVRHtDK3sCLIFvE2+u
         C2NQLTWpCuhGDE39f7fmNzfMK2K407pqic0TKaGZeC7maV1iynrxDVgChMMUxWaBIDe6
         m7OQ==
X-Gm-Message-State: AFqh2kpmMUfslKuDtWEwlzliTkpaWwSdceW383MwitHyz/2R1LeJccdQ
        7SV51Sud2jOATozEmDEVQzoXMNZpkQs=
X-Google-Smtp-Source: AMrXdXsjd0ojc6Ck3GaLPzWei6Oar8qzCxROQgcTVi2r5rxJKZ2xGCKzpkTE0GPUFjgWv1vmDdvJIg==
X-Received: by 2002:a17:906:aec4:b0:84d:269e:7b01 with SMTP id me4-20020a170906aec400b0084d269e7b01mr2480382ejb.0.1673291347719;
        Mon, 09 Jan 2023 11:09:07 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id uk41-20020a170907ca2900b0078d9b967962sm4065109ejc.65.2023.01.09.11.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:09:07 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:09:05 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] staging: rtl8192e: Rename MCSTxPowerL..,
 LegacyHTTxPowe.. and AntennaTx..
Message-ID: <271b3a9e1c23593e9ead925eb8415a584058fb56.1673290428.git.philipp.g.hortmann@gmail.com>
References: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable MCSTxPowerLevelOriginalOffset to
mcs_tx_pwr_level_org_offset, LegacyHTTxPowerDiff to legacy_ht_tx_pwr_diff
and AntennaTxPwDiff to antenna_tx_pwr_diff to avoid CamelCase which is not
accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  4 +--
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 16 +++++-----
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 30 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  6 ++--
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 7517ec001421..1672a3fea13c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -169,7 +169,7 @@ void rtl92e_set_ofdm_tx_power(struct net_device *dev, u8 powerlevel)
 	u16 RegOffset[6] = {0xe00, 0xe04, 0xe10, 0xe14, 0xe18, 0xe1c};
 	u8 byte0, byte1, byte2, byte3;
 
-	powerBase0 = powerlevel + priv->LegacyHTTxPowerDiff;
+	powerBase0 = powerlevel + priv->legacy_ht_tx_pwr_diff;
 	powerBase0 = (powerBase0 << 24) | (powerBase0 << 16) |
 		     (powerBase0 << 8) | powerBase0;
 	powerBase1 = powerlevel;
@@ -177,7 +177,7 @@ void rtl92e_set_ofdm_tx_power(struct net_device *dev, u8 powerlevel)
 		     (powerBase1 << 8) | powerBase1;
 
 	for (index = 0; index < 6; index++) {
-		writeVal = (u32)(priv->MCSTxPowerLevelOriginalOffset[index] +
+		writeVal = (u32)(priv->mcs_tx_pwr_level_org_offset[index] +
 			   ((index < 2) ? powerBase0 : powerBase1));
 		byte0 = writeVal & 0x7f;
 		byte1 = (writeVal & 0x7f00) >> 8;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index ab9e2265df6f..06ab02230125 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -413,12 +413,12 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 				priv->tx_pwr_level_ofdm_24g[i] =
 					 priv->EEPROMTxPowerLevelOFDM24G[i];
 			}
-			priv->LegacyHTTxPowerDiff =
+			priv->legacy_ht_tx_pwr_diff =
 					 priv->EEPROMLegacyHTTxPowerDiff;
-			priv->AntennaTxPwDiff[0] = priv->EEPROMAntPwDiff & 0xf;
-			priv->AntennaTxPwDiff[1] = (priv->EEPROMAntPwDiff &
+			priv->antenna_tx_pwr_diff[0] = priv->EEPROMAntPwDiff & 0xf;
+			priv->antenna_tx_pwr_diff[1] = (priv->EEPROMAntPwDiff &
 							0xf0) >> 4;
-			priv->AntennaTxPwDiff[2] = (priv->EEPROMAntPwDiff &
+			priv->antenna_tx_pwr_diff[2] = (priv->EEPROMAntPwDiff &
 							0xf00) >> 8;
 			priv->CrystalCap = priv->EEPROMCrystalCap;
 			priv->ThermalMeter[0] = priv->EEPROMThermalMeter & 0xf;
@@ -456,11 +456,11 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 				priv->tx_pwr_level_ofdm_24g_c[i] =
 					 priv->EEPROMRfCOfdmChnlTxPwLevel[2];
 			}
-			priv->LegacyHTTxPowerDiff =
+			priv->legacy_ht_tx_pwr_diff =
 				 priv->EEPROMLegacyHTTxPowerDiff;
-			priv->AntennaTxPwDiff[0] = 0;
-			priv->AntennaTxPwDiff[1] = 0;
-			priv->AntennaTxPwDiff[2] = 0;
+			priv->antenna_tx_pwr_diff[0] = 0;
+			priv->antenna_tx_pwr_diff[1] = 0;
+			priv->antenna_tx_pwr_diff[2] = 0;
 			priv->CrystalCap = priv->EEPROMCrystalCap;
 			priv->ThermalMeter[0] = priv->EEPROMThermalMeter & 0xf;
 			priv->ThermalMeter[1] = (priv->EEPROMThermalMeter &
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 19c65aaef3f6..cc7e72f2a52c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -535,9 +535,9 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
 
 	if (priv->IC_Cut  > VERSION_8190_BD) {
 		if (priv->rf_type == RF_2T4R)
-			dwRegValue = priv->AntennaTxPwDiff[2]<<8 |
-				      priv->AntennaTxPwDiff[1]<<4 |
-				      priv->AntennaTxPwDiff[0];
+			dwRegValue = priv->antenna_tx_pwr_diff[2] << 8 |
+				      priv->antenna_tx_pwr_diff[1] << 4 |
+				      priv->antenna_tx_pwr_diff[0];
 		else
 			dwRegValue = 0x0;
 		rtl92e_set_bb_reg(dev, rFPGA0_TxGainStage,
@@ -561,17 +561,17 @@ void rtl92e_get_tx_power(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	priv->MCSTxPowerLevelOriginalOffset[0] =
+	priv->mcs_tx_pwr_level_org_offset[0] =
 		rtl92e_readl(dev, rTxAGC_Rate18_06);
-	priv->MCSTxPowerLevelOriginalOffset[1] =
+	priv->mcs_tx_pwr_level_org_offset[1] =
 		rtl92e_readl(dev, rTxAGC_Rate54_24);
-	priv->MCSTxPowerLevelOriginalOffset[2] =
+	priv->mcs_tx_pwr_level_org_offset[2] =
 		rtl92e_readl(dev, rTxAGC_Mcs03_Mcs00);
-	priv->MCSTxPowerLevelOriginalOffset[3] =
+	priv->mcs_tx_pwr_level_org_offset[3] =
 		rtl92e_readl(dev, rTxAGC_Mcs07_Mcs04);
-	priv->MCSTxPowerLevelOriginalOffset[4] =
+	priv->mcs_tx_pwr_level_org_offset[4] =
 		rtl92e_readl(dev, rTxAGC_Mcs11_Mcs08);
-	priv->MCSTxPowerLevelOriginalOffset[5] =
+	priv->mcs_tx_pwr_level_org_offset[5] =
 		rtl92e_readl(dev, rTxAGC_Mcs15_Mcs12);
 
 	priv->DefaultInitialGain[0] = rtl92e_readb(dev, rOFDM0_XAAGCCore1);
@@ -609,13 +609,13 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 
 			ant_pwr_diff &= 0xf;
 
-			priv->AntennaTxPwDiff[2] = 0;
-			priv->AntennaTxPwDiff[1] = (u8)(ant_pwr_diff);
-			priv->AntennaTxPwDiff[0] = 0;
+			priv->antenna_tx_pwr_diff[2] = 0;
+			priv->antenna_tx_pwr_diff[1] = (u8)(ant_pwr_diff);
+			priv->antenna_tx_pwr_diff[0] = 0;
 
-			u4RegValue = priv->AntennaTxPwDiff[2]<<8 |
-				      priv->AntennaTxPwDiff[1]<<4 |
-				      priv->AntennaTxPwDiff[0];
+			u4RegValue = priv->antenna_tx_pwr_diff[2] << 8 |
+				      priv->antenna_tx_pwr_diff[1] << 4 |
+				      priv->antenna_tx_pwr_diff[0];
 
 			rtl92e_set_bb_reg(dev, rFPGA0_TxGainStage,
 					  (bXBTxAGC|bXCTxAGC|bXDTxAGC),
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index ca61fc60db6e..cc3e2816e657 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -469,16 +469,16 @@ struct r8192_priv {
 	s8 cck_present_attn;
 	long undecorated_smoothed_pwdb;
 
-	u32 MCSTxPowerLevelOriginalOffset[6];
+	u32 mcs_tx_pwr_level_org_offset[6];
 	u8 tx_pwr_level_cck[14];
 	u8 tx_pwr_level_cck_a[14];
 	u8 tx_pwr_level_cck_c[14];
 	u8 tx_pwr_level_ofdm_24g[14];
 	u8 tx_pwr_level_ofdm_24g_a[14];
 	u8 tx_pwr_level_ofdm_24g_c[14];
-	u8		LegacyHTTxPowerDiff;
+	u8 legacy_ht_tx_pwr_diff;
 	s8		RF_C_TxPwDiff;
-	u8		AntennaTxPwDiff[3];
+	u8 antenna_tx_pwr_diff[3];
 
 	bool		bDynamicTxHighPower;
 	bool		bDynamicTxLowPower;
-- 
2.39.0

