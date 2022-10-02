Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C755F2487
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 20:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJBSN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 14:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJBSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:13:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D161AF15;
        Sun,  2 Oct 2022 11:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408F360EE8;
        Sun,  2 Oct 2022 18:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2C0C433D6;
        Sun,  2 Oct 2022 18:13:22 +0000 (UTC)
Date:   Sun, 2 Oct 2022 14:13:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20221002141321.394de676@rorschach.local.home>
In-Reply-To: <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
        <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
        <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
        <YzgY9X/DM9t/ZuJe@kroah.com>
        <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
        <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
        <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
        <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
        <Yzg7pHspc72I7TAb@mit.edu>
        <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
        <YzmBjgXq9geMnL1B@mit.edu>
        <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
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

On Sun, 2 Oct 2022 12:49:04 +0000
"Artem S. Tashkinov" <aros@gmx.com> wrote:

> Let's subscribe the past six months of developers using git commits and
> if someone doesn't like getting emails they go to the website and
> unsubscribe _once_ which takes a minute. This is a non-issue I've no
> clue why we're dwelling on it.

As one of the few kernel maintainers that actually likes bugzilla and I
do not mind being subscribed to it, I too find the above an awful idea
(and I agree with all those that explained why it is so).

This really comes down to a manpower issue, which is common among most
open source projects. Remember it is commonly said that the only
warrantee you get from open source projects is that if it breaks, you
get to keep the pieces.

The issue is that the users of the Linux kernel mostly got it for free.
And if they did pay for it, it is highly unlikely that they paid the
kernel maintainer that owns the subsystem that they are having issues
with. That means, for the maintainers to triage these bug reports, they
are essentially doing it for free.

Some projects are better at this, and there are developers that are
happy to give free work, but there are also other projects that have
companies actively backing the work to debug these issues.

If you are using fedora, go bug Red Hat, Ubuntu then Canonical. And
again, it comes down to if you have a paid subscription or not if you
are going to get anywhere with it.

Can this be annoying, sure. But that's how the open source ecosystem
works.

If someone is not able to figure out how to use the mailing lists, it
is unlikely that they will be able to be useful in working with the
maintainer to solve their issue. As Ted mentioned, when asked to do
something to help analyze the issue, many times there's no response
from the reporter. Maybe because the reporter had no idea what the
maintainer wanted them to do. Most kernel bugs requires a constant back
and forth between the reporter and the developer. If you don't have
that, then there's no reason to bother with trying to fix the issue.

Ideally, someone (you?) would want to be a middle man and triage the
bugzilla reports and find those that look promising to get a fix
completed, and then be the liaison between bugzilla and the kernel
maintainer, then I think that could work. But the issue comes back to
manpower. Who's going to do that?

-- Steve
