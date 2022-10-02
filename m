Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313485F254D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJBUlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 16:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJBUlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 16:41:04 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23CC624941;
        Sun,  2 Oct 2022 13:41:00 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 292KehXo022408;
        Sun, 2 Oct 2022 22:40:43 +0200
Date:   Sun, 2 Oct 2022 22:40:43 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221002204042.GA22129@1wt.eu>
References: <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002175740.GA21700@1wt.eu>
 <4ace3c9c-f1f5-eb7e-58cd-c2081f77fa0d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ace3c9c-f1f5-eb7e-58cd-c2081f77fa0d@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 07:55:35PM +0000, Artem S. Tashkinov wrote:
> 
> 
> On 10/2/22 17:57, Willy Tarreau wrote:
> > On Sun, Oct 02, 2022 at 12:49:04PM +0000, Artem S. Tashkinov wrote:
> > > The current ill-maintained semi-functional bugzilla has proven to be a
> > > ton more useful than random mailing lists no sane person can keep track
> > > of. Bug "reports", i.e. random emails are neglected and forgotten. LKML
> > > is the worst of them probably.
> > 
> > You seem to completely miss the point. There's no need for *someone* to
> > keep track of the whole mailing lists, these mailing lists are used daily
> > by thousands of people. It's a *collective* effort. What matters is that
> > there exists someone among these people who will deal with your request.
> > Do patches fall through the cracks ? Sure! And so what ? The important
> > ones are eventually noticed or resent, and there's no harm in sending a
> > "ping" once in a while. Actually I find bug trackers worse for this,
> > because they give the reporter the impression that their report is being
> > handled while many times there's noone reading at the other end due to
> > the amount of stuff that has to be triaged. With mailing lists, a sender
> > who gets no response starts to wonder whether anything wrong happened and
> > is more naturally going to ask if the message was properly received, thus
> > reviving it. It's extremely rare that nobody responds to a retry on a first
> > message.
> 
> I've given multiple reasons why mailing lists more often than not do not
> work at all, I won't repeat them again.

Indeed, it just seems that many others don't share your opinion.

> You can open LKML right now and check all the unreplied emails where
> people complain about various issues. There are tons of such messages.

I don't have to "open LKML", it arrives in my mailbox and I glance over
it a few times a day in search for interesting topics or reports before
archiving it. By the way, how long do you wait before declaring a message
"unreplied" ? For me, "unreplied" starts at one week. And when I sort the
messages by thread and go back one week, I see very few such unreplied
messages. Interestingly most of the unreplied ones are LKP reports. For
sure there will be such messages lost, but it's definitely not "a ton"
like you're saying. Probably that your analysis is skewed by the fact
that many messages are patches, but one response to the cover message
is enough.

> > > As I've said many times already: bugzilla must be an opt-out, not opt-in
> > > experience/option.
> > 
> > That's the best way to make sure those who feel annoyed by this spam will
> > just redirect the bug tracker's address to /dev/null and will never ever
> > receive any message from it anymore. That's quite a common pattern, I'm
> > surprised that it's even still proposed as a solution...
> 
> Great, it's a single action which takes at most a minute. Why are people
> creating a drama out of it I've no idea.

Because if every bug tracker operator started to act like this it would
really be annoying. Why would the kernel's bugzilla have the right to
spam many people, and not all trac/gitlab/github/whatever tracker of
whatever other projects developers also follow ? It's like when spammers
used to say that spam isn't a problem, it just requires deleting a message
once in a while, why are people making a fuss about this.

> > > Let's subscribe the past six months of developers using git commits and
> > > if someone doesn't like getting emails they go to the website and
> > > unsubscribe _once_ which takes a minute. This is a non-issue I've no
> > > clue why we're dwelling on it.
> > 
> > Maybe because you have not yourself been spammed by bots that each
> > require a different way to unsubscribe/unregister/reconfigure options ?
> 
> There's just one bugzilla. We are not talking about many bugzillas yet.

This "yet" has a lot of meaning for so few letters.

> > With a difference that these ones are not necessarily *read*, they're
> > *scanned* by many of us before being archived via a single- or two-key
> > shortcut, with a particular focus only on some messages or series
> > (hence the importance of a good subject).
> 
> The problem is today you're scanning it, tomorrow you don't feel like
> it. An email gets lost, a problem is never addressed.

No. Again, mainling lists are not read by a single person but by many
thousands. Nobody's essential there. Plenty of people can sleep, visit
family, go fishing or to vacation with basically no impact. Actually I'm
way more worried about your model where you would be almost alone doing
the triage on bugzilla after most annoyed ones unsubscribe.

> Again most bug reports sent to LKML are completely neglected, and it's
> _not_ limited to LKML.

No. "Some", likely. "Many", possibly. "Most", no. The most recent one
that qualifies that I've found is "PROBLEM: Segfault in kconfig" dated
22/9 which actually I had read, and I think few people feel legitimate
about:

  https://lore.kernel.org/all/33059074b78110d4717efe09b887dd28ac77fe7f.camel@pengutronix.de/

The bug tracker would unlikely have changed this.

> Looks like that's what people here are advocating for. "We are not paid
> to deal with bug reports, so we prefer not to even hear about them".

No that's not how it works, any developer is interested with bug reports
in their respective areas. It's just that some areas are poorly covered
and that a bug tracker will not suddenly cause the missing skills to
appear out of nowhere.

Willy
