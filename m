Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB466146A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 10:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjAHJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 04:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHJ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 04:59:08 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D791B7DD
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 01:59:06 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id c7so5657566qtw.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 01:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2B9MnY4Z0fXaBruSpv14G2A2gTAMp4GjLVqp6oCb+0=;
        b=8LCUQlGzPC+BIKx26XU+DS/Jj0jBiLs2/qZLCxqesAg9lB9tT/TSdd3OwfaykfrrDM
         a877J+lcVT402ZIwzX41TAtk3IyjzbhekC6XNvkwICJ+eQEoQl5xd/vrkjngOFkMRqGS
         QyAjR9hSgV25U++4SDku0XdLlEtFGy5r+e0wrkfuGx+dvayDBinEQWC1U/x5LQdr/ou9
         U7tLM+HloajEOl0/h4KmO11lLEUb7H8aDam+CPR6N4JBQBdWyd8sDTPDKb0PZ+KQMSmT
         XjOsX9iPp5N0dOf+MtI0dI5c7wLisqP9fJzzO3NBiHVsP8YBKYg+RrG2qOnekpEMwBt/
         UVrA==
X-Gm-Message-State: AFqh2kr8cCtDy8akdAUzAkn3kbRZh40qldR5cbRLnrMkWsN37MItmOpC
        YuzDCDwd7JbVw35bVDAEIhNczWBjlGUMqw==
X-Google-Smtp-Source: AMrXdXtRTcH5p5P4TObuXSfHB+VmQd/mJwVYjESWssYBNtS2gylJF2UtMOVzEsIMqFWagSrYK+S2+A==
X-Received: by 2002:ac8:4d1d:0:b0:3a7:e1aa:727c with SMTP id w29-20020ac84d1d000000b003a7e1aa727cmr77814951qtv.17.1673171945577;
        Sun, 08 Jan 2023 01:59:05 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a2a0500b006fcc437c2e8sm3540006qkp.44.2023.01.08.01.59.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 01:59:05 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id o75so6078141yba.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 01:59:04 -0800 (PST)
X-Received: by 2002:a25:d243:0:b0:702:90b4:2e24 with SMTP id
 j64-20020a25d243000000b0070290b42e24mr4322992ybg.365.1673171944632; Sun, 08
 Jan 2023 01:59:04 -0800 (PST)
MIME-Version: 1.0
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz> <Y7pRw47hidw+s6+g@mit.edu> <Y7pzbnlXgv+asekg@amd.ucw.cz>
In-Reply-To: <Y7pzbnlXgv+asekg@amd.ucw.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 8 Jan 2023 10:58:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
Message-ID: <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
Subject: Re: Dhrystone -- userland version
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sun, Jan 8, 2023 at 8:40 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > Distributions do not usually carry dhrystone, and I don't think anyone
> > > really maintains it. It is useful tool, and it seems we'll maintain
> > > it.
> > >
> > > I'd like to add enough glue so that it would be runnable from
> > > userspace, too? Userland version is what is actually useful to me, and
> > > it should not be hard.
> >
> > I don't see whatever message you were replying to, and it doesn't seem
> > to be archived in lore[1], so I'm not sure about the context.  But you
> > are talking about the Dhrystone benchmark[2], right?
> >
> > [1] https://lore.kernel.org/all/Y7nyd4hPeXsdiibH@duo.ucw.cz/T/#u
> > [2] https://wiki.cdot.senecacollege.ca/wiki/Dhrystone_howto
> >
> > If so, I'm confused what you mean by "add enough glue so that it would
> > be runnable from userspace" --- Dhrystone is a userspace benchmark,
> > dating from the 1980's, although what it benchmarks is often more about
> > the compiler than the CPU's performace.
>
> Yes, I'm talking about Dhrystone benchmark. We are carrying
> kernel-only version in lib/dhry_*.c, it is in -next now.
>
> commit cfbd4cc940275240e97f8b922c8f18a44fe15c07
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Thu Dec 8 15:31:28 2022 +0100
>
>     lib: add Dhrystone benchmark test
>
> I'd like userspace-too version, at the same place :-).

So you want to add some glue code to tools/testing/, for building a
userspace version?

However, as this is not Linux-specific, how hard can it be to convince
your distro to include https://github.com/qris/dhrystone-deb.git?
Usually, when I have a full userspace available, I just clone the above,
and debuild it myself.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
