Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3269788A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBOI6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBOI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:58:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260B023320;
        Wed, 15 Feb 2023 00:58:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAA8DB81E2A;
        Wed, 15 Feb 2023 08:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB9AC433EF;
        Wed, 15 Feb 2023 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676451487;
        bh=jrGJzrG2skBYV2raSxtxHsTglP/uwpkm81LKlzw08iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vncmQqU5+gf6a7yLciWkWD9jId4mQ0WeOqn2o9FVzMyGrEaigXYpoUNk1bo2fq2ue
         m1Dzg31J9YFSWAKTzaYrmzOtGca6QieNy0EgvRgPVKQhWYgI6S9xjGfa9dV18oVg/b
         HWBaom0tVl/c40f2SCHcOm2OYUcAE39bkuBBxlyQ=
Date:   Wed, 15 Feb 2023 09:58:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou nan <zhounan@nfschina.com>
Cc:     leoyang.li@nxp.com, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: fix some spelling mistakes in comment
Message-ID: <Y+yenCvi7vTCkb84@kroah.com>
References: <20230215084324.7065-1-zhounan@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215084324.7065-1-zhounan@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 12:43:24AM -0800, Zhou nan wrote:
> Fix typos in comment.
> 
> Signed-off-by: Zhou nan <zhounan@nfschina.com>
> ---
>  drivers/usb/gadget/udc/fsl_udc_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
> index a67873a074b7..da876d09fc01 100644
> --- a/drivers/usb/gadget/udc/fsl_udc_core.c
> +++ b/drivers/usb/gadget/udc/fsl_udc_core.c
> @@ -471,7 +471,7 @@ static int dr_ep_get_stall(unsigned char ep_num, unsigned char dir)
>  ********************************************************************/
>  
>  /*------------------------------------------------------------------
> -* struct_ep_qh_setup(): set the Endpoint Capabilites field of QH
> +* struct_ep_qh_setup(): set the Endpoint Capabilities field of QH
>   * @zlt: Zero Length Termination Select (1: disable; 0: enable)
>   * @mult: Mult field
>   ------------------------------------------------------------------*/
> @@ -483,7 +483,7 @@ static void struct_ep_qh_setup(struct fsl_udc *udc, unsigned char ep_num,
>  	struct ep_queue_head *p_QH = &udc->ep_qh[2 * ep_num + dir];
>  	unsigned int tmp = 0;
>  
> -	/* set the Endpoint Capabilites in QH */
> +	/* set the Endpoint Capabilities in QH */
>  	switch (ep_type) {
>  	case USB_ENDPOINT_XFER_CONTROL:
>  		/* Interrupt On Setup (IOS). for control ep  */
> @@ -593,7 +593,7 @@ static int fsl_ep_enable(struct usb_ep *_ep,
>  	ep->stopped = 0;
>  
>  	/* Controller related setup */
> -	/* Init EPx Queue Head (Ep Capabilites field in QH
> +	/* Init EPx Queue Head (Ep Capabilities field in QH
>  	 * according to max, zlt, mult) */
>  	struct_ep_qh_setup(udc, (unsigned char) ep_index(ep),
>  			(unsigned char) ((desc->bEndpointAddress & USB_DIR_IN)
> @@ -1361,7 +1361,7 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
>  	udc->ep0_dir = USB_DIR_IN;
>  	/* Borrow the per device status_req */
>  	req = udc->status_req;
> -	/* Fill in the reqest structure */
> +	/* Fill in the request structure */
>  	*((u16 *) req->req.buf) = cpu_to_le16(tmp);
>  
>  	req->ep = ep;
> -- 
> 2.27.0
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
