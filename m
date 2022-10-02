Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CA65F252D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJBT7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJBT7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 15:59:12 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82262EF1E;
        Sun,  2 Oct 2022 12:59:10 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 73535505;
        Sun,  2 Oct 2022 21:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664740748;
        bh=f8k+OmBhued1C24z5rrP+EDyjxpgNoPGFYnHuSNuP/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/BJUlhSv3PLyJmkHy0JOsucj2UJi+a0anXrNhqYbLrwXchz96cMMWEl9S4/hhbPI
         +l5tsFS1il4qVC24T6BKDqURK0mjkfwWIxryQybLAO5vUTGM4nWsI6N0EbvOTh8swK
         ZXfI84jh7L7B+zeZOAuD6IcZFSB9DmtWEz/2Z6Xc=
Date:   Sun, 2 Oct 2022 22:59:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <Yznti0ca4g/hsm/T@pendragon.ideasonboard.com>
References: <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 12:49:04PM +0000, Artem S. Tashkinov wrote:
> On 10/2/22 12:18, Theodore Ts'o wrote:
> > On Sat, Oct 01, 2022 at 02:58:04PM +0000, Artem S. Tashkinov wrote:
> >>
> >> My expectations are actually quite low:
> >>
> >> * A central place to collect bugs (yeah, bugzilla)
> >> * Proper up to date components (they don't change too often, so there's
> >> not a lot of work to be done - you can refresh them probably every 12-24
> >> months and it's gonna be totally OK)
> >> * An ability to CC the relevant people/mailing lists (this is the only
> >> serious missing feature)
> >>
> >> That's it. It's a billion times better than random emails sent to random
> >> mailing lists. Signing up once is easier that to keep track of whom and
> >> where you've emailed or not. And of course it's a ton lot easier to find
> >> the existing bug reports.
> >
> > First of all, some of the components do CC the relevant mailing lists
> > automatically.  And this is the part of Bugzilla which is hand-hacked
> > and has no, zero, nada support upstream.  I'll defer to Konstantin
> > about how easy it is to keep that working.
> >
> > Secondly, not everyone is happy with getting an e-mail message sent to
> > a mailing list that has a lot of bugzilla metadata associated with it,
> > and depending on how they respond, the response might not make it back
> > to bugzilla.
> 
> I've mentioned it a dozen times already - you're unhappy with emails
> from bugzilla? Go there and unsubscribe. It takes a minute and we're
> talking as if it's the actual issue we are dealing with. It's not.
> Bugzilla maintenance and its up-to-date status are the issues.
> 
> >
> > Finally, in the absense of someone to actually close bugzilla entries
> > and do other necessary grooming, the bugzilla database will rapidly
> > become useless --- in which case, you might as well have a web form
> > that just helps the user send e-mail to the mailing list, and hope it
> > doesn't become a SPAM magnet.
> 
> The current ill-maintained semi-functional bugzilla has proven to be a
> ton more useful than random mailing lists no sane person can keep track
> of. Bug "reports", i.e. random emails are neglected and forgotten. LKML
> is the worst of them probably.
> 
> >
> >> Bugzilla as it is works nearly perfectly. We have a number of developers
> >> who don't want to touch it or get emails from it - it's their right.
> >> However it would be madness to take it from users. That will make filing
> >> and following up on bug reports an absolutely poor experience for
> >> absolute most users.
> >
> > At the moment, developers aren't following up on the bug reports.
> > There is some debate as to why.  Is it because users who can't figure
> > out how to send e-mail, and who send web-form based e-mails send low
> > quality bug reports that can't be easily responded to unless someone
> > is paid $$$ and/or has the patience of a saint?  Is it because
> > components aren't being gatewayed to mailing lists?
> 
> This is not always true, some of them do, some of them actually check
> new bug reports and do a tremendous job at helping people, e.g. Mario
> Limonciello who helps resolve bugs which are not even his direct
> responsibility. BTW, I'll now CC him since he's so active over there.
> Would be great if he chimed in.
> 
> > And if we force developers to get Bugzilla spam whether they want it
> > not, and they said, "absolutely not", is it there right to have the
> > mailing list gateway disabled --- and if so, what does that do to the
> > user experience?  Thats basically the situation we have right now.
> 
> As I've said many times already: bugzilla must be an opt-out, not opt-in
> experience/option.
> 
> Let's subscribe the past six months of developers using git commits and
> if someone doesn't like getting emails they go to the website and
> unsubscribe _once_ which takes a minute. This is a non-issue I've no
> clue why we're dwelling on it.

I'm not sure that would be legal, at least in the EU.

> Let's operate with some examples:
> 
> Bugzilla gets around two dozen bug reports weekly which encompass at
> most thirty emails, which equals to four emails daily on average.
> 
> LKML alone sees up to a hundred emails _daily_.
> 
> Getting worked up about it? I'm dumbfounded to be honest.

-- 
Regards,

Laurent Pinchart
