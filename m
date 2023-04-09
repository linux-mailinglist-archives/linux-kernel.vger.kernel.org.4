Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813696DBF08
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDIHF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 03:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 03:05:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D14DF4
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 00:05:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94706a972f3so43079166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681023921; x=1683615921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BOkY+ky4SbuSPBMaY8sn3NPpyr+PwRWOIJ+MmW4WIDA=;
        b=l/tBpFX0FFU+EtBzHL8hU3vw0WpMuXEzmUzIrZ5GoOSKnRVI+Vd78RNIiMorYQIjH6
         gyxdiN64KR1YacceImXOHtiB+bEa+PzuPgdvm2ZFsvF9hBzhoRE+q1MYZZIZWactLzFb
         fiX2WOR9xMqp1F9ARTsTHw7AI3YPFD2QrDtMwiPYGCYNXJxVS7iIJNnyAlAUa7WlxPOg
         HJQ6LL7XQnkGOQypnPOnBxS/oXACQ64eOazD3wCqb7I+pxrOc5e2tJedrdJZx/xU27JM
         f1BGFD6DTUQURPH/uNSLv7D/SAPIRSEZ0A2fE1WYvZKUHUe/VsEt3UjkUUysR4UXfjDH
         iQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681023921; x=1683615921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOkY+ky4SbuSPBMaY8sn3NPpyr+PwRWOIJ+MmW4WIDA=;
        b=oC70sjaDwFoGaSdHraCHiK3S4cfDvbGJMjRCYlzMrwjFzgMsU0vVwTysXUBroHaRM3
         L/vsKfZptJqv+qYC99Cy4oM1VNVG8Bq76JEs+OgfMga+Lasa/7xNOUcljuLWguPt2PXG
         LWzV3YLEGjtpzSsa4T/NeAV1dy+kd1sA+5ozHuKCKMbzy94nA72g+WFtQgTftd9F5GbA
         ZR7PK0gUQPoztRgjXfHbh+cjwiykXQNjbBqMzusUiQzHzqdoN1HkeJVJo3o4kD1w6zPI
         2C39PjHHsXUK1I8YZtATlu5xB4LSS3b/I+VDo2MdAkyW2p56+cjs1SYJxKn+qPr6+A0+
         vjKA==
X-Gm-Message-State: AAQBX9ezJMXf0Qjvtgy6nHlbY9KuP1p1khJbxlYG70xCcJ0FPWMd8gF0
        XxQ92OWg21x5A+E8JOqM2mg=
X-Google-Smtp-Source: AKy350aAtXTROEf7m2xmmABAXLiAMJ6sj+BkCkpOvk4zo093HT61Oku3vmG/9TnsksBhUX7WHj4ntg==
X-Received: by 2002:a17:906:1041:b0:92e:f520:7762 with SMTP id j1-20020a170906104100b0092ef5207762mr3918548ejj.6.1681023921480;
        Sun, 09 Apr 2023 00:05:21 -0700 (PDT)
Received: from [192.168.0.103] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id oz8-20020a1709077d8800b0093120a11a5dsm3878383ejc.92.2023.04.09.00.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 00:05:20 -0700 (PDT)
Message-ID: <052468bd-98db-a564-cf5f-0ea287b1025f@gmail.com>
Date:   Sun, 9 Apr 2023 09:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] staging: rtl8192e: Remove unnecessary blank lines
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230408155545.GA261160@sumitra.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230408155545.GA261160@sumitra.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 17:55, Sumitra Sharma wrote:
> Remove extra blank lines as suggested by the Linux kernel
> coding-style. These issues were reported by checkpatch.
> 
> CHECK: Blank lines aren't necessary before a close brace '}'
> CHECK: Blank lines aren't necessary after an open brace '{'
> CHECK: Please don't use multiple blank lines
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 33 ----------------------
>   1 file changed, 33 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index cde41111012a..421265261c73 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -140,26 +140,22 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
>   
>   /*---------------------------Define Local Constant---------------------------*/
>   
> -
>   /*------------------------Define global variable-----------------------------*/
>   struct dig_t dm_digtable;
>   
>   struct drx_path_sel dm_rx_path_sel_table;
>   /*------------------------Define global variable-----------------------------*/
>   
> -
>   /*------------------------Define local variable------------------------------*/
>   /*------------------------Define local variable------------------------------*/
>   
>   
> -
>   /*---------------------Define local function prototype-----------------------*/
>   static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev);
>   
>   static void _rtl92e_dm_init_bandwidth_autoswitch(struct net_device *dev);
>   static	void	_rtl92e_dm_bandwidth_autoswitch(struct net_device *dev);
>   
> -
>   static	void	_rtl92e_dm_check_tx_power_tracking(struct net_device *dev);
>   
>   static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev);
> @@ -180,7 +176,6 @@ static void _rtl92e_dm_check_rx_path_selection(struct net_device *dev);
>   static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev);
>   static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev);
>   
> -
>   static void _rtl92e_dm_init_fsync(struct net_device *dev);
>   static void _rtl92e_dm_deinit_fsync(struct net_device *dev);
>   
> @@ -222,9 +217,7 @@ void rtl92e_dm_init(struct net_device *dev)
>   
>   void rtl92e_dm_deinit(struct net_device *dev)
>   {
> -
>   	_rtl92e_dm_deinit_fsync(dev);
> -
>   }
>   
>   void rtl92e_dm_watchdog(struct net_device *dev)
> @@ -253,7 +246,6 @@ void rtl92e_dm_watchdog(struct net_device *dev)
>   
>   void rtl92e_init_adaptive_rate(struct net_device *dev)
>   {
> -
>   	struct r8192_priv *priv = rtllib_priv(dev);
>   	struct rate_adaptive *pra = &priv->rate_adaptive;
>   
> @@ -300,7 +292,6 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
>   		return;
>   
>   	if (priv->rtllib->state == RTLLIB_LINKED) {
> -
>   		bshort_gi_enabled = (ht_info->cur_tx_bw40mhz &&
>   				     ht_info->bCurShortGI40MHz) ||
>   				    (!ht_info->cur_tx_bw40mhz &&
> @@ -527,7 +518,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
>   	priv->rtllib->bdynamic_txpower_enable = false;
>   
>   	for (j = 0; j <= 30; j++) {
> -
>   		tx_cmd.op	= TXCMD_SET_TX_PWR_TRACKING;
>   		tx_cmd.length	= 4;
>   		tx_cmd.value	= priv->pwr_track >> 24;
> @@ -759,20 +749,17 @@ void rtl92e_dm_txpower_tracking_wq(void *data)
>   
>   static void _rtl92e_dm_initialize_tx_power_tracking_tssi(struct net_device *dev)
>   {
> -
>   	struct r8192_priv *priv = rtllib_priv(dev);
>   
>   	priv->btxpower_tracking = true;
>   	priv->txpower_count       = 0;
>   	priv->tx_pwr_tracking_init = false;
> -
>   }
>   
>   static void _rtl92e_dm_init_tx_power_tracking_thermal(struct net_device *dev)
>   {
>   	struct r8192_priv *priv = rtllib_priv(dev);
>   
> -
>   	if (priv->rtllib->FwRWRF)
>   		priv->btxpower_tracking = true;
>   	else
> @@ -802,12 +789,10 @@ static void _rtl92e_dm_check_tx_power_tracking_tssi(struct net_device *dev)
>   		return;
>   	tx_power_track_counter++;
>   
> -
>   	if (tx_power_track_counter >= 180) {
>   		schedule_delayed_work(&priv->txpower_tracking_wq, 0);
>   		tx_power_track_counter = 0;
>   	}
> -
>   }
>   
>   static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
> @@ -839,7 +824,6 @@ static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
>   	netdev_info(dev, "===============>Schedule TxPowerTrackingWorkItem\n");
>   	schedule_delayed_work(&priv->txpower_tracking_wq, 0);
>   	TM_Trigger = 0;
> -
>   }
>   
>   static void _rtl92e_dm_check_tx_power_tracking(struct net_device *dev)
> @@ -971,7 +955,6 @@ void rtl92e_dm_restore_state(struct net_device *dev)
>   		_rtl92e_dm_tx_power_reset_recovery(dev);
>   
>   	_rtl92e_dm_bb_initialgain_restore(dev);
> -
>   }
>   
>   static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
> @@ -995,7 +978,6 @@ static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
>   	rtl92e_set_bb_reg(dev, rCCK0_CCA, bit_mask,
>   			  (u32)priv->initgain_backup.cca);
>   	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
> -
>   }
>   
>   void rtl92e_dm_backup_state(struct net_device *dev)
> @@ -1050,7 +1032,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
>   
>   static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
>   {
> -
>   	if (!dm_digtable.dig_enable_flag)
>   		return;
>   
> @@ -1103,7 +1084,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
>   	else
>   		dm_digtable.cur_sta_connect_state = DIG_STA_DISCONNECT;
>   
> -
>   	dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
>   	_rtl92e_dm_initial_gain(dev);
>   	_rtl92e_dm_pd_th(dev);
> @@ -1111,7 +1091,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
>   	if (dm_digtable.dig_algorithm_switch)
>   		dm_digtable.dig_algorithm_switch = 0;
>   	dm_digtable.pre_sta_connect_state = dm_digtable.cur_sta_connect_state;
> -
>   }
>   
>   static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
> @@ -1201,7 +1180,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
>   	_rtl92e_dm_ctrl_initgain_byrssi_highpwr(dev);
>   }
>   
> -
>   static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
>   {
>   	struct r8192_priv *priv = rtllib_priv(dev);
> @@ -1399,7 +1377,6 @@ static void _rtl92e_dm_cs_ratio(struct net_device *dev)
>   		reset_cnt = priv->reset_count;
>   	}
>   
> -
>   	if ((dm_digtable.precs_ratio_state != dm_digtable.curcs_ratio_state) ||
>   	    !initialized || force_write) {
>   		if (dm_digtable.curcs_ratio_state == DIG_CS_RATIO_LOWER)
> @@ -1481,7 +1458,6 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
>   						      edca_setting_UL[ht_info->IOTPeer]);
>   					priv->bis_cur_rdlstate = false;
>   				}
> -
>   			}
>   
>   			priv->bcurrent_turbo_EDCA = true;
> @@ -1496,7 +1472,6 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
>   		}
>   	}
>   
> -
>   dm_CheckEdcaTurbo_EXIT:
>   	priv->rtllib->bis_any_nonbepkts = false;
>   	lastTxOkCnt = priv->stats.txbytesunicast;
> @@ -1536,7 +1511,6 @@ static void _rtl92e_dm_cts_to_self(struct net_device *dev)
>   	}
>   }
>   
> -
>   static void _rtl92e_dm_init_wa_broadcom_iot(struct net_device *dev)
>   {
>   	struct r8192_priv *priv = rtllib_priv((struct net_device *)dev);
> @@ -1767,7 +1741,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
>   						tmp_cck_min_pwdb = cur_cck_pwdb;
>   					}
>   				}
> -
>   			}
>   		}
>   	}
> @@ -1833,7 +1806,6 @@ static void _rtl92e_dm_check_rx_path_selection(struct net_device *dev)
>   	schedule_delayed_work(&priv->rfpath_check_wq, 0);
>   }
>   
> -
>   static void _rtl92e_dm_init_fsync(struct net_device *dev)
>   {
>   	struct r8192_priv *priv = rtllib_priv(dev);
> @@ -1851,7 +1823,6 @@ static void _rtl92e_dm_init_fsync(struct net_device *dev)
>   	timer_setup(&priv->fsync_timer, _rtl92e_dm_fsync_timer_callback, 0);
>   }
>   
> -
>   static void _rtl92e_dm_deinit_fsync(struct net_device *dev)
>   {
>   	struct r8192_priv *priv = rtllib_priv(dev);
> @@ -1886,7 +1857,6 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
>   		else
>   			rate_count_diff = rate_count - priv->rate_record;
>   		if (rate_count_diff < priv->rate_count_diff_rec) {
> -
>   			u32 DiffNum = priv->rate_count_diff_rec -
>   				      rate_count_diff;
>   			if (DiffNum >=
> @@ -2027,7 +1997,6 @@ static void _rtl92e_dm_start_sw_fsync(struct net_device *dev)
>   	add_timer(&priv->fsync_timer);
>   
>   	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c12cd);
> -
>   }
>   
>   static void _rtl92e_dm_check_fsync(struct net_device *dev)
> @@ -2070,7 +2039,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
>   			case SW_Fsync:
>   			default:
>   				break;
> -
>   			}
>   		}
>   		if (priv->frame_sync_monitor) {
> @@ -2198,7 +2166,6 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
>   	}
>   	priv->last_dtp_flag_high = priv->dynamic_tx_high_pwr;
>   	priv->last_dtp_flag_low = priv->dynamic_tx_low_pwr;
> -
>   }
>   
>   static void _rtl92e_dm_check_txrateandretrycount(struct net_device *dev)

Hi,

Please do not send in patches at almost the same time with exactly the 
same name. I need to look into the patch to find out which one is which.

This patch interfears with one of my patches. So only one can be 
accepted and the otherone has to rebase. Will see what happens.

Bye Philipp
