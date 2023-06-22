Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9501F7397DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjFVHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFVHKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38891BD5;
        Thu, 22 Jun 2023 00:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 161B161777;
        Thu, 22 Jun 2023 07:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23007C433C0;
        Thu, 22 Jun 2023 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687417816;
        bh=jJ9/1h8Jv56y/AA0CGfCYljz3gMni9xKw48AEwgthYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToTrTUz1nz11K9iDk9LIgOMV4VpTgYxe0YBWLZrjy2aIaDWQH2LamHZmZlKiiDFz8
         g0YCpxG9BQGq6DFR4HoRawTjdllmaKN7gSIdxc+00iVHhiabpt4BAERs2fGOd/m71u
         BC0a+30O5DmQmhWMIrdKLzEtsFiIgzYXjBHblu+k=
Date:   Thu, 22 Jun 2023 09:10:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and the
 wider community
Message-ID: <2023062245-engraver-antsy-005c@gregkh>
References: <20230620212502.GI286961@mit.edu>
 <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
 <2023062144-hefty-why-305d@gregkh>
 <04cd7204-cdee-c333-8815-57acbab82721@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04cd7204-cdee-c333-8815-57acbab82721@linux-m68k.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 05:02:10PM +1000, Finn Thain wrote:
> On Wed, 21 Jun 2023, Greg Kroah-Hartman wrote:
> 
> > On Wed, Jun 21, 2023 at 11:51:19AM +1000, Finn Thain wrote:
> > > > You appear to have a very different model of how non-profits might 
> > > > approach the Linux kernel --- could you go into more detail about 
> > > > why they might want to contribute to the Linux kernel, and how we 
> > > > might encourage them to contribute more engineering effort?
> > > > 
> > > 
> > > Sure. Here's a recent example, in which a not-for-profit volunteer 
> > > might have been granted an opportunity to work upstream: 
> > > https://lore.kernel.org/all/129c9d5e-213a-80c9-092e-dc1dcf38ae3e@linux-m68k.org/
> > > 
> > > The driver in question may may not be commercially viable, but that 
> > > doesn't matter, if the intention is to foster new maintainers and 
> > > increase the talent pool. And the problem ostensibly being addressed 
> > > in the Linux Contributor Maturity Model is a shortage of maintainers.
> > 
> > I would NEVER recommend ANYONE picking up obsolete hardware and trying 
> > to get it to work to maintain the driver if NO ONE is actually using the 
> > stuff.  That should not be for a not-for-profit to maintain as 
> > obviously, no one uses it.
> > 
> > It's up to those that need/use the code to help maintain it, don't ask 
> > not-for-profit groups to maintain and support code that no one uses, 
> > that's a sure way to waste resources all around.
> > 
> 
> Actually, that patch was offered without any prompting from me. But you're 
> quite right -- I would have prompted it, had I had the oppportunity.
> 
> > So that's a good example of how our ecosystem works properly, if no one 
> > needs the code, it gets dropped.  Don't ask for it to come back without 
> > real users who are invested in it please.
> > 
> 
> You mentioned wasted resources. If you want to generate e-waste, remove 
> drivers from the kernel. If you want to prevent e-waste, add drivers for 
> obsolete hardware and then watch the user count climb from zero as devices 
> get pulled from drawers and dusted off.

Based on our experience, opld devices are not being pulled from
anywhere, and if they were being used, they almost always take more
power than existing devices, so it's hard to justify the use of them at
times given energy prices in many parts of the world.

> Anyway, your reaction is an interesting example of strong feelings in the 
> community as to how contributed code should or should not be used.

I did not pass any judgement on how the code should or should not be
used.  All I am saying is that this code is not being used at all.

> If there was consensus, it might be feasible to give a formula for 
> "recognized usage" which could be quantified. From there we could create a 
> kind of heat map to show which commits, maintainers, processes, models, 
> modules etc. were the most "useful" within some time interval.

Determining code use is difficult given that we are not going to add
tracking to the kernel source for obvious reasons, so this is a
non-starter, as you know.

greg k-h
