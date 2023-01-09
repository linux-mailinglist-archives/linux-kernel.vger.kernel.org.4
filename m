Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C71A662FF6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbjAITJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbjAITJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:09:16 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B333B937
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:09:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i15so14060709edf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI4QNYHAsoqJCIbKwCF4KbxUOqKXYFqsYQ+1I8J7L9A=;
        b=KeuCh0wCp6/fkrCV+b7lipshXbHWdWeLJLV+uyA0HVd7egVd5zzRkZ1LUeB7lJnW5b
         JyktUsLZClLwML0jvBrLvMhX1gdZivmQ7lCz6cZZH19klIyoU9W7qtDivZXa9n47tbpp
         ALMjq7YQp/pPoE4jrtGIEk+N5UTTdoF/YUnvSJYWC1hlK9IM3wjiaekqU8mqsIuAcezP
         oXdYDlHShjkWLHwKF8pXchC+8ZDADZct4XAR9na8JLiovrjknRAYkJJ7ZCK2w1qpvJK2
         iKZ0SUzhQLT9bccYgK8cl81sAeKbRWP+EzSf4d2Nlydjof3/QNXt3ObZJGmgu6IX8XVg
         uBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI4QNYHAsoqJCIbKwCF4KbxUOqKXYFqsYQ+1I8J7L9A=;
        b=kZBbmaDrtJqdMTJzxjAb2v7q1QSSLiEKv51OuDEqbdu6MEMwYohyNJI8H+NGBFiBQb
         BiCXT3/p7NhuEHdoi38aGLv+NbYCOBUgbl5ousgwjMtjezUgOkXGEedWg9SnBUvIFonZ
         TqkXA99BSdJOoQ5vtCSySNY2Z+t1kmQFdmSBC86pzoycl+ZzlFKOZ89TXL/eXTXdMx/x
         8sTMvM9reXijMwfTh3Yq1pbdlRZNK3HEgHVAe0HH3EbhJGXwXYxi8tbb2SgL5Dn/9X5V
         rQODUOCnuSWiZ79bRasOnI4L3t2aTKatR6NDuBkMH0w0EziDUlObsrMHVPJocgfEHaqb
         XUkA==
X-Gm-Message-State: AFqh2kqORtI2vikcTDrWQbPVLSPmC22a4H3mZy9F6NxnaHXRN0AZaNQT
        oQtmIWZDEOC5N6jePqi5na8=
X-Google-Smtp-Source: AMrXdXuD4MlMKwuEwJVAD+D5BX/tAz1GAS6ckQ8kHmmpf93LnSQ8Q2N6IECunQt8abziuA7mJ+Bzlw==
X-Received: by 2002:a05:6402:207c:b0:490:ff75:7aa with SMTP id bd28-20020a056402207c00b00490ff7507aamr3522527edb.1.1673291354140;
        Mon, 09 Jan 2023 11:09:14 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id p9-20020aa7d309000000b0046776f98d0csm4062977edq.79.2023.01.09.11.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:09:13 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:09:11 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] staging: rtl8192e: Rename SetRFPowerSta..,
 RfReg0Value and bTXPowerDa..
Message-ID: <01ff54a2c135ba6e3d06255102679d496fd2aef1.1673290428.git.philipp.g.hortmann@gmail.com>
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
index 06ab02230125..ebf1fa5ec295 100644
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
index cc3e2816e657..ad34bef5660c 100644
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

