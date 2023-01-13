Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99E669E24
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjAMQ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjAMQ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:28:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A381431
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:23:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCB9AB82180
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613DCC433D2;
        Fri, 13 Jan 2023 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673626985;
        bh=YDX8SJkt3SZ4+nX7Nq7WTlGzwK5A4+n7LBCrk9/cja4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnwSipf5fncfGe59Vpl0F6IgjRTeHtcbjfHcl+3Cmwdry6129xzk+QRq4Oo7PS7RK
         PAZT7uJR5QSRc4CW/OMAxbcAAZpTVgX0JK6gcqxtf2L0FD5fS7+mII2Nks+lbKNGw7
         UXImkIZcQHM6v1IIceYqBZtNx/xZMn8y/VV3Xa2M=
Date:   Fri, 13 Jan 2023 17:22:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Kris Chaplin <kris.chaplin@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y8GFYEnIy0Wbh/n6@kroah.com>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com>
 <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 01:54:29PM +0100, Michal Simek wrote:
> 
> 
> On 1/13/23 12:27, Greg KH wrote:
> > On Thu, Jan 12, 2023 at 01:26:28PM +0100, Michal Simek wrote:
> > > Hi Greg,
> > > 
> > > On 1/12/23 13:23, Kris Chaplin wrote:
> > > > Hello Greg,
> > > > 
> > > > > You tell me please.  How has your testing gone for 6.1 so far?  Does it
> > > > > work properly for you?  Are you and/or your company willing to test out
> > > > > the -rc releases and provide feedback if it works or not for your
> > > > > systems?  Do you have problems with 6.1.y vs. older kernels?  Is there
> > > > > anything missing in it that you feel needs to be addressed with a newer
> > > > > kernel instead?
> > > > 
> > > > We have been integrating and testing 6.1 on the Microblaze, ARM32 and
> > > > ARM64-bit architectures over the past few weeks.  These builds have
> > > > been successful and we are able to run our regression tests on hardware
> > > > targeting our FPGA SoC devices.
> > > > 
> > > > We're continuing our tests as new updates to the 6.1 kernel series
> > > > appear.
> > > 
> > > As Kris said AMD/Xilinx has already moved internal SOC tree to 6.1 based
> > > kernel in expectation that 6.1 will become next LTS.
> > > And I am not aware about any issue from testing team related to 6.1 kernel
> > > version. And we are covering our AMD/Xilinx SOCs based on arm32/arm64 and
> > > Microblaze CPUs.
> > > 
> > > It would be good to continue with the same strategy which using the latest
> > > kernel at that year which is what I am hearing all the time from others that
> > > 6.1 was last kernel at that year and it should be LTS.
> > 
> > Generally yes, I pick the last release of the year but we need people to
> > verify and validate that both it works for them, and that they are going
> > to be using it in their systems and can provide testing results to us
> > (as well as providing a way for their devices to actually be updated to
> > the new releases, we've had previous stable kernel releases that were
> > never actually shipped out to devices...)
> 
> We are preparing base (every year) for our customers which is what it is
> also shipped in our distribution.

What distribution does AMD create?  Who uses it?  Where is it published
and how is it updated?

> Other distribution like Ubuntu with their derivative kernels prefer to stay
> on the LTS kernels too.

I already discuss this with the various "normal" distributions all the
time so they know what is going on here already.

> Also users will be getting fixes against our base for extended period with
> fixes going from vanilla kernel.

What is "your base"?  Who uses this?  How long is it supported?

> For code which is not upstream(which we unfortunately have it) we are
> providing fixes only till the next LTS version base is created.

So you only support the image for one year?

> That's why it is very beneficial to use for our base kernel which is going
> to be LTS that users will get that extended period support.

But you should be keeping this up to date for each normal release,
right?  Never do only yearly jumps, that way causes way too much work
and is proven to be a bad idea.

And why not just update your "customers" to every normal release?  Why
stick them with one a year?  What is preventing more frequent updates?

> Base Kernel version is taken after your decision about LTS. But this year
> because of timing we couldn't wait for this decision. That's why 6.1 was
> taken with expectation that your generic concept about picking up the last
> release of the year is going to continue.

That's a great guess, but again, you should always be updating your
out-of-tree changes against every release so it will not matter what
kernel is picked as a stable one or not.

> Tested wise. We have test result from 6.1 <.0> and I have also shared 6.1.5
> based version for our distribution. As of today we can't see any issue with
> 6.1 kernel in general on features which we are using on AMD/Xilinx SOCs.

Great, can you also test the -rc releases to make sure we don't break
anything for your systems?

> Also Jonathan wrote at https://lwn.net/Articles/915435/
> "Unless something extremely surprising happens, 6.1 will be the final kernel
> release for 2022, and thus will become the next LTS kernel."
> That's why I hope that 6.1 is going to be next LTS.

Testing and feedback is going to be what allows this to happen.  I can't
happen in a vacuum, and nor should you want it to.

> > > I didn't run any stats but normally also more patches are going to this
> > > version to be the part of LTS.
> > 
> > What do you mean by this?  The patches accepted so far since 6.1.0 was
> > released, or up until 6.1.0 was released?  For the patches since 6.1.0
> > was released, that's due to more developers/maintainers tagging patches
> > during the -rc1 merge window for stable releases (honestly they should
> > have gotten them into the -final release first), and due to us having
> > better tools in digging up potential stable patches (i.e. Sasha's
> > AUTOSEL bot work.)
> 
> I am just saying that developers/driver owners can simple do calculation to
> identify LTS version. When they know it they also know time when their
> deadline is for upstreaming work. It means if patch is accepted between
> 6.0-r1 and 6.0-rc5/6 they know that it will get to 6.1 merge window.

That is what I am afraid of and if it causes problems I will purposfully
pick the previous release.  This has happened in the past and is never
an excuse to get anything merged.  Code gets merged when it is ready,
not based on a LTS release.

thanks,

greg k-h
