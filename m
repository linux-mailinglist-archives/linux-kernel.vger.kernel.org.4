Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2D6695C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbjAMLiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjAMLhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:37:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1A5F917
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:27:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32940B8211C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0976AC433D2;
        Fri, 13 Jan 2023 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673609242;
        bh=DL7Rv8R8ZcSMbuTUDBTyVdswyoWOualPuASbLY1fd4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bA/PtKBZVejYKfCRXPKGl6CKieE7XHaOYE4uCU353hYo4uWsmGiLhY7D9mDnCAkly
         SGHbgt3A3B8ME3Uc6B5aO8xGfIT63XaewEbIlaZ06eKTPYcd0UeugM8E/ealcZpFeM
         ICYwWQtbAIL1RNS8ohYQXGwddx0yAMDg1U77ECuc=
Date:   Fri, 13 Jan 2023 12:27:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Kris Chaplin <kris.chaplin@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y8FAFAwB9gBzQXQG@kroah.com>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 01:26:28PM +0100, Michal Simek wrote:
> Hi Greg,
> 
> On 1/12/23 13:23, Kris Chaplin wrote:
> > Hello Greg,
> > 
> > > You tell me please.  How has your testing gone for 6.1 so far?  Does it
> > > work properly for you?  Are you and/or your company willing to test out
> > > the -rc releases and provide feedback if it works or not for your
> > > systems?  Do you have problems with 6.1.y vs. older kernels?  Is there
> > > anything missing in it that you feel needs to be addressed with a newer
> > > kernel instead?
> > 
> > We have been integrating and testing 6.1 on the Microblaze, ARM32 and
> > ARM64-bit architectures over the past few weeks.  These builds have
> > been successful and we are able to run our regression tests on hardware
> > targeting our FPGA SoC devices.
> > 
> > We're continuing our tests as new updates to the 6.1 kernel series
> > appear.
> 
> As Kris said AMD/Xilinx has already moved internal SOC tree to 6.1 based
> kernel in expectation that 6.1 will become next LTS.
> And I am not aware about any issue from testing team related to 6.1 kernel
> version. And we are covering our AMD/Xilinx SOCs based on arm32/arm64 and
> Microblaze CPUs.
> 
> It would be good to continue with the same strategy which using the latest
> kernel at that year which is what I am hearing all the time from others that
> 6.1 was last kernel at that year and it should be LTS.

Generally yes, I pick the last release of the year but we need people to
verify and validate that both it works for them, and that they are going
to be using it in their systems and can provide testing results to us
(as well as providing a way for their devices to actually be updated to
the new releases, we've had previous stable kernel releases that were
never actually shipped out to devices...)

> I didn't run any stats but normally also more patches are going to this
> version to be the part of LTS.

What do you mean by this?  The patches accepted so far since 6.1.0 was
released, or up until 6.1.0 was released?  For the patches since 6.1.0
was released, that's due to more developers/maintainers tagging patches
during the -rc1 merge window for stable releases (honestly they should
have gotten them into the -final release first), and due to us having
better tools in digging up potential stable patches (i.e. Sasha's
AUTOSEL bot work.)

thanks,

greg k-h
