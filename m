Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A66B5F25E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJBWSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJBWSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:18:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F933386AD;
        Sun,  2 Oct 2022 15:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3081B80DCF;
        Sun,  2 Oct 2022 22:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95F4C433C1;
        Sun,  2 Oct 2022 22:18:02 +0000 (UTC)
Date:   Sun, 2 Oct 2022 18:18:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <20221002181801.25b5ff77@rorschach.local.home>
In-Reply-To: <Yzn9ci/9urgTCF6h@pendragon.ideasonboard.com>
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
        <Yzn9ci/9urgTCF6h@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 00:06:58 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> > 
> > If you are using fedora, go bug Red Hat, Ubuntu then Canonical. And
> > again, it comes down to if you have a paid subscription or not if you
> > are going to get anywhere with it.
> > 
> > Can this be annoying, sure. But that's how the open source ecosystem
> > works.  
> 
> The dichotomy between the community/hobbyist/free side and the
> commercial/professional/paid side is an argument I often hear, and often
> make myself. It is not, however, ineluctable.

But is still the essence of a community. Things only get done when it
benefits those that are doing it. The point of open source is that
collaborating has a benefit for all involved. But dealing with bugs
that do affect you directly, usually goes to the bottom of your
priority list. Not that you are not willing to do so, but it may only
get done when you have time to do it. And we all know how much time
kernel developers have.

> 
> We have shown multiple times that this barrier doesn't have to exist.
> The kernel is an impressive example of how companies and communities can
> cooperate to reach a result that no single entity could have achieved.
> It started with the development model and how it scaled, and other areas
> were tackled along the way, such as automated testing and quality
> control in general for instance. Lots of efforts went into creating
> solutions that could fulfil the unique needs of our development model,
> and into convincing large and small companies to invest, either money or
> time.
> 
> Are we doing a great job ? Certainly not. But we are moving forward. As
> Jon Corbet said several years ago in one of his talks, now that the
> Linux kernel has reached a leading position in many areas, we have lost
> the comfort of following other industry actors and have to innovate
> ourselves. That often means (and this thought is mine, not Jon's)
> winging it along the way. As impressive as some of our achievements may
> be, our failures to maintain some areas of the kernel in a professional
> way is also astonishing (https://xkcd.com/2347/ comes to mind). It's not
> entirely surprising: the community and (part-time) volunteer model means
> that everybody will tackle problems that interest them. Building a
> community that can deliver professional support is not an interesting
> task for everybody. It is, however, a key factor in the difference
> between a kernel subsystem that strives and a subsystem that survives.

Exactly. The problem is that this is an issue (getting general bug
reporting from users), but it's not a fatal one if you don't get it
right. The community tends to do what it takes to survive. It's usually
not until there's a well established threat that everyone changes how
they do things. Major updates to the kernel at the end of an -rc
release is unheard of, until there's a meltdown/spectre threat.

> 
> I believe the same holds true for bug tracking and support. At the end
> of the day, someone will need to pay for it, but we could shatter the
> traditional model here too. We could, given enough interest, bridge the
> gap between all involved parties and create a support model that would
> benefit everybody. It took years and huge efforts for Linux to evolve
> towards more professionalism in many areas, and it would take more years
> and more effort to continue and expand that, but I believe it would be
> feasible.

Linus went away and came back with git. Should we ask him to go away
and come back with a better bugzilla? :-D

> 
> Linux didn't start because Linus complained about existing operating
> systems, ranted on usenet forums and waited for someone to fix the
> problem. Someone will need to step up and lead the effrot here too. If
> that person could ignore for a while that this is an impossible task, I
> think they could succeed.
> 
> > If someone is not able to figure out how to use the mailing lists, it
> > is unlikely that they will be able to be useful in working with the
> > maintainer to solve their issue. As Ted mentioned, when asked to do
> > something to help analyze the issue, many times there's no response
> > from the reporter. Maybe because the reporter had no idea what the
> > maintainer wanted them to do. Most kernel bugs requires a constant back
> > and forth between the reporter and the developer. If you don't have
> > that, then there's no reason to bother with trying to fix the issue.
> > 
> > Ideally, someone (you?) would want to be a middle man and triage the
> > bugzilla reports and find those that look promising to get a fix
> > completed, and then be the liaison between bugzilla and the kernel
> > maintainer, then I think that could work. But the issue comes back to
> > manpower. Who's going to do that?  
> 
> On the topic of triage, I've found that distro developers often do a
> pretty good job. I've received multiple bug reports of great quality
> following problems initially posted to distro bug trackers, after the
> distro developers took the time needed to hold reporters by the hand to
> get all the required information. Kudos for that !
> 

This is what I was saying about having a liaison. It could work if we
have someone to do it. We have one volunteer (Slade), perhaps this
could turn out to be something more.

-- Steve
