Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F586C8DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjCYMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E81735
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB9E560C3E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF620C433EF;
        Sat, 25 Mar 2023 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679746998;
        bh=7ppK1dezInckwEatHKgVAR9N75jT8VGwrDocbFmyk9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1FEz6e9fVcoEOGPI6DX5dwtmOOYP+MnnLjx6c/PPTud/9S2dP8zvFa//uKw0nGTGR
         ITfr3347QzhfIh4GVbhC7DZOPQaVJnANAyG7Izo98fBeaSnq6D6Xaf9Mnm7y9qxrZY
         iw0mTY9CMpnbnLDbpHRpVw7YfcfBlUiLqjOrroak=
Date:   Sat, 25 Mar 2023 13:23:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8192u: reformat block comments
Message-ID: <ZB7nsz1UQ9kn6d6p@kroah.com>
References: <cover.1679744684.git.kamrankhadijadj@gmail.com>
 <2974a7ba0e2d3cc693b2a7229cf150c10f395ac5.1679744684.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2974a7ba0e2d3cc693b2a7229cf150c10f395ac5.1679744684.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 05:13:16PM +0500, Khadija Kamran wrote:
> Linux kernel coding style for block comments uses a column of '*' on the
> left side and  uses '*/' on a separate line.
> 
> Fix block comments by adding '*' on subsequent lines and moving '*/' at
> the end of block comments on a separate line. These issues in block
> comments are reported by checkpatch.pl script.
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

Do not reformat things, only to remove them in the last commit in the
series.  Instead, remove the commented out code lines first, and then
fix up any remaining ones, that should make the churn much less.

thanks,

greg k-h
