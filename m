Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8F6B4BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjCJP4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCJP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:56:16 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5195E118BFE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1678463347; bh=KUWMx4xTtQ2NV8s0yXAq68XeDXgRcHLK7NX2DqJUdEw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=OmKncEQIA2d37NsPi0ZIa+hBXeLWs0A8pCUHXbl0tt8v8ShLcWcwvscxA6Xfyfs7S
         jGExYDndlwAKTX1vdlGnMKb6Dhpcgk9APzuCW2v6dS/1Y4kftuLxm+fqGDEKTsN5Rd
         7LsQJRC8DEYlG4nz+m377h8vUMptM0H+F4BJEYOk=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri, 10 Mar 2023 16:49:07 +0100 (CET)
X-EA-Auth: P1Jwh5XT4/s4Cxxa0/bBk9Cr0nuDmUWCczMFH0RTWzzfcXux+9EDP4p9sHlC7NDe8Wocegms03J6L9ZBxBYkzN94YT9fPEi1
Date:   Fri, 10 Mar 2023 21:19:00 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] comedi: drivers: ni_pcimio: Remove the code enclosed by
 #if 0 and its #endif
Message-ID: <ZAtRbDYxNbFxQdI9@ubun2204.myguest.virtualbox.org>
References: <20230310140119.GA12544@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310140119.GA12544@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 06:01:19AM -0800, Sumitra Sharma wrote:
> Reported by checkpatch.pl:
> 
> WARNING: Consider removing the code enclosd by this #if 0 and its #endif
> at line 482, 501, 570.
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>  drivers/comedi/drivers/ni_pcimio.c | 48 ------------------------------
>  1 file changed, 48 deletions(-)

Hi Sumitra,
Nice first attempt. However, you should be working in the drivers/staging
directory for now.

Also, specific to the following change, the device definitions may be useful to
people who have those devices and can be added to the driver by simply removing
the #if 0 condition. Hence, these commented blocks are likely retained due to
same reason.

Thank you,
Deepak.

> 
> diff --git a/drivers/comedi/drivers/ni_pcimio.c b/drivers/comedi/drivers/ni_pcimio.c
> index 0b055321023d..1603095f2ed9 100644
> --- a/drivers/comedi/drivers/ni_pcimio.c
> +++ b/drivers/comedi/drivers/ni_pcimio.c
> @@ -479,43 +479,6 @@ static const struct ni_board_struct ni_boards[] = {
>  		.ao_speed	= 250,
>  		.caldac		= { ad8804, ad8804 },
>  	},
> -#if 0
> -	/* The 6115 boards probably need their own driver */
> -	[BOARD_PCI6115] = {	/* .device_id = 0x2ed0, */
> -		.name		= "pci-6115",
> -		.n_adchan	= 4,
> -		.ai_maxdata	= 0x0fff,
> -		.ai_fifo_depth	= 8192,
> -		.gainlkup	= ai_gain_611x,
> -		.ai_speed	= 100,
> -		.n_aochan	= 2,
> -		.ao_maxdata	= 0xffff,
> -		.ao_671x	= 1,
> -		.ao_fifo_depth	= 2048,
> -		.ao_speed	= 250,
> -		.reg_611x	= 1,
> -		/* XXX */
> -		.caldac		= { ad8804_debug, ad8804_debug, ad8804_debug },
> -	},
> -#endif
> -#if 0
> -	[BOARD_PXI6115] = {	/* .device_id = ????, */
> -		.name		= "pxi-6115",
> -		.n_adchan	= 4,
> -		.ai_maxdata	= 0x0fff,
> -		.ai_fifo_depth	= 8192,
> -		.gainlkup	= ai_gain_611x,
> -		.ai_speed	= 100,
> -		.n_aochan	= 2,
> -		.ao_maxdata	= 0xffff,
> -		.ao_671x	= 1,
> -		.ao_fifo_depth	= 2048,
> -		.ao_speed	= 250,
> -		.reg_611x	= 1,
> -		/* XXX */
> -		.caldac		= { ad8804_debug, ad8804_debug, ad8804_debug },
> -	},
> -#endif
>  	[BOARD_PCI6711] = {
>  		.name = "pci-6711",
>  		.n_aochan	= 4,
> @@ -567,17 +530,6 @@ static const struct ni_board_struct ni_boards[] = {
>  		.reg_type	= ni_reg_6711,
>  		.caldac		= { ad8804_debug },
>  	},
> -#if 0
> -	[BOARD_PXI6731] = {	/* .device_id = ????, */
> -		.name		= "pxi-6731",
> -		.n_aochan	= 4,
> -		.ao_maxdata	= 0xffff,
> -		.ao_fifo_depth	= 8192,
> -		.ao_range_table	= &range_bipolar10,
> -		.reg_type	= ni_reg_6711,
> -		.caldac		= { ad8804_debug },
> -	},
> -#endif
>  	[BOARD_PCI6733] = {
>  		.name		= "pci-6733",
>  		.n_aochan	= 8,
> -- 
> 2.25.1
> 
> 


