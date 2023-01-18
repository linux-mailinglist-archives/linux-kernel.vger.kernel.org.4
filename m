Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB457672AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjARV4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjARVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:55:59 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F33654D0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:55:58 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4d13cb4bbffso658247b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eh8dAbgVRrFwnzWUEGIwJaAIH80Ew7E9/OKwj57uyg0=;
        b=nJGNy+FYWaPE6HWuHcH3oVryDlTnQctCoWA59TQXSEdtT7u9LVPaE+3Bp6dcuR9eo8
         ZuCt/cm+uMsaq4ePsq2JuQNp72mXm9CCQ8wZd5k1ixUun0zKMaVU0yGAhGPJ7VYH35k7
         ZXaiN6GgNMMY83qMhnVgWVsUlUzDW6nzZyMBwP9v8ftHZEG1zdJ2EEGJkrIMcFAqqPBh
         jQxzRS+A4btlwvGxufPrEifN6QyKTtiFOyDYzKQw6roPc60PFhHbHqWCCVPN+bGlEVI7
         K2/Nus0JAbDaikFmuLLiQdU2OO+gsg/XY6u/NHBMMiYIBmzYkDopNVKgW2+8wK02SRg8
         h7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eh8dAbgVRrFwnzWUEGIwJaAIH80Ew7E9/OKwj57uyg0=;
        b=yLIwihXmBpDCojreCJhchFMQ9qg+9pMobSmTGiN6mv7uInsnGvYCEsQVeEX1mSd5Vv
         /B/dZgDmEruyHBC/AZSCDuAzMxgg600OwSJu6jT2vFLK/6vjGhLXuMSEVLpxEzOqKDsA
         AnsSPyMqdHsoMehUYb6iTdk0L8ZH2O4nKIJxOC63Yxp2shdJHRzt7UFH2pA2M/jrPfCT
         8dE7L436cgzV0i2ojUIh8p7TkL+dkOOcxOFzYtUgnn5hruHg9nJwcDhXE/3TO3tLwO37
         biAAlDxyrMHiNCKgafn+fSLXP7l1fJgftHaTuwjrt/rlB5Sn6hCRG/dcC0q+d8GTFd1B
         YDyg==
X-Gm-Message-State: AFqh2kp4SKsaWIXcKqjrsaSAb48GpuzEvYpr7VP2goZzuTrnqwuMjF+i
        LHZQGTCdlT7beJY5G5rJITgCNqRUDrs4bCRHm+U=
X-Google-Smtp-Source: AMrXdXv5PDQluCVuSe+uge/CS/etL4IODtqL4EWrk8R+baPiBG8a5S3r9Nkksy/cEvuI1VftbSYH/dnNKGf0BMGm1IY=
X-Received: by 2002:a81:5c02:0:b0:4e2:db5a:2c2c with SMTP id
 q2-20020a815c02000000b004e2db5a2c2cmr1134272ywb.202.1674078957602; Wed, 18
 Jan 2023 13:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
In-Reply-To: <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Jan 2023 22:55:46 +0100
Message-ID: <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:47 PM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Wed, Jan 18, 2023 at 10:18 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 18 Jan 2023 16:07:03 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > > {set,clear}_bits_ll.  x86 CMPXCHG instruction returns success in ZF
> > > flag, so this change saves a compare after cmpxchg (and related move
> > > instruction in front of cmpxchg).
> > >
> > > Also, try_cmpxchg implicitly assigns old *ptr value to "old"
> > > when cmpxchg fails.
> > >
> > > Note that the value from *ptr should be read using READ_ONCE to prevent
> > > the compiler from merging, refetching or reordering the read.
> > >
> > > The patch also declares these two functions inline, to ensure inlining.
> >
> > But why is that better?  This adds a few hundred bytes more text, which
> > has a cost.
>
> Originally, both functions are inlined and the size of an object file
> is (gcc version 12.2.1, x86_64):
>
>   text    data     bss     dec     hex filename
>   4661     480       0    5141    1415 genalloc-orig.o
>
> When try_cmpxchg is used, gcc chooses to not inline set_bits_ll (its
> estimate of code size is not very precise when multi-line assembly is
> involved), resulting in:
>
>   text    data     bss     dec     hex filename
>   4705     488       0    5193    1449 genalloc-noinline.o
>
> And with an inline added to avoid gcc's quirks:
>
>   text    data     bss     dec     hex filename
>   4629     480       0    5109    13f5 genalloc.o
>
> Considering that these two changed functions are used only in
> genalloc.o, adding inline qualifier is a win, also when comparing to
> the original size.

BTW: Recently, it was determined [1] that the usage of cpu_relax()
inside the cmpxchg loop can be harmful for performance. We actually
have the same situation here, so perhaps cpu_relax() should be removed
in the same way it was removed from the lockref.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f5fe24ef17b5fbe6db49534163e77499fb10ae8c

Uros.
