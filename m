Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5497D708612
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjERQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:32:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A4C2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:32:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510ede0f20aso859699a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684427532; x=1687019532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9/4F72AbD3q9HM/Uf0mPhG6/Vl5G2umZ46oR5Y28Mg=;
        b=CS1ddOlHqJ5nOz9peHNJ5VTOEm5wWlbMjgGmw7/dTEyAupf+G8VHDiQiiShaF93SZV
         Mst50ThOAM+9JpXG5mzvJIJJ2tto/oJL6CpN/CLQTiBFaK0x2CbRoExis4v8Z5zxDaht
         MMfL3FDPJEfslduuV04ogn78AQXnBPb+l3c8Z+aIPeAtG9d6FjoYpaa0lfVNPlEKTXOk
         bGOIVT0L3fhUkIm5VXbDwnRN0FPpq4CpUCa3UJuBFq+lCEti1+GEBohQx29Dyc/C4alM
         VzxIS97A4cG7DnQFgyadKcYtHLLIBwFbW761W3jHMTOKnVDxw/aSpPwUnjtsJ/UhEtgF
         V3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684427532; x=1687019532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9/4F72AbD3q9HM/Uf0mPhG6/Vl5G2umZ46oR5Y28Mg=;
        b=M8/ril0U1gqnkH1sq7q+d7ZWy8QSZlkPyomdsUDbFw1CRFQpEOJivTUQ2E0Nwd3wf+
         TcsQRUonXZVCjGbT044oGutsrbTjf34q3leprlJcs9DYxFU7JGgUbwAEOM89QPZ/oRQK
         ljgFuUFC9ljvhFBr/ncIC4GNHfVpdLENb0XEla94PB75NsUss/SIwoPJ0hVsSUXglOGH
         Hsy+JdpCZ/+fbFYz5ccr/UF3y+DAo+O8eq+BBoUVrfcKw7TS5J0Om7ux+8XPocsDnD+g
         WBbp7F4qe/gKsISkn2SLqgsCUmg9NKdb4RT4JZWMqVwfA8QWNX0SwMQ/J11AWSvBvXuV
         Pk/w==
X-Gm-Message-State: AC+VfDxbpbAgY+U19WoL+kDqj1QDEN1szvc86WeRQlquSymdzBw3JLsf
        Y2nxq9T95KOgizsm+Jr6idQ=
X-Google-Smtp-Source: ACHHUZ7HSY/mjxSJj/3Z7ANT/I/HzRXin0Kepch4CL0VzNBF9LzSnjRCaaPpuUq0tt71D7oYW3YTQA==
X-Received: by 2002:a05:6402:68f:b0:510:e82e:4130 with SMTP id f15-20020a056402068f00b00510e82e4130mr1850753edy.0.1684427531918;
        Thu, 18 May 2023 09:32:11 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbb0.dynamic.kabel-deutschland.de. [95.90.187.176])
        by smtp.gmail.com with ESMTPSA id g6-20020aa7d1c6000000b0050690bc07a3sm747602edp.18.2023.05.18.09.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:32:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8192e: add missing spaces around operators
Date:   Thu, 18 May 2023 18:32:01 +0200
Message-Id: <20230518163201.14463-1-straube.linux@gmail.com>
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

Add missing spaces around operators to improve readability and clear
checkpatch issues.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Compile-tested only, due to lack of hardware.

 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  6 +--
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 54 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 24 ++++-----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 50 ++++++++---------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 50 ++++++++---------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  4 +-
 6 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index bb4539e337c8..7061f1cf4d3a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -73,11 +73,11 @@ bool rtl92e_config_rf(struct net_device *dev)
 			break;
 		case RF90_PATH_B:
 			u4RegValue = rtl92e_get_bb_reg(dev, pPhyReg->rfintfs,
-						       bRFSI_RFENV<<16);
+						       bRFSI_RFENV << 16);
 			break;
 		}
 
-		rtl92e_set_bb_reg(dev, pPhyReg->rfintfe, bRFSI_RFENV<<16, 0x1);
+		rtl92e_set_bb_reg(dev, pPhyReg->rfintfe, bRFSI_RFENV << 16, 0x1);
 
 		rtl92e_set_bb_reg(dev, pPhyReg->rfintfo, bRFSI_RFENV, 0x1);
 
@@ -117,7 +117,7 @@ bool rtl92e_config_rf(struct net_device *dev)
 			break;
 		case RF90_PATH_B:
 			rtl92e_set_bb_reg(dev, pPhyReg->rfintfs,
-					  bRFSI_RFENV<<16, u4RegValue);
+					  bRFSI_RFENV << 16, u4RegValue);
 			break;
 		}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index c612e31d1a84..97a3eaf76d7c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -36,8 +36,8 @@ void rtl92e_start_beacon(struct net_device *dev)
 
 	rtl92e_writeb(dev, BCN_ERR_THRESH, 100);
 
-	BcnTimeCfg |= BcnCW<<BCN_TCFG_CW_SHIFT;
-	BcnTimeCfg |= BcnIFS<<BCN_TCFG_IFS;
+	BcnTimeCfg |= BcnCW << BCN_TCFG_CW_SHIFT;
+	BcnTimeCfg |= BcnIFS << BCN_TCFG_IFS;
 	rtl92e_writew(dev, BCN_TCFG, BcnTimeCfg);
 	rtl92e_irq_enable(dev);
 }
@@ -168,7 +168,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 			 &priv->rtllib->current_network.qos_data.parameters;
 
 		u1bAIFS = qop->aifs[pAcParam] *
-			  ((mode&(IEEE_G|IEEE_N_24G)) ? 9 : 20) + aSifsTime;
+			  ((mode & (IEEE_G | IEEE_N_24G)) ? 9 : 20) + aSifsTime;
 
 		rtl92e_dm_init_edca_turbo(dev);
 
@@ -256,7 +256,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 
 	case HW_VAR_SIFS:
 		rtl92e_writeb(dev, SIFS, val[0]);
-		rtl92e_writeb(dev, SIFS+1, val[0]);
+		rtl92e_writeb(dev, SIFS + 1, val[0]);
 		break;
 
 	case HW_VAR_RF_TIMING:
@@ -299,12 +299,12 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 					     (EEPROM_Customer_ID >> 1)) >> 8;
 		priv->eeprom_customer_id = usValue & 0xff;
 		usValue = rtl92e_eeprom_read(dev,
-					     EEPROM_ICVersion_ChannelPlan>>1);
-		priv->eeprom_chnl_plan = usValue&0xff;
-		IC_Version = (usValue & 0xff00)>>8;
+					     EEPROM_ICVersion_ChannelPlan >> 1);
+		priv->eeprom_chnl_plan = usValue & 0xff;
+		IC_Version = (usValue & 0xff00) >> 8;
 
 		ICVer8192 = IC_Version & 0xf;
-		ICVer8256 = (IC_Version & 0xf0)>>4;
+		ICVer8256 = (IC_Version & 0xf0) >> 4;
 		if (ICVer8192 == 0x2) {
 			if (ICVer8256 == 0x5)
 				priv->card_8192_version = VERSION_8190_BE;
@@ -354,7 +354,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 		if (!priv->autoload_fail_flag)
 			priv->eeprom_thermal_meter = ((rtl92e_eeprom_read(dev,
-						   (EEPROM_ThermalMeter>>1))) &
+						   (EEPROM_ThermalMeter >> 1))) &
 						   0xff00) >> 8;
 		else
 			priv->eeprom_thermal_meter = EEPROM_Default_ThermalMeter;
@@ -596,7 +596,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 		      RSVD_FW_QUEUE_PAGE_MGNT_SHIFT);
 	rtl92e_writel(dev, RQPN3, APPLIED_RESERVED_QUEUE_IN_FW |
 		      NUM_OF_PAGE_IN_FW_QUEUE_BCN <<
-		      RSVD_FW_QUEUE_PAGE_BCN_SHIFT|
+		      RSVD_FW_QUEUE_PAGE_BCN_SHIFT |
 		      NUM_OF_PAGE_IN_FW_QUEUE_PUB <<
 		      RSVD_FW_QUEUE_PAGE_PUB_SHIFT);
 
@@ -605,7 +605,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	ulRegRead = (0xFFF00000 & rtl92e_readl(dev, RRSR))  |
 		     RATE_ALL_OFDM_AG | RATE_ALL_CCK;
 	rtl92e_writel(dev, RRSR, ulRegRead);
-	rtl92e_writel(dev, RATR0+4*7, (RATE_ALL_OFDM_AG | RATE_ALL_CCK));
+	rtl92e_writel(dev, RATR0 + 4 * 7, (RATE_ALL_OFDM_AG | RATE_ALL_CCK));
 
 	rtl92e_writeb(dev, ACK_TIMEOUT, 0x30);
 
@@ -738,8 +738,8 @@ static void _rtl92e_net_update(struct net_device *dev)
 		rtl92e_writew(dev, BCN_DRV_EARLY_INT, 10);
 		rtl92e_writeb(dev, BCN_ERR_THRESH, 100);
 
-		BcnTimeCfg |= (BcnCW<<BCN_TCFG_CW_SHIFT);
-		BcnTimeCfg |= BcnIFS<<BCN_TCFG_IFS;
+		BcnTimeCfg |= (BcnCW << BCN_TCFG_CW_SHIFT);
+		BcnTimeCfg |= BcnIFS << BCN_TCFG_IFS;
 
 		rtl92e_writew(dev, BCN_TCFG, BcnTimeCfg);
 	}
@@ -883,7 +883,7 @@ static u8 _rtl92e_rate_mgn_to_hw(u8 rate)
 	case MGN_MCS15:
 		ret = DESC90_RATEMCS15;
 		break;
-	case (0x80|0x20):
+	case (0x80 | 0x20):
 		ret = DESC90_RATEMCS32;
 		break;
 	default:
@@ -973,7 +973,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	pTxFwInfo->RtsEnable =	(cb_desc->bRTSEnable) ? 1 : 0;
 	pTxFwInfo->CtsEnable = (cb_desc->bCTSEnable) ? 1 : 0;
 	pTxFwInfo->RtsSTBC = (cb_desc->bRTSSTBC) ? 1 : 0;
-	pTxFwInfo->RtsHT = (cb_desc->rts_rate&0x80) ? 1 : 0;
+	pTxFwInfo->RtsHT = (cb_desc->rts_rate & 0x80) ? 1 : 0;
 	pTxFwInfo->RtsRate = _rtl92e_rate_mgn_to_hw(cb_desc->rts_rate);
 	pTxFwInfo->RtsBandwidth = 0;
 	pTxFwInfo->RtsSubcarrier = cb_desc->RTSSC;
@@ -1345,7 +1345,7 @@ static void _rtl92e_query_rxphystatus(
 				else if (pcck_buf->sq_rpt < 20)
 					sq = 100;
 				else
-					sq = ((64-sq) * 100) / 44;
+					sq = ((64 - sq) * 100) / 44;
 			}
 			pstats->SignalQuality = sq;
 			precord_stats->SignalQuality = sq;
@@ -1452,7 +1452,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	if (slide_rssi_index >= PHY_RSSI_SLID_WIN_MAX)
 		slide_rssi_index = 0;
 
-	tmp_val = priv->stats.slide_rssi_total/slide_rssi_statistics;
+	tmp_val = priv->stats.slide_rssi_total / slide_rssi_statistics;
 	priv->stats.signal_strength = rtl92e_translate_to_dbm(priv, tmp_val);
 	curr_st->rssi = priv->stats.signal_strength;
 	if (!prev_st->bPacketMatchBSSID) {
@@ -1482,7 +1482,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 			} else {
 				priv->stats.rx_rssi_percentage[rfpath] =
 				   ((priv->stats.rx_rssi_percentage[rfpath] *
-				   (RX_SMOOTH-1)) +
+				   (RX_SMOOTH - 1)) +
 				   (prev_st->RxMIMOSignalStrength[rfpath])) /
 				   (RX_SMOOTH);
 			}
@@ -1517,14 +1517,14 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		if (prev_st->RxPWDBAll > (u32)priv->undecorated_smoothed_pwdb) {
 			priv->undecorated_smoothed_pwdb =
 					(((priv->undecorated_smoothed_pwdb) *
-					(RX_SMOOTH-1)) +
+					(RX_SMOOTH - 1)) +
 					(prev_st->RxPWDBAll)) / (RX_SMOOTH);
 			priv->undecorated_smoothed_pwdb =
 					 priv->undecorated_smoothed_pwdb + 1;
 		} else {
 			priv->undecorated_smoothed_pwdb =
 					(((priv->undecorated_smoothed_pwdb) *
-					(RX_SMOOTH-1)) +
+					(RX_SMOOTH - 1)) +
 					(prev_st->RxPWDBAll)) / (RX_SMOOTH);
 		}
 		rtl92e_update_rx_statistics(priv, prev_st);
@@ -1753,7 +1753,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 			    (pDrvInfo->FirstAGGR == 1);
 
 	stats->TimeStampLow = pDrvInfo->TSFL;
-	stats->TimeStampHigh = rtl92e_readl(dev, TSFR+4);
+	stats->TimeStampHigh = rtl92e_readl(dev, TSFR + 4);
 
 	rtl92e_update_rx_pkt_timestamp(dev, stats);
 
@@ -1766,7 +1766,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	skb_trim(skb, skb->len - S_CRC_LEN);
 
 
-	stats->packetlength = stats->Length-4;
+	stats->packetlength = stats->Length - 4;
 	stats->fraglength = stats->packetlength;
 	stats->fragoffset = 0;
 	stats->ntotalfrag = 1;
@@ -1837,7 +1837,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 		ratr_value &= 0x0000000F;
 		break;
 	case IEEE_G:
-	case IEEE_G|IEEE_B:
+	case IEEE_G | IEEE_B:
 		ratr_value &= 0x00000FF7;
 		break;
 	case IEEE_N_24G:
@@ -1857,7 +1857,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 	else if (!ieee->ht_info->cur_tx_bw40mhz &&
 		  ieee->ht_info->bCurShortGI20MHz)
 		ratr_value |= 0x80000000;
-	rtl92e_writel(dev, RATR0+rate_index*4, ratr_value);
+	rtl92e_writel(dev, RATR0 + rate_index * 4, ratr_value);
 	rtl92e_writeb(dev, UFWP, 1);
 }
 
@@ -1881,7 +1881,7 @@ rtl92e_init_variables(struct net_device  *dev)
 		RCR_AMF | RCR_ADF |
 		RCR_AICV |
 		RCR_AB | RCR_AM | RCR_APM |
-		RCR_AAP | ((u32)7<<RCR_MXDMA_OFFSET) |
+		RCR_AAP | ((u32)7 << RCR_MXDMA_OFFSET) |
 		((u32)7 << RCR_FIFO_OFFSET) | RCR_ONLYERLPKT;
 
 	priv->irq_mask[0] = (u32)(IMR_ROK | IMR_VODOK | IMR_VIDOK |
@@ -1976,7 +1976,7 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	}
 
 
-	SlotIndex = (priv->silent_reset_rx_slot_index++)%SilentResetRxSoltNum;
+	SlotIndex = (priv->silent_reset_rx_slot_index++) % SilentResetRxSoltNum;
 
 	if (priv->rx_ctr == RegRxCounter) {
 		priv->silent_reset_rx_stuck_event[SlotIndex] = 1;
@@ -2021,7 +2021,7 @@ bool rtl92e_get_nmode_support_by_sec(struct net_device *dev)
 	struct rtllib_device *ieee = priv->rtllib;
 
 	if (ieee->rtllib_ap_sec_type &&
-	   (ieee->rtllib_ap_sec_type(priv->rtllib)&(SEC_ALG_WEP |
+	   (ieee->rtllib_ap_sec_type(priv->rtllib) & (SEC_ALG_WEP |
 				     SEC_ALG_TKIP))) {
 		return false;
 	} else {
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 4b0ebe96302e..61fd84ca58d2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -267,9 +267,9 @@ void rtl92e_config_mac(struct net_device *dev)
 	}
 	for (i = 0; i < dwArrayLen; i += 3) {
 		if (pdwArray[i] == 0x318)
-			pdwArray[i+2] = 0x00000800;
-		rtl92e_set_bb_reg(dev, pdwArray[i], pdwArray[i+1],
-				  pdwArray[i+2]);
+			pdwArray[i + 2] = 0x00000800;
+		rtl92e_set_bb_reg(dev, pdwArray[i], pdwArray[i + 1],
+				  pdwArray[i + 2]);
 	}
 	return;
 
@@ -291,13 +291,13 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 		for (i = 0; i < PHY_REGArrayLen; i += 2) {
 			rtl92e_set_bb_reg(dev, Rtl819XPHY_REGArray_Table[i],
 					  bMaskDWord,
-					  Rtl819XPHY_REGArray_Table[i+1]);
+					  Rtl819XPHY_REGArray_Table[i + 1]);
 		}
 	} else if (ConfigType == BB_CONFIG_AGC_TAB) {
 		for (i = 0; i < AGCTAB_ArrayLen; i += 2) {
 			rtl92e_set_bb_reg(dev, Rtl819XAGCTAB_Array_Table[i],
 					  bMaskDWord,
-					  Rtl819XAGCTAB_Array_Table[i+1]);
+					  Rtl819XAGCTAB_Array_Table[i + 1]);
 		}
 	}
 }
@@ -389,10 +389,10 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
 	u32 dwRegValue = 0;
 
 	bRegValue = rtl92e_readb(dev, BB_GLOBAL_RESET);
-	rtl92e_writeb(dev, BB_GLOBAL_RESET, (bRegValue|BB_GLOBAL_RESET_BIT));
+	rtl92e_writeb(dev, BB_GLOBAL_RESET, (bRegValue | BB_GLOBAL_RESET_BIT));
 
 	dwRegValue = rtl92e_readl(dev, CPU_GEN);
-	rtl92e_writel(dev, CPU_GEN, (dwRegValue&(~CPU_GEN_BB_RST)));
+	rtl92e_writel(dev, CPU_GEN, (dwRegValue & (~CPU_GEN_BB_RST)));
 
 	for (eCheckItem = (enum hw90_block)HW90_BLOCK_PHY0;
 	     eCheckItem <= HW90_BLOCK_PHY1; eCheckItem++) {
@@ -402,18 +402,18 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
 		if (!rtStatus)
 			return rtStatus;
 	}
-	rtl92e_set_bb_reg(dev, rFPGA0_RFMOD, bCCKEn|bOFDMEn, 0x0);
+	rtl92e_set_bb_reg(dev, rFPGA0_RFMOD, bCCKEn | bOFDMEn, 0x0);
 	_rtl92e_phy_config_bb(dev, BB_CONFIG_PHY_REG);
 
 	dwRegValue = rtl92e_readl(dev, CPU_GEN);
-	rtl92e_writel(dev, CPU_GEN, (dwRegValue|CPU_GEN_BB_RST));
+	rtl92e_writel(dev, CPU_GEN, (dwRegValue | CPU_GEN_BB_RST));
 
 	_rtl92e_phy_config_bb(dev, BB_CONFIG_AGC_TAB);
 
 	if (priv->ic_cut  > VERSION_8190_BD) {
 		dwRegValue = 0x0;
 		rtl92e_set_bb_reg(dev, rFPGA0_TxGainStage,
-				  (bXBTxAGC|bXCTxAGC|bXDTxAGC), dwRegValue);
+				  (bXBTxAGC | bXCTxAGC | bXDTxAGC), dwRegValue);
 
 
 		dwRegValue = priv->crystal_cap;
@@ -645,7 +645,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 					rtl92e_set_rf_reg(dev,
 						 (enum rf90_radio_path)eRFPath,
 						 CurrentCmd->Para1, bMask12Bits,
-						 CurrentCmd->Para2<<7);
+						 CurrentCmd->Para2 << 7);
 				break;
 			default:
 				break;
@@ -880,7 +880,7 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 		}
 
 		rtl92e_set_bb_reg(dev, rCCK0_System, bCCKSideBand,
-				  (priv->n_cur_40mhz_prime_sc>>1));
+				  (priv->n_cur_40mhz_prime_sc >> 1));
 		rtl92e_set_bb_reg(dev, rOFDM1_LSTF, 0xC00,
 				  priv->n_cur_40mhz_prime_sc);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index feac50cd8fa0..893614bf32aa 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -353,7 +353,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 
 		if (pra->ping_rssi_enable) {
 			if (priv->undecorated_smoothed_pwdb <
-			    (long)(pra->ping_rssi_thresh_for_ra+5)) {
+			    (long)(pra->ping_rssi_thresh_for_ra + 5)) {
 				if ((priv->undecorated_smoothed_pwdb <
 				     (long)pra->ping_rssi_thresh_for_ra) ||
 				    ping_rssi_state) {
@@ -562,7 +562,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 			for (k = 0; k < 5; k++) {
 				if (k != 4)
 					tmp_report[k] = rtl92e_readb(dev,
-							 Tssi_Report_Value1+k);
+							 Tssi_Report_Value1 + k);
 				else
 					tmp_report[k] = rtl92e_readb(dev,
 							 Tssi_Report_Value2);
@@ -861,7 +861,7 @@ static void _rtl92e_dm_cck_tx_power_adjust_tssi(struct net_device *dev,
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter1, bMaskHWord, TempVal);
 		TempVal = (u32)((dm_cck_tx_bb_gain[attenuation][2]) +
 			  (dm_cck_tx_bb_gain[attenuation][3] << 8) +
-			  (dm_cck_tx_bb_gain[attenuation][4] << 16)+
+			  (dm_cck_tx_bb_gain[attenuation][4] << 16) +
 			  (dm_cck_tx_bb_gain[attenuation][5] << 24));
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter2, bMaskDWord, TempVal);
 		TempVal = (u32)(dm_cck_tx_bb_gain[attenuation][6] +
@@ -875,7 +875,7 @@ static void _rtl92e_dm_cck_tx_power_adjust_tssi(struct net_device *dev,
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter1, bMaskHWord, TempVal);
 		TempVal = (u32)((dm_cck_tx_bb_gain_ch14[attenuation][2]) +
 			  (dm_cck_tx_bb_gain_ch14[attenuation][3] << 8) +
-			  (dm_cck_tx_bb_gain_ch14[attenuation][4] << 16)+
+			  (dm_cck_tx_bb_gain_ch14[attenuation][4] << 16) +
 			  (dm_cck_tx_bb_gain_ch14[attenuation][5] << 24));
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter2, bMaskDWord, TempVal);
 		TempVal = (u32)((dm_cck_tx_bb_gain_ch14[attenuation][6]) +
@@ -898,7 +898,7 @@ static void _rtl92e_dm_cck_tx_power_adjust_thermal_meter(struct net_device *dev,
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter1, bMaskHWord, TempVal);
 		TempVal = CCKSwingTable_Ch1_Ch13[priv->cck_index][2] +
 			  (CCKSwingTable_Ch1_Ch13[priv->cck_index][3] << 8) +
-			  (CCKSwingTable_Ch1_Ch13[priv->cck_index][4] << 16)+
+			  (CCKSwingTable_Ch1_Ch13[priv->cck_index][4] << 16) +
 			  (CCKSwingTable_Ch1_Ch13[priv->cck_index][5] << 24);
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter2, bMaskDWord, TempVal);
 		TempVal = CCKSwingTable_Ch1_Ch13[priv->cck_index][6] +
@@ -912,11 +912,11 @@ static void _rtl92e_dm_cck_tx_power_adjust_thermal_meter(struct net_device *dev,
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter1, bMaskHWord, TempVal);
 		TempVal = CCKSwingTable_Ch14[priv->cck_index][2] +
 			  (CCKSwingTable_Ch14[priv->cck_index][3] << 8) +
-			  (CCKSwingTable_Ch14[priv->cck_index][4] << 16)+
+			  (CCKSwingTable_Ch14[priv->cck_index][4] << 16) +
 			  (CCKSwingTable_Ch14[priv->cck_index][5] << 24);
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter2, bMaskDWord, TempVal);
 		TempVal = CCKSwingTable_Ch14[priv->cck_index][6] +
-			  (CCKSwingTable_Ch14[priv->cck_index][7]<<8);
+			  (CCKSwingTable_Ch14[priv->cck_index][7] << 8);
 
 		rtl92e_set_bb_reg(dev, rCCK0_DebugPort, bMaskLWord, TempVal);
 	}
@@ -1146,7 +1146,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 		rtl92e_writeb(dev, rOFDM0_XDAGCCore1, 0x17);
 
 		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-			rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x00);
+			rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x00);
 		else
 			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x42);
 
@@ -1183,7 +1183,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 		}
 
 		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-			rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x20);
+			rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x20);
 		else
 			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x44);
 
@@ -1214,7 +1214,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 		dm_digtable.dig_highpwr_state = DM_STA_DIG_ON;
 
 		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-			rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x10);
+			rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x10);
 		else
 			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x43);
 	} else {
@@ -1228,7 +1228,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 		    (priv->undecorated_smoothed_pwdb >=
 		    dm_digtable.rssi_high_thresh)) {
 			if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-				rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x20);
+				rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x20);
 			else
 				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x44);
 		}
@@ -1339,18 +1339,18 @@ static void _rtl92e_dm_pd_th(struct net_device *dev)
 	    (initialized <= 3) || force_write) {
 		if (dm_digtable.curpd_thstate == DIG_PD_AT_LOW_POWER) {
 			if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-				rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x00);
+				rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x00);
 			else
 				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x42);
 		} else if (dm_digtable.curpd_thstate ==
 			   DIG_PD_AT_NORMAL_POWER) {
 			if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-				rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x20);
+				rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x20);
 			else
 				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x44);
 		} else if (dm_digtable.curpd_thstate == DIG_PD_AT_HIGH_POWER) {
 			if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-				rtl92e_writeb(dev, (rOFDM0_XATxAFE+3), 0x10);
+				rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x10);
 			else
 				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x43);
 		}
@@ -1435,7 +1435,7 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 		curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 		if (ht_info->iot_action & HT_IOT_ACT_EDCA_BIAS_ON_RX) {
-			if (curTxOkCnt > 4*curRxOkCnt) {
+			if (curTxOkCnt > 4 * curRxOkCnt) {
 				if (priv->bis_cur_rdlstate ||
 				    !priv->bcurrent_turbo_EDCA) {
 					rtl92e_writel(dev, EDCAPARA_BE,
@@ -1456,7 +1456,7 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 			}
 			priv->bcurrent_turbo_EDCA = true;
 		} else {
-			if (curRxOkCnt > 4*curTxOkCnt) {
+			if (curRxOkCnt > 4 * curTxOkCnt) {
 				if (!priv->bis_cur_rdlstate ||
 				    !priv->bcurrent_turbo_EDCA) {
 					if (priv->rtllib->mode == WIRELESS_MODE_G)
@@ -1519,7 +1519,7 @@ static void _rtl92e_dm_cts_to_self(struct net_device *dev)
 	if (ht_info->IOTPeer == HT_IOT_PEER_BROADCOM) {
 		curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
-		if (curRxOkCnt > 4*curTxOkCnt)
+		if (curRxOkCnt > 4 * curTxOkCnt)
 			ht_info->iot_action &= ~HT_IOT_ACT_FORCED_CTS2SELF;
 		else
 			ht_info->iot_action |= HT_IOT_ACT_FORCED_CTS2SELF;
@@ -1546,7 +1546,7 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 
 	tmp1byte = rtl92e_readb(dev, GPI);
 
-	rf_power_state_to_set = (tmp1byte&BIT1) ?  rf_on : rf_off;
+	rf_power_state_to_set = (tmp1byte & BIT1) ?  rf_on : rf_off;
 
 	if (priv->hw_radio_off && (rf_power_state_to_set == rf_on)) {
 		netdev_info(dev, "gpiochangeRF  - HW Radio ON\n");
@@ -1576,7 +1576,7 @@ void rtl92e_dm_rf_pathcheck_wq(void *data)
 	rfpath = rtl92e_readb(dev, 0xc04);
 
 	for (i = 0; i < RF90_PATH_MAX; i++) {
-		if (rfpath & (0x01<<i))
+		if (rfpath & (0x01 << i))
 			priv->brfpath_rxenable[i] = true;
 		else
 			priv->brfpath_rxenable[i] = false;
@@ -1627,7 +1627,7 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 	u8 update_cck_rx_path;
 
 	if (!cck_Rx_Path_initialized) {
-		dm_rx_path_sel_table.cck_rx_path = (rtl92e_readb(dev, 0xa07)&0xf);
+		dm_rx_path_sel_table.cck_rx_path = (rtl92e_readb(dev, 0xa07) & 0xf);
 		cck_Rx_Path_initialized = 1;
 	}
 
@@ -1763,11 +1763,11 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 		if ((tmp_max_rssi - tmp_min_rssi) >=
 		     dm_rx_path_sel_table.diff_th) {
 			dm_rx_path_sel_table.rf_enable_rssi_th[min_rssi_index] =
-				 tmp_max_rssi+5;
+				 tmp_max_rssi + 5;
 			rtl92e_set_bb_reg(dev, rOFDM0_TRxPathEnable,
-					  0x1<<min_rssi_index, 0x0);
+					  0x1 << min_rssi_index, 0x0);
 			rtl92e_set_bb_reg(dev, rOFDM1_TRxPathEnable,
-					  0x1<<min_rssi_index, 0x0);
+					  0x1 << min_rssi_index, 0x0);
 			disabled_rf_cnt++;
 		}
 		if (dm_rx_path_sel_table.cck_method == CCK_Rx_Version_1) {
@@ -1779,7 +1779,7 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 	}
 
 	if (update_cck_rx_path) {
-		dm_rx_path_sel_table.cck_rx_path = (cck_default_Rx<<2) |
+		dm_rx_path_sel_table.cck_rx_path = (cck_default_Rx << 2) |
 						(cck_optional_Rx);
 		rtl92e_set_bb_reg(dev, rCCK0_AFESetting, 0x0f000000,
 				  dm_rx_path_sel_table.cck_rx_path);
@@ -2084,7 +2084,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 					     RegC38_NonFsync_Other_AP;
 				}
 			} else if (priv->undecorated_smoothed_pwdb >=
-				   (RegC38_TH+5)) {
+				   (RegC38_TH + 5)) {
 				if (reg_c38_State) {
 					rtl92e_writeb(dev,
 						rOFDM0_RxDetector3,
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 1ca77cdbafa3..46cc22520f73 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -156,7 +156,7 @@ u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
 
 
 	for (i = 0; i < ieee->current_network.rates_len; i++) {
-		BasicRate = ieee->current_network.rates[i]&0x7F;
+		BasicRate = ieee->current_network.rates[i] & 0x7F;
 		if (!rtllib_is_cck_rate(BasicRate)) {
 			if (QueryRate == 0) {
 				QueryRate = BasicRate;
@@ -226,7 +226,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 		if (ieee->queue_stop) {
 			enqueue_mgmt(ieee, skb);
 		} else {
-			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0]<<4);
+			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 			if (ieee->seq_ctrl[0] == 0xFFF)
 				ieee->seq_ctrl[0] = 0;
@@ -494,7 +494,7 @@ static void rtllib_send_probe_requests(struct rtllib_device *ieee, u8 is_mesh)
 static void rtllib_update_active_chan_map(struct rtllib_device *ieee)
 {
 	memcpy(ieee->active_channel_map, GET_DOT11D_INFO(ieee)->channel_map,
-	       MAX_CHANNEL_NUMBER+1);
+	       MAX_CHANNEL_NUMBER + 1);
 }
 
 /* this performs syncro scan blocking the caller until all channels
@@ -817,7 +817,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 
 	char *ssid = ieee->current_network.ssid;
 	int ssid_len = ieee->current_network.ssid_len;
-	int rate_len = ieee->current_network.rates_len+2;
+	int rate_len = ieee->current_network.rates_len + 2;
 	int rate_ex_len = ieee->current_network.rates_ex_len;
 	int wpa_ie_len = ieee->wpa_ie_len;
 	u8 erpinfo_content = 0;
@@ -870,7 +870,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 		}
 	}
 
-	beacon_size = sizeof(struct rtllib_probe_response)+2+
+	beacon_size = sizeof(struct rtllib_probe_response) + 2 +
 		ssid_len + 3 + rate_len + rate_ex_len + atim_len + erp_len
 		+ wpa_ie_len + ieee->tx_headroom;
 	skb = dev_alloc_skb(beacon_size);
@@ -915,9 +915,9 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	tag += ssid_len;
 
 	*(tag++) = MFIE_TYPE_RATES;
-	*(tag++) = rate_len-2;
-	memcpy(tag, ieee->current_network.rates, rate_len-2);
-	tag += rate_len-2;
+	*(tag++) = rate_len - 2;
+	memcpy(tag, ieee->current_network.rates, rate_len - 2);
+	tag += rate_len - 2;
 
 	*(tag++) = MFIE_TYPE_DS_SET;
 	*(tag++) = 1;
@@ -939,9 +939,9 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	}
 	if (rate_ex_len) {
 		*(tag++) = MFIE_TYPE_RATES_EX;
-		*(tag++) = rate_ex_len-2;
-		memcpy(tag, ieee->current_network.rates_ex, rate_ex_len-2);
-		tag += rate_ex_len-2;
+		*(tag++) = rate_ex_len - 2;
+		memcpy(tag, ieee->current_network.rates_ex, rate_ex_len - 2);
+		tag += rate_ex_len - 2;
 	}
 
 	if (wpa_ie_len) {
@@ -1046,7 +1046,7 @@ static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
 	struct sk_buff *skb;
 	struct rtllib_hdr_3addr *hdr;
 
-	skb = dev_alloc_skb(sizeof(struct rtllib_hdr_3addr)+ieee->tx_headroom);
+	skb = dev_alloc_skb(sizeof(struct rtllib_hdr_3addr) + ieee->tx_headroom);
 	if (!skb)
 		return NULL;
 
@@ -1072,7 +1072,7 @@ static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 	struct sk_buff *skb;
 	struct rtllib_pspoll_hdr *hdr;
 
-	skb = dev_alloc_skb(sizeof(struct rtllib_pspoll_hdr)+ieee->tx_headroom);
+	skb = dev_alloc_skb(sizeof(struct rtllib_pspoll_hdr) + ieee->tx_headroom);
 	if (!skb)
 		return NULL;
 
@@ -1195,11 +1195,11 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (beacon->bCkipSupported)
-		ckip_ie_len = 30+2;
+		ckip_ie_len = 30 + 2;
 	if (beacon->bCcxRmEnable)
-		ccxrm_ie_len = 6+2;
+		ccxrm_ie_len = 6 + 2;
 	if (beacon->BssCcxVerNumber >= 2)
-		cxvernum_ie_len = 5+2;
+		cxvernum_ie_len = 5 + 2;
 
 	PMKCacheIdx = SecIsInPMKIDList(ieee, ieee->current_network.bssid);
 	if (PMKCacheIdx >= 0) {
@@ -1247,7 +1247,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE);
 
 	if (ieee->short_slot &&
-	   (beacon->capability&WLAN_CAPABILITY_SHORT_SLOT_TIME))
+	   (beacon->capability & WLAN_CAPABILITY_SHORT_SLOT_TIME))
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
 
 
@@ -1286,7 +1286,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		       sizeof(AironetIeOui));
 
 		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |=
-					 (SUPPORT_CKIP_PK|SUPPORT_CKIP_MIC);
+					 (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
 		tag = skb_put(skb, ckip_ie_len);
 		*tag++ = MFIE_TYPE_AIRONET;
 		*tag++ = osCcxAironetIE.Length;
@@ -1459,7 +1459,7 @@ static void rtllib_auth_challenge(struct rtllib_device *ieee, u8 *challenge,
 	if (!skb)
 		rtllib_associate_abort(ieee);
 	else {
-		c = skb_put(skb, chlen+2);
+		c = skb_put(skb, chlen + 2);
 		*(c++) = MFIE_TYPE_CHALLENGE;
 		*(c++) = chlen;
 		memcpy(c, challenge, chlen);
@@ -1471,7 +1471,7 @@ static void rtllib_auth_challenge(struct rtllib_device *ieee, u8 *challenge,
 					sizeof(struct rtllib_hdr_3addr));
 
 		softmac_mgmt_xmit(skb, ieee);
-		mod_timer(&ieee->associate_timer, jiffies + (HZ/2));
+		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
 	}
 	kfree(challenge);
 }
@@ -1491,7 +1491,7 @@ static void rtllib_associate_step2(struct rtllib_device *ieee)
 		rtllib_associate_abort(ieee);
 	else {
 		softmac_mgmt_xmit(skb, ieee);
-		mod_timer(&ieee->associate_timer, jiffies + (HZ/2));
+		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
 	}
 }
 
@@ -1887,7 +1887,7 @@ static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	   status_code == WLAN_STATUS_CAPS_UNSUPPORTED) &&
 	   ((ieee->mode == IEEE_G) &&
 	   (ieee->current_network.mode == IEEE_N_24G) &&
-	   (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT-1)))) {
+	   (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
 		ieee->ht_info->iot_action |= HT_IOT_ACT_PURE_N_MODE;
 	} else {
 		ieee->AsocRetryCount = 0;
@@ -2011,7 +2011,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 					LPSAwakeIntvl_tmp = period +
 						 (psc->LPSAwakeIntvl -
 						 period) -
-						 ((psc->LPSAwakeIntvl-period) %
+						 ((psc->LPSAwakeIntvl - period) %
 						 period);
 				else
 					LPSAwakeIntvl_tmp = psc->LPSAwakeIntvl;
@@ -2021,7 +2021,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 				    ieee->current_network.tim.tim_count)
 					LPSAwakeIntvl_tmp = count +
 					(psc->LPSAwakeIntvl - count) -
-					((psc->LPSAwakeIntvl-count)%period);
+					((psc->LPSAwakeIntvl - count) % period);
 				else
 					LPSAwakeIntvl_tmp = psc->LPSAwakeIntvl;
 			}
@@ -2370,7 +2370,7 @@ rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 						LED_CTL_START_TO_LINK);
 
 		if (!(ieee->rtllib_ap_sec_type(ieee) &
-		    (SEC_ALG_CCMP|SEC_ALG_TKIP)))
+		    (SEC_ALG_CCMP | SEC_ALG_TKIP)))
 			schedule_delayed_work(
 				       &ieee->associate_procedure_wq, 5);
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 1f2fa711e60b..789035e8a69a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -92,7 +92,7 @@ int rtllib_wx_get_freq(struct rtllib_device *ieee,
 
 	if (ieee->current_network.channel == 0)
 		return -1;
-	fwrq->m = rtllib_wlan_frequencies[ieee->current_network.channel-1] *
+	fwrq->m = rtllib_wlan_frequencies[ieee->current_network.channel - 1] *
 		  100000;
 	fwrq->e = 1;
 	return 0;
@@ -231,7 +231,7 @@ int rtllib_wx_set_rate(struct rtllib_device *ieee,
 
 	u32 target_rate = wrqu->bitrate.value;
 
-	ieee->rate = target_rate/100000;
+	ieee->rate = target_rate / 100000;
 	return 0;
 }
 EXPORT_SYMBOL(rtllib_wx_set_rate);
-- 
2.40.1

