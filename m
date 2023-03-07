Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6206AE615
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCGQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCGQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:15:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9862B68
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:15:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE714614A7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD77C433EF;
        Tue,  7 Mar 2023 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678205726;
        bh=7MZrKFCJQHWQi1BISZzgYGEV0VEFsVBaVJ+PPmTkk/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRLlGtUQ4RVZ4FqQiFW/Hcd5d0cHHZLPNC+NfppW4YdQPXd3iWJ0/KQE/8U1Giizq
         zYthhmLZPbFS/a+KKKMQh8MnCvt5zxhjU+FayQKT2tvYoyToqH1X3xRTQNSsiqR5dz
         cG7zpaLjrGniWtBOxmY1u0jR+D0XVLpGUJclWflE=
Date:   Tue, 7 Mar 2023 17:15:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atin Bainada <hi@atinb.me>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: do checkpatch cleanup
Message-ID: <ZAdjGYtCA0eWRUMl@kroah.com>
References: <20230307160232.1029705-1-hi@atinb.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307160232.1029705-1-hi@atinb.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 04:02:47PM +0000, Atin Bainada wrote:
> Signed-off-by: Atin Bainada <hi@atinb.me>
> ---
>  drivers/tty/tty_ioctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 12983ce4e43e..05a4dd0db476 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -73,7 +73,7 @@ EXPORT_SYMBOL(tty_chars_in_buffer);
>   *	the number of bytes written. If no method is provided 2K is always
>   *	returned and data may be lost as there will be no flow control.
>   */
> -
> +
>  unsigned int tty_write_room(struct tty_struct *tty)
>  {
>  	if (tty->ops->write_room)
> @@ -403,6 +403,7 @@ __weak int kernel_termios_to_user_termio(struct termio __user *termio,
>  						struct ktermios *termios)
>  {
>  	struct termio v;
> +
>  	memset(&v, 0, sizeof(struct termio));
>  	v.c_iflag = termios->c_iflag;
>  	v.c_oflag = termios->c_oflag;
> @@ -540,6 +541,7 @@ static void copy_termios_locked(struct tty_struct *tty, struct ktermios *kterm)
>  static int get_termio(struct tty_struct *tty, struct termio __user *termio)
>  {
>  	struct ktermios kterm;
> +
>  	copy_termios(tty, &kterm);
>  	if (kernel_termios_to_user_termio(termio, &kterm))
>  		return -EFAULT;
> @@ -919,6 +921,7 @@ static int __tty_perform_flush(struct tty_struct *tty, unsigned long arg)
>  int tty_perform_flush(struct tty_struct *tty, unsigned long arg)
>  {
>  	struct tty_ldisc *ld;
> +
>  	int retval = tty_check_change(tty);
>  	if (retval)
>  		return retval;
> --
> 2.39.2
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
