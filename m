Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625615F257A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJBVcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBVcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:32:53 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1CAE37F90;
        Sun,  2 Oct 2022 14:32:52 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 292LWZVR022607;
        Sun, 2 Oct 2022 23:32:35 +0200
Date:   Sun, 2 Oct 2022 23:32:35 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221002213235.GA22532@1wt.eu>
References: <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002150522.ul4nbtfawqjhnsag@meerkat.local>
 <b594681b-6b8c-ffb7-f526-3da847d160a8@gmx.com>
 <20221002205430.GC22129@1wt.eu>
 <d1f99826-2a66-c2d5-c9cd-d2fadd35eca4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f99826-2a66-c2d5-c9cd-d2fadd35eca4@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 09:07:13PM +0000, Artem S. Tashkinov wrote:
> > > Why are people are now blowing stuff out of proportion for no reason?
> > 
> > Because the approach is wrong. As I explained it gives a false sense to
> > the reporter that their issue is being handled while the simple fact that
> > a message was sent to a person is in no way an engagement to do anything
> > about it. LKML is a broadcast area. Everyone hopes someone else will
> > respond and that eventually happens. When the reports are targetted, it
> 
> No, it doesn't happen. Should I open LKML and send you a hundred of
> unreplied emails over the past year alone?

If that makes you feel better, feel free to do so. I'm not scared by
only one hundred e-mails. What I'm impressed by, however, is that you're
able to spot that many unreplied e-mails because I don't see as many. If
you're that efficient at spotting them, maybe these are the ones you
should just resend to make sure they're seen, and it would require less
work (even on your side) than triaging issues.

> Just before I GTFO I will leave this bug report here (already posted it
> here but maybe I need to do it again and again):
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=204807
> 
> Tell me honestly how ~255 comments, and a ton of collaboration over the
> span of 2.5 years can be managed using email.

What makes you think it would have taken that long over e-mail ? Between
your first report and the first reply "this is not a bug", 18 months had
elapsed already. The most active part of the discussion happened grouped
on 3 days (2021-03-19 -> 22), where there were already some "I'm removing
myself from the CC because the discussion isn't productive", then a large
number of "me too" happened. Not sure how much useful this has been
overall to the involved developers, given that it's impossible to stay
focused on that long a thread and sum up all the information spanning
over that many kernel versions and that many different hardware.

My gut feeling is that handling this over the ML would have resulted in:
  - a few "sorry, no solution, try to fix your BIOS"
  - "try this" => "it works, thank you".
  - "this fix above broke for me"
  - and a few such iterations until a satisfying enough solution would
    have been found. Maybe not in 2.5 years, maybe 6 months.

But I could be wrong. I'm not claiming I know how people feel the most
efficient. Just observing what we're seeing on the lists and what I'm
used to dealing with in some bug trackers. If you want I can as well
show you a bug I reported 19 years ago that's still in state "NEW",
having seen little updates over the years. It had better been closed
since then, TBH:

   https://gcc.gnu.org/bugzilla/show_bug.cgi?format=multiple&id=11873

Pretty close to your demo above except it lasted 8 times longer and
has not seen progress by lack of interest. How's that different from
what you complain about mailing lists ? Hmm ?

Willy
