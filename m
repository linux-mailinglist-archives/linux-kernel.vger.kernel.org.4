Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A18658F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiL2Q05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiL2Q02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:26:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC993CE01
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:26:26 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id tz12so46088041ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3s3KQ51G7iN+Q95ah8Lmo1iEkBKdbq/0OpGzR/t0yI=;
        b=i9VuJ5wtSUdxv56H3Fkd/wewLr1M3b+x4CPVeLYPzlKOWF3JutB5BIriOkgsTK0yYD
         kQ1ZC9LvjxzhrImTbPwKIfIhIgkRlzKFcnquJ74eJxn3h0cjTjU30FFXZQ5HI2pG1Qrv
         13n7i2f68/ANbALeX6UeA2/wj4cv3BoAd7hcDs3jVn5qgCkJR0maFdznosd44nnvAh3l
         texqWIV6O3hSWXWN5v8mQOqqPo7eB1CYlvoXueb/093LrKXhUWmKKlKk1Xsykabb9SH5
         4WHgmPVJM8RhAQ3C0xCyxyGsk9olYWl2p8WnLJ09Dqr5kDb/l52YwbuRnmh4HFjCljbx
         rbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3s3KQ51G7iN+Q95ah8Lmo1iEkBKdbq/0OpGzR/t0yI=;
        b=yEwPhLHxB6F2FezWrr3+IdXgWLkyOxZR7SE5EH9lM+27fn/SyD+2mamdbF0rac1hEe
         6zSaJqQoRE2JVjMf03MTQzLJlHY4qKw1gjLfVblY2WHb1BpDJeoIunTzOwvfduNDQWTt
         zMORxlm+wn4i3VlGVkwLjAHOl8Ek4wMC77ngo8+yZmQBFY2o4KTRhy0gNL9sPJ2SkqCf
         kKCgKXQbz1l4zNjCOCEftSKGxVE/45iWqRa0hpNUHar85AMmss2NZPD6bnf2sSxwnCcf
         ECwSVhKDl4c7ZhGrWoYTRK2lVOwjOgGVumlHrEnNgRsBIVS8SHpgwJjV8fqCbBEzR5aD
         H8ig==
X-Gm-Message-State: AFqh2kowNERO3uJOXFggwzKzMCd87sFTrtHSMvWQpKF3OhP3a9XrRUsC
        bsvNCNJmTEM+Q4o8OCniDT0=
X-Google-Smtp-Source: AMrXdXuTO4SMfzoukxRCQait7p/ML0b0M+geR4v/XGYHKr35sB3CJnYqNEd05rVv6c1Jw3LbeH98eQ==
X-Received: by 2002:a17:907:8b95:b0:84c:95c7:302d with SMTP id tb21-20020a1709078b9500b0084c95c7302dmr300013ejc.5.1672331185565;
        Thu, 29 Dec 2022 08:26:25 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906181200b0077f324979absm8625680eje.67.2022.12.29.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:26:25 -0800 (PST)
Date:   Thu, 29 Dec 2022 17:26:23 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: rtl8192e: Rename MCSTxPowerL..,
 LegacyHTTxPowe.. and AntennaTx..
Message-ID: <6e123b7a8d600cdc20ea7d4a8ae0b9638406b6a7.1672330343.git.philipp.g.hortmann@gmail.com>
References: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
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
index 618939dbfb13..4a94c40f1930 100644
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
index a1274a5fdf44..30efc46c307c 100644
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

