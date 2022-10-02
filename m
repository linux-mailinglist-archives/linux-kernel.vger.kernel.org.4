Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9535F222D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJBJD1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Oct 2022 05:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:03:24 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073F51EEC3;
        Sun,  2 Oct 2022 02:03:23 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id i17so5180265qkk.12;
        Sun, 02 Oct 2022 02:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eqhMZWvXULuL578n1n0PalIWlRFdoHoI0gRbkp8SjOY=;
        b=X/QtqsnKoDb2ZiK2aQzVbwRLEMkKbOhuxnF5KVv146HW293pJHp3bmx9ixnL8fQg9d
         ozi1tH7E6WfcIjMpHPaknqcNdCe86lGuN+pEOJO9Fp3vn8FP3NGdqB+3KjvQfePkJM9S
         m4epIc+hoYdBX3V4Y1F99tay5015kHSzJ2DuJsE38V9OuelIXsZ6zwBKvC6o1HhJjrdO
         JCwoBbNmssn6XHdkESCkpKo+ZvXeWICtxV3MWJSk/LOZqp9JtliOZZSXCfaKsRycHcCp
         EulyZC5EKaTRZDYxuX1NhhEusi/be2UF8YBoF4Bl/Y669vEM5QM+hsYNuZXSP8Xxo6Bp
         RoDQ==
X-Gm-Message-State: ACrzQf1pzWLU9Ldujy39v74FgZYbhRJHr3yPviN4LbGurqEMEUY6zMMF
        Nz1kBsJO78OSBkk7WabKvB6+eGrFtJQZBQ==
X-Google-Smtp-Source: AMsMyM62f84RNVZkChCVJXq0M8Y3mGNCkhRhQHfa9gPs+Q39qROxw25QUg7r1/GArSjCio6E1bB/kg==
X-Received: by 2002:a05:620a:490a:b0:6ce:d88f:30fe with SMTP id ed10-20020a05620a490a00b006ced88f30femr11086271qkb.534.1664701401986;
        Sun, 02 Oct 2022 02:03:21 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006ce9e880c6fsm8113617qkn.111.2022.10.02.02.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 02:03:21 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id c9so9924976ybf.5;
        Sun, 02 Oct 2022 02:03:21 -0700 (PDT)
X-Received: by 2002:a05:6902:45:b0:6ae:ce15:a08d with SMTP id
 m5-20020a056902004500b006aece15a08dmr14801571ybh.380.1664701401207; Sun, 02
 Oct 2022 02:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info> <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <YzgY9X/DM9t/ZuJe@kroah.com> <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info> <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
In-Reply-To: <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Oct 2022 11:03:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWontzcX=ww8HbVWc2j418SdyzoPyKa4HHFsxzijbVSw@mail.gmail.com>
Message-ID: <CAMuHMdUWontzcX=ww8HbVWc2j418SdyzoPyKa4HHFsxzijbVSw@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

On Sat, Oct 1, 2022 at 1:21 PM Artem S. Tashkinov <aros@gmx.com> wrote:
> On 10/1/22 10:57, Thorsten Leemhuis wrote:
> > On 01.10.22 12:47, Artem S. Tashkinov wrote:
> >> On 10/1/22 10:39, Greg KH wrote:
> >>> On Sat, Oct 01, 2022 at 10:30:22AM +0000, Artem S. Tashkinov wrote:
> >
> >>>> I have a 20+ years experience in IT and some kernel issues are just
> >>>> baffling in terms of trying to understand what to do about them.
> >>>>
> >>>> Here's an example: https://bugzilla.kernel.org/show_bug.cgi?id=216274
> >>>>
> >>>> What should I do about that? Who's responsible for this? Who should I
> >>>> CC?
> >>>
> >>> Input subsystem.
> >>
> >> It's great you've replied immediately, what about hundreds or even
> >> thousands of other bug reports where people have no clue who has to be
> >> CC'ed?
> >
> > Quoting from https://docs.kernel.org/admin-guide/reporting-issues.html:
> >
> > "[...] try your best guess which kernel part might be causing the issue.
> > Check the MAINTAINERS file [...] In case tricks like these don’t bring
> > you any further, try to search the internet on how to narrow down the
> > driver or subsystem in question. And if you are unsure which it is: just
> > try your best guess, somebody will help you if you guessed poorly. [...]"
> >
> > HTH, Ciao, Thorsten
>
> Absolute most people:
>
> * Will never read this document
> * Will not be able to "search the internet on how to narrow down the
> driver or subsystem in question"

So how did these people arrive at "bugzilla" in the first place? ;-)

Or is this a case of "if all you have is a hammer...", so you
actively start looking for a bugzilla?
I.e. people who are used to bugzilla/discourse/slack/irc/trac/... will
look for how to use bugzilla/discourse/slack/irc/trac/... to interact
with the developer and/or maintainer.

The definitive guide is the MAINTAINERS file.  If there is a (rare)
corresponding "B" entry, you can use that.  Else fall back to the
"M" and "L" entries.  "C" might be good for an initial query, but not
for the actual reporting, as there's even less traceability than with
mailing lists (the latter are archived by lore).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
