Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE6717639
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjEaFbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjEaFbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:31:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7EE121
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:31:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f5d651170so114714566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685511099; x=1688103099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Mr5vbs4/XaILvuDoJVrNI2Kkx3f3rCAozsjtLr9BM=;
        b=nCQc5Ybv4eh8XoJdkHvwCl80tIlWOVhKXFfEewYpIg8ULljqf/UaevgpSIyGVMVFlT
         GxMMeB61wgN8T60QAD/BAv+r0NZWLvdkuDf+1pD3UKBCMzOMuSIpsp743MLl/whsE8OL
         29T3v+hMMvAlxzwLeTN+uQrVm+WfijNNldANbCyAVMqB3JnZ2CixCoEZv32WwYQRXZix
         SbJAq36oe1dzOSzWN30xD4bkB0lhJvlXgJyxlzn+swz5iDG2zx8tt0yD2gLnqdNRClxt
         n+ZBmimA/xNqEbfg71eBjKZLFRrj1kYjxcasB/a9S8VuuMxItA7PUlYngC22Lj0sIdnT
         zvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685511099; x=1688103099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/Mr5vbs4/XaILvuDoJVrNI2Kkx3f3rCAozsjtLr9BM=;
        b=XEkmMr0lF+TwFbJmXPN34INAmpn85+dVlL4NbWYoBLsAOWbOZ9OV6LrGNOJ3ghw10K
         m25Ub+tt7fnitHhIUHRIbV5Wuuebimp+KSod33byU4QXH+AR1NO0kU0+VTEPm8dC+nFl
         kROdnd+pAfk8P+y6/R7JghE6VJNuUoS3DYOLsxefmNRmY0h34UfoD8wZY5nkhailqLVL
         MSOJuvWK2IXnGtJWMaXmapJQXjqpt+sNJbluJPV6j/sgVbbNgOGEC6bJcSQzPZLSc2mu
         CNcr/lHgwLq1lDbn+3b/6bOZSYG6L6ILoOBWUBMZ67ZxesbrOzxPfYL+w7qN+4ouv9a9
         KGaw==
X-Gm-Message-State: AC+VfDw1AH97HW2tEfVIJa66zNirhirqmC/2x8WjEk0/hlKNW+I3l3fk
        Kb7CdG1rp/B1Vx0jLPDHVFg=
X-Google-Smtp-Source: ACHHUZ6M1XQUh6jSKibl+9gp/9YEGNhDGcW2QwohW7fbp52oxcrz9XfuKZlnE/QtbchohYwWPmpALQ==
X-Received: by 2002:a17:906:6a27:b0:973:940e:a00d with SMTP id qw39-20020a1709066a2700b00973940ea00dmr4992523ejc.31.1685511098404;
        Tue, 30 May 2023 22:31:38 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbb4.dynamic.kabel-deutschland.de. [95.90.187.180])
        by smtp.gmail.com with ESMTPSA id g7-20020aa7c847000000b005106975c7a1sm5329164edt.23.2023.05.30.22.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 22:31:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8192e: remove blank lines
Date:   Wed, 31 May 2023 07:31:18 +0200
Message-Id: <20230531053118.17053-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8190P_def.h    |  8 ---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 16 ------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 20 -------
 .../staging/rtl8192e/rtl8192e/r8192E_phyreg.h |  4 --
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |  2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 29 -----------
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c    |  2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  1 -
 drivers/staging/rtl8192e/rtl819x_HT.h         |  6 ---
 drivers/staging/rtl8192e/rtl819x_Qos.h        |  1 -
 drivers/staging/rtl8192e/rtl819x_TS.h         |  2 -
 drivers/staging/rtl8192e/rtllib.h             |  3 --
 drivers/staging/rtl8192e/rtllib_softmac.c     | 52 -------------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  | 16 ------
 14 files changed, 162 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index 385cca79f484..c229fd244a48 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -85,7 +85,6 @@ enum rtl819x_loopback {
 #define HAL_PRIME_CHNL_OFFSET_LOWER		1
 #define HAL_PRIME_CHNL_OFFSET_UPPER		2
 
-
 enum version_8190_loopback {
 	VERSION_8190_BD = 0x3,
 	VERSION_8190_BE
@@ -139,8 +138,6 @@ struct tx_fwinfo_8190pci {
 	u32			Retry_Limit:4;
 	u32			Reserved2:1;
 	u32			PacketID:13;
-
-
 };
 
 struct phy_ofdm_rx_status_rxsc_sgien_exintfflag {
@@ -172,7 +169,6 @@ struct phy_sts_cck_819xpci {
 	u8	cck_agc_rpt;
 };
 
-
 #define		PHY_RSSI_SLID_WIN_MAX				100
 #define		PHY_Beacon_RSSI_SLID_WIN_MAX		10
 
@@ -214,7 +210,6 @@ struct tx_desc {
 	u32	Reserved7;
 };
 
-
 struct tx_desc_cmd {
 	u16	PktSize;
 	u8	Reserved1;
@@ -256,10 +251,8 @@ struct rx_desc {
 	u32			Reserved3;
 
 	u32	BufferAddress;
-
 };
 
-
 struct rx_fwinfo {
 	u16			Reserved1:12;
 	u16			PartAggr:1;
@@ -278,7 +271,6 @@ struct rx_fwinfo {
 	u8			Reserved4:1;
 
 	u32			TSFL;
-
 };
 
 #endif
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index f9b6c3069b30..ce51a6a7c2ec 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -107,7 +107,6 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 		}
 
 		rtl92e_writeb(dev, MSR, btMsr);
-
 	}
 	break;
 
@@ -126,7 +125,6 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 
 		rtl92e_writel(dev, RCR, RegRCR);
 		priv->receive_config = RegRCR;
-
 	}
 	break;
 
@@ -266,7 +264,6 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 	default:
 		break;
 	}
-
 }
 
 static void _rtl92e_read_eeprom_info(struct net_device *dev)
@@ -714,7 +711,6 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 static void _rtl92e_net_update(struct net_device *dev)
 {
-
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_network *net;
 	u16 BcnTimeCfg = 0, BcnCW = 6, BcnIFS = 0xf;
@@ -1006,7 +1002,6 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	pdesc->SecCAMID = 0;
 	pdesc->RATid = cb_desc->ratr_index;
 
-
 	pdesc->NoEnc = 1;
 	pdesc->SecType = 0x0;
 	if (cb_desc->bHwSec) {
@@ -1213,7 +1208,6 @@ static long _rtl92e_signal_scale_mapping(struct r8192_priv *priv, long currsig)
 	return retsig;
 }
 
-
 #define	 rx_hal_is_cck_rate(_pdrvinfo)\
 			((_pdrvinfo->RxRate == DESC90_RATE1M ||\
 			_pdrvinfo->RxRate == DESC90_RATE2M ||\
@@ -1261,7 +1255,6 @@ static void _rtl92e_query_rxphystatus(
 		check_reg824 = 1;
 	}
 
-
 	prxpkt = (u8 *)pdrvinfo;
 
 	prxpkt += sizeof(struct rx_fwinfo);
@@ -1368,7 +1361,6 @@ static void _rtl92e_query_rxphystatus(
 			}
 		}
 
-
 		rx_pwr_all = (((pofdm_buf->pwdb_all) >> 1) & 0x7f) - 106;
 		pwdb_all = rtl92e_rx_db_to_percent(rx_pwr_all);
 
@@ -1485,7 +1477,6 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		}
 	}
 
-
 	if (prev_st->bPacketBeacon) {
 		if (slide_beacon_adc_pwdb_statistics++ >=
 		    PHY_Beacon_RSSI_SLID_WIN_MAX) {
@@ -1761,7 +1752,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
 	skb_trim(skb, skb->len - S_CRC_LEN);
 
-
 	stats->packetlength = stats->Length - 4;
 	stats->fraglength = stats->packetlength;
 	stats->fragoffset = 0;
@@ -1802,7 +1792,6 @@ void rtl92e_stop_adapter(struct net_device *dev, bool reset)
 			rtl92e_writel(dev, WFCRC1, 0xffffffff);
 			rtl92e_writel(dev, WFCRC2, 0xffffffff);
 
-
 			rtl92e_writeb(dev, PMR, 0x5);
 			rtl92e_writeb(dev, MAC_BLK_CTRL, 0xa);
 		}
@@ -1897,7 +1886,6 @@ void rtl92e_enable_irq(struct net_device *dev)
 	priv->irq_enabled = 1;
 
 	rtl92e_writel(dev, INTA_MASK, priv->irq_mask[0]);
-
 }
 
 void rtl92e_disable_irq(struct net_device *dev)
@@ -1929,7 +1917,6 @@ void rtl92e_enable_tx(struct net_device *dev)
 		rtl92e_writel(dev, TX_DESC_BASE[i], priv->tx_ring[i].dma);
 }
 
-
 void rtl92e_ack_irq(struct net_device *dev, u32 *p_inta, u32 *p_intb)
 {
 	*p_inta = rtl92e_readl(dev, ISR);
@@ -1971,7 +1958,6 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 		rx_chk_cnt = 0;
 	}
 
-
 	SlotIndex = (priv->silent_reset_rx_slot_index++) % SilentResetRxSoltNum;
 
 	if (priv->rx_ctr == RegRxCounter) {
@@ -1986,8 +1972,6 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 				TotalRxStuckCount +=
 					 priv->silent_reset_rx_stuck_event[i];
 		}
-
-
 	} else {
 		priv->silent_reset_rx_stuck_event[SlotIndex] = 0;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 641e993aaa86..7b0da55fa7aa 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -32,7 +32,6 @@ static u32 _rtl92e_calculate_bit_shift(u32 dwBitMask)
 void rtl92e_set_bb_reg(struct net_device *dev, u32 dwRegAddr, u32 dwBitMask,
 		       u32 dwData)
 {
-
 	u32 OriginalValue, BitShift, NewValue;
 
 	if (dwBitMask != bMaskDWord) {
@@ -99,7 +98,6 @@ static u32 _rtl92e_phy_rf_read(struct net_device *dev,
 	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0x300, 0x3);
 
 	return ret;
-
 }
 
 static void _rtl92e_phy_rf_write(struct net_device *dev,
@@ -226,7 +224,6 @@ static u32 _rtl92e_phy_rf_fw_read(struct net_device *dev,
 			return 0;
 	}
 	return rtl92e_readl(dev, RF_DATA);
-
 }
 
 static void _rtl92e_phy_rf_fw_write(struct net_device *dev,
@@ -247,10 +244,8 @@ static void _rtl92e_phy_rf_fw_write(struct net_device *dev,
 			break;
 	}
 	rtl92e_writel(dev, QPNR, Data);
-
 }
 
-
 void rtl92e_config_mac(struct net_device *dev)
 {
 	u32 dwArrayLen = 0, i = 0;
@@ -272,7 +267,6 @@ void rtl92e_config_mac(struct net_device *dev)
 				  pdwArray[i + 2]);
 	}
 	return;
-
 }
 
 static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
@@ -370,7 +364,6 @@ bool rtl92e_check_bb_and_rf(struct net_device *dev, enum hw90_block CheckBlock,
 			break;
 		}
 
-
 		if (dwRegRead != WriteData[i]) {
 			netdev_warn(dev, "%s(): Check failed.\n", __func__);
 			ret = false;
@@ -415,7 +408,6 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
 		rtl92e_set_bb_reg(dev, rFPGA0_TxGainStage,
 				  (bXBTxAGC | bXCTxAGC | bXDTxAGC), dwRegValue);
 
-
 		dwRegValue = priv->crystal_cap;
 		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1, bXtalCap92x,
 				  dwRegValue);
@@ -470,7 +462,6 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 
 u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 {
-
 	int i;
 
 	switch (eRFPath) {
@@ -483,7 +474,6 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIO_A_ARR[i],
 					  bMask12Bits,
 					  RTL8192E_RADIO_A_ARR[i + 1]);
-
 		}
 		break;
 	case RF90_PATH_B:
@@ -495,7 +485,6 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIO_B_ARR[i],
 					  bMask12Bits,
 					  RTL8192E_RADIO_B_ARR[i + 1]);
-
 		}
 		break;
 	default:
@@ -503,7 +492,6 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 	}
 
 	return 0;
-
 }
 
 static void _rtl92e_set_tx_power_level(struct net_device *dev, u8 channel)
@@ -677,7 +665,6 @@ static void _rtl92e_phy_switch_channel(struct net_device *dev, u8 channel)
 
 static void _rtl92e_phy_switch_channel_work_item(struct net_device *dev)
 {
-
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	_rtl92e_phy_switch_channel(dev, priv->chan);
@@ -694,7 +681,6 @@ u8 rtl92e_set_channel(struct net_device *dev, u8 channel)
 	if (priv->sw_chnl_in_progress)
 		return false;
 
-
 	switch (priv->rtllib->mode) {
 	case WIRELESS_MODE_B:
 		if (channel > 14) {
@@ -824,7 +810,6 @@ static void _rtl92e_cck_tx_power_track_bw_switch(struct net_device *dev)
 
 static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 {
-
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 regBwOpMode;
 
@@ -890,7 +875,6 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 		netdev_err(dev, "%s(): unknown Bandwidth: %#X\n", __func__,
 			   priv->current_chnl_bw);
 		break;
-
 	}
 
 	rtl92e_set_bandwidth(dev, priv->current_chnl_bw);
@@ -904,7 +888,6 @@ void rtl92e_set_bw_mode(struct net_device *dev, enum ht_channel_width bandwidth,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-
 	if (priv->set_bw_mode_in_progress)
 		return;
 
@@ -921,7 +904,6 @@ void rtl92e_set_bw_mode(struct net_device *dev, enum ht_channel_width bandwidth,
 		priv->n_cur_40mhz_prime_sc = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	_rtl92e_set_bw_mode_work_item(dev);
-
 }
 
 void rtl92e_init_gain(struct net_device *dev, u8 Operation)
@@ -993,7 +975,6 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 
 void rtl92e_set_rf_off(struct net_device *dev)
 {
-
 	rtl92e_set_bb_reg(dev, rFPGA0_XA_RFInterfaceOE, BIT4, 0x0);
 	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0x300, 0x0);
 	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1, 0x18, 0x0);
@@ -1002,7 +983,6 @@ void rtl92e_set_rf_off(struct net_device *dev)
 	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1, 0x60, 0x0);
 	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1, 0x4, 0x0);
 	rtl92e_writeb(dev, ANAPAR_FOR_8192PCIE, 0x07);
-
 }
 
 static bool _rtl92e_set_rf_power_state(struct net_device *dev,
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index e1b30fbdf8cc..65365ebe4e85 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -7,7 +7,6 @@
 #ifndef _R819XU_PHYREG_H
 #define _R819XU_PHYREG_H
 
-
 #define RF_DATA			0x1d4
 
 #define rPMAC_Reset		0x100
@@ -125,7 +124,6 @@
 #define rOFDM0_TxCoeff5			0xcb4
 #define rOFDM0_TxCoeff6			0xcb8
 
-
 #define rOFDM1_LSTF			0xd00
 #define rOFDM1_TRxPathEnable		0xd04
 #define rOFDM1_CFO			0xd08
@@ -163,7 +161,6 @@
 #define rTxAGC_Mcs11_Mcs08		0xe18
 #define rTxAGC_Mcs15_Mcs12		0xe1c
 
-
 #define rZebra1_HSSIEnable		0x0
 #define rZebra1_TRxEnable1		0x1
 #define rZebra1_TRxEnable2		0x2
@@ -819,7 +816,6 @@
 #define bOFDMPHY0_End	0xcff
 #define bOFDMPHY1_End	0xdff
 
-
 #define bPMACControl	0x0
 #define bWMACControl	0x1
 #define bWNICControl	0x2
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index a4d65b4d99c2..6d9e5c27017d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -101,7 +101,6 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	else
 		usConfig |= BIT15 | (KeyType << 2) | KeyIndex;
 
-
 	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
 		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
 		TargetCommand |= BIT31 | BIT16;
@@ -149,7 +148,6 @@ void rtl92e_cam_restore(struct net_device *dev)
 
 	if ((priv->rtllib->pairwise_key_type == KEY_TYPE_WEP40) ||
 	    (priv->rtllib->pairwise_key_type == KEY_TYPE_WEP104)) {
-
 		for (EntryId = 0; EntryId < 4; EntryId++) {
 			MacAddr = CAM_CONST_ADDR[EntryId];
 			if (priv->rtllib->swcamtable[EntryId].bused) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 893614bf32aa..219ff7685c15 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -159,7 +159,6 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev);
 static void _rtl92e_dm_init_bandwidth_autoswitch(struct net_device *dev);
 static	void	_rtl92e_dm_bandwidth_autoswitch(struct net_device *dev);
 
-
 static	void	_rtl92e_dm_check_tx_power_tracking(struct net_device *dev);
 
 static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev);
@@ -179,7 +178,6 @@ static void _rtl92e_dm_check_rx_path_selection(struct net_device *dev);
 static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev);
 static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev);
 
-
 static void _rtl92e_dm_init_fsync(struct net_device *dev);
 static void _rtl92e_dm_deinit_fsync(struct net_device *dev);
 
@@ -219,9 +217,7 @@ void rtl92e_dm_init(struct net_device *dev)
 
 void rtl92e_dm_deinit(struct net_device *dev)
 {
-
 	_rtl92e_dm_deinit_fsync(dev);
-
 }
 
 void rtl92e_dm_watchdog(struct net_device *dev)
@@ -250,7 +246,6 @@ void rtl92e_dm_watchdog(struct net_device *dev)
 
 void rtl92e_init_adaptive_rate(struct net_device *dev)
 {
-
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rate_adaptive *pra = &priv->rate_adaptive;
 
@@ -297,7 +292,6 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 		return;
 
 	if (priv->rtllib->state == RTLLIB_LINKED) {
-
 		bshort_gi_enabled = (ht_info->cur_tx_bw40mhz &&
 				     ht_info->bCurShortGI40MHz) ||
 				    (!ht_info->cur_tx_bw40mhz &&
@@ -524,7 +518,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	priv->rtllib->bdynamic_txpower_enable = false;
 
 	for (j = 0; j <= 30; j++) {
-
 		tx_cmd.op	= TXCMD_SET_TX_PWR_TRACKING;
 		tx_cmd.length	= 4;
 		tx_cmd.value	= priv->pwr_track >> 24;
@@ -756,20 +749,17 @@ void rtl92e_dm_txpower_tracking_wq(void *data)
 
 static void _rtl92e_dm_initialize_tx_power_tracking_tssi(struct net_device *dev)
 {
-
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	priv->btxpower_tracking = true;
 	priv->txpower_count       = 0;
 	priv->tx_pwr_tracking_init = false;
-
 }
 
 static void _rtl92e_dm_init_tx_power_tracking_thermal(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-
 	if (priv->rtllib->FwRWRF)
 		priv->btxpower_tracking = true;
 	else
@@ -799,12 +789,10 @@ static void _rtl92e_dm_check_tx_power_tracking_tssi(struct net_device *dev)
 		return;
 	tx_power_track_counter++;
 
-
 	if (tx_power_track_counter >= 180) {
 		schedule_delayed_work(&priv->txpower_tracking_wq, 0);
 		tx_power_track_counter = 0;
 	}
-
 }
 
 static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
@@ -833,7 +821,6 @@ static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
 	netdev_info(dev, "===============>Schedule TxPowerTrackingWorkItem\n");
 	schedule_delayed_work(&priv->txpower_tracking_wq, 0);
 	TM_Trigger = 0;
-
 }
 
 static void _rtl92e_dm_check_tx_power_tracking(struct net_device *dev)
@@ -965,7 +952,6 @@ void rtl92e_dm_restore_state(struct net_device *dev)
 		_rtl92e_dm_tx_power_reset_recovery(dev);
 
 	_rtl92e_dm_bb_initialgain_restore(dev);
-
 }
 
 static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
@@ -989,7 +975,6 @@ static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
 	rtl92e_set_bb_reg(dev, rCCK0_CCA, bit_mask,
 			  (u32)priv->initgain_backup.cca);
 	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
-
 }
 
 void rtl92e_dm_backup_state(struct net_device *dev)
@@ -1043,7 +1028,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 
 static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
 {
-
 	if (!dm_digtable.dig_enable_flag)
 		return;
 
@@ -1096,7 +1080,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 	else
 		dm_digtable.cur_sta_connect_state = DIG_STA_DISCONNECT;
 
-
 	dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
 	_rtl92e_dm_initial_gain(dev);
 	_rtl92e_dm_pd_th(dev);
@@ -1104,7 +1087,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 	if (dm_digtable.dig_algorithm_switch)
 		dm_digtable.dig_algorithm_switch = 0;
 	dm_digtable.pre_sta_connect_state = dm_digtable.cur_sta_connect_state;
-
 }
 
 static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
@@ -1194,7 +1176,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 	_rtl92e_dm_ctrl_initgain_byrssi_highpwr(dev);
 }
 
-
 static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -1392,7 +1373,6 @@ static void _rtl92e_dm_cs_ratio(struct net_device *dev)
 		reset_cnt = priv->reset_count;
 	}
 
-
 	if ((dm_digtable.precs_ratio_state != dm_digtable.curcs_ratio_state) ||
 	    !initialized || force_write) {
 		if (dm_digtable.curcs_ratio_state == DIG_CS_RATIO_LOWER)
@@ -1474,7 +1454,6 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 						      edca_setting_UL[ht_info->IOTPeer]);
 					priv->bis_cur_rdlstate = false;
 				}
-
 			}
 
 			priv->bcurrent_turbo_EDCA = true;
@@ -1489,7 +1468,6 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 		}
 	}
 
-
 dm_CheckEdcaTurbo_EXIT:
 	priv->rtllib->bis_any_nonbepkts = false;
 	lastTxOkCnt = priv->stats.txbytesunicast;
@@ -1746,7 +1724,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 						tmp_cck_min_pwdb = cur_cck_pwdb;
 					}
 				}
-
 			}
 		}
 	}
@@ -1812,7 +1789,6 @@ static void _rtl92e_dm_check_rx_path_selection(struct net_device *dev)
 	schedule_delayed_work(&priv->rfpath_check_wq, 0);
 }
 
-
 static void _rtl92e_dm_init_fsync(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -1829,7 +1805,6 @@ static void _rtl92e_dm_init_fsync(struct net_device *dev)
 	timer_setup(&priv->fsync_timer, _rtl92e_dm_fsync_timer_callback, 0);
 }
 
-
 static void _rtl92e_dm_deinit_fsync(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -1864,7 +1839,6 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
 		else
 			rate_count_diff = rate_count - priv->rate_record;
 		if (rate_count_diff < priv->rate_count_diff_rec) {
-
 			u32 DiffNum = priv->rate_count_diff_rec -
 				      rate_count_diff;
 			if (DiffNum >=
@@ -2005,7 +1979,6 @@ static void _rtl92e_dm_start_sw_fsync(struct net_device *dev)
 	add_timer(&priv->fsync_timer);
 
 	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c12cd);
-
 }
 
 static void _rtl92e_dm_check_fsync(struct net_device *dev)
@@ -2048,7 +2021,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 			case SW_Fsync:
 			default:
 				break;
-
 			}
 		}
 		if (reg_c38_State != RegC38_Fsync_AP_BCM) {
@@ -2164,7 +2136,6 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 	}
 	priv->last_dtp_flag_high = priv->dynamic_tx_high_pwr;
 	priv->last_dtp_flag_low = priv->dynamic_tx_low_pwr;
-
 }
 
 static void _rtl92e_dm_check_txrateandretrycount(struct net_device *dev)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
index 9c80dc1b6e12..d124b5eee0cc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
@@ -9,7 +9,6 @@
 #include "r8190P_rtl8256.h"
 #include "rtl_pm.h"
 
-
 int rtl92e_suspend(struct device *dev_d)
 {
 	struct net_device *dev = dev_get_drvdata(dev_d);
@@ -62,7 +61,6 @@ int rtl92e_resume(struct device *dev_d)
 
 	netdev_info(dev, "================>r8192E resume call.\n");
 
-
 	pci_read_config_dword(pdev, 0x40, &val);
 	if ((val & 0x0000ff00) != 0)
 		pci_write_config_dword(pdev, 0x40, val & 0xffff00ff);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 54a21c14cc75..6e372f5a5ec7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -216,7 +216,6 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 
 	if (psc->bLeisurePs) {
 		if (psc->LpsIdleCount >= RT_CHECK_FOR_HANG_PERIOD) {
-
 			if (priv->rtllib->ps == RTLLIB_PS_DISABLED)
 				_rtl92e_ps_set_mode(dev, RTLLIB_PS_MBCAST | RTLLIB_PS_UNICAST);
 		} else
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index f4e9fa849796..3e601537412a 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -24,7 +24,6 @@ enum ht_extchnl_offset {
 };
 
 struct ht_capab_ele {
-
 	u8	AdvCoding:1;
 	u8	ChlWidth:1;
 	u8	MimoPwrSave:2;
@@ -46,7 +45,6 @@ struct ht_capab_ele {
 
 	u8	MCS[16];
 
-
 	u16	ExtHTCapInfo;
 
 	u8	TxBFCap[4];
@@ -55,7 +53,6 @@ struct ht_capab_ele {
 
 } __packed;
 
-
 struct ht_info_ele {
 	u8	ControlChl;
 
@@ -94,7 +91,6 @@ enum ht_aggre_mode {
 	HT_AGG_FORCE_DISABLE = 2,
 };
 
-
 struct rt_hi_throughput {
 	u8				enable_ht;
 	u8				bCurrentHTSupport;
@@ -113,14 +109,12 @@ struct rt_hi_throughput {
 
 	enum ht_spec_ver ePeerHTSpecVer;
 
-
 	struct ht_capab_ele SelfHTCap;
 	struct ht_info_ele SelfHTInfo;
 
 	u8				PeerHTCapBuf[32];
 	u8				PeerHTInfoBuf[32];
 
-
 	u8				bAMSDU_Support;
 	u16				nAMSDU_MaxSize;
 	u8				bCurrent_AMSDU_Support;
diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index c010eb0d6036..0499711ea2bf 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -104,7 +104,6 @@ struct acm {
 };
 
 union qos_tclas {
-
 	struct _TYPE_GENERAL {
 		u8		Priority;
 		u8		ClassifierType;
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 4aa9b12a2dd5..37760d0bc35d 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -53,6 +53,4 @@ struct rx_ts_record {
 	u8 num;
 };
 
-
-
 #endif
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4aa5ce9f7792..f2903b14b793 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1137,7 +1137,6 @@ struct rtllib_network {
 };
 
 enum rtllib_state {
-
 	/* the card is not linked at all */
 	RTLLIB_NOLINK = 0,
 
@@ -1298,7 +1297,6 @@ enum fw_cmd_io_type {
 
 #define RT_MAX_LD_SLOT_NUM	10
 struct rt_link_detect {
-
 	u32				NumRecvBcnInPeriod;
 	u32				NumRecvDataInPeriod;
 
@@ -1316,7 +1314,6 @@ struct rt_link_detect {
 };
 
 struct sw_cam_table {
-
 	u8				macaddr[ETH_ALEN];
 	bool				bused;
 	u8				key_buf[16];
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 7c4cba6dcf46..821ca86b8bcd 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -22,7 +22,6 @@
 
 static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl);
 
-
 static short rtllib_is_54g(struct rtllib_network *net)
 {
 	return (net->rates_ex_len > 0) || (net->rates_len > 4);
@@ -139,7 +138,6 @@ static void enqueue_mgmt(struct rtllib_device *ieee, struct sk_buff *skb)
  */
 	ieee->mgmt_queue_head = nh;
 	ieee->mgmt_queue_ring[nh] = skb;
-
 }
 
 static void init_mgmt_queue(struct rtllib_device *ieee)
@@ -147,14 +145,12 @@ static void init_mgmt_queue(struct rtllib_device *ieee)
 	ieee->mgmt_queue_tail = ieee->mgmt_queue_head = 0;
 }
 
-
 u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
 {
 	u16	i;
 	u8	QueryRate = 0;
 	u8	BasicRate;
 
-
 	for (i = 0; i < ieee->current_network.rates_len; i++) {
 		BasicRate = ieee->current_network.rates[i] & 0x7F;
 		if (!rtllib_is_cck_rate(BasicRate)) {
@@ -286,7 +282,6 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 	type = WLAN_FC_GET_TYPE(fc);
 	stype = WLAN_FC_GET_STYPE(fc);
 
-
 	if (stype != RTLLIB_STYPE_PSPOLL)
 		tcb_desc->queue_index = MGNT_QUEUE;
 	else
@@ -295,7 +290,6 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 	if (ieee->disable_mgnt_queue)
 		tcb_desc->queue_index = HIGH_QUEUE;
 
-
 	tcb_desc->data_rate = MgntQuery_MgntFrameTxRate(ieee);
 	tcb_desc->ratr_index = 7;
 	tcb_desc->tx_dis_rate_fallback = 1;
@@ -308,7 +302,6 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 				ieee->seq_ctrl[0] = 0;
 			else
 				ieee->seq_ctrl[0]++;
-
 		}
 		/* avoid watchdog triggers */
 		ieee->softmac_data_hard_start_xmit(skb, ieee->dev,
@@ -324,7 +317,6 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 				ieee->seq_ctrl[0]++;
 		}
 		ieee->softmac_hard_start_xmit(skb, ieee->dev);
-
 	}
 }
 
@@ -388,7 +380,6 @@ static void rtllib_send_beacon(struct rtllib_device *ieee)
 			  (msecs_to_jiffies(ieee->current_network.beacon_interval - 5)));
 }
 
-
 static void rtllib_send_beacon_cb(struct timer_list *t)
 {
 	struct rtllib_device *ieee =
@@ -411,7 +402,6 @@ void rtllib_EnableNetMonitorMode(struct net_device *dev,
 	ieee->AllowAllDestAddrHandler(dev, true, !bInitState);
 }
 
-
 /* Disables network monitor mode. Only packets destinated to
  * us will be received.
  */
@@ -425,7 +415,6 @@ void rtllib_DisableNetMonitorMode(struct net_device *dev,
 	ieee->AllowAllDestAddrHandler(dev, false, !bInitState);
 }
 
-
 /* Enables the specialized promiscuous mode required by Intel.
  * In this mode, Intel intends to hear traffics from/to other STAs in the
  * same BSS. Therefore we don't have to disable checking BSSID and we only need
@@ -449,7 +438,6 @@ void rtllib_EnableIntelPromiscuousMode(struct net_device *dev,
 }
 EXPORT_SYMBOL(rtllib_EnableIntelPromiscuousMode);
 
-
 /* Disables the specialized promiscuous mode required by Intel.
  * See MgntEnableIntelPromiscuousMode for detail.
  */
@@ -481,7 +469,6 @@ static void rtllib_send_probe(struct rtllib_device *ieee, u8 is_mesh)
 	}
 }
 
-
 static void rtllib_send_probe_requests(struct rtllib_device *ieee, u8 is_mesh)
 {
 	if (ieee->active_scan && (ieee->softmac_features &
@@ -629,8 +616,6 @@ static void rtllib_softmac_scan_wq(void *data)
 	mutex_unlock(&ieee->scan_mutex);
 }
 
-
-
 static void rtllib_beacons_start(struct rtllib_device *ieee)
 {
 	unsigned long flags;
@@ -653,10 +638,8 @@ static void rtllib_beacons_stop(struct rtllib_device *ieee)
 
 	spin_unlock_irqrestore(&ieee->beacon_lock, flags);
 	del_timer_sync(&ieee->beacon_timer);
-
 }
 
-
 void rtllib_stop_send_beacons(struct rtllib_device *ieee)
 {
 	ieee->stop_send_beacons(ieee->dev);
@@ -665,7 +648,6 @@ void rtllib_stop_send_beacons(struct rtllib_device *ieee)
 }
 EXPORT_SYMBOL(rtllib_stop_send_beacons);
 
-
 void rtllib_start_send_beacons(struct rtllib_device *ieee)
 {
 	ieee->start_send_beacons(ieee->dev);
@@ -674,7 +656,6 @@ void rtllib_start_send_beacons(struct rtllib_device *ieee)
 }
 EXPORT_SYMBOL(rtllib_start_send_beacons);
 
-
 static void rtllib_softmac_stop_scan(struct rtllib_device *ieee)
 {
 	mutex_lock(&ieee->scan_mutex);
@@ -888,7 +869,6 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	if (encrypt)
 		beacon_buf->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
-
 	beacon_buf->header.frame_ctl = cpu_to_le16(RTLLIB_STYPE_PROBE_RESP);
 	beacon_buf->info_element[0].id = MFIE_TYPE_SSID;
 	beacon_buf->info_element[0].len = ssid_len;
@@ -967,7 +947,6 @@ static struct sk_buff *rtllib_assoc_resp(struct rtllib_device *ieee, u8 *dest)
 	assoc->capability = cpu_to_le16(ieee->iw_mode == IW_MODE_MASTER ?
 		WLAN_CAPABILITY_ESS : WLAN_CAPABILITY_IBSS);
 
-
 	if (ieee->short_slot)
 		assoc->capability |=
 				 cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
@@ -1022,8 +1001,6 @@ static struct sk_buff *rtllib_auth_resp(struct rtllib_device *ieee, int status,
 	ether_addr_copy(auth->header.addr1, dest);
 	auth->header.frame_ctl = cpu_to_le16(RTLLIB_STYPE_AUTH);
 	return skb;
-
-
 }
 
 static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
@@ -1048,8 +1025,6 @@ static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
 		(pwr ? RTLLIB_FCTL_PM : 0));
 
 	return skb;
-
-
 }
 
 static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
@@ -1073,7 +1048,6 @@ static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 			 RTLLIB_FCTL_PM);
 
 	return skb;
-
 }
 
 static void rtllib_resp_to_assoc_rq(struct rtllib_device *ieee, u8 *dest)
@@ -1084,7 +1058,6 @@ static void rtllib_resp_to_assoc_rq(struct rtllib_device *ieee, u8 *dest)
 		softmac_mgmt_xmit(buf, ieee);
 }
 
-
 static void rtllib_resp_to_auth(struct rtllib_device *ieee, int s, u8 *dest)
 {
 	struct sk_buff *buf = rtllib_auth_resp(ieee, s, dest);
@@ -1093,7 +1066,6 @@ static void rtllib_resp_to_auth(struct rtllib_device *ieee, int s, u8 *dest)
 		softmac_mgmt_xmit(buf, ieee);
 }
 
-
 static void rtllib_resp_to_probe(struct rtllib_device *ieee, u8 *dest)
 {
 	struct sk_buff *buf = rtllib_probe_resp(ieee, dest);
@@ -1102,7 +1074,6 @@ static void rtllib_resp_to_probe(struct rtllib_device *ieee, u8 *dest)
 		softmac_mgmt_xmit(buf, ieee);
 }
 
-
 static inline int SecIsInPMKIDList(struct rtllib_device *ieee, u8 *bssid)
 {
 	int i = 0;
@@ -1215,7 +1186,6 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	hdr = skb_put(skb, sizeof(struct rtllib_assoc_request_frame) + 2);
 
-
 	hdr->header.frame_ctl = cpu_to_le16(RTLLIB_STYPE_ASSOC_REQ);
 	hdr->header.duration_id = cpu_to_le16(37);
 	ether_addr_copy(hdr->header.addr1, beacon->bssid);
@@ -1235,7 +1205,6 @@ rtllib_association_req(struct rtllib_network *beacon,
 	   (beacon->capability & WLAN_CAPABILITY_SHORT_SLOT_TIME))
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
 
-
 	hdr->listen_interval = cpu_to_le16(beacon->listen_interval);
 
 	hdr->info_element[0].id = MFIE_TYPE_SSID;
@@ -1713,7 +1682,6 @@ static void rtllib_softmac_check_all_nets(struct rtllib_device *ieee)
 	spin_lock_irqsave(&ieee->lock, flags);
 
 	list_for_each_entry(target, &ieee->network_list, list) {
-
 		/* if the state become different that NOLINK means
 		 * we had found what we are searching for
 		 */
@@ -1900,7 +1868,6 @@ static inline void rtllib_rx_assoc_rq(struct rtllib_device *ieee,
 {
 	u8 dest[ETH_ALEN];
 
-
 	ieee->softmac_stats.rx_ass_rq++;
 	if (assoc_rq_parse(ieee->dev, skb, dest) != -1)
 		rtllib_resp_to_assoc_rq(ieee, dest);
@@ -1910,7 +1877,6 @@ static inline void rtllib_rx_assoc_rq(struct rtllib_device *ieee,
 
 void rtllib_sta_ps_send_null_frame(struct rtllib_device *ieee, short pwr)
 {
-
 	struct sk_buff *buf = rtllib_null_func(ieee, pwr);
 
 	if (buf)
@@ -2008,8 +1974,6 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 	}
 
 	return 1;
-
-
 }
 
 static inline void rtllib_sta_ps(struct work_struct *work)
@@ -2048,7 +2012,6 @@ static inline void rtllib_sta_ps(struct work_struct *work)
 				ieee->ps_time = time;
 			}
 			spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
-
 		}
 
 		ieee->bAwakePktSent = false;
@@ -2063,7 +2026,6 @@ static inline void rtllib_sta_ps(struct work_struct *work)
 
 out:
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 
 static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl)
@@ -2080,7 +2042,6 @@ static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl)
 			}
 		}
 		return;
-
 	}
 
 	if (ieee->sta_sleep == LPS_IS_SLEEP)
@@ -2300,7 +2261,6 @@ static inline int
 rtllib_rx_auth(struct rtllib_device *ieee, struct sk_buff *skb,
 	       struct rtllib_rx_stats *rx_stats)
 {
-
 	if (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) {
 		if (ieee->state == RTLLIB_ASSOCIATING_AUTHENTICATING &&
 		    (ieee->iw_mode == IW_MODE_INFRA)) {
@@ -2408,7 +2368,6 @@ inline int rtllib_rx_frame_softmac(struct rtllib_device *ieee,
  */
 void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee)
 {
-
 	unsigned int queue_index = txb->queue_index;
 	unsigned long flags;
 	int  i;
@@ -2453,7 +2412,6 @@ void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee)
 	rtllib_txb_free(txb);
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 
 void rtllib_reset_queue(struct rtllib_device *ieee)
@@ -2468,7 +2426,6 @@ void rtllib_reset_queue(struct rtllib_device *ieee)
 	}
 	ieee->queue_stop = 0;
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 EXPORT_SYMBOL(rtllib_reset_queue);
 
@@ -2547,7 +2504,6 @@ static void rtllib_start_ibss_wq(void *data)
 	/* check if we have this cell in our network list */
 	rtllib_softmac_check_all_nets(ieee);
 
-
 	/* if not then the state is not linked. Maybe the user switched to
 	 * ad-hoc mode just after being in monitor mode, or just after
 	 * being very few time in managed mode (so the card have had no
@@ -2573,7 +2529,6 @@ static void rtllib_start_ibss_wq(void *data)
 			eth_random_addr(ieee->current_network.bssid);
 
 		if (ieee->modulation & RTLLIB_CCK_MODULATION) {
-
 			ieee->current_network.rates_len = 4;
 
 			ieee->current_network.rates[0] =
@@ -2760,7 +2715,6 @@ static struct sk_buff *rtllib_get_beacon_(struct rtllib_device *ieee)
 	b->header.frame_ctl = cpu_to_le16(RTLLIB_STYPE_BEACON);
 
 	return skb;
-
 }
 
 struct sk_buff *rtllib_get_beacon(struct rtllib_device *ieee)
@@ -2794,7 +2748,6 @@ void rtllib_softmac_stop_protocol(struct rtllib_device *ieee, u8 mesh_flag,
 }
 EXPORT_SYMBOL(rtllib_softmac_stop_protocol);
 
-
 void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
 {
 	if (!ieee->proto_started)
@@ -3103,7 +3056,6 @@ static void rtllib_MgntDisconnectIBSS(struct rtllib_device *rtllib)
 	rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_CECHK_BSSID,
 				(u8 *)(&bFilterOutNonAssociatedBSSID));
 	notify_wx_assoc_event(rtllib);
-
 }
 
 static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
@@ -3127,9 +3079,7 @@ static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 
 		rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_BSSID,
 					rtllib->current_network.bssid);
-
 	}
-
 }
 
 static void
@@ -3159,7 +3109,6 @@ bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn)
 			rtllib_MgntDisconnectIBSS(rtllib);
 		if (rtllib->iw_mode == IW_MODE_INFRA)
 			rtllib_MgntDisconnectAP(rtllib, asRsn);
-
 	}
 
 	return true;
@@ -3178,7 +3127,6 @@ void notify_wx_assoc_event(struct rtllib_device *ieee)
 		memcpy(wrqu.ap_addr.sa_data, ieee->current_network.bssid,
 		       ETH_ALEN);
 	else {
-
 		netdev_info(ieee->dev, "%s(): Tell user space disconnected\n",
 			    __func__);
 		eth_zero_addr(wrqu.ap_addr.sa_data);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index d85a32d2d050..78a70e5f1974 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -25,7 +25,6 @@ const long rtllib_wlan_frequencies[] = {
 };
 EXPORT_SYMBOL(rtllib_wlan_frequencies);
 
-
 int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 			     union iwreq_data *wrqu, char *b)
 {
@@ -83,7 +82,6 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 }
 EXPORT_SYMBOL(rtllib_wx_set_freq);
 
-
 int rtllib_wx_get_freq(struct rtllib_device *ieee,
 			     struct iw_request_info *a,
 			     union iwreq_data *wrqu, char *b)
@@ -128,13 +126,11 @@ int rtllib_wx_get_wap(struct rtllib_device *ieee,
 }
 EXPORT_SYMBOL(rtllib_wx_get_wap);
 
-
 int rtllib_wx_set_wap(struct rtllib_device *ieee,
 			 struct iw_request_info *info,
 			 union iwreq_data *awrq,
 			 char *extra)
 {
-
 	int ret = 0;
 	unsigned long flags;
 
@@ -164,7 +160,6 @@ int rtllib_wx_set_wap(struct rtllib_device *ieee,
 		goto out;
 	}
 
-
 	if (ifup)
 		rtllib_stop_protocol(ieee, true);
 
@@ -220,7 +215,6 @@ int rtllib_wx_get_essid(struct rtllib_device *ieee, struct iw_request_info *a,
 	spin_unlock_irqrestore(&ieee->lock, flags);
 
 	return ret;
-
 }
 EXPORT_SYMBOL(rtllib_wx_get_essid);
 
@@ -228,7 +222,6 @@ int rtllib_wx_set_rate(struct rtllib_device *ieee,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
-
 	u32 target_rate = wrqu->bitrate.value;
 
 	ieee->rate = target_rate / 100000;
@@ -250,7 +243,6 @@ int rtllib_wx_get_rate(struct rtllib_device *ieee,
 }
 EXPORT_SYMBOL(rtllib_wx_get_rate);
 
-
 int rtllib_wx_set_rts(struct rtllib_device *ieee,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
@@ -397,7 +389,6 @@ void rtllib_wx_sync_scan_wq(void *data)
 
 out:
 	mutex_unlock(&ieee->wx_mutex);
-
 }
 
 int rtllib_wx_set_scan(struct rtllib_device *ieee, struct iw_request_info *a,
@@ -425,7 +416,6 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
 			struct iw_request_info *a,
 			union iwreq_data *wrqu, char *extra)
 {
-
 	int ret = 0, len;
 	short proto_started;
 	unsigned long flags;
@@ -445,7 +435,6 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
 	if (proto_started)
 		rtllib_stop_protocol(ieee, true);
 
-
 	/* this is just to be sure that the GET wx callback
 	 * has consistent infos. not needed otherwise
 	 */
@@ -483,7 +472,6 @@ int rtllib_wx_set_rawtx(struct rtllib_device *ieee,
 			struct iw_request_info *info,
 			union iwreq_data *wrqu, char *extra)
 {
-
 	int *parms = (int *)extra;
 	int enable = (parms[0] > 0);
 	short prev = ieee->raw_tx;
@@ -524,7 +512,6 @@ int rtllib_wx_get_name(struct rtllib_device *ieee, struct iw_request_info *info,
 }
 EXPORT_SYMBOL(rtllib_wx_get_name);
 
-
 /* this is mostly stolen from hostap */
 int rtllib_wx_set_power(struct rtllib_device *ieee,
 				 struct iw_request_info *info,
@@ -570,12 +557,10 @@ int rtllib_wx_set_power(struct rtllib_device *ieee,
 	default:
 		ret = -EINVAL;
 		goto exit;
-
 	}
 exit:
 	mutex_unlock(&ieee->wx_mutex);
 	return ret;
-
 }
 EXPORT_SYMBOL(rtllib_wx_set_power);
 
@@ -612,6 +597,5 @@ int rtllib_wx_get_power(struct rtllib_device *ieee,
 exit:
 	mutex_unlock(&ieee->wx_mutex);
 	return 0;
-
 }
 EXPORT_SYMBOL(rtllib_wx_get_power);
-- 
2.40.1

