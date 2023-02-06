Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4EE68B77B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBFIjU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Feb 2023 03:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBFIjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:39:16 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A211166D1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:39:14 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id v17so11993075qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwBpv3w7L/SXyUtsSmWuDaKIbkLHcGVq9fg041BM71k=;
        b=W/iAn4/oj4BuqXsej04Ds7Y3LtCKOg/5fulRnqJLhevvhOBT0k26gC+0wb/jiVO2Yo
         vda+8BiNm03lYHzFtHhuH9l82em4Qr3tZR5ZZmJKUyiBDH4yWRlYATijaybF5sdFJn1k
         SBiLdPnDwD7Dw6B6Ooc0jcSXnoPvPu93NT6nP7400Fw+BtCf4KOpfx4RZzFQ0hFp080D
         +Xa8tDr9iPQnd0kjVN7dnet5DxjJmviRzm3eSHpkJ7TXlVMw47drReyCLtHWPzIBsZYJ
         q7fZULF2ieUYOhWgIB79TrP1yKG086drixr99SYiyeKj5g1l5yPEsWGi2f4PUE9jDfIA
         kAEw==
X-Gm-Message-State: AO0yUKWs0lcCqDJc35WcSrU3znN3HdSA0SYypnlMXwLl5wpmz1z7Uzbc
        9jJarXvCRphce8OjSIqkOUt7orr+Fqnwmw==
X-Google-Smtp-Source: AK7set/Dxqm9PEjZmEeK0id6MlymidAZY714nAxe80fMb6X4TnpQ/1z+41Sk30NUL2truHDMfIIsQQ==
X-Received: by 2002:ac8:5d93:0:b0:3b6:335a:828c with SMTP id d19-20020ac85d93000000b003b6335a828cmr35646527qtx.47.1675672753252;
        Mon, 06 Feb 2023 00:39:13 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id g15-20020ac87f4f000000b003b86b99690fsm6869085qtk.62.2023.02.06.00.39.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 00:39:12 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id x8so5134109ybt.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:39:12 -0800 (PST)
X-Received: by 2002:a25:780e:0:b0:86e:9acc:1635 with SMTP id
 t14-20020a25780e000000b0086e9acc1635mr920452ybc.202.1675672752489; Mon, 06
 Feb 2023 00:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
 <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com> <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
In-Reply-To: <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Feb 2023 09:38:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWcjUXwkk2V29p-hifDnMhLRSwQBXMzVeURRA48znKC5Q@mail.gmail.com>
Message-ID: <CAMuHMdWcjUXwkk2V29p-hifDnMhLRSwQBXMzVeURRA48znKC5Q@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sat, Feb 4, 2023 at 5:59 PM Joe Perches <joe@perches.com> wrote:
> On Sun, 2023-01-29 at 09:52 -0800, Joe Perches wrote:
> > On Sun, 2023-01-29 at 13:34 +0100, Jonathan Neuschäfer wrote:
> > > By now, `git log --pretty=%h` (on my copy of linux.git) prints commit
> > > hashes with 13 digits, because of the number of objects.
> > >
> > > Relax the rule in checkpatch.pl to allow a few more digits (up to 16).
> >
> > NAK without updating the process docs first.
>
> btw: it looks like 12 will still be sufficient for awhile yet
>
> $ git count
> total 1154908

Hmm, Ubuntu git too old?

> $ git -c core.abbrev=5 log --pretty=format:%h | \
>   perl -nE 'chomp;say length' | sort | uniq -c | sort -n -k2
>     198 5
>  664613 6
>  450955 7
>   36667 8
>    2312 9
>     155 10
>       8 11

I'm already at twelve:

 433752 6
 640819 7
  62759 8
   3998 9
    261 10
     12 11
      1 12

I've been using core.abbrev=16 for a while, and some maintainers
reject my patches with Fixes: tags because of that...

Is it really worthwhile to save on the number of hexits, making lookup
of some commits more inconvenient?

Note that while "git show edb9b8" suggests edb9b8f[...],
gitweb says bad object id:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edb9b8

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
