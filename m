Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9080266A9EA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjANHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjANHPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:15:15 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0F9E212C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:14:23 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30E7ECCw005543;
        Sat, 14 Jan 2023 08:14:12 +0100
Date:   Sat, 14 Jan 2023 08:14:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Michal Simek <michal.simek@amd.com>,
        Kris Chaplin <kris.chaplin@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <20230114071412.GB5088@1wt.eu>
References: <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com>
 <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com>
 <Y8GFYEnIy0Wbh/n6@kroah.com>
 <Y8HPw2t+TbdXa83C@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8HPw2t+TbdXa83C@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:40:19PM -0500, Theodore Ts'o wrote:
> On Fri, Jan 13, 2023 at 05:22:56PM +0100, Greg KH wrote:
> > > I am just saying that developers/driver owners can simple do calculation to
> > > identify LTS version. When they know it they also know time when their
> > > deadline is for upstreaming work. It means if patch is accepted between
> > > 6.0-r1 and 6.0-rc5/6 they know that it will get to 6.1 merge window.
> > 
> > That is what I am afraid of and if it causes problems I will purposfully
> > pick the previous release.  This has happened in the past and is never
> > an excuse to get anything merged.  Code gets merged when it is ready,
> > not based on a LTS release.
> 
> This is probably the best reason not to preannounce when the LTS
> release will be ahead of time --- because it can be abused by
> developers who try to get not-ready-for-prime-time features into what
> they think will be the LTS kernel, with the result that the last
> release of the year could be utterly unsitable for that perpose.

We know this risk exists but since Greg never makes promises on any
version, it remains reasonable. For users who have to rebase some local
patches and run tests, it's still quite important to have a good enough
idea about what version to start working on. It also encourages them to
test the expected version earlier and possibly return more feedback
during the -rc cycle. I did this for 4.9 and 5.10. We all know that
making a good release is a collective effort, and that as such, getting
forces aligned on one version is helpful. However if the engagement is
too strong there's a risk that everyone relies on others. As such I
think the current approach is the most balanced one. All those who
follow the kernel development have reasonably good confidence about what
the version will be, are willing to assign a bit of time to it and their
participation contributes to making it suitable for becoming LTS. And if
nobody cares about it, there's no need for it to become LTS and be
maintained by a single person. And this approach keeps away all those
only interested in "my manager asks me what the next version will be".

> What I would try to tell people who are trying to get a feature into
> the enterprise distro kernel is to target a release in the *middle*a
> of the year, so that there is plenty of time to stablize it before the
> LTS kernel is cut.

Definitely! It's also important to let people know that if they push
too much stuff at once, it's the best way for this stuff never being
reviewed by lack of reviewers time, hence not being merged. Thus
pushing too much too late will never work for an LTS release.

Willy
