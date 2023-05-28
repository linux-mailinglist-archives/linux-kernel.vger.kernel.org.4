Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0291713A17
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjE1O2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjE1O2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:28:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F80BE;
        Sun, 28 May 2023 07:28:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0638532002F9;
        Sun, 28 May 2023 10:28:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 28 May 2023 10:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685284096; x=1685370496; bh=iS
        jyKKgZCeV7tTuvcwALF+6hypZ+TqctPSP3VLBkQYw=; b=TcFBOzwUGQTK8vsZJ4
        XwNF/Y8P3SISUjF8LZEozB2RLo42tVAzFGM/Ns+9j7f7hCLfy75pQJTkVKqnvCLB
        aviECnaYYmfnd2fVmU9LdcgjOTP3upvrTgkR38xiRvEb1CSXQmgg9TN5Di0MtXxF
        JOoOeNYMRqwUakkle3/5ugDXdcq1ucr9xVF9o+lk64pn/37TmRzdeMQ1l7W8RjZ+
        M7temEV5HZfasu/gnuUbfDCJis0kMwpEWAxjESg+ZygbY/tTOxx0dmCcLdEg1TrN
        5AMtom8kuwsd9IJKJ1vvaYpbF+th722Kg9xgnVr9TN3odNFez6gyBt5KHJMPETZi
        cgBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685284096; x=1685370496; bh=iSjyKKgZCeV7t
        TuvcwALF+6hypZ+TqctPSP3VLBkQYw=; b=oWruq4bTre2f7iTey9OGgG7lii56O
        X8h2ZpDuLjJq/1AfaQF2Eqk13cthqFYS/4+quVFpI8Ia1i+/uG21rSMKYYeg+5cG
        DZgX7lK8beA4sgJHa8B8ukKjQq4Pxw+TdyEV0gOTYsRmdmlQP5Cm2y3BzluvSFqL
        lSJoVZo5tAzEv12UyOeBV1AKsxcGiEJK+B3CeQXWhC2mrQRh2htz4lQ72ubcey4B
        OkmJbgUkD1y2SDXLSu6XV3hJ2SOYwGAC4fecgTSrmEbZZTZ31W2qCBAD0lAu3Qd7
        Htotxw1GMBaML7H20CFit8kwcgO6lhdgFKjmuK4KbVcatt8Ma6NjP7zCg==
X-ME-Sender: <xms:AGVzZHp-VdS1HbG7iK1dlFZJO7MgB_WN0ZgBKhj-n20YUQ0ZPs05PQ>
    <xme:AGVzZBqSduQ2KPCkUWMgsDSGRJ757lZNMg8feysLtyVvsehJXmNqBQ4XrAkCljESi
    1psc0-DeiQZgQ>
X-ME-Received: <xmr:AGVzZEPpFwHTm6FATLtACU9lfO2qMx1F9fWF3rYKrQ0qxZmVKLX4hGxRezvP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekfedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:AGVzZK7vZ1uKnvp9viM4-ROexJs9HhSdmh6AbH8Y16ZrE-wj3-7SKA>
    <xmx:AGVzZG4lQ2G8jmuhm4qBcZ0GgZlGNE3RKmEuW-q0INOujqIKCUSkDQ>
    <xmx:AGVzZChghiPJKHb0aLl17cjF7dafVUqF1jm9fjax4nNuoDR-Ay64xA>
    <xmx:AGVzZIuo74DaGZRlyQf-X80S6d-MRl16K5Ee2YvaqAWWxUhcQnDyjA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 May 2023 10:28:16 -0400 (EDT)
Date:   Sun, 28 May 2023 15:28:14 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <2023052806-stout-revisable-311f@gregkh>
References: <20230515125023.639f3ca3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515125023.639f3ca3@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 12:50:23PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/gadget/udc/core.c
> 
> between commit:
> 
>   f22e9b67f19c ("Revert "usb: gadget: udc: core: Invoke usb_gadget_connect only when started"")
> 
> from the usb.current tree and commit:
> 
>   d34f9bafa78d ("usb: gadget: udc: Handle gadget_connect failure during bind operation")
> 
> from the usb tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/usb/gadget/udc/core.c
> index 52e6d2e84e35,69041cca5d24..000000000000
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@@ -1078,12 -1121,17 +1078,16 @@@ EXPORT_SYMBOL_GPL(usb_gadget_set_state)
>   
>   /* ------------------------------------------------------------------------- */
>   
> - static void usb_udc_connect_control(struct usb_udc *udc)
>  -/* Acquire connect_lock before calling this function. */
>  -static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
> ++static int usb_udc_connect_control(struct usb_udc *udc)
>   {
> + 	int ret;
> + 
>  -	if (udc->vbus && udc->started)
>  -		ret = usb_gadget_connect_locked(udc->gadget);
>  +	if (udc->vbus)
> - 		usb_gadget_connect(udc->gadget);
> ++		ret = usb_gadget_connect(udc->gadget);
>   	else
> - 		usb_gadget_disconnect(udc->gadget);
>  -		ret = usb_gadget_disconnect_locked(udc->gadget);
> ++		ret = usb_gadget_disconnect(udc->gadget);
> + 
> + 	return ret;
>   }
>   
>   /**
> @@@ -1523,15 -1580,28 +1527,23 @@@ static int gadget_bind_driver(struct de
>   	if (ret)
>   		goto err_bind;
>   
>  -	mutex_lock(&udc->connect_lock);
>  -	ret = usb_gadget_udc_start_locked(udc);
>  -	if (ret) {
>  -		mutex_unlock(&udc->connect_lock);
>  +	ret = usb_gadget_udc_start(udc);
>  +	if (ret)
>   		goto err_start;
>  -	}
>   	usb_gadget_enable_async_callbacks(udc);
> - 	usb_udc_connect_control(udc);
>  -	ret = usb_udc_connect_control_locked(udc);
> ++	ret = usb_udc_connect_control(udc);
> + 	if (ret)
> + 		goto err_connect_control;
>   
>  -	mutex_unlock(&udc->connect_lock);
>  -
>   	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>   	return 0;
>   
> +  err_connect_control:
> + 	usb_gadget_disable_async_callbacks(udc);
> + 	if (gadget->irq)
> + 		synchronize_irq(gadget->irq);
>  -	usb_gadget_udc_stop_locked(udc);
> ++	usb_gadget_udc_stop(udc);
> + 
>    err_start:
>   	driver->unbind(udc->gadget);
>   



Should now be resolved in my branch.

thanks,

greg k-h
