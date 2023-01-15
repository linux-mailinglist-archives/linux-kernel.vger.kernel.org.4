Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2236866B3D0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjAOUVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAOUV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:21:26 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FC012F24
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:21:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bk15so6207332ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIxHz0r1/Yq7Juo2j3DUvAGGJxlMsy7WNAR58hhY6OM=;
        b=NYi/Bs8CBj2l9N41+UF6lF0VbthfjqI9PnVAnp0jaqm4VWm8RLGygg90ZiQTOi0eLn
         T/9XiR7vNKS2HK1BckW6TwnP5w0UnFOy5m8bAgQ9alDTDKDcqKJgFOPCTuy4MbwoHHDU
         +buYWwx6mC4ZmnJ4IsAlzG+aReczuE7VHpRZdQV5SEeNCcWXkq9qUL8EUgtu0NIWkd78
         gdh0BIM9M/ttIvPFNVOJvc9bzltBSmG5txqLw4APi/dO/uyQ+3xkCQJW/goWcu/O1aUO
         JLWdvKnJUkFDOCLfKAK1d64isNPY1cbQ7K35rBPQDgtaQEwpjlT2dPn2AqkiKEQRsK9S
         kjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIxHz0r1/Yq7Juo2j3DUvAGGJxlMsy7WNAR58hhY6OM=;
        b=3Bh4Gw3946EH7qWnb7f10Hh4fsRh9//GxUr3ZOmcT8qETI841HVweBGysEhU1O365q
         AdCGI0FszzFWYyZkX6gImfG1YmJH/JvQ1Y0Lxn0jA5pTxJZg0eo5tsoHfJXkB8+1cFeY
         Z6jQGyw/6SvHIf+AadtE20qpP9/aBBPaNJlspBvoEPMhp3jTRlXCFQ6pIUsYgz7awTwc
         vx+xclky2F0+FdI2GmfTwr60ypgc7IPIAw7LRLwHUolqVZxgkB49D7S74Ln+or1vJBxp
         9rJs4bb3xxiInMwNVbQysaYSC6ULn/6MYB3yDYz0qzQrlDPQvoxjbQWJybTiT9ErH6Nl
         QiAg==
X-Gm-Message-State: AFqh2kpsASEWmIeQHFazPHMWFAXlSG45oUkks7VD971Qx5ieA4U2K/Xg
        Oi69nCa5v/vYLRF4QdngTsCTWyZl1w8=
X-Google-Smtp-Source: AMrXdXut9KkjM2r4GrMHz35eEONHDU14UYIgGtIqFJdrxkRqzyZ0lbS6+k4GeCXjLdeQE9VREBnJgw==
X-Received: by 2002:a17:906:280d:b0:837:c290:eb83 with SMTP id r13-20020a170906280d00b00837c290eb83mr19100862ejc.2.1673814069409;
        Sun, 15 Jan 2023 12:21:09 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0077a8fa8ba55sm10928478ejf.210.2023.01.15.12.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 12:21:08 -0800 (PST)
Date:   Sun, 15 Jan 2023 21:21:07 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging: rtl8192e: Rename EEPROMTxPower.., AutoloadF..
 and SilentReset..
Message-ID: <328bdd5fd16ba000d2083473e16e89ce2e2521ee.1673812850.git.philipp.g.hortmann@gmail.com>
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

Rename variable EEPROMTxPowerLevelCCK to eeprom_tx_pwr_level_cck,
AutoloadFailFlag to autoload_fail_flag and SilentResetRxStuckEvent to
silent_reset_rx_stuck_event to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 30 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  6 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 655a7966a876..8522a4b9b8f1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -292,12 +292,12 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	if (EEPROMId != RTL8190_EEPROM_ID) {
 		netdev_err(dev, "%s(): Invalid EEPROM ID: %x\n", __func__,
 			   EEPROMId);
-		priv->AutoloadFailFlag = true;
+		priv->autoload_fail_flag = true;
 	} else {
-		priv->AutoloadFailFlag = false;
+		priv->autoload_fail_flag = false;
 	}
 
-	if (!priv->AutoloadFailFlag) {
+	if (!priv->autoload_fail_flag) {
 		priv->eeprom_vid = rtl92e_eeprom_read(dev, EEPROM_VID >> 1);
 		priv->eeprom_did = rtl92e_eeprom_read(dev, EEPROM_DID >> 1);
 
@@ -331,7 +331,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->eeprom_chnl_plan = 0;
 	}
 
-	if (!priv->AutoloadFailFlag) {
+	if (!priv->autoload_fail_flag) {
 		u8 addr[ETH_ALEN];
 
 		for (i = 0; i < 6; i += 2) {
@@ -352,7 +352,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	priv->rf_type = RTL819X_DEFAULT_RF_TYPE;
 
 	if (priv->card_8192_version > VERSION_8190_BD) {
-		if (!priv->AutoloadFailFlag) {
+		if (!priv->autoload_fail_flag) {
 			tempval = (rtl92e_eeprom_read(dev,
 						      (EEPROM_RFInd_PowerDiff >> 1))) & 0xff;
 			priv->eeprom_legacy_ht_tx_pwr_diff = tempval & 0xf;
@@ -365,7 +365,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 			priv->eeprom_legacy_ht_tx_pwr_diff = 0x04;
 		}
 
-		if (!priv->AutoloadFailFlag)
+		if (!priv->autoload_fail_flag)
 			priv->eeprom_thermal_meter = ((rtl92e_eeprom_read(dev,
 						   (EEPROM_ThermalMeter>>1))) &
 						   0xff00) >> 8;
@@ -374,7 +374,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->tssi_13dBm = priv->eeprom_thermal_meter * 100;
 
 		if (priv->epromtype == EEPROM_93C46) {
-			if (!priv->AutoloadFailFlag) {
+			if (!priv->autoload_fail_flag) {
 				usValue = rtl92e_eeprom_read(dev,
 					  EEPROM_TxPwDiff_CrystalCap >> 1);
 				priv->eeprom_ant_pwr_diff = usValue & 0x0fff;
@@ -388,16 +388,16 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 			}
 
 			for (i = 0; i < 14; i += 2) {
-				if (!priv->AutoloadFailFlag)
+				if (!priv->autoload_fail_flag)
 					usValue = rtl92e_eeprom_read(dev,
 						  (EEPROM_TxPwIndex_CCK + i) >> 1);
 				else
 					usValue = EEPROM_Default_TxPower;
-				*((u16 *)(&priv->EEPROMTxPowerLevelCCK[i])) =
+				*((u16 *)(&priv->eeprom_tx_pwr_level_cck[i])) =
 								 usValue;
 			}
 			for (i = 0; i < 14; i += 2) {
-				if (!priv->AutoloadFailFlag)
+				if (!priv->autoload_fail_flag)
 					usValue = rtl92e_eeprom_read(dev,
 						(EEPROM_TxPwIndex_OFDM_24G + i) >> 1);
 				else
@@ -409,7 +409,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		if (priv->epromtype == EEPROM_93C46) {
 			for (i = 0; i < 14; i++) {
 				priv->tx_pwr_level_cck[i] =
-					 priv->EEPROMTxPowerLevelCCK[i];
+					 priv->eeprom_tx_pwr_level_cck[i];
 				priv->tx_pwr_level_ofdm_24g[i] =
 					 priv->eeprom_tx_pwr_level_ofdm24g[i];
 			}
@@ -2126,21 +2126,21 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	SlotIndex = (priv->SilentResetRxSlotIndex++)%SilentResetRxSoltNum;
 
 	if (priv->rx_ctr == RegRxCounter) {
-		priv->SilentResetRxStuckEvent[SlotIndex] = 1;
+		priv->silent_reset_rx_stuck_event[SlotIndex] = 1;
 
 		for (i = 0; i < SilentResetRxSoltNum; i++)
-			TotalRxStuckCount += priv->SilentResetRxStuckEvent[i];
+			TotalRxStuckCount += priv->silent_reset_rx_stuck_event[i];
 
 		if (TotalRxStuckCount == SilentResetRxSoltNum) {
 			bStuck = true;
 			for (i = 0; i < SilentResetRxSoltNum; i++)
 				TotalRxStuckCount +=
-					 priv->SilentResetRxStuckEvent[i];
+					 priv->silent_reset_rx_stuck_event[i];
 		}
 
 
 	} else {
-		priv->SilentResetRxStuckEvent[SlotIndex] = 0;
+		priv->silent_reset_rx_stuck_event[SlotIndex] = 0;
 	}
 
 	priv->rx_ctr = RegRxCounter;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 9cb717892dcb..bd524a818776 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -406,7 +406,7 @@ struct r8192_priv {
 	u8 check_roaming_cnt;
 
 	u32 SilentResetRxSlotIndex;
-	u32 SilentResetRxStuckEvent[MAX_SILENT_RESET_RX_SLOT_NUM];
+	u32 silent_reset_rx_stuck_event[MAX_SILENT_RESET_RX_SLOT_NUM];
 
 	u16 basic_rate;
 	u8 short_preamble;
@@ -414,7 +414,7 @@ struct r8192_priv {
 	u8 slot_time;
 	u16 SifsTime;
 
-	bool AutoloadFailFlag;
+	bool autoload_fail_flag;
 
 	short	epromtype;
 	u16 eeprom_vid;
@@ -422,7 +422,7 @@ struct r8192_priv {
 	u8 eeprom_CustomerID;
 	u16 eeprom_chnl_plan;
 
-	u8 EEPROMTxPowerLevelCCK[14];
+	u8 eeprom_tx_pwr_level_cck[14];
 	u8 eeprom_tx_pwr_level_ofdm24g[14];
 	u8 EEPROMRfACCKChnl1TxPwLevel[3];
 	u8 EEPROMRfAOfdmChnlTxPwLevel[3];
-- 
2.39.0

