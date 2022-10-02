Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C85F255F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiJBVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJBVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:07:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872812CCB3;
        Sun,  2 Oct 2022 14:07:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89A91505;
        Sun,  2 Oct 2022 23:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664744819;
        bh=lYj/TP65RErbs9PAzQqNcLnG6LWwinWkii/p0iY5KzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vvoP9fJlmEWrTqkwDXbJo18CXL2wqkuVB7IRfNOBzs/FPPm4UpRd13kuqzjnnqOVH
         wJfxABcJPV7ltw/83DnXuIHZzMvS/Bj+e9+SKb+BrT5IhWwNa545Jjry8MtbsNi5HY
         b/giigJiXjVXY3pn5Hh+5iYckNgfgHGSlqiVnTSc=
Date:   Mon, 3 Oct 2022 00:06:58 +0300
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
Message-ID: <Yzn9ci/9urgTCF6h@pendragon.ideasonboard.com>
References: <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221002141321.394de676@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 02:13:20PM -0400, Steven Rostedt wrote:
> On Sun, 2 Oct 2022 12:49:04 +0000 Artem S. Tashkinov wrote:
> 
> > Let's subscribe the past six months of developers using git commits and
> > if someone doesn't like getting emails they go to the website and
> > unsubscribe _once_ which takes a minute. This is a non-issue I've no
> > clue why we're dwelling on it.
> 
> As one of the few kernel maintainers that actually likes bugzilla and I
> do not mind being subscribed to it, I too find the above an awful idea
> (and I agree with all those that explained why it is so).
> 
> This really comes down to a manpower issue, which is common among most
> open source projects. Remember it is commonly said that the only
> warrantee you get from open source projects is that if it breaks, you
> get to keep the pieces.
> 
> The issue is that the users of the Linux kernel mostly got it for free.
> And if they did pay for it, it is highly unlikely that they paid the
> kernel maintainer that owns the subsystem that they are having issues
> with. That means, for the maintainers to triage these bug reports, they
> are essentially doing it for free.
> 
> Some projects are better at this, and there are developers that are
> happy to give free work, but there are also other projects that have
> companies actively backing the work to debug these issues.
> 
> If you are using fedora, go bug Red Hat, Ubuntu then Canonical. And
> again, it comes down to if you have a paid subscription or not if you
> are going to get anywhere with it.
> 
> Can this be annoying, sure. But that's how the open source ecosystem
> works.

The dichotomy between the community/hobbyist/free side and the
commercial/professional/paid side is an argument I often hear, and often
make myself. It is not, however, ineluctable.

We have shown multiple times that this barrier doesn't have to exist.
The kernel is an impressive example of how companies and communities can
cooperate to reach a result that no single entity could have achieved.
It started with the development model and how it scaled, and other areas
were tackled along the way, such as automated testing and quality
control in general for instance. Lots of efforts went into creating
solutions that could fulfil the unique needs of our development model,
and into convincing large and small companies to invest, either money or
time.

Are we doing a great job ? Certainly not. But we are moving forward. As
Jon Corbet said several years ago in one of his talks, now that the
Linux kernel has reached a leading position in many areas, we have lost
the comfort of following other industry actors and have to innovate
ourselves. That often means (and this thought is mine, not Jon's)
winging it along the way. As impressive as some of our achievements may
be, our failures to maintain some areas of the kernel in a professional
way is also astonishing (https://xkcd.com/2347/ comes to mind). It's not
entirely surprising: the community and (part-time) volunteer model means
that everybody will tackle problems that interest them. Building a
community that can deliver professional support is not an interesting
task for everybody. It is, however, a key factor in the difference
between a kernel subsystem that strives and a subsystem that survives.

I believe the same holds true for bug tracking and support. At the end
of the day, someone will need to pay for it, but we could shatter the
traditional model here too. We could, given enough interest, bridge the
gap between all involved parties and create a support model that would
benefit everybody. It took years and huge efforts for Linux to evolve
towards more professionalism in many areas, and it would take more years
and more effort to continue and expand that, but I believe it would be
feasible.

Linux didn't start because Linus complained about existing operating
systems, ranted on usenet forums and waited for someone to fix the
problem. Someone will need to step up and lead the effrot here too. If
that person could ignore for a while that this is an impossible task, I
think they could succeed.

> If someone is not able to figure out how to use the mailing lists, it
> is unlikely that they will be able to be useful in working with the
> maintainer to solve their issue. As Ted mentioned, when asked to do
> something to help analyze the issue, many times there's no response
> from the reporter. Maybe because the reporter had no idea what the
> maintainer wanted them to do. Most kernel bugs requires a constant back
> and forth between the reporter and the developer. If you don't have
> that, then there's no reason to bother with trying to fix the issue.
> 
> Ideally, someone (you?) would want to be a middle man and triage the
> bugzilla reports and find those that look promising to get a fix
> completed, and then be the liaison between bugzilla and the kernel
> maintainer, then I think that could work. But the issue comes back to
> manpower. Who's going to do that?

On the topic of triage, I've found that distro developers often do a
pretty good job. I've received multiple bug reports of great quality
following problems initially posted to distro bug trackers, after the
distro developers took the time needed to hold reporters by the hand to
get all the required information. Kudos for that !

-- 
Regards,

Laurent Pinchart
