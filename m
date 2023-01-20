Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EE1674D83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjATG5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATG5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:57:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3765CE68;
        Thu, 19 Jan 2023 22:57:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157F561E31;
        Fri, 20 Jan 2023 06:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85E0C433D2;
        Fri, 20 Jan 2023 06:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674197830;
        bh=iR8irKikdBBBq/MCs+R8NpDj23hq/KzA4TkNi6TBP8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0K24k7BAgiK7lxn63tFMmRcFoHwbkqE/Szqh/Q3W5ZEECuX1CTHdtYYXrDzUeApt
         NRIHT/qjW92gzrGNryJjZ+Ij4ixh52Zi2tEiLkYSbov0GltugTmO/uCepxbP5hLAfp
         WBTP9ESvUQo1ps9FfH8Nq0jkjzqq7/+DKThXqqeA=
Date:   Fri, 20 Jan 2023 07:57:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: Re: [PATCH v5 2/6] staging: vc04_services: bcm2835-audio: Drop
 include Makefile directive
Message-ID: <Y8o7Qrg8MhCgkALk@kroah.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
 <20230119115503.268693-3-umang.jain@ideasonboard.com>
 <Y8nuJfuzW9QBcSVd@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8nuJfuzW9QBcSVd@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 03:28:05AM +0200, Laurent Pinchart wrote:
> Hi Umang,
> 
> Thank you for the patch.
> 
> On Thu, Jan 19, 2023 at 05:24:59PM +0530, Umang Jain wrote:
> > Drop the include directive they can break the build one only wants to
> > build a subdirectory. Replace with "../" for the includes, in the
> > bcm2835.h instead.
> 
> I assume you meant
> 
> Drop the include directive. They can break the build, when one only
> wants to build a subdirectory.
> 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > ---
> >  drivers/staging/vc04_services/bcm2835-audio/Makefile  | 2 --
> >  drivers/staging/vc04_services/bcm2835-audio/bcm2835.h | 3 ++-
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/bcm2835-audio/Makefile b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> > index fc7ac6112a3e..01ceebdf88e7 100644
> > --- a/drivers/staging/vc04_services/bcm2835-audio/Makefile
> > +++ b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> > @@ -1,5 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
> >  snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
> > -
> > -ccflags-y += -I $(srctree)/$(src)/../include
> 
> The reason for this, I assume, is that the driver is in staging. The
> vchiq.h file should live in include/linux/raspberrypi/, not
> drivers/staging/vc04_services/include/linux/raspberrypi/, so an
> additional include directory is added in order to use
> 
> #include <linux/raspberrypi/vchiq.h>
> 
> When the code will get out of staging, vchiq.h will go to
> include/linux/raspberrypi/, the extra include directory will be dropped,
> and all will be well without having to change any source file.
> 
> With this patch, we'll have to undo the change below to
> drivers/staging/vc04_services/bcm2835-audio/bcm2835.h when vc04_services
> will get out of staging.
> 
> Greg, is that what you prefer ?

I prefer the drivers to NOT use include ccflags in the kernel as it
breaks the build when trying to build just a subdirectory.  If/when this
code ever gets out of staging, then the include lines can be fixed up to
point to the correct location of wherever the files move to.

So I like this patch, but as I couldn't take the first one, this and the
rest did not apply so I'll wait for them to be resubmitted.

thanks,

greg k-h
