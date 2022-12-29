Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E51658F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiL2Q1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiL2Q0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:26:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7251401B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:26:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u18so25904118eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7X56oiCW3O33eo6MlmC7Nu2XKLGXqJJ4nlcMKqYmDmI=;
        b=MjN2zSMgQS/sFnqxqJ4awCudn7ywN/fdOkiVKWHofWgCyQUuPdQWBeFYpZluv13Wq5
         RCicDrApDD7jj0VoD9tsyzxgJAbrkvajf6UpMNnNm6Twd5U6eYzEjuH1/dISFvWaUONU
         FoAD2jaLWgraT6TecWoqwCvEkrKBwPXai5WGhrRhFqofQOauaH06M17E+pC1x2S9KHSN
         Wfddw/hRG7rhjzIPsYjK9w+4cRyd1eDu8kjmIa9SvZqoo4AmhJXauEIttwtkbFadYjII
         7ayp0YSGtODWxYlRlCptQ8QEryJt4s2JprinjTJdpn9EhaD3Z+yZETDpEf9YFChcxVHR
         rsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X56oiCW3O33eo6MlmC7Nu2XKLGXqJJ4nlcMKqYmDmI=;
        b=ESqU5HkK0z6MGdwhz6CeZel1fItoeluymKV3NkQFUVlaBIR41PHsWTi/bY2MU5+e8M
         Z7phnjso6lOlGvE5ib4LJRKw6ZN83LLGL48/FL7xR3rA7iv86HLHg9gV8I/cB7Y+yJFw
         BjCfPj/mTRocFhPh1p3vHNYKfuyMjGU/JiC75tVnHDWp2G7iInst7E+hMZ7r4BXRwEZ2
         UrH3VLPN6kiD32CSz8jSkp0PDvIVueCf5oCICkvxG+jqexPzwRW949giSaOkgq+byKM4
         uajBAkUkilmz3A/HjZd5y4fk4tFZA7VRzoyT6m70dUgUM4zt4b1lFdaeMSyBmR1mwmOS
         1fkA==
X-Gm-Message-State: AFqh2kog7QTU4NBjU57OlHvvY3W3Q+A3mSnkUvgHjXnS/o7jrhCoh1M8
        n6NT04DYukRjeR4YpqRXBmr7b5oWfyA=
X-Google-Smtp-Source: AMrXdXuOeHcRoWEw4CsCkN3krp9JFBh205GraX+io2Jk8HWie1860ZqrWCKPdU5A9/ndmydJv60oRQ==
X-Received: by 2002:a05:6402:538f:b0:46d:76e1:a0de with SMTP id ew15-20020a056402538f00b0046d76e1a0demr313088edb.0.1672331195113;
        Thu, 29 Dec 2022 08:26:35 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b0046aa78ecd8asm8470886edt.3.2022.12.29.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:26:34 -0800 (PST)
Date:   Thu, 29 Dec 2022 17:26:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging: rtl8192e: Rename SetRFPowerSta.., RfReg0Value
 and bTXPowerDa..
Message-ID: <b17550a26a0ebd8eb1afbc5230d47a529fa592ea.1672330343.git.philipp.g.hortmann@gmail.com>
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

Rename variable SetRFPowerStateInProgress to set_rf_pwr_state_in_progress,
RfReg0Value to rf_reg_0value and bTXPowerDataReadFromEEPORM to
tx_pwr_data_read_from_eeprom to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 40 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  6 +--
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 4a94c40f1930..3cbe0218c0ee 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -345,9 +345,9 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	}
 
 	if (priv->card_8192_version > VERSION_8190_BD)
-		priv->bTXPowerDataReadFromEEPORM = true;
+		priv->tx_pwr_data_read_from_eeprom = true;
 	else
-		priv->bTXPowerDataReadFromEEPORM = false;
+		priv->tx_pwr_data_read_from_eeprom = false;
 
 	priv->rf_type = RTL819X_DEFAULT_RF_TYPE;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index cc7e72f2a52c..2e9932a26382 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -101,17 +101,17 @@ static u32 _rtl92e_phy_rf_read(struct net_device *dev,
 	if (priv->rf_chip == RF_8256) {
 		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0xf00, 0x0);
 		if (Offset >= 31) {
-			priv->RfReg0Value[eRFPath] |= 0x140;
+			priv->rf_reg_0value[eRFPath] |= 0x140;
 			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
 					  bMaskDWord,
-					  (priv->RfReg0Value[eRFPath]<<16));
+					  (priv->rf_reg_0value[eRFPath] << 16));
 			NewOffset = Offset - 30;
 		} else if (Offset >= 16) {
-			priv->RfReg0Value[eRFPath] |= 0x100;
-			priv->RfReg0Value[eRFPath] &= (~0x40);
+			priv->rf_reg_0value[eRFPath] |= 0x100;
+			priv->rf_reg_0value[eRFPath] &= (~0x40);
 			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
 					  bMaskDWord,
-					  (priv->RfReg0Value[eRFPath]<<16));
+					  (priv->rf_reg_0value[eRFPath] << 16));
 
 			NewOffset = Offset - 15;
 		} else
@@ -130,10 +130,10 @@ static u32 _rtl92e_phy_rf_read(struct net_device *dev,
 				bLSSIReadBackData);
 
 	if (priv->rf_chip == RF_8256) {
-		priv->RfReg0Value[eRFPath] &= 0xebf;
+		priv->rf_reg_0value[eRFPath] &= 0xebf;
 
 		rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset, bMaskDWord,
-				  (priv->RfReg0Value[eRFPath] << 16));
+				  (priv->rf_reg_0value[eRFPath] << 16));
 
 		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0x300, 0x3);
 	}
@@ -156,17 +156,17 @@ static void _rtl92e_phy_rf_write(struct net_device *dev,
 		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0xf00, 0x0);
 
 		if (Offset >= 31) {
-			priv->RfReg0Value[eRFPath] |= 0x140;
+			priv->rf_reg_0value[eRFPath] |= 0x140;
 			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
 					  bMaskDWord,
-					  (priv->RfReg0Value[eRFPath] << 16));
+					  (priv->rf_reg_0value[eRFPath] << 16));
 			NewOffset = Offset - 30;
 		} else if (Offset >= 16) {
-			priv->RfReg0Value[eRFPath] |= 0x100;
-			priv->RfReg0Value[eRFPath] &= (~0x40);
+			priv->rf_reg_0value[eRFPath] |= 0x100;
+			priv->rf_reg_0value[eRFPath] &= (~0x40);
 			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
 					  bMaskDWord,
-					  (priv->RfReg0Value[eRFPath] << 16));
+					  (priv->rf_reg_0value[eRFPath] << 16));
 			NewOffset = Offset - 15;
 		} else
 			NewOffset = Offset;
@@ -179,14 +179,14 @@ static void _rtl92e_phy_rf_write(struct net_device *dev,
 	rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset, bMaskDWord, DataAndAddr);
 
 	if (Offset == 0x0)
-		priv->RfReg0Value[eRFPath] = Data;
+		priv->rf_reg_0value[eRFPath] = Data;
 
 	if (priv->rf_chip == RF_8256) {
 		if (Offset != 0) {
-			priv->RfReg0Value[eRFPath] &= 0xebf;
+			priv->rf_reg_0value[eRFPath] &= 0xebf;
 			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
 					  bMaskDWord,
-					  (priv->RfReg0Value[eRFPath] << 16));
+					  (priv->rf_reg_0value[eRFPath] << 16));
 		}
 		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0x300, 0x3);
 	}
@@ -306,7 +306,7 @@ void rtl92e_config_mac(struct net_device *dev)
 	u32 *pdwArray = NULL;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bTXPowerDataReadFromEEPORM) {
+	if (priv->tx_pwr_data_read_from_eeprom) {
 		dwArrayLen = MACPHY_Array_PGLength;
 		pdwArray = Rtl819XMACPHY_Array_PG;
 
@@ -1309,9 +1309,9 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 	u8	i = 0, QueueID = 0;
 	struct rtl8192_tx_ring  *ring = NULL;
 
-	if (priv->SetRFPowerStateInProgress)
+	if (priv->set_rf_pwr_state_in_progress)
 		return false;
-	priv->SetRFPowerStateInProgress = true;
+	priv->set_rf_pwr_state_in_progress = true;
 
 	switch (priv->rf_chip) {
 	case RF_8256:
@@ -1331,7 +1331,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 					netdev_err(dev,
 						   "%s(): Failed to initialize Adapter.\n",
 						   __func__);
-					priv->SetRFPowerStateInProgress = false;
+					priv->set_rf_pwr_state_in_progress = false;
 					return false;
 				}
 
@@ -1438,7 +1438,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 		}
 	}
 
-	priv->SetRFPowerStateInProgress = false;
+	priv->set_rf_pwr_state_in_progress = false;
 	return bResult;
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 92260d098eaa..050f0435ab6d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -872,7 +872,7 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->rf_off_reason = 0;
 	priv->rf_change_in_progress = false;
 	priv->hw_rf_off_action = 0;
-	priv->SetRFPowerStateInProgress = false;
+	priv->set_rf_pwr_state_in_progress = false;
 	priv->rtllib->pwr_save_ctrl.bLeisurePs = true;
 	priv->rtllib->LPSDelayCnt = 0;
 	priv->rtllib->sta_sleep = LPS_IS_WAKE;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 30efc46c307c..72b3c1869883 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -444,18 +444,18 @@ struct r8192_priv {
 
 	u8 nCur40MhzPrimeSC;
 
-	u32 RfReg0Value[4];
+	u32 rf_reg_0value[4];
 	u8 num_total_rf_path;
 	bool brfpath_rxenable[4];
 
-	bool bTXPowerDataReadFromEEPORM;
+	bool tx_pwr_data_read_from_eeprom;
 
 	u16 reg_chnl_plan;
 	u16 chnl_plan;
 	u8 hw_rf_off_action;
 
 	bool rf_change_in_progress;
-	bool SetRFPowerStateInProgress;
+	bool set_rf_pwr_state_in_progress;
 	bool bdisable_nic;
 
 	u8 DM_Type;
-- 
2.39.0

