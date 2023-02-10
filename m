Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76F2691E43
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjBJLaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjBJL36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:29:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18D2A5E8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:29:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73CAB61D8E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4895CC433D2;
        Fri, 10 Feb 2023 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676028596;
        bh=ZxG5OIhHVe7YMOoL6EJqoffJA+00mdVAJDaQPdFUyfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wkk9R5Psp96/sxBVODOmTjusIPh9vPBT2VF+zKTUqg2VLyWgtsFjpds+g8H6CQudI
         7ycUhe74+bLAmmvC2HsjlBN3P1RDYTuOVU7Q9sKW1sppM2uQMeT37pxjfSfsZl0hbx
         D+nSjS346QR2hjxwFakozrLmsTEmcdg16mjFwdhg=
Date:   Fri, 10 Feb 2023 12:29:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gaba, Aahit" <aahit.gaba@hpe.com>
Cc:     "Hsiao, Matt (CBG Linux Enablement)" <matt.hsiao@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "nishadkamdar@gmail.com" <nishadkamdar@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "dhaval.experiance@gmail.com" <dhaval.experiance@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "arvind.yadav.cs@gmail.com" <arvind.yadav.cs@gmail.com>,
        "standby24x7@gmail.com" <standby24x7@gmail.com>,
        "wfp5p@virginia.edu" <wfp5p@virginia.edu>,
        "jslaby@suse.cz" <jslaby@suse.cz>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>
Subject: Re: [PATCH v2] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Message-ID: <Y+YqscpBXMMTWT6V@kroah.com>
References: <20221116103457.27486-1-matt.hsiao@hpe.com>
 <Y3TLSON/7XRG5BiN@kroah.com>
 <20230209033812.GA17928@blofly.tw.rdlabs.hpecorp.net>
 <MW4PR84MB1539887EFAA00D60D777C75696D99@MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR84MB1539887EFAA00D60D777C75696D99@MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 03:59:04AM +0000, Gaba, Aahit wrote:
> On Thu, Feb 09, 2023 at 09:29:00AM +0530, Aahit Gaba wrote:
> > On Wed, Nov 16, 2022 at 12:36:40PM +0100, Greg KH wrote:
> > > On Wed, Nov 16, 2022 at 06:34:57PM +0800, matt.hsiao@hpe.com wrote:
> > > > From: Matt Hsiao <matt.hsiao@hpe.com>
> > > >
> > > > Currently, the hpilo driver is licensed as GPL. To run OpenBSD on
> > > > HPE servers with BMC (HPE iLO) functionality, a dual MIT/GPL license
> > > > is needed for porting the hpilo driver to OpenBSD.
> > > >
> > > > Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> > > > ---
> > > >
> > > > Hello contributors in the CC list,
> > > >
> > > > Thanks for your contributions to the hpilo driver. Please kindly
> > > > review the license change and hopefully you would agree and approve it.
> > Thanks!
> > > >
> > > > Patch v2:
> > > > ---------
> > > > - Change MODULE_LICENSE to Dual MIT/GPL too
> > >
> > > As I asked for on the v1 version (delayed email on my side), I need a
> > > lawyer from HPE to sign off on this change as well.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > Add HPE attorney Aahit Gaba to sign off.
> 
> Signed-off-by: Aahit Gaba <aahit.gaba@hpe.com>
> 
> The reasons we want to dual license Linux hpilo driver are:
> - There are required bug fixes that are not copyrighted by HPE in the current Linux hpilo driver.

And have you identified them and gotten a sign-off from those copyright
holders?  I don't see that here documented at all, so I imagine you
documented it somewhere else?  If so, where?

> - We want to maintain one hpilo driver between Linux and OpenBSD, and dual-licensing of hpilo driver's existing codebase and all the future bug fixes are the requirements for it. Therefore, we requested all other copyright owners of Linux hpilo driver to accept dual-licensing (MIT/GPL-2.0) for their respective contributions.

You can request, you can not require, right?

How are you going to deal with the fact that the driver really can not
be shared between these two operating systems without a lot of rewriting
and changing of the code?

Also, this code uses GPL-only symbols out of the Linux kernel, how are
you going to handle them in openbsd?  Do you have a port of the code to
openbsd somewhere for review that shows how this all is translated?

And this is really a tiny driver, why not just rewrite it from scratch
for openbsd anyway?  Odds are that's going to be required to fit into
the openbsd driver and coding style, right?

thanks,

greg k-h
