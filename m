Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08A7723ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjFFKCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjFFKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:02:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7CE78;
        Tue,  6 Jun 2023 03:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC2EB62598;
        Tue,  6 Jun 2023 10:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA03C433EF;
        Tue,  6 Jun 2023 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686045729;
        bh=1IoFuwmoNSSKAwyxIlVTyvXm8uDl4GdCtAIidncLBB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ye+qgjyDzSkgkebwek9jswghyGjYlglS9wXkb33X7e7Ie/Uv2rWxBZrqIFA8/5Q44
         Qt0FxrJOYXfkdLJoMtiDhUHRvRdzxz6ZLxYeCw37b6LB/jQMGOb3jCer3xDknF4xfX
         aeT8jODlrzBENDSIk9nb0283Ga10Q7tD2ugaLP7M=
Date:   Tue, 6 Jun 2023 12:02:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: usb: musb: musb_gadget: fixed coding style
 issues and removed unneeded code
Message-ID: <2023060644-countdown-employer-2af9@gregkh>
References: <20230606065921.997102-1-neelchakrabortykernelwork@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606065921.997102-1-neelchakrabortykernelwork@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 12:29:21PM +0530, Neel Chakraborty wrote:
> Fixed a few coding style issues
> Removed the static int musb_gadget_vbus_session function as it was
> doing nothing.
> 
> Signed-off-by: Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
> ---
>  drivers/usb/musb/musb_gadget.c | 38 +++++++++++-----------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
