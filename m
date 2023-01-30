Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D5681647
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbjA3QZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjA3QZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:25:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3951F3A853
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:25:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C90E7611A3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B45C433D2;
        Mon, 30 Jan 2023 16:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675095952;
        bh=2algA3To7DS6kKYjYO+O+2oaJYiq9Ps5Mt4pAyK0+Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5CCXh09MepBHm624Eyvsfb6IC8eieB9rnX9MAi4NIIQQRjUqyyG9pdN8BIF97JlF
         nK9WToOrVU8hNq6zdUfEj3FRzEZfoGevezPAdpdHgWdq4lzZA+Wzrz813YTQrOA+AY
         t4gHku4091MemWcNLGtsOwOQ6KZZar4xai5Ky10c=
Date:   Mon, 30 Jan 2023 17:25:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jongwoo Han <jongwooo.han@gmail.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vc04_services: mmal-vchiq: fix typo in comment
Message-ID: <Y9fvjd2fntMIRCEA@kroah.com>
References: <20230130160548.45879-1-jongwooo.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130160548.45879-1-jongwooo.han@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:05:48AM +0900, Jongwoo Han wrote:
> Correct typo from 'witin' to 'within' in comment.
> 
> Signed-off-by: Jongwoo Han <jongwooo.han@gmail.com>
> ---
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 294b184d4..e318f3609 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -245,7 +245,7 @@ static void event_to_host_cb(struct vchiq_mmal_instance *instance,
>  /* workqueue scheduled callback
>   *
>   * we do this because it is important we do not call any other vchiq
> - * sync calls from witin the message delivery thread
> + * sync calls from within the message delivery thread
>   */
>  static void buffer_work_cb(struct work_struct *work)
>  {
> -- 
> 2.34.1
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
