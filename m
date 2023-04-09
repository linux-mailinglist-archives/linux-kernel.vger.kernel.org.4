Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E426DBFA7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDIL1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 07:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIL1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 07:27:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3861A40DC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 04:27:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a5126f2518so4062585ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681039624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HwUXVW1300mZtoHWnTqOH3dDMQDuPQfGANLi31VYxc0=;
        b=FNZEL6iWY9FLsZWdzyoj8xSmaVuxEzW5ysBayyX8/UC1+QqeR0keM+XEnlTaLjpMKw
         j8fxXEzTcLfDlpxIgiSv8ayx5bk37fNV8S8avAozPHCGce9921CDZBnlmfHguZHLG4Xh
         4SEHAC5ccBq8gcXCMWrJPp+7d9sIgtnkYleJ7WddCH9JOrx+ikfF/xExDBgmh5VTSAbX
         SsBqFmgKI5F00YAEwLDAdnxWUh9ihDfbyj99Z8Wn3p427HYcm5SW/i+O0kt+B+CgQSm8
         Op7wJhqRmUSf1kQ/aVi6s+Tes8RfwkeFkjLinox2M+v4/y3dK089zEuJrtXF2Sarym5C
         Im4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681039624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwUXVW1300mZtoHWnTqOH3dDMQDuPQfGANLi31VYxc0=;
        b=Up6JCYNbvLnBgmvFDb6J4Eqfximc18O8AnliHvR1vkSRdXxmrKnuT1+VGBppyYO5RS
         xYj1TCZN6EZItolodJWnAqMcnc5KVJ//5nH1/Un8F0S4yatuBX38tlbgwGtwGVOwJe6v
         /c77XZvq7g02VpOyz1WiKcYYGzLmYo45mm3rbFEfY4tnTaHH6UWnOLBL8id3Ax5pheeD
         n8t/KIkSRyLfAeMTCBgFboJXLYczOv7D/kgyWloY68kdABFHQIR3TKgSzMrPf7rskcy2
         DGkU152ubYsQPQAyfV6eOVx4Fjq+lFmEbzKMM/O2KbkSWNz3yR2XRUHiM/dxvaexv8U2
         TNwA==
X-Gm-Message-State: AAQBX9dTqUpRIpTsqhviY/XXCxuAQgYDPBrOUZfinR1CnyDeaIJCW+IP
        8Y7F1/FhFoy4Ee3Bsk5VOZ8=
X-Google-Smtp-Source: AKy350ZIXG8GZw19s66tyTjw2Xh+z1tVvO/66GsGhIeHArJPD+D5b9WfdfXIEU7qYS6337g1iclFoQ==
X-Received: by 2002:a62:8442:0:b0:628:1a59:4c1 with SMTP id k63-20020a628442000000b006281a5904c1mr9040344pfd.13.1681039624384;
        Sun, 09 Apr 2023 04:27:04 -0700 (PDT)
Received: from sumitra.com ([59.95.148.219])
        by smtp.gmail.com with ESMTPSA id u5-20020a62ed05000000b0062a56e51fd7sm5937006pfh.188.2023.04.09.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 04:27:03 -0700 (PDT)
Date:   Sun, 9 Apr 2023 04:27:04 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Remove unnecessary blank lines
Message-ID: <20230409112704.GA264154@sumitra.com>
References: <20230408155545.GA261160@sumitra.com>
 <052468bd-98db-a564-cf5f-0ea287b1025f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052468bd-98db-a564-cf5f-0ea287b1025f@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 09:05:19AM +0200, Philipp Hortmann wrote:
> On 4/8/23 17:55, Sumitra Sharma wrote:
> > Remove extra blank lines as suggested by the Linux kernel
> > coding-style. These issues were reported by checkpatch.
> > 
> > CHECK: Blank lines aren't necessary before a close brace '}'
> > CHECK: Blank lines aren't necessary after an open brace '{'
> > CHECK: Please don't use multiple blank lines
> > 
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> >   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 33 ----------------------
> >   1 file changed, 33 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> > index cde41111012a..421265261c73 100644
> > --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> > +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> > @@ -140,26 +140,22 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
> >   /*---------------------------Define Local Constant---------------------------*/
> > -
> >   /*------------------------Define global variable-----------------------------*/
> >   struct dig_t dm_digtable;
> >   struct drx_path_sel dm_rx_path_sel_table;
> >   /*------------------------Define global variable-----------------------------*/
> > -
> >   /*------------------------Define local variable------------------------------*/
> >   /*------------------------Define local variable------------------------------*/
> > -
> >   /*---------------------Define local function prototype-----------------------*/
> >   static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev);
> >   static void _rtl92e_dm_init_bandwidth_autoswitch(struct net_device *dev);
> >   static	void	_rtl92e_dm_bandwidth_autoswitch(struct net_device *dev);
> > -
> >   static	void	_rtl92e_dm_check_tx_power_tracking(struct net_device *dev);
> >   static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev);
> > @@ -180,7 +176,6 @@ static void _rtl92e_dm_check_rx_path_selection(struct net_device *dev);
> >   static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev);
> >   static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev);
> > -
> >   static void _rtl92e_dm_init_fsync(struct net_device *dev);
> >   static void _rtl92e_dm_deinit_fsync(struct net_device *dev);
> > @@ -222,9 +217,7 @@ void rtl92e_dm_init(struct net_device *dev)
> >   void rtl92e_dm_deinit(struct net_device *dev)
> >   {
> > -
> >   	_rtl92e_dm_deinit_fsync(dev);
> > -
> >   }
> >   void rtl92e_dm_watchdog(struct net_device *dev)
> > @@ -253,7 +246,6 @@ void rtl92e_dm_watchdog(struct net_device *dev)
> >   void rtl92e_init_adaptive_rate(struct net_device *dev)
> >   {
> > -
> >   	struct r8192_priv *priv = rtllib_priv(dev);
> >   	struct rate_adaptive *pra = &priv->rate_adaptive;
> > @@ -300,7 +292,6 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
> >   		return;
> >   	if (priv->rtllib->state == RTLLIB_LINKED) {
> > -
> >   		bshort_gi_enabled = (ht_info->cur_tx_bw40mhz &&
> >   				     ht_info->bCurShortGI40MHz) ||
> >   				    (!ht_info->cur_tx_bw40mhz &&
> > @@ -527,7 +518,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
> >   	priv->rtllib->bdynamic_txpower_enable = false;
> >   	for (j = 0; j <= 30; j++) {
> > -
> >   		tx_cmd.op	= TXCMD_SET_TX_PWR_TRACKING;
> >   		tx_cmd.length	= 4;
> >   		tx_cmd.value	= priv->pwr_track >> 24;
> > @@ -759,20 +749,17 @@ void rtl92e_dm_txpower_tracking_wq(void *data)
> >   static void _rtl92e_dm_initialize_tx_power_tracking_tssi(struct net_device *dev)
> >   {
> > -
> >   	struct r8192_priv *priv = rtllib_priv(dev);
> >   	priv->btxpower_tracking = true;
> >   	priv->txpower_count       = 0;
> >   	priv->tx_pwr_tracking_init = false;
> > -
> >   }
> >   static void _rtl92e_dm_init_tx_power_tracking_thermal(struct net_device *dev)
> >   {
> >   	struct r8192_priv *priv = rtllib_priv(dev);
> > -
> >   	if (priv->rtllib->FwRWRF)
> >   		priv->btxpower_tracking = true;
> >   	else
> > @@ -802,12 +789,10 @@ static void _rtl92e_dm_check_tx_power_tracking_tssi(struct net_device *dev)
> >   		return;
> >   	tx_power_track_counter++;
> > -
> >   	if (tx_power_track_counter >= 180) {
> >   		schedule_delayed_work(&priv->txpower_tracking_wq, 0);
> >   		tx_power_track_counter = 0;
> >   	}
> > -
> >   }
> >   static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
> > @@ -839,7 +824,6 @@ static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
> >   	netdev_info(dev, "===============>Schedule TxPowerTrackingWorkItem\n");
> >   	schedule_delayed_work(&priv->txpower_tracking_wq, 0);
> >   	TM_Trigger = 0;
> > -
> >   }
> >   static void _rtl92e_dm_check_tx_power_tracking(struct net_device *dev)
> > @@ -971,7 +955,6 @@ void rtl92e_dm_restore_state(struct net_device *dev)
> >   		_rtl92e_dm_tx_power_reset_recovery(dev);
> >   	_rtl92e_dm_bb_initialgain_restore(dev);
> > -
> >   }
> >   static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
> > @@ -995,7 +978,6 @@ static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
> >   	rtl92e_set_bb_reg(dev, rCCK0_CCA, bit_mask,
> >   			  (u32)priv->initgain_backup.cca);
> >   	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
> > -
> >   }
> >   void rtl92e_dm_backup_state(struct net_device *dev)
> > @@ -1050,7 +1032,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
> >   static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
> >   {
> > -
> >   	if (!dm_digtable.dig_enable_flag)
> >   		return;
> > @@ -1103,7 +1084,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
> >   	else
> >   		dm_digtable.cur_sta_connect_state = DIG_STA_DISCONNECT;
> > -
> >   	dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
> >   	_rtl92e_dm_initial_gain(dev);
> >   	_rtl92e_dm_pd_th(dev);
> > @@ -1111,7 +1091,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
> >   	if (dm_digtable.dig_algorithm_switch)
> >   		dm_digtable.dig_algorithm_switch = 0;
> >   	dm_digtable.pre_sta_connect_state = dm_digtable.cur_sta_connect_state;
> > -
> >   }
> >   static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
> > @@ -1201,7 +1180,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
> >   	_rtl92e_dm_ctrl_initgain_byrssi_highpwr(dev);
> >   }
> > -
> >   static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
> >   {
> >   	struct r8192_priv *priv = rtllib_priv(dev);
> > @@ -1399,7 +1377,6 @@ static void _rtl92e_dm_cs_ratio(struct net_device *dev)
> >   		reset_cnt = priv->reset_count;
> >   	}
> > -
> >   	if ((dm_digtable.precs_ratio_state != dm_digtable.curcs_ratio_state) ||
> >   	    !initialized || force_write) {
> >   		if (dm_digtable.curcs_ratio_state == DIG_CS_RATIO_LOWER)
> > @@ -1481,7 +1458,6 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
> >   						      edca_setting_UL[ht_info->IOTPeer]);
> >   					priv->bis_cur_rdlstate = false;
> >   				}
> > -
> >   			}
> >   			priv->bcurrent_turbo_EDCA = true;
> > @@ -1496,7 +1472,6 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
> >   		}
> >   	}
> > -
> >   dm_CheckEdcaTurbo_EXIT:
> >   	priv->rtllib->bis_any_nonbepkts = false;
> >   	lastTxOkCnt = priv->stats.txbytesunicast;
> > @@ -1536,7 +1511,6 @@ static void _rtl92e_dm_cts_to_self(struct net_device *dev)
> >   	}
> >   }
> > -
> >   static void _rtl92e_dm_init_wa_broadcom_iot(struct net_device *dev)
> >   {
> >   	struct r8192_priv *priv = rtllib_priv((struct net_device *)dev);
> > @@ -1767,7 +1741,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
> >   						tmp_cck_min_pwdb = cur_cck_pwdb;
> >   					}
> >   				}
> > -
> >   			}
> >   		}
> >   	}
> > @@ -1833,7 +1806,6 @@ static void _rtl92e_dm_check_rx_path_selection(struct net_device *dev)
> >   	schedule_delayed_work(&priv->rfpath_check_wq, 0);
> >   }
> > -
> >   static void _rtl92e_dm_init_fsync(struct net_device *dev)
> >   {
> >   	struct r8192_priv *priv = rtllib_priv(dev);
> > @@ -1851,7 +1823,6 @@ static void _rtl92e_dm_init_fsync(struct net_device *dev)
> >   	timer_setup(&priv->fsync_timer, _rtl92e_dm_fsync_timer_callback, 0);
> >   }
> > -
> >   static void _rtl92e_dm_deinit_fsync(struct net_device *dev)
> >   {
> >   	struct r8192_priv *priv = rtllib_priv(dev);
> > @@ -1886,7 +1857,6 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
> >   		else
> >   			rate_count_diff = rate_count - priv->rate_record;
> >   		if (rate_count_diff < priv->rate_count_diff_rec) {
> > -
> >   			u32 DiffNum = priv->rate_count_diff_rec -
> >   				      rate_count_diff;
> >   			if (DiffNum >=
> > @@ -2027,7 +1997,6 @@ static void _rtl92e_dm_start_sw_fsync(struct net_device *dev)
> >   	add_timer(&priv->fsync_timer);
> >   	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c12cd);
> > -
> >   }
> >   static void _rtl92e_dm_check_fsync(struct net_device *dev)
> > @@ -2070,7 +2039,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
> >   			case SW_Fsync:
> >   			default:
> >   				break;
> > -
> >   			}
> >   		}
> >   		if (priv->frame_sync_monitor) {
> > @@ -2198,7 +2166,6 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
> >   	}
> >   	priv->last_dtp_flag_high = priv->dynamic_tx_high_pwr;
> >   	priv->last_dtp_flag_low = priv->dynamic_tx_low_pwr;
> > -
> >   }
> >   static void _rtl92e_dm_check_txrateandretrycount(struct net_device *dev)
> 
> Hi,
> 
> Please do not send in patches at almost the same time with exactly the same
> name. I need to look into the patch to find out which one is which.
> 


Hi Philipp 

I am sorry. I will take care of it.

> This patch interfears with one of my patches. So only one can be accepted
> and the otherone has to rebase. Will see what happens.
>

Okay Thank you.

Regards
Sumitra

> Bye Philipp
