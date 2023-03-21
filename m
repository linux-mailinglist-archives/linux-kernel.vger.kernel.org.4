Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E873D6C2F84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCUKue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCUKuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F262AAF32
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0601B8129E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D8CC433D2;
        Tue, 21 Mar 2023 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679395790;
        bh=mBqXmjcYNZV8WUHWvRmKJEG6BOl47liAF/vEszOX6CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WI0RS9QO/yJi7euLFQQ5te4EDv/GVE2eqa+wH99Pdj9Hg+jeWAlBdpq20fx0z/XaY
         jxXuN9umZMXteRglPrkDeeXWS02m5fL6nQykzSJXNFgsJzROommjP5530bEYGD/Y+6
         c6Tqqx/hNNodNtszK98Qd1KEOpShlRtBVnIdxFuE=
Date:   Tue, 21 Mar 2023 11:49:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Inshal Khan <kziaul123@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8712: Remove redundant parentheses and
 improve macro definition
Message-ID: <ZBmLy6hhdabmB5Ph@kroah.com>
References: <ZBmJ0luUeoX/uhZp@mehmed-HP-Pavilion-Laptop-15-eh2xxx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBmJ0luUeoX/uhZp@mehmed-HP-Pavilion-Laptop-15-eh2xxx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 04:11:22PM +0530, Inshal Khan wrote:
> This commit simplifies the code in the ieee80211 and osdep_intf modules by
> removing unnecessary parentheses and improving the readability and avoiding
> any unexpected as well as operator preceedence side effects of RND4 macro.
> These changes improve the robustness of the driver and make it easier to
> maintain going forward.
> 
> Signed-off-by: Inshal Khan <kziaul123@gmail.com>
> ---
>  drivers/staging/rtl8712/ieee80211.c  | 10 +++++-----
>  drivers/staging/rtl8712/osdep_intf.h |  5 ++++-
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
> index 7d8f1a29d18a..85e698c2126d 100644
> --- a/drivers/staging/rtl8712/ieee80211.c
> +++ b/drivers/staging/rtl8712/ieee80211.c
> @@ -63,8 +63,8 @@ uint r8712_is_cckrates_included(u8 *rate)
>  	u32 i = 0;
>  
>  	while (rate[i] != 0) {
> -		if ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
> -		    (((rate[i]) & 0x7f) == 11) || (((rate[i]) & 0x7f) == 22))
> +		if (((rate[i] & 0x7f) == 2) || ((rate[i] & 0x7f) == 4) ||
> +		    ((rate[i] & 0x7f) == 11) || ((rate[i] & 0x7f) == 22))
>  			return true;
>  		i++;
>  	}
> @@ -76,8 +76,8 @@ uint r8712_is_cckratesonly_included(u8 *rate)
>  	u32 i = 0;
>  
>  	while (rate[i] != 0) {
> -		if ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
> -		    (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
> +		if (((rate[i] & 0x7f) != 2) && ((rate[i] & 0x7f) != 4) &&
> +		    ((rate[i] & 0x7f) != 11)  && ((rate[i] & 0x7f) != 22))
>  			return false;
>  		i++;
>  	}
> @@ -147,7 +147,7 @@ static uint r8712_get_rateset_len(u8 *rateset)
>  	uint i = 0;
>  
>  	while (1) {
> -		if ((rateset[i]) == 0)
> +		if (rateset[i] == 0)
>  			break;
>  		if (i > 12)
>  			break;
> diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl8712/osdep_intf.h
> index 9e75116c987e..3d4f82cc60f9 100644
> --- a/drivers/staging/rtl8712/osdep_intf.h
> +++ b/drivers/staging/rtl8712/osdep_intf.h
> @@ -17,7 +17,10 @@
>  #include "osdep_service.h"
>  #include "drv_types.h"
>  
> -#define RND4(x)	(((x >> 2) + ((x & 3) != 0)) << 2)
> +#define RND4(x) ({ \
> +		typeof(x) _x = (x); \
> +		(((_x) + 3) & ~3); \
> +		})
>  
>  struct intf_priv {
>  	u8 *intf_dev;
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
