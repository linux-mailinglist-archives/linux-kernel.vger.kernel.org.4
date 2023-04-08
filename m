Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C782F6DB9A0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDHIWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDHIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC71C148;
        Sat,  8 Apr 2023 01:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59367611DD;
        Sat,  8 Apr 2023 08:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD5EC433D2;
        Sat,  8 Apr 2023 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680942129;
        bh=LTWRdAclgGf11bub+IQh60JZrPzmwlbMWa/9Z716qSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CiUbg6k7a01CUs2enncs4M+wclwylBvOp3cbPeU6RqZ4N8aJf7Pbkz1+n15UIkWTU
         K40sPDnS0IC1ns3lIJbiv2riZ7Z3MCufpjJXE0kuWM+jDBobqilLVnq73ZFTbY17Re
         dGbZCIB0RYIDEtkr8nETqePS82PNXkftlh7ttV8g=
Date:   Sat, 8 Apr 2023 10:22:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fbtft-bus.c added params
Message-ID: <2023040822-trend-squeegee-16e7@gregkh>
References: <20230408081817.81562-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408081817.81562-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 01:48:17PM +0530, Deepanshu Kartikey wrote:
> Added cpu_to_be16 param in define_fbtft_write_reg
> 
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 3d422bc11641..228a5430c1d5 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> -define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, cpu_to_be16);
> +define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16);
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, cpu_to_be16);
>  
>  void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  {
> -- 
> 2.25.1
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

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for a
  description of how to do this so that Greg has a chance to apply these
  correctly.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
