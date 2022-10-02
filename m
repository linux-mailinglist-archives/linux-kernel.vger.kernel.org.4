Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9475F246E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJBR6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJBR57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:57:59 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51B7E3A17A;
        Sun,  2 Oct 2022 10:57:58 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 292HveuS021796;
        Sun, 2 Oct 2022 19:57:40 +0200
Date:   Sun, 2 Oct 2022 19:57:40 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
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
Message-ID: <20221002175740.GA21700@1wt.eu>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 12:49:04PM +0000, Artem S. Tashkinov wrote:
> The current ill-maintained semi-functional bugzilla has proven to be a
> ton more useful than random mailing lists no sane person can keep track
> of. Bug "reports", i.e. random emails are neglected and forgotten. LKML
> is the worst of them probably.

You seem to completely miss the point. There's no need for *someone* to
keep track of the whole mailing lists, these mailing lists are used daily
by thousands of people. It's a *collective* effort. What matters is that
there exists someone among these people who will deal with your request.
Do patches fall through the cracks ? Sure! And so what ? The important
ones are eventually noticed or resent, and there's no harm in sending a
"ping" once in a while. Actually I find bug trackers worse for this,
because they give the reporter the impression that their report is being
handled while many times there's noone reading at the other end due to
the amount of stuff that has to be triaged. With mailing lists, a sender
who gets no response starts to wonder whether anything wrong happened and
is more naturally going to ask if the message was properly received, thus
reviving it. It's extremely rare that nobody responds to a retry on a first
message.

> As I've said many times already: bugzilla must be an opt-out, not opt-in
> experience/option.

That's the best way to make sure those who feel annoyed by this spam will
just redirect the bug tracker's address to /dev/null and will never ever
receive any message from it anymore. That's quite a common pattern, I'm
surprised that it's even still proposed as a solution...

> Let's subscribe the past six months of developers using git commits and
> if someone doesn't like getting emails they go to the website and
> unsubscribe _once_ which takes a minute. This is a non-issue I've no
> clue why we're dwelling on it.

Maybe because you have not yourself been spammed by bots that each
require a different way to unsubscribe/unregister/reconfigure options ?

> Let's operate with some examples:
> 
> Bugzilla gets around two dozen bug reports weekly which encompass at
> most thirty emails, which equals to four emails daily on average.

That's roughly what I was getting from github when I disabled all
notifications.

> LKML alone sees up to a hundred emails _daily_.

With a difference that these ones are not necessarily *read*, they're
*scanned* by many of us before being archived via a single- or two-key
shortcut, with a particular focus only on some messages or series
(hence the importance of a good subject).

Willy
