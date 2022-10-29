Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF4612119
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJ2HsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJ2HsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:48:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCECC1494
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 823A2B80064
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7502C433C1;
        Sat, 29 Oct 2022 07:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667029677;
        bh=9OpGv9HaiIEMfZdChodvj9wdQK8zGbRvTn51GuTpkhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG+GbD6PmSCRJo6FMWaBDJVK2Rt9mzPvdsTZ6c9pB5NUmZnuHZiR+2Yae8wW+9RVT
         FnZ8Qq89PBywcPnkRPOK46vV/Uxw1ajhA9ZhOPXzITccSPgLcc9Z4Z689+EYhMvWmG
         8vcc9H0ZE9KHcIO4gL42Bv5RkJKu2rg/v+ki3KyM=
Date:   Sat, 29 Oct 2022 09:48:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v9 2/6] staging: vt6655: split long code lines in
 s_uGetRTSCTSDuration
Message-ID: <Y1za5Gzr/uXsPF3N@kroah.com>
References: <cover.1666995639.git.tanjubrunostar0@gmail.com>
 <0e6a307052d3a354a850a502e509f46baccdbe1e.1666995639.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6a307052d3a354a850a502e509f46baccdbe1e.1666995639.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:23:23PM +0000, Tanjuate Brunostar wrote:
> Increase code visibility by splitting long lines of code in the
> function: s_uGetRTSCTSDuration
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 108 ++++++++++++++++++++++++----------
>  1 file changed, 76 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 7eb7c6eb5cf0..8e56a7ee8035 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -186,20 +186,29 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
>  
>  	data_time = bb_get_frame_time(priv->preamble_type, pkt_type, frame_length, current_rate);
>  	if (rts_rsvtype == 0) { /* RTSTxRrvTime_bb */
> -		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
> -		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
> +		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20,
> +					     priv->byTopCCKBasicRate);
> +		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
> +					     priv->byTopCCKBasicRate);

While I understand the feeling of "let's fix this warning by wrapping
the line!" type of solution, overall, it's NOT the correct thing to do.

Remember, coding style changes are to be done to make code easier to
read and understand, not harder.  The original code here is easier to
read, and you made it harder to understand.

The "best" solution for this will be to fix up the line length by virtue
of fixing up the incorrect variable names.  Here is the original lines:

		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);

but if you were to fix up just 1 function and one variable name, look at
what happens and checkpatch is happy with it:

		rts_time = get_frame_time(priv->preamble_type, pkt_type, 20, priv->top_basic_rate);
		ack_time = get_frame_time(priv->preamble_type, pkt_type, 14, priv->top_basic_rate);

Or even better:
		type = priv->preamble_type;
		rate = priv->top_basic_rate;
		rts_time = get_frame_time(type, pkt_type, 20, rate);
		ack_time = get_frame_time(type, pkt_type, 14, rate);

Look, no line-wrapping and isn't that easier to understand?  The second
version here might even produce smaller compiled code overall, making it
a even better solution.

So step back, revisit this whole series with the goal of overall making
the code better and easier to review.  Don't create a series just with
the short-term goal of making checkpatch quiet.

Hope this helps,

greg k-h
