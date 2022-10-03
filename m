Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06585F2DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiJCJbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJCJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:29:26 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59575208B;
        Mon,  3 Oct 2022 02:27:34 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id l19so1821146qvu.4;
        Mon, 03 Oct 2022 02:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9excRcA/AuyGayqGljoD++Jb4ncrUvF318p9Vq+i1xY=;
        b=FekBfJ3WPCBfJ/Ife6rJWCaAH4tUMjPSgSQjJKIm+0rh5E433W7nvyUk3f0L2oxx4C
         8Os6CpwqMLHYw+5kQ2hZ9FAc65UbjLrHU4ergihyanA1l8NnkESOMxpubOHGPmqLIf59
         rAigzKPZn/oIR3mPTO4lmB+I1FQ45Q947+OegiiOivclFYtPF6jV5P5MCiGkszYHf1WA
         dONnNI8U3RniTY9iG84lVrymwKfGLh53xROi0mly5cjvmz1yPMUbbVDzHnRI8uQR5j+Y
         QpWH5syMQxgGP/YX4k4+/8JMSA9W7JSAQHpTyqw0Vvfr31AvNNXQ1hhzarHE+NWzCgiX
         Z7vA==
X-Gm-Message-State: ACrzQf2T4FfoF5dianvyo9wZWYKWnmIt+UPPuVkaIa+Km/ZeqPp1Z1ld
        OpPSSqQRwqP+RBWm3vSns5nZz37OFzY33w==
X-Google-Smtp-Source: AMsMyM6JjD1VyNRAQ8vrQK6UB2mbgBLayAybL2fquB7l7uTV7LGRHbS+0gLTugxsAYqKtf1vuKe63g==
X-Received: by 2002:a05:6214:1bc8:b0:4ac:7f16:aef1 with SMTP id m8-20020a0562141bc800b004ac7f16aef1mr15400136qvc.64.1664789226501;
        Mon, 03 Oct 2022 02:27:06 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a404400b006cddf59a600sm10972886qko.34.2022.10.03.02.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 02:27:05 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 63so12328873ybq.4;
        Mon, 03 Oct 2022 02:27:05 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr17298314ybp.365.1664789225092; Mon, 03
 Oct 2022 02:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home> <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home> <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
 <YzoY+dxLuCfOp0sL@ZenIV> <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
 <YzqjfU66alRlGk5y@kernel.org> <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
In-Reply-To: <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Oct 2022 11:26:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8Ko_LiqsWafzcqheW_7SZmtzEvgrpBbyoCLxyWqjqBg@mail.gmail.com>
Message-ID: <CAMuHMdX8Ko_LiqsWafzcqheW_7SZmtzEvgrpBbyoCLxyWqjqBg@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Mon, Oct 3, 2022 at 11:16 AM Artem S. Tashkinov <aros@gmx.com> wrote:
> On 10/3/22 08:55, Mike Rapoport wrote:
> > On Mon, Oct 03, 2022 at 07:41:08AM +0000, Artem S. Tashkinov wrote:
> >> On 10/2/22 23:04, Al Viro wrote:
> >>> On Sun, Oct 02, 2022 at 10:20:40PM +0000, Artem S. Tashkinov wrote:
> >>>> Bugzilla hasn't been updated in a very long time so it's missing both
> >>>> mailing lists and individual kernel developers.
> >>>>
> >>>> AFAIK, some pieces of kernel have no appropriate mailing lists at all.
> >>>> What about that? I've no clue.
> >>>
> >>> There's that file, right in the root of the source tree.  Called "MAINTAINERS",
> >>> in all-caps...  Could have something to do with locating maintainers, could it not?
> >>>
> >>>> Opt-in will work, except I've no idea how to make it work. Mass email
> >>>> all the kernel developers and politely invite them to sign up? Most will
> >>>> simply ignore it.
> >>>
> >>> Sigh...   You really don't seem to appreciate just how deep a septic
> >>> tank you've jumped into with your combination of "it should be opt-out"
> >>> and "but unsubscribing takes just a minute, what are you unhappy about?!?"
> >>>
> >>> Maybe you are not using email a lot, but for just about everyone who does...
> >>> We have heard that.  Many, many times.  From many sources - spammers,
> >>> "legitimate" companies' marketing departments, etc.
> >>>
> >>> And you keep moving along the same track - the usual reaction of some
> >>> company after having pulled back a bloody stump and enjoyed the pile of
> >>> explanations of the reasons why opt-out is *NOT* *ACCEPTABLE*, *EVER*
> >>> is along the lines of "OK, we'll just spam everyone in our database once
> >>> and ask them to opt-in - that must be OK, right?"
> >>
> >> Being on bugzilla does _not_ mean you'll receive a single email unless
> >> someone _specifically_ CC's you.
> >
> > If I'm not mistaken, bugzilla lets CC people explicitly. How the database
> > of emails in bugzilla would help choosing the right people to CC better
> > than MAINTAINERS?
> >
> > You repeated multiple times that bug reports sent to the mailing lists are
> > ignored, but what will make emails from bugzilla different from those bug
> > reports? Why do you think they will get more attention?
>
> Maybe because they are specific? Maybe because they are not part of a
> high volume mailing list such as LKML? Maybe because lots of developers
> are _not_ on any mailing lists?

If they're sent only to the maintainers, not to the subsystem mailing
lists, they may be ignored, as no one but the maintainer will be aware.

> Imagine instead you send your issue to a random mailing list. What is
> the chance another person with a similar issue will even find it?

Do not underestimate the power of search engines.

> Again the volume of bug reports is relatively low, fewer than two dozen
> a week.

Which proves this tool is insignificant in the grant scheme of (Linux)
things.

> * Multiple reporters can perfectly find the people who have made bad
> commits or who are responsible for certain drivers - it's safer to CC
> them _via_ Bugzilla than to email them _privately_ or via mailing lists
> which entails multiple issues including trust, SPAM, formatting,
> English, net etiquette, etc. etc. etc.

Never send bug reports privately, unless you have a monetary
relationship with the receiving end.  Always Cc the subsystem
mailing list, so anyone involved can help.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
