Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC85F7DEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJGTXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJGTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:22:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83D4103D87;
        Fri,  7 Oct 2022 12:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B6DFB82425;
        Fri,  7 Oct 2022 19:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F51C433D6;
        Fri,  7 Oct 2022 19:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665170486;
        bh=kDDmlANB1TS7aOxr2j/CieG7L5PTUWHRPHIq14nRaYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVZWtgf7wdX8Zv6uHNLH9b+zB/LFfCQawDgHDMpsFVIcS3aRImtkxL6vUYjGrriTB
         L8jrr1KcE66M6sEIQYfeCDjrTGSt9QFEY5keeZi5SZvYJ5wq2Hwe+6S1y9Y76GeK5C
         mcEmPoSiLuuPv0/p4t9Eny4doMrZPAUtaK+4gOhU=
Date:   Fri, 7 Oct 2022 21:22:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Justin Chen <justinpopo6@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, kishon@ti.com,
        linux-phy@lists.infradead.org, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for broadcom USB
Message-ID: <Y0B8X1q0twk5aJt0@kroah.com>
References: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com>
 <Yz/G0jQxc4c2gzhl@kroah.com>
 <CAJx26kUTzBeNkV_=gEeUYaatBwugT1uFH_b_ggq-fXaJDRBMqQ@mail.gmail.com>
 <Yz/Oik0uXXo0uGk6@kroah.com>
 <CAJx26kVL4nYL2fbHd31ZqpXxEos-nyQ2-GSZbL6FUa5ztAbxXw@mail.gmail.com>
 <Yz/UqtGD/dthxYJ2@kroah.com>
 <3d74b5cf-0f50-ac27-aa21-210507f41858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d74b5cf-0f50-ac27-aa21-210507f41858@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 11:45:04AM -0700, Florian Fainelli wrote:
> On 10/7/22 00:26, Greg KH wrote:
> > On Fri, Oct 07, 2022 at 12:19:01AM -0700, Justin Chen wrote:
> > > On Thu, Oct 6, 2022 at 11:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > On Thu, Oct 06, 2022 at 11:46:45PM -0700, Justin Chen wrote:
> > > > > On Thu, Oct 6, 2022 at 11:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > 
> > > > > > On Thu, Oct 06, 2022 at 04:21:09PM -0700, justinpopo6@gmail.com wrote:
> > > > > > > From: Justin Chen <justinpopo6@gmail.com>
> > > > > > > 
> > > > > > > Al Cooper is no longer the downstream maintainer for broadcom USB.
> > > > > > > I will be taking his place as downstream and as an additional
> > > > > > > upstream maintainer.
> > > > > > 
> > > > > > What do you mean by "downstream" here?
> > > > > > 
> > > > > Downstream as in internal to Broadcom. Apologies for the confusion.
> > > > 
> > > > Ok, but then why are these all gmail.com addresses?  Why not use your
> > > > proper work addresses instead so that we can at least validate that the
> > > > patches are coming from a broadcom.com domain?
> > > > 
> > > I believe the idea is we can continue to support as maintainers even
> > > if we are no longer part of broadcom without having to change emails.
> > > I believe Florian should be able to comment more. :)
> > 
> > So in other words, broadcom email servers do not allow sending patches
> > out without mangling the text?  :)
> 
> That was definitively the case years ago due to IT using a Microsoft
> Exchange SMTP server and which had us switch to our gmail.com accounts. The
> "continuity" aspect of not having your email change does matter IMHO in that
> we should always be reachable, at expense of not immediately disclosing our
> employer. Other reasons I heard was that people posting publicly with a
> @broadcom.com email grew tired of being asked when they would get a working
> WLAN driver for their card.
> 
> Now we supposedly have a special SMTP server that would not mangle the
> patches and also not add the annoying legalese footer at the end telling you
> to destroy the email.
> 
> Does it matter though as long as Jonathan Corbet knows about our employer at
> the time for his lwn.net stats :)?

It doesn't really matter much, but we are seeing more and more email
validation being added and required over time for people sending
patches.  So it's up to you and your corporate rules as to what you want
to do.

thanks,

greg k-h
