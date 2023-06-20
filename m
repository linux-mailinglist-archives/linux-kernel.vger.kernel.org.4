Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EB8737699
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFTV0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:26:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09F110F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:26:03 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-196.bstnma.fios.verizon.net [173.48.111.196])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35KLP26b007777
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 17:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687296305; bh=gu6F3ADo9YAAJZbgYrVOdkcOYoC76xihkwxLpT1QfZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To;
        b=R1Tt+cBumwWkuJ5VQkV+qkjUEheuQ/9p4KrkRonWpoypMTz707y+mxTzezpP5h3c6
         gBANVJxkgKFtv8y+4fo2D4kKIt0/AVKJ951pcTsnprjqG2njb1iA3QzwOER5IAJpdH
         nVMsDaGfN02Uw6dJWSdmnNnw4ZrlgC0LuFvd6ACMSKosRmXCwRDrZ6O7urs9c8aLWq
         VFdTt/2DBqA64A/iHpsDdLslpiR9fyYhfSDbjnqxw6mQ2Zil1Q80tmxVA0Iu6BlEVP
         bvEKj+uIIKe72G9gpbRnYV9lm+Dr1Xyv6o6YY6URWJu0DcquZMEyAQ1kqqCjfOYL4A
         BTevSekksslGw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D7FDA15C0266; Tue, 20 Jun 2023 17:25:02 -0400 (EDT)
Date:   Tue, 20 Jun 2023 17:25:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and the
 wider community
Message-ID: <20230620212502.GI286961@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b5fc04-798d-a235-c001-fb444e78ada9@linux-m68k.org>
 <1dca9f44-3716-19b2-efc6-03aef5c22d74@linux-m68k.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:54:23PM +1000, Finn Thain wrote:
> 
> I suspect that counting commits may be the wrong metric (I can think of 
> better ones).

As far as whether counting commits is the wrong metric, it doesn't
matter if you look at lines of code changes, attendance at conferences
such as the Linux Plumbers Conference, or participation on weekly
subsystem calls or video conferences, it's fair to say that that the
vast majority of those current developers work for companies. 

> But if that's what we have, the lack of commits from 
> non-profit organizations is a situation that might actually be improved by 
> changes like the ones I'm advocating.

Not only have you not provided any evidence for your thesis (which to
be fair is hard since what you are positing is a hypothetical), but
you haven't even provided a theory why you believe that to be true!

I *do* have a theory for what we've observed, which is that developers
like to have food with their meals, and the amount of time and effort
to do serious kernel work is significant.  And so companies are the
ones who can fund the engineers which are spending a good proportion
of their time working on Linux kerenl development.  These is why we
see a huge amount of work from people who work for Linaro, Intel, Red
Hat, Google, IBM, Nvidia, Facebook, Oracle, etc. both in terms of code
contributed to the kernel, code reviews of other people's code
submission, design discussions on LKML and in various "hallway track
conversations" at the verious Linux conferences/workshops, etc.

As far as non-profit organizations are concerned, most of them have
very tightly defined mission.  That mission might be mostly unrelated
to the kernel, except as a customer of the kernel --- for example, the
Mozilla and Eclipse Foundation --- or it might be Linux adjacent, such
as "make a good distributions ala Debian, Arch, Fedora, etc."  The
people at these non-profits might be volunteers (this is mostly the
case for Debian), or they might be paid engineers based on the
corporate sponsoprs of the non-profits (for example) or engineers who
are paid by a company, but who are "on loan" to the non-profit
organization (for example, in the Apache Software Foundation this is a
common pattern).  Either way, though, those non-profits tend to have a
very tightly focused mission, and it tends not to be one which
requires a large amount of kernel development.

You appear to have a very different model of how non-profits might
approach the Linux kernel --- could you go into more detail about why
they might want to contribute to the Linux kernel, and how we might
encourage them to contribute more engineering effort?

> > I'm not sure how this document would "hinder collaboration" with 
> > non-profit organizations and individuals.  Could you say more about your 
> > concern regarding how this undesireable outcome would happen in 
> > practice?
> 
> I believe that I've now addressed this in my message to Greg.

Well, no, you haven't.   More below....

On Tue, Jun 20, 2023 at 01:48:59PM +1000, Finn Thain wrote: (in reply to Greg)
> 
> Bonuses and salaries are tied to performance reviews so the hazard here 
> are clear. Level 5 compels companies to seek feedback and naturally they 
> will seek it from companies who share their goals. You ask too much of 
> employees if you expect them to put aside the corporate agendas and pursue 
> the interests of the wider community.

I was a hobbyist from 1991 to 1999 (I was the first North American
linux kernel developer, and at the time my day job was tech lead for
the MIT KerBeros Team and I also served on the IETF Security Area
Directorate and was one of the IPSEC working group chairs), and then
from 1999 until present, I've worked for companies (first VA Linux
Systems, then the IBM Linux Technology Cetner, and now at Google).  So
I think I know something about how employees balance the needs of the
Linux Kernel community and the needs of their employer.

> Countless lawsuits over the last few decades made it abundantly clear that 
> the goals of companies often diverge from those of the wider FLOSS 
> community.
> 
> Consider all of the open source code thrown over the wall, the binary 
> blobs, the binary modules, the built-in obsolescence, the devices shipped 
> with vulnerabilities now reduced to e-waste because they cannot be fixed, 
> the vendor lock-in strategies, the walled gardens, the surveillance etc.

There haven't been *that* many lawsuits, and while there have been
some bad actors, there have also been many, MANY examples of companies
that have contributed in highly positive ways.  For example, well over
a decade ago, IBM started requiring that their peripheral card
suppliers (e.g., network cards, SCSI host bus adapters, etc.) that it
would be a requirement that thosse companies providing those
peripherals MUST have upstream Linux device drivers as a condition of
the procurement contract.

And the more enlightened companies *do* understood that out-of-tree
patches are technical debt, and to get drivers, patches, etc.,
upstream in the long run would save them huge amounts of effort.  So
there are plenty of ways in which the meeting the goals of the FLOSS
comunity is ultimately, good towards achieving the goals of for-profit
companies.

> To my jaded mind, it is obvious that such reprehensible strategies can be 
> advanced by co-operative employees given inducements from colluding 
> companies. My patch won't prevent this sort of behaviour but it does 
> remove a directive that would help facilitate it.
> 
> Greg, if you want to see more performance reviews, the maturity model 
> could compel companies to provide unsolicited feedback, instead of seek it 
> from an arbitrary source. Would you be amenable to a revised patch along 
> those lines?

It was never about *companies* providing unsolicited feedback, but
rather the upstream Linux kerenl development community:

Level 4
=======

* Organizations will consider community member feedback in official
  performance reviews.

Level 5
=======

* Organizations will actively seek out community member feedback as a
  factor in official performance reviews.

I could see making this be more explicit by spelling out "upstream
development community" and "regarding their upstream contributions".
But I'm not sure where you thought it was about "getting *from*
companies".

The reality is that many, if not most of the key Linux kernel
developer leaders are employed by companies.  And so we are quite well
practiced at being able to put on our "open source leader hat" --- and
explicitly telling people that this is what we are doing --- as well
as being able to explain when we are relying the requirements from a
particular company, usually when we are explianing what motiviated a
particular code contribution.

So if I were asked to give a recommendation for an employee working at
Company I, and I'm working at Company G, I'm perfectly capable of
saying, this is what this person has done as an upstream developer,
and based on her upstream contributions, you should definitely promote
her.  And this has actually happened, BTW.  If we could encourage more
companies to sek out or accept more feedback from community members,
that would certainly be a good thing.

Cheers,

						- Ted

