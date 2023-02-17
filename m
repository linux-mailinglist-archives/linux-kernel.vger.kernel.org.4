Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC169AFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjBQPuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBQPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:50:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3306028203;
        Fri, 17 Feb 2023 07:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD2B61D58;
        Fri, 17 Feb 2023 15:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FA4C433D2;
        Fri, 17 Feb 2023 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676649021;
        bh=wdxVx4yRbEc5bQYA+TtsVCZUg/aQa+90CIuR0xubgqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnXwVzCXqWp5QtaaLoFxiISBidR38PhCJCGJ2BTWVMrous5BvWiK0Rz6W2MRmjL6I
         O7CxT06U9wALUWH02ZtPdp/gQIn/ORX8BsopC9Yt7sveWRQpFVtMtxZlipY9/lHlxY
         0VRWY5rZzFq+wcxAdPQfCpohVeCtz9Gn18EQNm9M=
Date:   Fri, 17 Feb 2023 16:50:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Angelo Compagnucci <angelo@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] misc: servo-pwm: driver for controlling servo
 motors via PWM
Message-ID: <Y++iOrrong8atQTM@kroah.com>
References: <20230217145731.3018148-1-angelo@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217145731.3018148-1-angelo@amarulasolutions.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 03:57:28PM +0100, Angelo Compagnucci wrote:
> This patch adds a simple driver to control servo motor position via
> PWM signal.
> The driver allows to set the angle from userspace, while min/max
> positions duty cycle and the motor degrees aperture are defined in
> the dts.
> 
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
>  MAINTAINERS              |   6 ++
>  drivers/misc/Kconfig     |  11 +++
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/servo-pwm.c | 149 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 167 insertions(+)
>  create mode 100644 drivers/misc/servo-pwm.c
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
