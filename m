Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A60695D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjBNIw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjBNIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:52:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A523339
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:52:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 212DFB81C98
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EC6C433D2;
        Tue, 14 Feb 2023 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676364757;
        bh=IIWs74rDQbQtURoMw6kjDY1f5MCO5pO7u7SRouv8I/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a5ZtR6VCDkFmWmygnlGk2oFzr7iTJ+eh09az13EXl+1jXcUSvUrA//gA2BPISj111
         ZTzw/F9trwEKz2gAcjcmgVJj9x+43rkBGgV4mmxRTz/Eai2a3iRWPXZ0SoI530wYE4
         HrDpfT9dHxjWgwdM/gqRCLUoa0Rqr3jX4cr5HBr4=
Date:   Tue, 14 Feb 2023 09:52:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matt Hsiao <matt.hsiao@hpe.com>
Cc:     "Gaba, Aahit" <aahit.gaba@hpe.com>,
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
Message-ID: <Y+tL02m4zS1d+WAa@kroah.com>
References: <20221116103457.27486-1-matt.hsiao@hpe.com>
 <Y3TLSON/7XRG5BiN@kroah.com>
 <20230209033812.GA17928@blofly.tw.rdlabs.hpecorp.net>
 <MW4PR84MB1539887EFAA00D60D777C75696D99@MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM>
 <Y+YqscpBXMMTWT6V@kroah.com>
 <20230214083017.GA22428@blofly.tw.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214083017.GA22428@blofly.tw.rdlabs.hpecorp.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 04:30:17PM +0800, Matt Hsiao wrote:
> On Fri, Feb 10, 2023 at 12:29:53PM +0100, Greg KH wrote:
> > On Thu, Feb 09, 2023 at 03:59:04AM +0000, Gaba, Aahit wrote:
> > > On Thu, Feb 09, 2023 at 09:29:00AM +0530, Aahit Gaba wrote:
> > > > On Wed, Nov 16, 2022 at 12:36:40PM +0100, Greg KH wrote:
> > > > > On Wed, Nov 16, 2022 at 06:34:57PM +0800, matt.hsiao@hpe.com wrote:
> > > > > > From: Matt Hsiao <matt.hsiao@hpe.com>
> > > > > >
> > > > > > Currently, the hpilo driver is licensed as GPL. To run OpenBSD on
> > > > > > HPE servers with BMC (HPE iLO) functionality, a dual MIT/GPL license
> > > > > > is needed for porting the hpilo driver to OpenBSD.
> > > > > >
> > > > > > Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> > > > > > ---
> > > > > >
> > > > > > Hello contributors in the CC list,
> > > > > >
> > > > > > Thanks for your contributions to the hpilo driver. Please kindly
> > > > > > review the license change and hopefully you would agree and approve it.
> > > > Thanks!
> > > > > >
> > > > > > Patch v2:
> > > > > > ---------
> > > > > > - Change MODULE_LICENSE to Dual MIT/GPL too
> > > > >
> > > > > As I asked for on the v1 version (delayed email on my side), I need a
> > > > > lawyer from HPE to sign off on this change as well.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > > 
> > > > Add HPE attorney Aahit Gaba to sign off.
> > > 
> > > Signed-off-by: Aahit Gaba <aahit.gaba@hpe.com>
> > > 
> > > The reasons we want to dual license Linux hpilo driver are:
> > > - There are required bug fixes that are not copyrighted by HPE in the current Linux hpilo driver.
> > 
> > And have you identified them and gotten a sign-off from those copyright
> > holders?  I don't see that here documented at all, so I imagine you
> > documented it somewhere else?  If so, where?
> 
> We are under the assumption that hpilo contributors would reply to this
> thread with their 'Acked-by' or 'Signed-off-by'. Is that the proper
> approach?

Please work with your legal team to do this properly, they know what to
do here.  If not, then just don't worry about it (i.e. if it costs too
much to do this, just spend the money to write a second driver.)

> We shouldn't have used the term 'one driver'. More accurate description
> is we want the core driver features and any changes or bug fixes apply
> to that dual licensed. We understand that the parts of the driver that
> are calls to Linux specific functions would be different in OpenBSD.
> There are also some Linux infrastructure things that would be different
> in OpenBSD. The key for us is that the core driver features and any
> future changes be kept in sync between Linux and OpenBSD.

Again, you have full control over this as you are making those changes
yourself.  I really don't see why you need to do this.

Write the OpenBSD driver yourself and see if you could actually share
anything.  Odds are, the shared parts you already have copyright over
today, so there's no issues involved.

good luck!

greg k-h
