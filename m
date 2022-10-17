Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1E6010CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiJQOKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJQOJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:09:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D921E31
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21B67B8188D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572F7C433D6;
        Mon, 17 Oct 2022 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666015792;
        bh=yJ08HzHEX+1X61S0D+yCv7kNru6KQif5JswxlVdBe1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peRR6IDCuyeyvt1k3vFBMReMldWHIyyLQlSP4aaxeg7fcFwvxi2Qbxy7y3X/lT3Kb
         4+m3k2Qb/md9Ep2+GbOByIRBl5KjJ/VjPfqvsWRLd8WPHbiwEiHiEOsgBDKSVKl2rb
         Aasrg1+r7laegS/f8WvNlnw1yxgqoqtRFDtNvsrs=
Date:   Mon, 17 Oct 2022 16:09:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH 2/4] staging: r8188eu: reformat long computation lines
Message-ID: <Y01iLXp20G0FSJFG@kroah.com>
References: <cover.1666011479.git.drv@mailo.com>
 <2dd27eff9aab5ffe31e61086c0584982794507cf.1666011479.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dd27eff9aab5ffe31e61086c0584982794507cf.1666011479.git.drv@mailo.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:52:50PM +0530, Deepak R Varma wrote:
> Reformat long running computation instructions to improve code readability.
> Address following checkpatch script complaints:
> 	CHECK: line length of 171 exceeds 100 columns
> 	CHECK: line length of 113 exceeds 100 columns
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 79daf8f269d6..427da7e8ba4c 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -211,8 +211,10 @@ static int __nat25_network_hash(unsigned char *network_addr)
>  	} else if (network_addr[0] == NAT25_IPX) {
>  		unsigned long x;
> 
> -		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
> -			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10];
> +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^

Why not go out to [4] here and then you are one line shorter?

> +		    network_addr[4] ^ network_addr[5] ^ network_addr[6] ^
> +		    network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
> +		    network_addr[10];
> 
>  		return x & (NAT25_HASH_SIZE - 1);
>  	} else if (network_addr[0] == NAT25_APPLE) {
> @@ -224,16 +226,20 @@ static int __nat25_network_hash(unsigned char *network_addr)
>  	} else if (network_addr[0] == NAT25_PPPOE) {
>  		unsigned long x;
> 
> -		x = network_addr[0] ^ network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^ network_addr[6] ^ network_addr[7] ^ network_addr[8];
> +		x = network_addr[0] ^ network_addr[1] ^ network_addr[2] ^
> +		    network_addr[3] ^ network_addr[4] ^ network_addr[5] ^

Same here


> +		    network_addr[6] ^ network_addr[7] ^ network_addr[8];
> 
>  		return x & (NAT25_HASH_SIZE - 1);
>  	} else if (network_addr[0] == NAT25_IPV6) {
>  		unsigned long x;
> 
> -		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
> -			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10] ^
> -			network_addr[11] ^ network_addr[12] ^ network_addr[13] ^ network_addr[14] ^ network_addr[15] ^
> -			network_addr[16];
> +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
> +		    network_addr[4] ^ network_addr[5] ^ network_addr[6] ^
> +		    network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
> +		    network_addr[10] ^ network_addr[11] ^ network_addr[12] ^
> +		    network_addr[13] ^ network_addr[14] ^ network_addr[15] ^
> +		    network_addr[16];

And here.

thanks,

greg k-h
