Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9063CFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiK3H13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiK3H11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:27:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D401D5B85E;
        Tue, 29 Nov 2022 23:27:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E66861A46;
        Wed, 30 Nov 2022 07:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1246EC433C1;
        Wed, 30 Nov 2022 07:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669793245;
        bh=xtnl6/qLF/jI+9/d7SK6ChMqoUOlvdXtqutDbCp/vmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIrjOPhKPpnf0sy5B4xqOHfAQtuMvOctotxQwttqHRoIQsVbyk0NM0ElhkdFWTWmX
         3kM1SyL5jE3/yyVvx1cjBY2tYhnXInqzGN9DqZKR9dBRLO0l/ushhcdJ1b6advbiy9
         fXtQrewCH4b0dl1kdQCx5R3fD5HYuFO1kxX3n2a4=
Date:   Wed, 30 Nov 2022 08:27:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
Message-ID: <Y4cF2pX4Lohefm4f@kroah.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <YyHq9OOKBLP2GEcc@kroah.com>
 <5d1485d4-08d4-1e26-f597-b5fa6cc65ce6@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1485d4-08d4-1e26-f597-b5fa6cc65ce6@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 09:10:08AM +0530, Manjunatha Venkatesh wrote:
> 
> On 9/14/2022 8:23 PM, Greg KH wrote:

Note, originally you all were "rushed" to get this accepted, and now
this took 2 1/2 months to respond back to a code review?  Something is
wrong here, when responding so late, almost all context is lost :(

> > Caution: EXT Email
> > 
> > On Wed, Sep 14, 2022 at 07:59:44PM +0530, Manjunatha Venkatesh wrote:
> > > +++ b/drivers/misc/nxp-sr1xx.c
> > > @@ -0,0 +1,794 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > Please no.  If you really want to dual-license your Linux kernel code,
> > that's fine, but I will insist that you get a signed-off-by from your
> > corporate lawyer so that I know that they agree with this and are
> > willing to handle all of the complex issues that this entails as it will
> > require work on their side over time.
> > 
> > If that's not worth bothering your lawyers over, please just stick with
> > GPL as the only license.
> Dual-license is signed-off by NXP corporate lawyer.

We need a signed-off-by on the patch itself.

> Though, we would like to understand what complex issues which require
> work over the time?

I am not a lawyer and can not advise you of this, please work with yours
to set into place the requirements you will have to keep this working
properly.  Note, it is not trivial, and will require work on your end.

I will push back again, and ask "Why?"  Why do you want this dual
licensed?  What is driving that requirement and what will having it
licensed like this enable you to do that having it just under GPL-2.0
will not?

> > > +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
> > > +#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)
> > You can't stick ioctl command definitions in a .c file that userspace
> > never sees.  How are your userspace tools supposed to know what the
> > ioctl is and how it is defined?
> We will move ioctl command definitions into user space header file as part
> of our next patch submission.
> > How was this ever tested and where is your userspace code that interacts
> > with this code?
> We will share the corresponding user space code soon,meanwhile can you
> please suggest how to share this user space code?

You all have ways of posting code publicly :)

thanks,

greg k-h
