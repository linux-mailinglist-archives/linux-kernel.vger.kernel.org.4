Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D365F2717
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJBXKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiJBXJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:09:51 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5AF111B;
        Sun,  2 Oct 2022 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kGCP8yNVzlc+4RMahfHxg09MCrNB/47vo8nl5oNIR+w=; b=dzWHjklMps7pTGMF/X2QpABXqI
        cXovPL1IK0aTjkgWK7SLc1RROcUWOS73GB/r8MSAfQ3ANexsM1sj73auzqY2ZGDcSnCYrIGFR0MT1
        gL3j2bHJjFze39UanPs7fUtgJHFHGN9l/SpVq/oSot8m2UzwlpSSZc20TatX0DWQT/FD3+sDGNODl
        WHZFbTQ31/7BAlYWpRUx6L6vsv7w1lzWnEDPR7ySXXSSOOH9J069n63FwuVFx11vGpLw2d0o8W75Y
        pVF0nUDmbi7b/JOciH8LWmVycQs9lbwVWrego7OUnGLMkY1q0/KivN9DTK/V28xLz8shBh6sCkq3Z
        ZDRNrD0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1of80X-006BGR-2P;
        Sun, 02 Oct 2022 23:04:25 +0000
Date:   Mon, 3 Oct 2022 00:04:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <YzoY+dxLuCfOp0sL@ZenIV>
References: <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 10:20:40PM +0000, Artem S. Tashkinov wrote:

> Bugzilla hasn't been updated in a very long time so it's missing both
> mailing lists and individual kernel developers.
> 
> AFAIK, some pieces of kernel have no appropriate mailing lists at all.
> What about that? I've no clue.

There's that file, right in the root of the source tree.  Called "MAINTAINERS",
in all-caps...  Could have something to do with locating maintainers, could it not?

> Opt-in will work, except I've no idea how to make it work. Mass email
> all the kernel developers and politely invite them to sign up? Most will
> simply ignore it.

Sigh...   You really don't seem to appreciate just how deep a septic
tank you've jumped into with your combination of "it should be opt-out"
and "but unsubscribing takes just a minute, what are you unhappy about?!?"

Maybe you are not using email a lot, but for just about everyone who does...
We have heard that.  Many, many times.  From many sources - spammers,
"legitimate" companies' marketing departments, etc.

And you keep moving along the same track - the usual reaction of some
company after having pulled back a bloody stump and enjoyed the pile of
explanations of the reasons why opt-out is *NOT* *ACCEPTABLE*, *EVER*
is along the lines of "OK, we'll just spam everyone in our database once
and ask them to opt-in - that must be OK, right?"
