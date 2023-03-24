Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE036C7E84
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjCXNNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjCXNNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:13:01 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243A61AB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G/kLtvP0jJshzL5H7/dAFWeuJWSoZduny346x6ZVfHs=;
  b=auG2McGE4DDUBFXEhbAu7kK26D0PNKAnQKv0A8XztJvbmr1OT3+jopLm
   1iHWxaVfJ0Bdp/PyN1MdT5jAlXIdES5iq/3ZutWvu2MqDQofZVE+Ne3SJ
   3Vf0AftrPwYLscFcO16fSvzk/CMM/70IZ8am+tvPwp/j6hJMgCnBZQgL9
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="98940679"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 14:12:42 +0100
Date:   Fri, 24 Mar 2023 14:12:41 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging rtl8192u: fix block comments
In-Reply-To: <ZB2a5zwYpBZ/6qwU@khadija-virtual-machine>
Message-ID: <b55ce570-2b50-4fcd-b9b1-c873d4aa56f@inria.fr>
References: <ZB2a5zwYpBZ/6qwU@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Mar 2023, Khadija Kamran wrote:

> Linux kernel coding style for block comments uses a column of '*' on the
> left side and ends the comment with '*/' on a separate line.
>
> Fix block comments by adding '*' on subsequent lines and moving '*/' at
> the end of block comments on a separate line. These issues in block
> comments are reported by checkpatch.pl script.

Normally, code in comments can just be removed.

julia

>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_dm.c | 162 ++++++++++++++-------------
>  1 file changed, 86 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
> index 6a33ca02c3dc..a88686be3523 100644
> --- a/drivers/staging/rtl8192u/r8192U_dm.c
> +++ b/drivers/staging/rtl8192u/r8192U_dm.c
> @@ -1,19 +1,20 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*++
> -Copyright-c Realtek Semiconductor Corp. All rights reserved.
> -
> -Module Name:
> -	r8192U_dm.c
> -
> -Abstract:
> -	HW dynamic mechanism.
> -
> -Major Change History:
> -	When		Who				What
> -	----------	--------------- -------------------------------
> -	2008-05-14	amy                     create version 0 porting from windows code.
> -
> ---*/
> + * Copyright-c Realtek Semiconductor Corp. All rights reserved.
> + *
> + * Module Name:
> + *	r8192U_dm.c
> + *
> + * Abstract:
> + *	HW dynamic mechanism.
> + *
> + * Major Change History:
> + *	When		Who				What
> + *	----------	--------------- -------------------------------
> + *	2008-05-14	amy                     create version 0 porting from windows code.
> + *
> + *--
> + */
>  #include "r8192U.h"
>  #include "r8192U_dm.h"
>  #include "r8192U_hw.h"
> @@ -147,20 +148,20 @@ void dm_CheckRxAggregation(struct net_device *dev)
>  	unsigned long		curRxOkCnt = 0;
>
>  /*
> -	if (pHalData->bForcedUsbRxAggr) {
> -		if (pHalData->ForcedUsbRxAggrInfo == 0) {
> -			if (pHalData->bCurrentRxAggrEnable) {
> -				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, FALSE);
> -			}
> -		} else {
> -			if (!pHalData->bCurrentRxAggrEnable || (pHalData->ForcedUsbRxAggrInfo != pHalData->LastUsbRxAggrInfoSetting)) {
> -				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, TRUE);
> -			}
> -		}
> -		return;
> -	}
> -
> -*/
> + *	if (pHalData->bForcedUsbRxAggr) {
> + *		if (pHalData->ForcedUsbRxAggrInfo == 0) {
> + *			if (pHalData->bCurrentRxAggrEnable) {
> + *				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, FALSE);
> + *			}
> + *		} else {
> + *			if (!pHalData->bCurrentRxAggrEnable || (pHalData->ForcedUsbRxAggrInfo != pHalData->LastUsbRxAggrInfoSetting)) {
> + *				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, TRUE);
> + *			}
> + *		}
> + *		return;
> + *	}
> + *
> + */
>  	curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
>  	curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
>
> @@ -279,7 +280,8 @@ void init_rate_adaptive(struct net_device *dev)
>   *	When		Who		Remark
>   *	05/26/08	amy	Create version 0 porting from windows code.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  static void dm_check_rate_adaptive(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
> @@ -377,8 +379,9 @@ static void dm_check_rate_adaptive(struct net_device *dev)
>  					targetRATR = pra->ping_rssi_ratr;
>  					ping_rssi_state = 1;
>  				}
> -				/*else
> -					DbgPrint("TestRSSI is between the range.\n");*/
> +				/* else
> +				 *	DbgPrint("TestRSSI is between the range.\n");
> +				 */
>  			} else {
>  				/*DbgPrint("TestRSSI Recover to 0x%x\n", targetRATR);*/
>  				ping_rssi_state = 0;
> @@ -719,9 +722,10 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
>  		}
>  		tmpCCK40Mindex = 0;
>  	}
> -	/*DbgPrint("%ddb, tmpOFDMindex = %d, tmpCCK20Mindex = %d, tmpCCK40Mindex = %d",
> -		((u1Byte)tmpRegA - pHalData->ThermalMeter[0]),
> -		tmpOFDMindex, tmpCCK20Mindex, tmpCCK40Mindex);*/
> +	/* DbgPrint("%ddb, tmpOFDMindex = %d, tmpCCK20Mindex = %d, tmpCCK40Mindex = %d",
> +	 *	((u1Byte)tmpRegA - pHalData->ThermalMeter[0]),
> +	 *	tmpOFDMindex, tmpCCK20Mindex, tmpCCK40Mindex);
> +	 */
>  	if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)	/* 40M */
>  		tmpCCKindex = tmpCCK40Mindex;
>  	else
> @@ -1594,7 +1598,8 @@ static void dm_bb_initialgain_backup(struct net_device *dev)
>   *	When		Who		Remark
>   *	05/15/2008	amy		Create Version 0 porting from windows code.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  static void dm_dig_init(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
> @@ -1638,7 +1643,8 @@ static void dm_dig_init(struct net_device *dev)
>   * Revised History:
>   *	When		Who		Remark
>   *	05/27/2008	amy		Create Version 0 porting from windows code.
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  static void dm_ctrl_initgain_byrssi(struct net_device *dev)
>  {
>  	if (!dm_digtable.dig_enable_flag)
> @@ -1680,8 +1686,9 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
>  	else
>  		dm_digtable.cur_connect_state = DIG_DISCONNECT;
>
> -	/*DbgPrint("DM_DigTable.PreConnectState = %d, DM_DigTable.CurConnectState = %d\n",
> -		DM_DigTable.PreConnectState, DM_DigTable.CurConnectState);*/
> +	/* DbgPrint("DM_DigTable.PreConnectState = %d, DM_DigTable.CurConnectState = %d\n",
> +	 *	DM_DigTable.PreConnectState, DM_DigTable.CurConnectState);
> +	 */
>
>  	dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
>  	/*DbgPrint("DM_DigTable.Rssi_val = %d\n", DM_DigTable.Rssi_val);*/
> @@ -1720,12 +1727,12 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
>  	    (priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_thresh))
>  		return;
>
> -	/*DbgPrint("Dig by Fw False Alarm\n");*/
> -	/*if (DM_DigTable.Dig_State == DM_STA_DIG_OFF)*/
> -	/*DbgPrint("DIG Check\n\r RSSI=%d LOW=%d HIGH=%d STATE=%d",
> -	pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
> -	DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);*/
> -	/* 1. When RSSI decrease, We have to judge if it is smaller than a threshold
> +	/* DbgPrint("Dig by Fw False Alarm\n");
> +	 * if (DM_DigTable.Dig_State == DM_STA_DIG_OFF)
> +	 * DbgPrint("DIG Check\n\r RSSI=%d LOW=%d HIGH=%d STATE=%d",
> +	 * pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
> +	 * DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);
> +	 * 1. When RSSI decrease, We have to judge if it is smaller than a threshold
>  	 * and then execute the step below.
>  	 */
>  	if (priv->undecorated_smoothed_pwdb <= dm_digtable.rssi_low_thresh) {
> @@ -1757,12 +1764,12 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
>  			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
>  			 */
>  			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
> -			/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> -				write_nic_byte(pAdapter, rOFDM0_RxDetector1, 0x40);
> -			else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
> -			else
> -				PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x40);
> -			*/
> +			/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> +			 *	write_nic_byte(pAdapter, rOFDM0_RxDetector1, 0x40);
> +			 * else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
> +			 * else
> +			 *	PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x40);
> +			 */
>  		} else
>  			write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
>
> @@ -1814,13 +1821,12 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
>  			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
>  			 */
>  			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
> -			/*
> -			else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> -				write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
> -			else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
> -			else
> -				PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x42);
> -			*/
> +			/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> +			 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
> +			 * else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
> +			 * else
> +			 *	PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x42);
> +			 */
>  		} else
>  			write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
>
> @@ -1855,7 +1861,8 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
>   *	When		Who		Remark
>   *	05/28/2008	amy		Create Version 0 porting from windows code.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  static void dm_ctrl_initgain_byrssi_highpwr(
>  	struct net_device *dev)
>  {
> @@ -1882,9 +1889,9 @@ static void dm_ctrl_initgain_byrssi_highpwr(
>  		if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
>  			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);
>
> -			/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> -				write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
> -			*/
> +			/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> +			 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
> +			 */
>
>  		} else
>  			write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
> @@ -1899,9 +1906,9 @@ static void dm_ctrl_initgain_byrssi_highpwr(
>  			/*  3.2 Recover PD_TH for OFDM for normal power region. */
>  			if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
>  				write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
> -				/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> -					write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
> -				*/
> +				/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> +				 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
> +				 */
>
>  			} else
>  				write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
> @@ -2020,9 +2027,9 @@ static void dm_pd_th(
>  					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
>  					 */
>  					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
> -					/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> -						write_nic_byte(dev, rOFDM0_RxDetector1, 0x40);
> -					*/
> +					/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> +					 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x40);
> +					 */
>  				} else
>  					write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
>  			} else if (dm_digtable.curpd_thstate == DIG_PD_AT_NORMAL_POWER) {
> @@ -2032,18 +2039,18 @@ static void dm_pd_th(
>  					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
>  					 */
>  					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
> -					/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> -						write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
> -					*/
> +					/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> +					 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
> +					 */
>  				} else
>  					write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
>  			} else if (dm_digtable.curpd_thstate == DIG_PD_AT_HIGH_POWER) {
>  				/* Higher PD_TH for OFDM for high power state. */
>  				if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
>  					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);
> -					/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> -						write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
> -					*/
> +					/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
> +					 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
> +					 */
>  				} else
>  					write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
>  			}
> @@ -2274,7 +2281,8 @@ static void dm_ctstoself(struct net_device *dev)
>   *	When		Who		Remark
>   *	05/28/2008	amy	Create Version 0 porting from windows code.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  static	void	dm_check_pbc_gpio(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
> @@ -2308,7 +2316,8 @@ static	void	dm_check_pbc_gpio(struct net_device *dev)
>   *	When		Who		Remark
>   *	01/30/2008	MHC		Create Version 0.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
>  {
>  	struct delayed_work *dwork = to_delayed_work(work);
> @@ -2557,7 +2566,8 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
>   *	When		Who		Remark
>   *	05/28/2008	amy		Create Version 0 porting from windows code.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  static void dm_check_rx_path_selection(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
> --
> 2.34.1
>
>
>
