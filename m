Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51D75F94C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJJAFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiJJAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:05:13 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 16:38:34 PDT
Received: from mail-200160.simplelogin.co (mail-200160.simplelogin.co [176.119.200.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC665B7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=dkim;
        t=1665357692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GE81zLXpV1t0gzZ6uOCRv3Jz/nVmC8+25fUTxenq7DE=;
        b=mizJvc7XghLZRkzA+0unCLv6IUiptTgKXdDf6jl41VVnt8pJ04x/rHlNYh4pxzTrh5QoDm
        oh0H2QF4w94SS2SblVP5pZLNBOtnNpX8UYkg3nDdATrvQ66Ds/dCir4dbZmOE4mfx9VOdE
        w8qOw7QaobDoco6DLAPBIekZdpBVdRU=
Subject: [PATCH v3] staging: rtl8192e: remove unnecessary braces for single
 statement blocks
Date:   Mon, 10 Oct 2022 07:21:05 +0800
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From:   Rui Li <me@lirui.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <166535769195.7.8013937898116750731.67872946@lirui.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 67872946
X-SimpleLogin-Want-Signing: yes
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit cleans up checkpatch warning as follows:
braces {} are not necessary for single statement blocks

Signed-off-by: Rui Li <me@lirui.org>
---
Changes since v2:
 - Correct commit message title
 - Add changelog

Changes since v1:
 - Only fix one of checkpatch warnings
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  3 +--
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  9 +++------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 12 ++++--------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 18e4e5d84878..8d20b0deca37 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1112,9 +1112,8 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	if (cb_desc->bHwSec) {
 		static u8 tmp;
 
-		if (!tmp) {
+		if (!tmp)
 			tmp = 1;
-		}
 		switch (priv->rtllib->pairwise_key_type) {
 		case KEY_TYPE_WEP40:
 		case KEY_TYPE_WEP104:
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 1b592258e640..4e3d183be0f2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -522,9 +522,8 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
 		rtStatus  = rtl92e_check_bb_and_rf(dev,
 						   (enum hw90_block)eCheckItem,
 						   (enum rf90_radio_path)0);
-		if (!rtStatus) {
+		if (!rtStatus)
 			return rtStatus;
-		}
 	}
 	rtl92e_set_bb_reg(dev, rFPGA0_RFMOD, bCCKEn|bOFDMEn, 0x0);
 	_rtl92e_phy_config_bb(dev, BaseBand_Config_PHY_REG);
@@ -1379,9 +1378,8 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 					i++;
 				}
 
-				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
+				if (i >= MAX_DOZE_WAITING_TIMES_9x)
 					break;
-				}
 			}
 			rtl92e_set_rf_off(dev);
 			break;
@@ -1398,9 +1396,8 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 					i++;
 				}
 
-				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
+				if (i >= MAX_DOZE_WAITING_TIMES_9x)
 					break;
-				}
 			}
 
 			if (pPSC->RegRfPsLevel & RT_RF_OFF_LEVL_HALT_NIC &&
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 702551056227..641961a14c52 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -267,9 +267,8 @@ static void _rtl92e_dm_check_ac_dc_power(struct net_device *dev)
 			"PATH=/usr/bin:/bin",
 			 NULL};
 
-	if (priv->ResetProgress == RESET_TYPE_SILENT) {
+	if (priv->ResetProgress == RESET_TYPE_SILENT)
 		return;
-	}
 
 	if (priv->rtllib->state != RTLLIB_LINKED)
 		return;
@@ -330,9 +329,8 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	bool bshort_gi_enabled = false;
 	static u8 ping_rssi_state;
 
-	if (!priv->up) {
+	if (!priv->up)
 		return;
-	}
 
 	if (pra->rate_adaptive_disabled)
 		return;
@@ -777,9 +775,8 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
 					    bMaskDWord);
 		for (i = 0; i < OFDM_Table_Length; i++) {
-			if (tmpRegA == OFDMSwingTable[i]) {
+			if (tmpRegA == OFDMSwingTable[i])
 				priv->OFDM_index[0] = i;
-			}
 		}
 
 		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
@@ -1066,9 +1063,8 @@ void rtl92e_dm_restore_state(struct net_device *dev)
 	u32	reg_ratr = priv->rate_adaptive.last_ratr;
 	u32 ratr_value;
 
-	if (!priv->up) {
+	if (!priv->up)
 		return;
-	}
 
 	if (priv->rate_adaptive.rate_adaptive_disabled)
 		return;
-- 
2.30.2


