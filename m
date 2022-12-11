Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8F6493CE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 12:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLKLGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 06:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLKLGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 06:06:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC4101EE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 03:06:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88C260D58
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 11:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0D2C433D2;
        Sun, 11 Dec 2022 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670756768;
        bh=gjPL3MEV9t4ErlkVqGFGfA27Nd5zV7/i7g3GgTTXPoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkBTZnscTg+QPGWzbGHWmDkrDAijkBIUEPiI566gJzolVS4A9y+RW3zbPd+qyaRm2
         3LzhPAdbZuZLeUQr61EBZgRVgN1Q4ZVwTfbOVgeoR9j4Gq4lYOMWSDebJTad0lEiSD
         Ok9YIypDGHipA9q9n4hqdQwIb5j6mTANe7cG8jaM=
Date:   Sun, 11 Dec 2022 12:06:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dalvin Aiguobas <pharcodra@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: wlan-ng: fix checkpatch error for spinlock
Message-ID: <Y5W5nKtLMV9b4xnm@kroah.com>
References: <20221211105649.GA4683@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211105649.GA4683@koolguy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 11:56:49AM +0100, Dalvin Aiguobas wrote:
> Checkpatch Styleproblem fixed by adding comment.
> 
> Signed-off-by: Dalvin <pharcodra@gmail.com>
> ---
>  drivers/staging/wlan-ng/hfa384x.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
> index 0611e37df6ac..ad117d570bb6 100644
> --- a/drivers/staging/wlan-ng/hfa384x.h
> +++ b/drivers/staging/wlan-ng/hfa384x.h
> @@ -1171,6 +1171,7 @@ struct hfa384x_usbctlx {
>  };
>  
>  struct hfa384x_usbctlxq {
> +	/* lock: Protect structure fields */
>  	spinlock_t lock;
>  	struct list_head pending;
>  	struct list_head active;
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
