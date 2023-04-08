Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DF6DBC0B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDHPz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjDHPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:55:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3611DFF0F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:55:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b5-20020a17090a6e0500b0023f32869993so3734680pjk.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680969352;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YhLiSrQRrRKj3ZUWxw4iyN90xaGUkc1Bu+//deqrm1M=;
        b=DUYjyNUKoZ3SeeB0Z4F+bQ3D5BQX13Q77HaN3Z7g9NXJsxUtdPNlVluzgccpE3v4uT
         1kS/7ykGl84rSrmmqvdwBaD3b1df0bRGYJAtlO+oui0E4ZSI4t97A+MzWOJv0XZub2+m
         2vdV+Sp+pbypcsaNF+p7ic02ZWonIYSmax81YEr+IRCfzp+2YH+R3MQGuBn+kZD5o3XT
         sAzdTEtO2h10Ddpo6PkSaTtJoNjR1nhQkhZlb35thPXcZGmDDqptIEN/guBuZTPpfRGT
         N/IM9fJP9AXtT3qRscBHGTnqSY50XIgZ/8ZgehqWVP5wmHGdh2LO6B3ziu+lAci3xp43
         L3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680969352;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhLiSrQRrRKj3ZUWxw4iyN90xaGUkc1Bu+//deqrm1M=;
        b=GKm4ZO29Xqc+Bk6SII4BBHAQeZz2nFId7FR0glMIJRGknBxxQ/X4chsAhdXUC+ndTC
         5LPgwH/RneachiiUDaJ53iQ/i9YL2wTn/Xbek1jdk/tVzmHb58aiwi/BQxzBUodKVFst
         anExbV4BXRBwhuZnOuUW25ZoFlrirN/uabNqRDX0IaZGxg++ZXDRXqpa2qV8pMehbHhl
         GTUs5pHMSbeWbkvnGZvdGgUeNTVwMQPe/T1xb8BZ2O7Z2Zl52ZJhSz3dY5BBm7zUn4hi
         hYLD2iUEhTqgNVp9B0NRV2wCLfW7Vng4tmt33acsWntdPPT+OvvJ1ndicPR0YvlMga5L
         tm+w==
X-Gm-Message-State: AAQBX9fvFZpdG7ZABs3CsSNmMgHvDRhi74Djnu11NUYKmMBcs80V1JHq
        ogCFEA8SuK4f541341U89pK2NoJR80BkWA==
X-Google-Smtp-Source: AKy350brK0at2hJng+mWXh2m4WuOdoAu6ULkBy2ntNgZjvK8F00fwnHfW6pW7ucZ+a3nIcwqJCQXAg==
X-Received: by 2002:a17:90a:b791:b0:23f:d487:1bc8 with SMTP id m17-20020a17090ab79100b0023fd4871bc8mr13780852pjr.13.1680969352279;
        Sat, 08 Apr 2023 08:55:52 -0700 (PDT)
Received: from sumitra.com ([117.207.136.97])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090a738900b00240afe72365sm6374787pjg.16.2023.04.08.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 08:55:51 -0700 (PDT)
Date:   Sat, 8 Apr 2023 08:55:45 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Remove unnecessary blank lines
Message-ID: <20230408155545.GA261160@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra blank lines as suggested by the Linux kernel
coding-style. These issues were reported by checkpatch.

CHECK: Blank lines aren't necessary before a close brace '}'
CHECK: Blank lines aren't necessary after an open brace '{'
CHECK: Please don't use multiple blank lines

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 33 ----------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index cde41111012a..421265261c73 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -140,26 +140,22 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
 
 /*---------------------------Define Local Constant---------------------------*/
 
-
 /*------------------------Define global variable-----------------------------*/
 struct dig_t dm_digtable;
 
 struct drx_path_sel dm_rx_path_sel_table;
 /*------------------------Define global variable-----------------------------*/
 
-
 /*------------------------Define local variable------------------------------*/
 /*------------------------Define local variable------------------------------*/
 
 
-
 /*---------------------Define local function prototype-----------------------*/
 static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev);
 
 static void _rtl92e_dm_init_bandwidth_autoswitch(struct net_device *dev);
 static	void	_rtl92e_dm_bandwidth_autoswitch(struct net_device *dev);
 
-
 static	void	_rtl92e_dm_check_tx_power_tracking(struct net_device *dev);
 
 static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev);
@@ -180,7 +176,6 @@ static void _rtl92e_dm_check_rx_path_selection(struct net_device *dev);
 static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev);
 static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev);
 
-
 static void _rtl92e_dm_init_fsync(struct net_device *dev);
 static void _rtl92e_dm_deinit_fsync(struct net_device *dev);
 
@@ -222,9 +217,7 @@ void rtl92e_dm_init(struct net_device *dev)
 
 void rtl92e_dm_deinit(struct net_device *dev)
 {
-
 	_rtl92e_dm_deinit_fsync(dev);
-
 }
 
 void rtl92e_dm_watchdog(struct net_device *dev)
@@ -253,7 +246,6 @@ void rtl92e_dm_watchdog(struct net_device *dev)
 
 void rtl92e_init_adaptive_rate(struct net_device *dev)
 {
-
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rate_adaptive *pra = &priv->rate_adaptive;
 
@@ -300,7 +292,6 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 		return;
 
 	if (priv->rtllib->state == RTLLIB_LINKED) {
-
 		bshort_gi_enabled = (ht_info->cur_tx_bw40mhz &&
 				     ht_info->bCurShortGI40MHz) ||
 				    (!ht_info->cur_tx_bw40mhz &&
@@ -527,7 +518,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	priv->rtllib->bdynamic_txpower_enable = false;
 
 	for (j = 0; j <= 30; j++) {
-
 		tx_cmd.op	= TXCMD_SET_TX_PWR_TRACKING;
 		tx_cmd.length	= 4;
 		tx_cmd.value	= priv->pwr_track >> 24;
@@ -759,20 +749,17 @@ void rtl92e_dm_txpower_tracking_wq(void *data)
 
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
@@ -802,12 +789,10 @@ static void _rtl92e_dm_check_tx_power_tracking_tssi(struct net_device *dev)
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
@@ -839,7 +824,6 @@ static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
 	netdev_info(dev, "===============>Schedule TxPowerTrackingWorkItem\n");
 	schedule_delayed_work(&priv->txpower_tracking_wq, 0);
 	TM_Trigger = 0;
-
 }
 
 static void _rtl92e_dm_check_tx_power_tracking(struct net_device *dev)
@@ -971,7 +955,6 @@ void rtl92e_dm_restore_state(struct net_device *dev)
 		_rtl92e_dm_tx_power_reset_recovery(dev);
 
 	_rtl92e_dm_bb_initialgain_restore(dev);
-
 }
 
 static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
@@ -995,7 +978,6 @@ static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
 	rtl92e_set_bb_reg(dev, rCCK0_CCA, bit_mask,
 			  (u32)priv->initgain_backup.cca);
 	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
-
 }
 
 void rtl92e_dm_backup_state(struct net_device *dev)
@@ -1050,7 +1032,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 
 static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
 {
-
 	if (!dm_digtable.dig_enable_flag)
 		return;
 
@@ -1103,7 +1084,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 	else
 		dm_digtable.cur_sta_connect_state = DIG_STA_DISCONNECT;
 
-
 	dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
 	_rtl92e_dm_initial_gain(dev);
 	_rtl92e_dm_pd_th(dev);
@@ -1111,7 +1091,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 	if (dm_digtable.dig_algorithm_switch)
 		dm_digtable.dig_algorithm_switch = 0;
 	dm_digtable.pre_sta_connect_state = dm_digtable.cur_sta_connect_state;
-
 }
 
 static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
@@ -1201,7 +1180,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 	_rtl92e_dm_ctrl_initgain_byrssi_highpwr(dev);
 }
 
-
 static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -1399,7 +1377,6 @@ static void _rtl92e_dm_cs_ratio(struct net_device *dev)
 		reset_cnt = priv->reset_count;
 	}
 
-
 	if ((dm_digtable.precs_ratio_state != dm_digtable.curcs_ratio_state) ||
 	    !initialized || force_write) {
 		if (dm_digtable.curcs_ratio_state == DIG_CS_RATIO_LOWER)
@@ -1481,7 +1458,6 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 						      edca_setting_UL[ht_info->IOTPeer]);
 					priv->bis_cur_rdlstate = false;
 				}
-
 			}
 
 			priv->bcurrent_turbo_EDCA = true;
@@ -1496,7 +1472,6 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 		}
 	}
 
-
 dm_CheckEdcaTurbo_EXIT:
 	priv->rtllib->bis_any_nonbepkts = false;
 	lastTxOkCnt = priv->stats.txbytesunicast;
@@ -1536,7 +1511,6 @@ static void _rtl92e_dm_cts_to_self(struct net_device *dev)
 	}
 }
 
-
 static void _rtl92e_dm_init_wa_broadcom_iot(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv((struct net_device *)dev);
@@ -1767,7 +1741,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 						tmp_cck_min_pwdb = cur_cck_pwdb;
 					}
 				}
-
 			}
 		}
 	}
@@ -1833,7 +1806,6 @@ static void _rtl92e_dm_check_rx_path_selection(struct net_device *dev)
 	schedule_delayed_work(&priv->rfpath_check_wq, 0);
 }
 
-
 static void _rtl92e_dm_init_fsync(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -1851,7 +1823,6 @@ static void _rtl92e_dm_init_fsync(struct net_device *dev)
 	timer_setup(&priv->fsync_timer, _rtl92e_dm_fsync_timer_callback, 0);
 }
 
-
 static void _rtl92e_dm_deinit_fsync(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -1886,7 +1857,6 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
 		else
 			rate_count_diff = rate_count - priv->rate_record;
 		if (rate_count_diff < priv->rate_count_diff_rec) {
-
 			u32 DiffNum = priv->rate_count_diff_rec -
 				      rate_count_diff;
 			if (DiffNum >=
@@ -2027,7 +1997,6 @@ static void _rtl92e_dm_start_sw_fsync(struct net_device *dev)
 	add_timer(&priv->fsync_timer);
 
 	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c12cd);
-
 }
 
 static void _rtl92e_dm_check_fsync(struct net_device *dev)
@@ -2070,7 +2039,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 			case SW_Fsync:
 			default:
 				break;
-
 			}
 		}
 		if (priv->frame_sync_monitor) {
@@ -2198,7 +2166,6 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 	}
 	priv->last_dtp_flag_high = priv->dynamic_tx_high_pwr;
 	priv->last_dtp_flag_low = priv->dynamic_tx_low_pwr;
-
 }
 
 static void _rtl92e_dm_check_txrateandretrycount(struct net_device *dev)
-- 
2.25.1

