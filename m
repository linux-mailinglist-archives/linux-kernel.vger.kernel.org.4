Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0162568BC19
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjBFLyW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Feb 2023 06:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBFLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:54:20 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F4712F1D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:54:16 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id v17so12387418qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiIai4jWpm01sXsbCZG8kIjSWXRH0hySR+jKxMCXho8=;
        b=Oh/u3OEY6wrjtSZgga0p6TNHlJhLP2W0bqi7YSTUgqPQc0dcxe/aQ3MCtOK4VJITur
         wyQ4xOSiAxZO0EMXG2zs1gjYlZmnY/Ia/KMWXDH9s2g0YTI/UOFxgErii2ce3M0AUJwn
         kS/yuRfel4tidlgGkU7rDmyb6HmQ5YWZNia7cFixIpxLmM1vl9s+SEwFb3FrQ3Po/u+N
         /CrQVZ2qAjnPjIqPE4xxFjV5o5Qb93hoEOK1W4OCSgW9XEyatkkBUf51VFlFaL/ChiEH
         Rk9Hk3ilj3NVExKqI4GS3mpfQomZKHy41Nfe2Mx7RVPZ5boECjVroeWTD7Y3d6QCuOwl
         j2pA==
X-Gm-Message-State: AO0yUKUpOCxXxIx99dXOgUjRi/dl+4JuRvRux0awJYS5PGYPxxhBm7zu
        EC6a5EzpfzgMwkFkdN8Re+Fi0+NsuBO2mg==
X-Google-Smtp-Source: AK7set8kvW9XizXTzTQuBX8anKujIKZyphTdvbQ3g3zQh7NGF/WWACUiW94N1vkX4xFDZpRD/xTXSg==
X-Received: by 2002:ac8:5e4a:0:b0:3b8:118d:83d9 with SMTP id i10-20020ac85e4a000000b003b8118d83d9mr36828905qtx.4.1675684455755;
        Mon, 06 Feb 2023 03:54:15 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a448b00b0072c01a3b6aasm7362471qkp.100.2023.02.06.03.54.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 03:54:15 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id t1so4745108ybd.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:54:15 -0800 (PST)
X-Received: by 2002:a5b:741:0:b0:87a:68fd:181a with SMTP id
 s1-20020a5b0741000000b0087a68fd181amr1014302ybq.36.1675684454997; Mon, 06 Feb
 2023 03:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
 <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
 <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
 <CAMuHMdWcjUXwkk2V29p-hifDnMhLRSwQBXMzVeURRA48znKC5Q@mail.gmail.com> <bbdf99df867786510f709473fa2c3744dbf27bb4.camel@perches.com>
In-Reply-To: <bbdf99df867786510f709473fa2c3744dbf27bb4.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Feb 2023 12:54:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4HUmTJZiecL9u0G1LuZ18K_1hYo4Q_U9S2a2fuo=xRA@mail.gmail.com>
Message-ID: <CAMuHMdU4HUmTJZiecL9u0G1LuZ18K_1hYo4Q_U9S2a2fuo=xRA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
To:     Joe Perches <joe@perches.com>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
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

Hi Joe,

On Mon, Feb 6, 2023 at 12:09 PM Joe Perches <joe@perches.com> wrote:
> On Mon, 2023-02-06 at 09:38 +0100, Geert Uytterhoeven wrote:
> > On Sat, Feb 4, 2023 at 5:59 PM Joe Perches <joe@perches.com> wrote:
> > > On Sun, 2023-01-29 at 09:52 -0800, Joe Perches wrote:
> > > > On Sun, 2023-01-29 at 13:34 +0100, Jonathan Neuschäfer wrote:
> > > > > By now, `git log --pretty=%h` (on my copy of linux.git) prints commit
> > > > > hashes with 13 digits, because of the number of objects.
> > > > >
> > > > > Relax the rule in checkpatch.pl to allow a few more digits (up to 16).
> > > >
> > > > NAK without updating the process docs first.
> > >
> > > btw: it looks like 12 will still be sufficient for awhile yet
> > >
> > > $ git count
> > > total 1154908
> >
> > Hmm, Ubuntu git too old?
>
> Don't think so
>
> $ git --version
> git version 2.39.1

Exactly, Ubuntu 22.04LTS only has

$ git --version
git version 2.34.1

i.e. no git count.

> > I've been using core.abbrev=16 for a while, and some maintainers
> > reject my patches with Fixes: tags because of that...
>
> Perhaps because that's not the documented format?

Right.  I look a lot at history, and don't want to become slowed down
by ambiguous Fixes: tags anytime soon (or later).

> > Is it really worthwhile to save on the number of hexits, making lookup
> > of some commits more inconvenient?
> >
> > Note that while "git show edb9b8" suggests edb9b8f[...],
> > gitweb says bad object id:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edb9b8
>
> hmm.  Not here.
>
> $ git show edb9b8
> tree edb9b8

Yeah, I also have that tree object.  But I don't want to see the tree
object; I want to see the commit object, which is in v6.2-rc7:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edb9b8f

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
