Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241475F3591
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJCSYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJCSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:24:24 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E68422CE;
        Mon,  3 Oct 2022 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N/oPy4XgXhIzrqKOR5W42A0ftB9EWHdXvTH3fhEJf7Y=; b=OlMaENkFNJMkG3SGO8yfajNTZ8
        /M7/EKCmBDwM0iQpbLannZMdymm6wNEsh46zlurpZw5lL6tsqAP45Bq8BWKed0Cf0SJ3HmMDll/Dk
        tt77ZVSLC/4wBwZG2eibBgAvYRhj7un3t2y3t7kgMQuiA85mir54tUEnWBhGdQ0P26ZqW4NWc/zqV
        css8j1OdAkX4EFV6bsNR6zHBS61jSxLY1QrClq/wEpLVYYDhDko41cs8PQk343awei3i/2tM3swTC
        6dMdtWmJYr8nfIsyGQN3/Nvq0neXRQVdVGHZJLVsQL7LFvO4dZDOI/4ilOu3dZi8hXepHh6h93pXc
        MrXlx6Sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ofQ6p-006Y5B-0y;
        Mon, 03 Oct 2022 18:24:07 +0000
Date:   Mon, 3 Oct 2022 19:24:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <Yzsox+Q6mKSpQuc6@ZenIV>
References: <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
 <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
 <YzqjfU66alRlGk5y@kernel.org>
 <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
 <CAMuHMdX8Ko_LiqsWafzcqheW_7SZmtzEvgrpBbyoCLxyWqjqBg@mail.gmail.com>
 <1d3fdc6a-a98a-fe3b-2e3e-acc2ffa24f9d@gmx.com>
 <20221003102029.1fe4f31b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003102029.1fe4f31b@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 10:20:29AM -0400, Steven Rostedt wrote:
> On Mon, 3 Oct 2022 09:40:43 +0000
> "Artem S. Tashkinov" <aros@gmx.com> wrote:
> 
> > For instance, I've CC'ed Linus Torvalds _privately_ from Bugzilla twice
> > and he _chimed_ in and _helped_ resolve the bugs.
> 
> You didn't Cc Linus _privately_, because you Cc'd him from Bugzilla. I'm
> guessing that means it's a public conversation. Which is similar to Cc'ing
> a maintainer and a public mailing list.
> 
> > My messages to LKML
> > were _ignored_ by +1000 people subscribed to it.
> 
> LKML gets 800 emails a day. Nobody reads it (besides Jon Corbet and Andrew
> Morton). But if you send email to a maintainer privately without Cc'ing any
> public mailing list (or Bugzilla), then it will likely be ignored.

Way more than 800, IME.  And I'm still subscribed to it, even though
reading through the damn thing isn't physically possible.  About 1 or 2
percents gets past the "delete unopened" pass...

Speaking of private mail... there's one case when it's warranted -
a bug that looks like a sufficiently nasty security hole in something that
would be sufficiently widely deployed.  Preferably - with something along
the lines of "off-list due to potential security impact".

Still a matter of taste - security@ is an option for those...
 
> What we are saying is, you need to do both. Cc the maintainer _and_ a
> public mailing list. That way the maintainer knows others can see it, and
> could point someone else to look at it if they do not have the time, or
> they know someone who can better help.
