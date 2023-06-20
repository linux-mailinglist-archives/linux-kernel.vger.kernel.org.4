Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7700A736341
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFTFnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjFTFnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF91FDC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4282F60F06
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DFFC433C8;
        Tue, 20 Jun 2023 05:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687239808;
        bh=3F7aV/3rPMkqAy06aNZSP3fJmD/noaWkR2ZbklfTEXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4zOC9YwDsIrvM1KT6y8B2pROOehASdlU8lqolEIncJmvfT4Kd04fdbeByw1K42Sx
         OHGuG9zKQpUFB+0+LMzF6k9VRoWtuGSsUhiJPBQhnRVQJQqebE683D0V0UzMk4FWbA
         X9yVsEwZgEYGJyXxTEUsRbUSVYtcjOFrx0l4VBH8=
Date:   Tue, 20 Jun 2023 07:43:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     philipp.g.hortmann@gmail.com, t4rmin@zohomail.com,
        colin.i.king@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/rtl8192e Style guide whitespace cleanup
Message-ID: <2023062047-jujitsu-badass-a7cc@gregkh>
References: <ZJD9U6y9RGIpeVDh@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJD9U6y9RGIpeVDh@tacos.darkphysics>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 06:13:55PM -0700, Tree Davies wrote:

> >From 25f4faf714f0e957996b9245f7e8c219080ad69b Mon Sep 17 00:00:00 2001
> From: Tree Davies <tdavies@darkphysics.net>
> Date: Mon, 19 Jun 2023 17:31:47 -0700
> Subject: [PATCH] drivers/staging/rtl8192e Style guide whitespace cleanup
> 
> This patch cleans up extraneous whitespace for the
> struct rt_hi_throughput definition.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
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

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
