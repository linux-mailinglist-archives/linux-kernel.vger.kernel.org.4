Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01C610CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJ1JKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1JJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:09:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482D19C34;
        Fri, 28 Oct 2022 02:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10DF5B8286D;
        Fri, 28 Oct 2022 09:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F2AC433C1;
        Fri, 28 Oct 2022 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666948192;
        bh=StSAq7x4Hh8GGTSvGeFg0pRLwkCZQ54Dfmmmc4LQcnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bd4NabXNCmnoLhtCtg9km/t7IWJY/e8mI6rqMaqvovubTZxVPWQ7rWksacMMnh8QO
         ws1Bn2iYV5eoRqDenyRDqsvZnESXMjKPIY2TCeJpGMJoB7++kQ39S5e/yfO1E0PkUQ
         KtjI+ERvjEjAdJ0pYj9ydJaCdqlqDTlB9L48jnGE=
Date:   Fri, 28 Oct 2022 11:09:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Chi <raychi@google.com>
Cc:     stern@rowland.harvard.edu, m.grzeschik@pengutronix.de,
        albertccwang@google.com, pumahsu@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH RESEND v4] usb: core: stop USB enumeration if too many
 retries
Message-ID: <Y1ucXnFzxo5Aa+2a@kroah.com>
References: <20221028090116.199601-1-raychi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028090116.199601-1-raychi@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 05:01:16PM +0800, Ray Chi wrote:
> When a broken USB accessory connects to a USB host, usbcore might
> keep doing enumeration retries. If the host has a watchdog mechanism,
> the kernel panic will happen on the host.
> 
> This patch provides an attribute early_stop to limit the numbers of retries
> for each port of a hub. If a port was marked with early_stop attribute,
> unsuccessful connection attempts will fail quickly. In addition, if an
> early_stop port has failed to initialize, it will ignore all future
> connection events until early_stop attribute is clear.
> 
> Signed-off-by: Ray Chi <raychi@google.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-usb | 11 +++++
>  drivers/usb/core/hub.c                  | 59 +++++++++++++++++++++++++
>  drivers/usb/core/hub.h                  |  4 ++
>  drivers/usb/core/port.c                 | 27 +++++++++++
>  4 files changed, 101 insertions(+)
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
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
