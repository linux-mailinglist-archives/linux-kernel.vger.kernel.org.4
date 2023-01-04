Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F365D75B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjADPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjADPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:39:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188241DDE5;
        Wed,  4 Jan 2023 07:39:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9B1FB816CE;
        Wed,  4 Jan 2023 15:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1249C433EF;
        Wed,  4 Jan 2023 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672846765;
        bh=3hMvQGxizKyuCmzdeT21b9sxTcAaxoUByPhxhR0E2xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BarF4nd+8w/PUzHArLsrzqW1EziK33xBM+Ez0w+IjrWUeOEh6HkfD9CtaWHIBz1vo
         xFevvJg1G3ph4tw5l4vtuMjO3DSOAiY0OpXZQOhheQEtEt+kUiS2YF/ylswyQj2nIy
         okgNuB+Qgc6fvh9DBvKslEgBs4tUa7GZTHwrhNw8=
Date:   Wed, 4 Jan 2023 16:39:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lizhe <sensor1010@163.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] serial: linflexuart: remove redundant uart type
 assignment
Message-ID: <Y7WdpQkqJA03z8w0@kroah.com>
References: <20230104152444.3407-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104152444.3407-1-sensor1010@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:24:44AM -0800, lizhe wrote:
> in linflex_config_port() the member variable type will be
> assigned again. see linflex_connfig_port()
> 
> Signed-off-by: lizhe <sensor1010@163.com>
> Link: https://lore.kernel.org/all/20230103170948.3777-1-sensor1010@163.com/
> ---
>  drivers/tty/serial/fsl_linflexuart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
> index 6fc21b6684e6..34400cc6ac7f 100644
> --- a/drivers/tty/serial/fsl_linflexuart.c
> +++ b/drivers/tty/serial/fsl_linflexuart.c
> @@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
>  		return PTR_ERR(sport->membase);
>  
>  	sport->dev = &pdev->dev;
> -	sport->type = PORT_LINFLEXUART;
>  	sport->iotype = UPIO_MEM;
>  	sport->irq = platform_get_irq(pdev, 0);
>  	sport->ops = &linflex_pops;
> -- 
> 2.17.1
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
