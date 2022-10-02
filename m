Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF845F2404
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJBQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJBQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:11:06 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2A82983F;
        Sun,  2 Oct 2022 09:11:05 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id y2so5465340qkl.11;
        Sun, 02 Oct 2022 09:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WTvr6KrD1Ov/UIG2XSm8BCfmFEi/ZMG6lyU59pelPCU=;
        b=8MY1LrlE7INrEe4x8peg21qMor77VPDb3WkkRcA0jlRNTXGNb2NLy6BZXrymexpD3t
         kX6Aia0q7tl3fgGK9Nz2oWgMs05OBGpk8YhLjNeMn/Imqzs/r3weAmfaBAvHmxLe/H/t
         cyFj1j3P2D4NvlUl3ICE+WHBGWeYyprYleJPnE3nrh+B7KaN1hIbsQV+xuRa3rW68RS/
         18ep6iowYQigTqbufWbvfV7/PlYksAIKYIRdENoo5jcacfp/vng/wZcAeXc7ADyHVOx/
         P4MUx8SG1PA9sETUpT/H3RaADlQyUMTha7TOjmOJKW+UgdsNivO2sdEN6vOYAqSlvU6t
         u/8g==
X-Gm-Message-State: ACrzQf2OUYhyDNeGtSxW7rh5kuMbg4WbzNBgZmHtEBkZziOMeXP4HNX0
        6MXJbbMPMvBGpWTBbJfjdvuIx88b4ESvkw==
X-Google-Smtp-Source: AMsMyM4vOs2daahAOeeoXl9Si+DbFp3pt8cv1wcNrsR7vE0rRw/F2L+TkQR4HGMckcHA4aoGudzEGQ==
X-Received: by 2002:a05:620a:2605:b0:6ce:1509:e9f7 with SMTP id z5-20020a05620a260500b006ce1509e9f7mr11718027qko.379.1664727064672;
        Sun, 02 Oct 2022 09:11:04 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x188-20020a3795c5000000b006bad7a2964fsm8395655qkd.78.2022.10.02.09.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:11:03 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id j7so10590732ybb.8;
        Sun, 02 Oct 2022 09:11:03 -0700 (PDT)
X-Received: by 2002:a05:6902:2c1:b0:6b2:8bb0:79a0 with SMTP id
 w1-20020a05690202c100b006b28bb079a0mr16557262ybh.202.1664727063295; Sun, 02
 Oct 2022 09:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info> <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <YzgY9X/DM9t/ZuJe@kroah.com> <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info> <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info> <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com> <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com> <CAMuHMdWLbS5jnOpdq0a6ie3eB5rmM6Rof3390t0u5FeO4Hmt5g@mail.gmail.com>
In-Reply-To: <CAMuHMdWLbS5jnOpdq0a6ie3eB5rmM6Rof3390t0u5FeO4Hmt5g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Oct 2022 18:10:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVskGrYpPG3dAGuMrELjNewD7vuLZFzP64N_xu9uKRwvw@mail.gmail.com>
Message-ID: <CAMuHMdVskGrYpPG3dAGuMrELjNewD7vuLZFzP64N_xu9uKRwvw@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
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

On Sun, Oct 2, 2022 at 6:08 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, Oct 2, 2022 at 2:49 PM Artem S. Tashkinov <aros@gmx.com> wrote:
> > The current ill-maintained semi-functional bugzilla has proven to be a
> > ton more useful than random mailing lists no sane person can keep track
> > of. Bug "reports", i.e. random emails are neglected and forgotten. LKML
> > is the worst of them probably.
>
> Such a statement really needs to be backed by numbers...
>
> > Let's operate with some examples:
> >
> > Bugzilla gets around two dozen bug reports weekly which encompass at
> > most thirty emails, which equals to four emails daily on average.
>
> This immediately debunks your statement above.
>
> $ git log v5.19..linus/master | grep Fixes: | wc -l
> 2928

Sorry, this was using my grep = `grep --color=tty -i' alias.
But that caused less than 100 false-positives, thus has no impact
on the point I'm trying to make.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
