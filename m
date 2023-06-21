Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E3738A85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjFUQLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15BF1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C140615C3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05D8C433C9;
        Wed, 21 Jun 2023 16:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687363885;
        bh=aY+kT0+JqyQx8y2AX0tAhPCb42KDo/HOuIAFdI1ht4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y1YrQ8Wv40W0BRfou8yaVAqGx2l/0cXZvtyLEk7Fm+PD8FloFGC2Thvv9h/JrBTzS
         fDIdnIsi29fnKnCQSzzqouwmpBilQu58FfcoOFnhH6OAWG8leKjjWSQDkumut19zLp
         0J52iwg32uGb1mkZ5+I4562U3VrGsNpakkB6m7Jg=
Date:   Wed, 21 Jun 2023 18:11:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     philipp.g.hortmann@gmail.com, t4rmin@zohomail.com,
        colin.i.king@gmail.com, dan.carpenter@linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8192e: Remove whitespace and blank lines
Message-ID: <2023062153-starlight-ebay-fac2@gregkh>
References: <ZJJj6Bea1ahxNdr3@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJJj6Bea1ahxNdr3@tacos.darkphysics>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:43:52PM -0700, Tree Davies wrote:
> This patch cleans up extraneous whitespace for the
> struct rt_hi_throughput definition.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
> v2: Fix subject line and send patch inline.
>  drivers/staging/rtl8192e/rtl819x_HT.h | 63 ++++++++++-----------------
>  1 file changed, 23 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
> index f4e9fa849796..f5ab19694f1a 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HT.h
> +++ b/drivers/staging/rtl8192e/rtl819x_HT.h
> @@ -96,70 +96,53 @@ enum ht_aggre_mode {
>  
>  
>  struct rt_hi_throughput {
> -	u8				enable_ht;
> -	u8				bCurrentHTSupport;
> -
> -	u8				bRegBW40MHz;
> -	u8				bCurBW40MHz;
> -
> -	u8				bRegShortGI40MHz;
> -	u8				bCurShortGI40MHz;
> -
> -	u8				bRegShortGI20MHz;
> -	u8				bCurShortGI20MHz;
> -
> -	u8				bRegSuppCCK;
> -	u8				bCurSuppCCK;
> -
> +	u8 enable_ht;
> +	u8 bCurrentHTSupport;
> +	u8 bRegBW40MHz;
> +	u8 bCurBW40MHz;
> +	u8 bRegShortGI40MHz;
> +	u8 bCurShortGI40MHz;
> +	u8 bRegShortGI20MHz;
> +	u8 bCurShortGI20MHz;
> +	u8 bRegSuppCCK;
> +	u8 bCurSuppCCK;
>  	enum ht_spec_ver ePeerHTSpecVer;
> -
> -
>  	struct ht_capab_ele SelfHTCap;
>  	struct ht_info_ele SelfHTInfo;
> -
> -	u8				PeerHTCapBuf[32];
> -	u8				PeerHTInfoBuf[32];
> -
> -
> -	u8				bAMSDU_Support;
> -	u16				nAMSDU_MaxSize;
> -	u8				bCurrent_AMSDU_Support;
> -	u16				nCurrent_AMSDU_MaxSize;
> -
> -	u8				bAMPDUEnable;
> -	u8				bCurrentAMPDUEnable;
> -	u8				AMPDU_Factor;
> -	u8				CurrentAMPDUFactor;
> -	u8				MPDU_Density;
> +	u8 PeerHTCapBuf[32];
> +	u8 PeerHTInfoBuf[32];
> +	u8 bAMSDU_Support;
> +	u16	nAMSDU_MaxSize;
> +	u8 bCurrent_AMSDU_Support;
> +	u16	nCurrent_AMSDU_MaxSize;
> +	u8 bAMPDUEnable;
> +	u8 bCurrentAMPDUEnable;
> +	u8 AMPDU_Factor;
> +	u8 CurrentAMPDUFactor;
> +	u8 MPDU_Density;
>  	u8 current_mpdu_density;
> -
>  	enum ht_aggre_mode ForcedAMPDUMode;
>  	u8 forced_ampdu_factor;
>  	u8 forced_mpdu_density;
> -
>  	enum ht_aggre_mode ForcedAMSDUMode;
>  	u8 forced_short_gi;
> -
>  	u8 current_op_mode;
> -
>  	u8 self_mimo_ps;
>  	u8 peer_mimo_ps;
> -
>  	enum ht_extchnl_offset CurSTAExtChnlOffset;
>  	u8 cur_tx_bw40mhz;
>  	u8 sw_bw_in_progress;
>  	u8 reg_rt2rt_aggregation;
> -	u8				RT2RT_HT_Mode;
> +	u8 RT2RT_HT_Mode;
>  	u8 current_rt2rt_aggregation;
>  	u8 current_rt2rt_long_slot_time;
>  	u8 sz_rt2rt_agg_buf[10];
> -
>  	u8 reg_rx_reorder_enable;
>  	u8 cur_rx_reorder_enable;
>  	u8 rx_reorder_win_size;
>  	u8 rx_reorder_pending_time;
>  	u16 rx_reorder_drop_counter;
> -	u8				IOTPeer;
> +	u8 IOTPeer;
>  	u32 iot_action;
>  	u8 iot_ra_func;
>  } __packed;
> -- 
> 2.39.2
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

- Your patch did not apply to any known trees that Greg is in control
  of.  Possibly this is because you made it against Linus's tree, not
  the linux-next tree, which is where all of the development for the
  next version of the kernel is at.  Please refresh your patch against
  the linux-next tree, or even better yet, the development tree
  specified in the MAINTAINERS file for the subsystem you are submitting
  a patch for, and resend it.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
