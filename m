Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7ED5F31DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJCOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJCOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346CC26101;
        Mon,  3 Oct 2022 07:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAE96B81115;
        Mon,  3 Oct 2022 14:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA9EC433D6;
        Mon,  3 Oct 2022 14:20:28 +0000 (UTC)
Date:   Mon, 3 Oct 2022 10:20:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20221003102029.1fe4f31b@gandalf.local.home>
In-Reply-To: <1d3fdc6a-a98a-fe3b-2e3e-acc2ffa24f9d@gmx.com>
References: <Yzg7pHspc72I7TAb@mit.edu>
        <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
        <YzmBjgXq9geMnL1B@mit.edu>
        <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
        <20221002141321.394de676@rorschach.local.home>
        <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
        <20221002180844.2e91b1f1@rorschach.local.home>
        <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
        <YzoY+dxLuCfOp0sL@ZenIV>
        <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
        <YzqjfU66alRlGk5y@kernel.org>
        <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
        <CAMuHMdX8Ko_LiqsWafzcqheW_7SZmtzEvgrpBbyoCLxyWqjqBg@mail.gmail.com>
        <1d3fdc6a-a98a-fe3b-2e3e-acc2ffa24f9d@gmx.com>
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

On Mon, 3 Oct 2022 09:40:43 +0000
"Artem S. Tashkinov" <aros@gmx.com> wrote:

> For instance, I've CC'ed Linus Torvalds _privately_ from Bugzilla twice
> and he _chimed_ in and _helped_ resolve the bugs.

You didn't Cc Linus _privately_, because you Cc'd him from Bugzilla. I'm
guessing that means it's a public conversation. Which is similar to Cc'ing
a maintainer and a public mailing list.

> My messages to LKML
> were _ignored_ by +1000 people subscribed to it.

LKML gets 800 emails a day. Nobody reads it (besides Jon Corbet and Andrew
Morton). But if you send email to a maintainer privately without Cc'ing any
public mailing list (or Bugzilla), then it will likely be ignored.

What we are saying is, you need to do both. Cc the maintainer _and_ a
public mailing list. That way the maintainer knows others can see it, and
could point someone else to look at it if they do not have the time, or
they know someone who can better help.

-- Steve
