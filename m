Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93B6BC63F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCPGov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCPGop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA9126E5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F5F261EFB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E4DC433D2;
        Thu, 16 Mar 2023 06:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678949081;
        bh=jR0bvb/Un4ZAh0h31p5cU01WDPJfnRov+4iMiAt79Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xdmi5iqMKMcub9wYVP2XCWQoMsVMjIkFVEyILWIOvXfr5+QKubXU1tuqYr7zVkDMK
         XPuretHmHWzjGcVR76zDyIfgsAtHQlT6z8y1C6C9ye7IzrR84hMW9BlrCFpFFTpS6H
         dwpwOgNcn91VKILO/1eLU1F/+XQj+1+LXnTGZ8Hk=
Date:   Thu, 16 Mar 2023 07:44:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Fix typo in LEGACY_TIOCSTI Kconfig description
Message-ID: <ZBK614GE0HDTSVDE@kroah.com>
References: <20230315201400.7bb07d47.hanno@hboeck.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315201400.7bb07d47.hanno@hboeck.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 08:14:00PM +0100, Hanno Böck wrote:
> There is a stray ' in the description before the Y. It appears this was
> meant as a quote for the 'Y'. However, it is more common to use
> unquoted Y in Kconfig descriptions.
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index d35fc068d..84caac32f 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -160,7 +160,7 @@ config LEGACY_TIOCSTI
>  	  a dangerous legacy operation, and can be disabled on most
>  	  systems.
>  
> -	  Say 'Y here only if you have confirmed that your system's
> +	  Say Y here only if you have confirmed that your system's
>  	  userspace depends on this functionality to continue operating
>  	  normally.
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
