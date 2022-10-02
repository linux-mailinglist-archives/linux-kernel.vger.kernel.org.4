Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38E35F2602
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJBWls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJBWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:41:46 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8B237407;
        Sun,  2 Oct 2022 15:41:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 43A188B8;
        Mon,  3 Oct 2022 00:41:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664750501;
        bh=9YHvVO0lZ8ECdX4IILvkBEPYkos2SyNsC+B9YsNgE1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlUNszvyy3Y3LRFMarsLXHPFkcVaPVn8G3cOXT7o10wikyFqsahgSubkZFq0v5y25
         WjffjuvTeyZycUuh9iEie+upJX/cxJyPeIwg3k4VAbrgUYnlj+idWSPptvB6KzWe4R
         6XA+euB+AdATRqGajlDSg6BKG18OvobphV7iKN6c=
Date:   Mon, 3 Oct 2022 01:41:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>, Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <YzoTpJ3m2EzerdSL@pendragon.ideasonboard.com>
References: <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <Yzn9ci/9urgTCF6h@pendragon.ideasonboard.com>
 <20221002181801.25b5ff77@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221002181801.25b5ff77@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Sun, Oct 02, 2022 at 06:18:01PM -0400, Steven Rostedt wrote:
> On Mon, 3 Oct 2022 00:06:58 +0300 Laurent Pinchart wrote:
> > > 
> > > If you are using fedora, go bug Red Hat, Ubuntu then Canonical. And
> > > again, it comes down to if you have a paid subscription or not if you
> > > are going to get anywhere with it.
> > > 
> > > Can this be annoying, sure. But that's how the open source ecosystem
> > > works.  
> > 
> > The dichotomy between the community/hobbyist/free side and the
> > commercial/professional/paid side is an argument I often hear, and often
> > make myself. It is not, however, ineluctable.
> 
> But is still the essence of a community. Things only get done when it
> benefits those that are doing it. The point of open source is that
> collaborating has a benefit for all involved. But dealing with bugs
> that do affect you directly, usually goes to the bottom of your
> priority list. Not that you are not willing to do so, but it may only
> get done when you have time to do it. And we all know how much time
> kernel developers have.

Absolutely, and that's why I think an efficient bug tracking *process*
(regardless of the tooling) would require new people to handle it
(obviously in collaboration with existing developers). I don't think we
can expect developers and maintainers to expand beyond what they're
already doing to new areas or to extend the amount of time they spend on
bug handling without expanding at the same time the scope of the
subsystems. The kernel started with technical maintainers, and over time
we have seen the rise of community builders in some subsystems. I
believe it would be possible to expand communities to cover a more
professional style of bug tracking and handling, but not by just
stretching the resources we have.

> > We have shown multiple times that this barrier doesn't have to exist.
> > The kernel is an impressive example of how companies and communities can
> > cooperate to reach a result that no single entity could have achieved.
> > It started with the development model and how it scaled, and other areas
> > were tackled along the way, such as automated testing and quality
> > control in general for instance. Lots of efforts went into creating
> > solutions that could fulfil the unique needs of our development model,
> > and into convincing large and small companies to invest, either money or
> > time.
> > 
> > Are we doing a great job ? Certainly not. But we are moving forward. As
> > Jon Corbet said several years ago in one of his talks, now that the
> > Linux kernel has reached a leading position in many areas, we have lost
> > the comfort of following other industry actors and have to innovate
> > ourselves. That often means (and this thought is mine, not Jon's)
> > winging it along the way. As impressive as some of our achievements may
> > be, our failures to maintain some areas of the kernel in a professional
> > way is also astonishing (https://xkcd.com/2347/ comes to mind). It's not
> > entirely surprising: the community and (part-time) volunteer model means
> > that everybody will tackle problems that interest them. Building a
> > community that can deliver professional support is not an interesting
> > task for everybody. It is, however, a key factor in the difference
> > between a kernel subsystem that strives and a subsystem that survives.
> 
> Exactly. The problem is that this is an issue (getting general bug
> reporting from users), but it's not a fatal one if you don't get it
> right. The community tends to do what it takes to survive. It's usually
> not until there's a well established threat that everyone changes how
> they do things. Major updates to the kernel at the end of an -rc
> release is unheard of, until there's a meltdown/spectre threat.
> 
> > I believe the same holds true for bug tracking and support. At the end
> > of the day, someone will need to pay for it, but we could shatter the
> > traditional model here too. We could, given enough interest, bridge the
> > gap between all involved parties and create a support model that would
> > benefit everybody. It took years and huge efforts for Linux to evolve
> > towards more professionalism in many areas, and it would take more years
> > and more effort to continue and expand that, but I believe it would be
> > feasible.
> 
> Linus went away and came back with git. Should we ask him to go away
> and come back with a better bugzilla? :-D

I'm sure Linus could give it a try if he was interested, but that's the
wrong approach. They key to a successful free software community is to
be prepared to do all the work yourself, not expecting that throwing
ideas around will result in someone jumping in to fix all your problems.
It may happen, but relying on it will most often lead to disappointment.
The same thing applies here. I believe something could be done to
improve bug tracking very significantly, but I have no hope that sharing
my ideas will magically result in any improvement (and when it comes to
volunteering to fix the problem myself, I can't, I'm drowning under
patch review and other tasks, in a perfect example of how things won't
scale when the amount of work prevents people from making the necessary
improvements that are key to lowering the workload).

> > Linux didn't start because Linus complained about existing operating
> > systems, ranted on usenet forums and waited for someone to fix the
> > problem. Someone will need to step up and lead the effrot here too. If
> > that person could ignore for a while that this is an impossible task, I
> > think they could succeed.
> > 
> > > If someone is not able to figure out how to use the mailing lists, it
> > > is unlikely that they will be able to be useful in working with the
> > > maintainer to solve their issue. As Ted mentioned, when asked to do
> > > something to help analyze the issue, many times there's no response
> > > from the reporter. Maybe because the reporter had no idea what the
> > > maintainer wanted them to do. Most kernel bugs requires a constant back
> > > and forth between the reporter and the developer. If you don't have
> > > that, then there's no reason to bother with trying to fix the issue.
> > > 
> > > Ideally, someone (you?) would want to be a middle man and triage the
> > > bugzilla reports and find those that look promising to get a fix
> > > completed, and then be the liaison between bugzilla and the kernel
> > > maintainer, then I think that could work. But the issue comes back to
> > > manpower. Who's going to do that?  
> > 
> > On the topic of triage, I've found that distro developers often do a
> > pretty good job. I've received multiple bug reports of great quality
> > following problems initially posted to distro bug trackers, after the
> > distro developers took the time needed to hold reporters by the hand to
> > get all the required information. Kudos for that !
> 
> This is what I was saying about having a liaison. It could work if we
> have someone to do it. We have one volunteer (Slade), perhaps this
> could turn out to be something more.

-- 
Regards,

Laurent Pinchart
