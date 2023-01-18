Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBE672AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjARWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjARWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:01:43 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA835EFAC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:01:41 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id l139so184652ybl.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qtq4bTyQy0W4Bsf1mh5rx8LNnKznTvqqjHsmXtsh7DY=;
        b=IAT5APY9WkjsiY4I6E0A+2MrwUYt2keZusJ6Z/9Twqhz6K1BzWrNvV/ddK0s3xkoca
         YntymHOvR/VNglekh3ZntKkkb1G9NVurcdaOmb+Md0YgJIYb2ldm6rVJW20LZiLC/uVZ
         gUA1FZQawq07+xrTuUkJ5JGs5Z+4iq4NmHh/lj5ReqVsVMOZn5no+MQjDEiuEHsprp5g
         tQdy7XV79TEyJHWBa3PUGdCwt6AkTZi+FGWzdcA4NiOYfWprnaf0bFWIplwonrwHNbIw
         r+VMmO10hBMU/tVLwNy5/W8bQmNPcpL+DiqwS1NOlGhOhS+INBm0Bb6H3wYD2RMCxz6E
         fVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qtq4bTyQy0W4Bsf1mh5rx8LNnKznTvqqjHsmXtsh7DY=;
        b=JC5SDEJ9u42RwsY0DVMVHWxhPVPw0+NRzX9B4aIWoiXneNQ6Ddo90yQAnjf8ITfXhC
         s4a4NIX41H4FzJ59wDS/Aw2pLnQrfTG2bRR0hBv0l4rDjMfnDji4tS3DCUPCzx/PGk9h
         F0xjXXAYcX81Ixyz+W1iRbFXAr/REpdswAd/ZFOWSVJUoAhLKhcD8VIKT530k331yBL/
         AWHxdk3UJz3FWsYZOpWlPMtiBzP60Id6deZ00bCR13c/DGAGLefDEeU5wCO6ew2AFBvp
         UOKU1xH79agELhG87RRv5qh6JSfceWYSRtWrcRiwaB8oCxreFbTW9g+PoLrDw0LHJlWO
         Ioog==
X-Gm-Message-State: AFqh2kqVhiGrU4XIxK9liBgLp4S1TZyFkPB1fM/dOIJj8LwWf2hYQLxZ
        tz7b5RmDU+1eA6FhweAT/nHkvxg6nsK8sJWMkSO1GyYN5q8=
X-Google-Smtp-Source: AMrXdXsbqHTIUxZ0kmW8VtpW1geWYPLEm+bgiYi5tHPR+hPgMkdnS2ZRkYrvkpfAjEw5z3YO4E5NLyx/YNRvkQpyCTI=
X-Received: by 2002:a25:740b:0:b0:7b6:9dcb:6588 with SMTP id
 p11-20020a25740b000000b007b69dcb6588mr977882ybc.251.1674079301023; Wed, 18
 Jan 2023 14:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com> <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
In-Reply-To: <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Jan 2023 23:01:29 +0100
Message-ID: <CAFULd4Y8huj1iZo0yE9A7Ww5Z7WWoBK2KvG90s75OU-s7pL90Q@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>
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

On Wed, Jan 18, 2023 at 10:55 PM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Wed, Jan 18, 2023 at 10:47 PM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > On Wed, Jan 18, 2023 at 10:18 PM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 18 Jan 2023 16:07:03 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > > > {set,clear}_bits_ll.  x86 CMPXCHG instruction returns success in ZF
> > > > flag, so this change saves a compare after cmpxchg (and related move
> > > > instruction in front of cmpxchg).
> > > >
> > > > Also, try_cmpxchg implicitly assigns old *ptr value to "old"
> > > > when cmpxchg fails.
> > > >
> > > > Note that the value from *ptr should be read using READ_ONCE to prevent
> > > > the compiler from merging, refetching or reordering the read.
> > > >
> > > > The patch also declares these two functions inline, to ensure inlining.
> > >
> > > But why is that better?  This adds a few hundred bytes more text, which
> > > has a cost.
> >
> > Originally, both functions are inlined and the size of an object file
> > is (gcc version 12.2.1, x86_64):
> >
> >   text    data     bss     dec     hex filename
> >   4661     480       0    5141    1415 genalloc-orig.o
> >
> > When try_cmpxchg is used, gcc chooses to not inline set_bits_ll (its
> > estimate of code size is not very precise when multi-line assembly is
> > involved), resulting in:
> >
> >   text    data     bss     dec     hex filename
> >   4705     488       0    5193    1449 genalloc-noinline.o
> >
> > And with an inline added to avoid gcc's quirks:
> >
> >   text    data     bss     dec     hex filename
> >   4629     480       0    5109    13f5 genalloc.o
> >
> > Considering that these two changed functions are used only in
> > genalloc.o, adding inline qualifier is a win, also when comparing to
> > the original size.
>
> BTW: Recently, it was determined [1] that the usage of cpu_relax()
> inside the cmpxchg loop can be harmful for performance. We actually
> have the same situation here, so perhaps cpu_relax() should be removed
> in the same way it was removed from the lockref.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f5fe24ef17b5fbe6db49534163e77499fb10ae8c

I forgot to add some CCs that may be interested in the above.

Uros.
