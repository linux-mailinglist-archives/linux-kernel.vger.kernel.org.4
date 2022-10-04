Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97375F40FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJDKpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJDKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:45:20 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B631220CD;
        Tue,  4 Oct 2022 03:45:18 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id e20so7731914qts.1;
        Tue, 04 Oct 2022 03:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=m9GiAv2zn7tOwgDUayjXp6TNSQoaABoD0B7pi612u2E=;
        b=n7Nayo7AMprY/KRScOMstGGRxg09Jwbu830Qck3JJPZAQvtcBLk9NAEi0dTxCsTBrj
         hAhTQZ+EGptjV3mvN8pcQ/RRowDujmkuyBXIMbzShChqr006gXFBgqvLYfAPG3q3I4PV
         kgHzUeB0Co1Yr/I2r1QSo22Wx+P0IFTkgZMfty9vFdzYIoMw8WR24fDBYsKvNPOfrzW6
         SW4ZaFSVQEz+hSW0EjdhwbI5rE8xTbKsPfu7GT5OxeEIxCGPLuzMh4BsRJjkVwwDmT3n
         UIbj/946ET8wsfLn+oa85b2Wlww89UVe6yn/obNph6LZyUNSsfz+gs1KxHkNhks1++c3
         jtLA==
X-Gm-Message-State: ACrzQf1plBQRDRFb2qg5t3GW8XCEDtyKgBBq8mOLbH88iAEZ9UbNS+SY
        0oyLOS7Jtnpp5jaRGkqs/erJgcLlm74nPw==
X-Google-Smtp-Source: AMsMyM45GI63QzCb0QM7ySosJcTmz27YwnClehbEDW0Co9NDsKzPLq6oY9/NO3sCrPg+Q/7+aL0prQ==
X-Received: by 2002:ac8:5983:0:b0:35c:c560:a3f8 with SMTP id e3-20020ac85983000000b0035cc560a3f8mr18534571qte.600.1664880316840;
        Tue, 04 Oct 2022 03:45:16 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id bs18-20020a05620a471200b006cf38fd659asm13137349qkb.103.2022.10.04.03.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 03:45:16 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 203so16283185ybc.10;
        Tue, 04 Oct 2022 03:45:15 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr23319543ybl.604.1664880315391; Tue, 04
 Oct 2022 03:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info> <63a8403d-b937-f870-3a9e-f92232d5306c@leemhuis.info>
 <534EB870-3AAE-4986-95F3-0E9AD9FCE45B@sladewatkins.net> <e9dd6af0-37ef-1195-0d3b-95601d1ab902@leemhuis.info>
 <20221003112605.4d5ec4e9@gandalf.local.home> <eb935178-995b-84f1-6cbe-3492ba74f85b@leemhuis.info>
 <CAMuHMdWq+NntrPqMHzP3XEvKZgjEwSHW80vwWkZnaTORRrhpHA@mail.gmail.com> <409a039b-fd00-a480-ee82-e7a329fa7ae2@leemhuis.info>
In-Reply-To: <409a039b-fd00-a480-ee82-e7a329fa7ae2@leemhuis.info>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Oct 2022 12:45:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxrmTC8caWpMTJ+s7QscGouJfFsK_3xy+qvNojHyNzkg@mail.gmail.com>
Message-ID: <CAMuHMdWxrmTC8caWpMTJ+s7QscGouJfFsK_3xy+qvNojHyNzkg@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Slade Watkins <srw@sladewatkins.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Artem S. Tashkinov" <aros@gmx.com>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On Tue, Oct 4, 2022 at 12:16 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
> On 04.10.22 11:20, Geert Uytterhoeven wrote:
> > On Tue, Oct 4, 2022 at 10:41 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >> But I consider explaining things like bisection and localmodconfig in
> >> the documentation as also important, as that's likely something the tool
> >> won't be able to automate any time soon (or never, as realizing that is
> >> likely hard and better left to a separate tool anyway).
> >
> > Creating a simple Linux-specific wrapper around git bisect under
> > scripts/ might be useful?
> > The wrapper could copy .config to
> > $(srctree)/arch/$(ARCH)/config/bisect_defconfig, automatically run
> > "make bisect_defconfig" in each step, and show not only the bisected
> > commit, but also the impact on .config.
>
> Don't worry, I still remember that trick of yours from this discussion:
> https://lore.kernel.org/all/12e09497-a848-b767-88f4-7dabd8360c5e@leemhuis.info/

OK ;-)

> Something like that would be a start, but I'd say having localmodconfig
> covered would be wise also, as it speeds things up tremendously for
> those that start with a full-blown x86 pc distro config.

That's not that much different, as you only need to run "make localmodconfig"
once, as the first step (or as step zero, before starting the bisection).

> There are also people that find regressions when updating from say
> v5.18.15 to v5.19.4 and want to bisect that range; never tried if that
> actually works with a stable git tree, but I'd assume that approach is
> unwise. I also assume a lot of people would prefer to download only the

Yeah, you may run into issues that are fixed in v5.18.15, but not in
v5.18 itself, or in later intermediate steps.
For a short range like v5.18.15 to v5.19.4 (which are not LTS, hence
didn't receive that many updates, which can be good or bad), I don't
expect many problems, though

There are similar (but much worse) issues with bisecting between two
linux-next releases.

> recent history or specific stable branches when cloning the git tree
> (which is possible if you know what to do, but I guess most people don't).

Does it really save that much bandwidth?
How many minutes of 4K streaming video is the kernel nowadays? ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
