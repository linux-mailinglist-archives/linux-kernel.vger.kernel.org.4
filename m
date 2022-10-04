Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43CD5F42F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJDMco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJDMcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:32:41 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E553D33;
        Tue,  4 Oct 2022 05:32:41 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id c19so8212960qkm.7;
        Tue, 04 Oct 2022 05:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mAm6cVyQiiO6vug+rJbXVrDQAEKK9J1ugo8edz5Ki04=;
        b=ZjrWlrNWBR/fOvaYhktWDTcf3HYLIo3xSp78F9V6/xTfu7lTBL/MsOhi/NHZ8fR2Ot
         wdfRVdhH5wWvVHxjaNMl8n/OTEr3r+AMUmwZkP2SlN5JiY1GcFVSuc2t7azbhkJPM+c5
         dwEFxuD4u7OmPTzq0/0Ws7x0ylN6LSK4FAgg5cXq7FNQdUkRECncYFpZq2KsfkPSS/km
         sw4ugaf2X775D8mMBJy8T7F5xflvPPr3NdjRR4xrqgIF090Tov3zuLup8xnXqsfBQR51
         X3hrogj/3cuBrYei4IJeIFb7hDjDMsiUFhof4m6LCjGppeDiy3K+cDkXWHanMZnXLOF5
         uyVg==
X-Gm-Message-State: ACrzQf0GiCMGuZE798Knmf5AQ1Gezlm9HE71lDo+wdbMKHe+mefW0VFE
        8iZZq8bZgVCiOpo3Qyj6qMBbNSQVCvSZKQ==
X-Google-Smtp-Source: AMsMyM6zUCq99cI1UjMAnSrc088FXBqHR5ydwJY5/TZRK4fbi70kKgOzJbRglABWXX/MPiYaXMXPZw==
X-Received: by 2002:a05:620a:1265:b0:6cd:f082:a97c with SMTP id b5-20020a05620a126500b006cdf082a97cmr16782898qkl.413.1664886759517;
        Tue, 04 Oct 2022 05:32:39 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id x9-20020ac87a89000000b0038b684a1642sm649184qtr.32.2022.10.04.05.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 05:32:38 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-35711e5a5ceso94259097b3.13;
        Tue, 04 Oct 2022 05:32:38 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr23626998ywe.283.1664886758049; Tue, 04
 Oct 2022 05:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home> <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home> <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
 <YzoY+dxLuCfOp0sL@ZenIV> <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
 <YzqjfU66alRlGk5y@kernel.org> <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
 <CAMuHMdX8Ko_LiqsWafzcqheW_7SZmtzEvgrpBbyoCLxyWqjqBg@mail.gmail.com>
 <1d3fdc6a-a98a-fe3b-2e3e-acc2ffa24f9d@gmx.com> <20221003102029.1fe4f31b@gandalf.local.home>
 <fde043f3-da34-9fc6-379b-922f29284e66@gmx.com>
In-Reply-To: <fde043f3-da34-9fc6-379b-922f29284e66@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Oct 2022 14:32:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1yp76X6xMFSXnpRNXPBVVLuyqm=UCOZ0uQem0_50poQ@mail.gmail.com>
Message-ID: <CAMuHMdW1yp76X6xMFSXnpRNXPBVVLuyqm=UCOZ0uQem0_50poQ@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Tue, Oct 4, 2022 at 2:16 PM Artem S. Tashkinov <aros@gmx.com> wrote:
> On 10/3/22 14:20, Steven Rostedt wrote:
> > On Mon, 3 Oct 2022 09:40:43 +0000
> > "Artem S. Tashkinov" <aros@gmx.com> wrote:
> >> For instance, I've CC'ed Linus Torvalds _privately_ from Bugzilla twice
> >> and he _chimed_ in and _helped_ resolve the bugs.
> >
> > You didn't Cc Linus _privately_, because you Cc'd him from Bugzilla. I'm
> > guessing that means it's a public conversation. Which is similar to Cc'ing
> > a maintainer and a public mailing list.
>
> I _did_ CC him privately by adding his _personal_ e-mail. I'm astonished
> not only you don't believe me you turn my words inside out.

I think there is a misunderstanding of the meaning of "CC privately".
To me it means no public data disclosing entity (be it a public mailing
list, or a public bug tracker) was CCed as well.
To you, it seems to mean you used his personal email address instead
of a mailing list address.

> Wow, so pretty much the vast majority of people here advocate for
> deprecating Bugzilla and asking non-IT people to use something which is
> essentially a ... SPAM list?
>
> Woah.
>
> I've given almost a dozen reasons why mailing lists simply don't work as
> a bug tracker in absolute most cases.

And people disagree.  No amount of "Woah" will change that, only
facts and figures can do.

> BTW, this discussion is a perfect f-ing example of that. What could have
> been easily read in a tracker needs to be repeated over and over and
> over again because you didn't bother to read previous messages 'cause
> you were busy, not paying attention, simply forgot and you don't want to
> scroll days of messages in your inbox.
>
> God, this is so ugly it's cringe worthy.
>
> Most people here who advocate for killing off Bugzilla:
>
> 1) Have _never_ used it
> 2) Have troubles even following _this_ conversation
>
> That' ridiculous.

Thanks for your insults.
This is not the way to convince people.

P.S. I did read all of it, I may stop doing so soon...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
