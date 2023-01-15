Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF666B3D3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjAOUWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjAOUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:21:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF8D1448D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:21:17 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id v6so20696621ejg.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+otSAik9O2Fw7DnAYDScejyC3Rd16+BHk2obm2UhJYE=;
        b=p8rSnuviDnbZz5yS4kcZbexgS3qS7RMQhjxTlO885SOnEZztqbC4A4aU2+fPa9UZ3F
         kbJwOR9qWMN3CKtsj7w2UZW84+Ii0GCmb7W91ks/LPukKdnMa/F6HAFnlSZ2xre6btmj
         2kPGZvLQwrx+VZmXz/+dnR3PW0hX7kCFbbzN8D/Q7fYgbVhB/70Zr7rONj0r/l0Ybm7s
         zOlP7pgLJU6OLHVHb1+Vv94g6gCbBeg77rnFJz2n7UUdd/h559Vfqu4+97SqFmxGlWKe
         q9UWyylQa6jxevsryivU2Hi8EMdewIS6ZDh631LaDm91IWwbaqZd8b3Ln1JGM1+8dDR2
         b0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+otSAik9O2Fw7DnAYDScejyC3Rd16+BHk2obm2UhJYE=;
        b=NhwOfCJVfZg89P86GWSMpq6QiYiw2mXfFqXuh0wvaT7WwJ9kiz7FCRRZedhjMoDSL4
         7riA/NFvY+/c4J4AwL/xAXgUN29fJDN5m3s1pWm6NyEtcYSLai1NvTPfglY5cLBsyGJD
         LTTUhXmn4sOTRviTaHDxK1SmIuUvi9wrokI6+SDhOpOqvvwLEePWfrG3TQJyNTG2gHIe
         Pu0o0Yei26PmjSrKfYFPqI3wvafihEjxvTUHhRXEU72VVEv+zapHOplyI0objU7YWBS0
         mWRYkS6QYX05qXVEWl/2IouNhXI2yCv08/k4Mv4M8k8IhqWj3Hg0WY9OPr/Wk6APGqtL
         Rggw==
X-Gm-Message-State: AFqh2kqmSCBBsGH2k4nzRx8VNuwU2xU2ejp/EH+1JOY1UoTFxXiCvDa8
        MqL5xhS8F5rQNcvpSKUigkk=
X-Google-Smtp-Source: AMrXdXsk9oUjf+CoVDOMmk2qoWhJvTl6GyzTbbtUnJdT5UcHvVf64Fm2DRXAkZ6GweVZaVzFYnGR4w==
X-Received: by 2002:a17:907:c018:b0:7b9:861b:9744 with SMTP id ss24-20020a170907c01800b007b9861b9744mr16723641ejc.1.1673814076360;
        Sun, 15 Jan 2023 12:21:16 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id kx4-20020a170907774400b007c10d47e748sm10947215ejc.36.2023.01.15.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 12:21:15 -0800 (PST)
Date:   Sun, 15 Jan 2023 21:21:14 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Rename EEPROMTxPower.., AutoloadF..
 and SilentReset..
Message-ID: <60c1fb2861143c8736f061cf85e737b78c210a09.1673812850.git.philipp.g.hortmann@gmail.com>
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

Rename variable SilentResetRxSlotIndex to silent_reset_rx_slot_index,
IC_Cut to ic_cut and Rf_Mode to rf_mode to avoid CamelCase which is not
accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 12 ++++++------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     |  8 ++++----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 8522a4b9b8f1..9cffe09e429c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -614,7 +614,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 start:
 	rtl92e_reset_desc_ring(dev);
-	priv->Rf_Mode = RF_OP_By_SW_3wire;
+	priv->rf_mode = RF_OP_By_SW_3wire;
 	if (priv->rst_progress == RESET_TYPE_NORESET) {
 		rtl92e_writeb(dev, ANAPAR, 0x37);
 		mdelay(500);
@@ -724,7 +724,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	}
 
 	tmpvalue = rtl92e_readb(dev, IC_VERRSION);
-	priv->IC_Cut = tmpvalue;
+	priv->ic_cut = tmpvalue;
 
 	bfirmwareok = rtl92e_init_fw(dev);
 	if (!bfirmwareok) {
@@ -760,14 +760,14 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	}
 
 	if (priv->rtllib->FwRWRF)
-		priv->Rf_Mode = RF_OP_By_FW;
+		priv->rf_mode = RF_OP_By_FW;
 	else
-		priv->Rf_Mode = RF_OP_By_SW_3wire;
+		priv->rf_mode = RF_OP_By_SW_3wire;
 
 	if (priv->rst_progress == RESET_TYPE_NORESET) {
 		rtl92e_dm_init_txpower_tracking(dev);
 
-		if (priv->IC_Cut >= IC_VersionCut_D) {
+		if (priv->ic_cut >= IC_VersionCut_D) {
 			tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
 						    bMaskDWord);
 			rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance, bMaskDWord);
@@ -2123,7 +2123,7 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	}
 
 
-	SlotIndex = (priv->SilentResetRxSlotIndex++)%SilentResetRxSoltNum;
+	SlotIndex = (priv->silent_reset_rx_slot_index++)%SilentResetRxSoltNum;
 
 	if (priv->rx_ctr == RegRxCounter) {
 		priv->silent_reset_rx_stuck_event[SlotIndex] = 1;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 6da76ea16ff1..97e859425784 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -203,7 +203,7 @@ void rtl92e_set_rf_reg(struct net_device *dev, enum rf90_radio_path eRFPath,
 	if (priv->rtllib->rf_power_state != rf_on && !priv->being_init_adapter)
 		return;
 
-	if (priv->Rf_Mode == RF_OP_By_FW) {
+	if (priv->rf_mode == RF_OP_By_FW) {
 		if (BitMask != bMask12Bits) {
 			Original_Value = _rtl92e_phy_rf_fw_read(dev, eRFPath,
 								RegAddr);
@@ -240,7 +240,7 @@ u32 rtl92e_get_rf_reg(struct net_device *dev, enum rf90_radio_path eRFPath,
 	if (priv->rtllib->rf_power_state != rf_on && !priv->being_init_adapter)
 		return	0;
 	mutex_lock(&priv->rf_mutex);
-	if (priv->Rf_Mode == RF_OP_By_FW) {
+	if (priv->rf_mode == RF_OP_By_FW) {
 		Original_Value = _rtl92e_phy_rf_fw_read(dev, eRFPath, RegAddr);
 		udelay(200);
 	} else {
@@ -533,7 +533,7 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
 
 	_rtl92e_phy_config_bb(dev, BaseBand_Config_AGC_TAB);
 
-	if (priv->IC_Cut  > VERSION_8190_BD) {
+	if (priv->ic_cut  > VERSION_8190_BD) {
 		if (priv->rf_type == RF_2T4R)
 			dwRegValue = priv->antenna_tx_pwr_diff[2] << 8 |
 				      priv->antenna_tx_pwr_diff[1] << 4 |
@@ -886,7 +886,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				continue;
 			switch (CurrentCmd->CmdID) {
 			case CmdID_SetTxPowerLevel:
-				if (priv->IC_Cut > VERSION_8190_BD)
+				if (priv->ic_cut > VERSION_8190_BD)
 					_rtl92e_set_tx_power_level(dev,
 								   channel);
 				break;
@@ -1088,7 +1088,7 @@ static void _rtl92e_cck_tx_power_track_bw_switch(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->IC_Cut >= IC_VersionCut_D)
+	if (priv->ic_cut >= IC_VersionCut_D)
 		_rtl92e_cck_tx_power_track_bw_switch_tssi(dev);
 	else
 		_rtl92e_cck_tx_power_track_bw_switch_thermal(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index bd524a818776..d86577277844 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -396,16 +396,16 @@ struct r8192_priv {
 
 	u32 irq_mask[2];
 
-	u8 Rf_Mode;
+	u8 rf_mode;
 	enum nic_t card_8192;
 	u8 card_8192_version;
 
 	u8 rf_type;
-	u8 IC_Cut;
+	u8 ic_cut;
 	char nick[IW_ESSID_MAX_SIZE + 1];
 	u8 check_roaming_cnt;
 
-	u32 SilentResetRxSlotIndex;
+	u32 silent_reset_rx_slot_index;
 	u32 silent_reset_rx_stuck_event[MAX_SILENT_RESET_RX_SLOT_NUM];
 
 	u16 basic_rate;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 96c45e5172bd..63be5f2872c6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -857,7 +857,7 @@ void rtl92e_dm_txpower_tracking_wq(void *data)
 				  struct r8192_priv, txpower_tracking_wq);
 	struct net_device *dev = priv->rtllib->dev;
 
-	if (priv->IC_Cut >= IC_VersionCut_D)
+	if (priv->ic_cut >= IC_VersionCut_D)
 		_rtl92e_dm_tx_power_tracking_callback_tssi(dev);
 	else
 		_rtl92e_dm_tx_power_tracking_cb_thermal(dev);
@@ -891,7 +891,7 @@ void rtl92e_dm_init_txpower_tracking(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->IC_Cut >= IC_VersionCut_D)
+	if (priv->ic_cut >= IC_VersionCut_D)
 		_rtl92e_dm_initialize_tx_power_tracking_tssi(dev);
 	else
 		_rtl92e_dm_init_tx_power_tracking_thermal(dev);
@@ -952,7 +952,7 @@ static void _rtl92e_dm_check_tx_power_tracking(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->IC_Cut >= IC_VersionCut_D)
+	if (priv->ic_cut >= IC_VersionCut_D)
 		_rtl92e_dm_check_tx_power_tracking_tssi(dev);
 	else
 		_rtl92e_dm_check_tx_power_tracking_thermal(dev);
@@ -1038,7 +1038,7 @@ void rtl92e_dm_cck_txpower_adjust(struct net_device *dev, bool binch14)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->IC_Cut >= IC_VersionCut_D)
+	if (priv->ic_cut >= IC_VersionCut_D)
 		_rtl92e_dm_cck_tx_power_adjust_tssi(dev, binch14);
 	else
 		_rtl92e_dm_cck_tx_power_adjust_thermal_meter(dev, binch14);
-- 
2.39.0

