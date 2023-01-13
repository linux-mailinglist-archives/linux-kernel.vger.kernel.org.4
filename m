Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2666A777
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjANAYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjANAYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:24:05 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422C7D9E5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:24:03 -0800 (PST)
Received: from letrec.thunk.org ([172.102.9.47])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30E0Nn1B014084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 19:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1673655837; bh=0O+ILYmavkI++K+On1igazLn1QGxTLfJd8Hm6ezSXNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ob1dfKJxAQZgOvOyiL8n1E9g6meQgM4qJNAa2tcj1tUNnF3UObf2XLUWvq2LZ9iLH
         8VeHXl234fywRmnRnbaEgM3pPtTSHBkq7vi++uhXJqtHjiDHmcBLFvHtYb8pmodl7B
         sDiHtWrjBVUkxHqwPsbNGDiYxtIN8EoXjkWXMWFtDQHE1z4nnaRoYINKNyOp4iI1kV
         oZfeZhM+TmcEzN3A7ysSyI4Dk7mKK2QtAeyWP3d3V2WuPjyWqQ9n/h9v35J5h47mwz
         S5eHKPKW4Ur44RScI2dEfX5B/P4aznhbetcYwRZs28wClw5Vvu7Ss56kwJopWLGDmd
         quQ3FpBpPSSzg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 0E7418C0A8D; Fri, 13 Jan 2023 16:40:20 -0500 (EST)
Date:   Fri, 13 Jan 2023 16:40:19 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michal Simek <michal.simek@amd.com>,
        Kris Chaplin <kris.chaplin@amd.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y8HPw2t+TbdXa83C@mit.edu>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com>
 <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com>
 <Y8GFYEnIy0Wbh/n6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GFYEnIy0Wbh/n6@kroah.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 05:22:56PM +0100, Greg KH wrote:
> > I am just saying that developers/driver owners can simple do calculation to
> > identify LTS version. When they know it they also know time when their
> > deadline is for upstreaming work. It means if patch is accepted between
> > 6.0-r1 and 6.0-rc5/6 they know that it will get to 6.1 merge window.
> 
> That is what I am afraid of and if it causes problems I will purposfully
> pick the previous release.  This has happened in the past and is never
> an excuse to get anything merged.  Code gets merged when it is ready,
> not based on a LTS release.

This is probably the best reason not to preannounce when the LTS
release will be ahead of time --- because it can be abused by
developers who try to get not-ready-for-prime-time features into what
they think will be the LTS kernel, with the result that the last
release of the year could be utterly unsitable for that perpose.

What I would try to tell people who are trying to get a feature into
the enterprise distro kernel is to target a release in the *middle*a
of the year, so that there is plenty of time to stablize it before the
LTS kernel is cut.

Alternatively, I might work with the team reasponsible for release
engineering the "product" kernel that I might be targetting (for
example, for my company's Cloud Optimized OS) and since they follow
the "upstream first" principle, once the feature is upstream, they
will backport it into the various LTS release which we support for our
cloud customers.  And if it just so happens that Amazon Linux doesn't
have the feature, but my company's cloud OS does ---- well, that's the
way the cookie crumbles, and that's why the wise distro company will
have kernel developers on staff, not just try to freeload off of the
LTS maintainers.  :-)

						- Ted

P.S.  And if you work for a hardware company, in general the LTS
maintainers have been willing to handle backporting device drivers to
older LTS kernels, since your customers might very well might want to
stay on 5.15, 5.10, 5.4, etc.  Of course, if your feature requires
massive surgery all over the kernel, that's even more of a reason not
incentivize people to make massive, risky changes right before the LTS
kernel is cut.
