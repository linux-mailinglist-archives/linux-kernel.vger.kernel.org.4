Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7304D6A9149
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCCG4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCCG4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:56:06 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D016ADE;
        Thu,  2 Mar 2023 22:56:00 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id bk39so449673qkb.8;
        Thu, 02 Mar 2023 22:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677826559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6BSGbpVKGjRC5Y9q1jFuD5z32A1JlZm8OjMKetWXD4=;
        b=OiA6fxIPBmZYOVuxSAFeAHed43p9wgoJGFGLLG5gMhH/lQSrGzuvOXZf62J2P9CUSF
         3A5/OQ8Ve+uxz+21G6tNgvKx47HAjbRSdadl0q3uaPaDTRExw8V2W/xmthLp69PzOo40
         YQ8gGikAjl9bAYTrttcxWhWme3WfGSKr0Uh1Rwk81IJoGCqxcf+Zk+c9rZVIgyfIG8Fp
         UQXgktuik0Me+05ml1mtgtVaAdK/eFvOCVgYxLxRIeI32ZwZECL3wDYDRp6JD1mamrG+
         CvsZl2EVFZ9QKGB5zZedlFBmJN4/A1UlRLO3JXoiXqksAQ5cP8x/2inbiHf/82O9FEWm
         iTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677826559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6BSGbpVKGjRC5Y9q1jFuD5z32A1JlZm8OjMKetWXD4=;
        b=MEBMCShvAp9BmePmpCsS6dcK0aj8LTvytdFJ18KxtxEpJA5oegms1a6QPfmNyM1Lfk
         v5FtOZ7qElOV0epvhBYcadoOYSjKdlC5rfxywL83Qgt40U4hwrw3lwA5doIfH11GOOPF
         S37c2O6H8Y9A9wgHR5JvU51Llce+fKoF3pzqRenTbdE3hNHXtGE5AXIaqdWnIbydYlIt
         jN2mW7KmkxDwzAfCZSzEiwPyeiVlNLVEO+6aTUdTBN7dzBtK8+3N2xlkal04GE7FmDjB
         N2q8WirCOKyblFm/auU6yVTB1eO13Xrxv3F2+q1RfeLOn6Cqdf7l4WkKY9cBEwb5ni+7
         q7XQ==
X-Gm-Message-State: AO0yUKUHcu/Gh1wM/epJ7S8/pXLvbpi9qEsyzPMOAMxNmW0Yy9dIypwD
        YqeW3FNE3mr76FlNbkAP00pSPP1ebwyFVVcOhKuuOWdpeFa27Q==
X-Google-Smtp-Source: AK7set9MwUPLhaZp/FXey97WvTwd/0gYXBcbqhML3C87oEiBQUKJddBM9tRa65JsY60XN/hSYeBwwYCz0jnsQGuHkrA=
X-Received: by 2002:a37:bd04:0:b0:735:6357:c1ce with SMTP id
 n4-20020a37bd04000000b007356357c1cemr1304161qkf.1.1677826559212; Thu, 02 Mar
 2023 22:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20230219073318.366189-1-nphamcs@gmail.com> <20230219073318.366189-3-nphamcs@gmail.com>
 <Y/IUTiL03C9OOSFx@casper.infradead.org>
In-Reply-To: <Y/IUTiL03C9OOSFx@casper.infradead.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 2 Mar 2023 22:55:48 -0800
Message-ID: <CAKEwX=M7HSzSF6GZ_Nv26FQv_j+5UD9FQ_v3CL4=a1q5epyvPA@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] cachestat: implement cachestat syscall
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 4:21=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Feb 18, 2023 at 11:33:17PM -0800, Nhat Pham wrote:
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e654435f1651..83300f1491e7 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -75,6 +75,7 @@ struct fs_context;
> >  struct fs_parameter_spec;
> >  struct fileattr;
> >  struct iomap_ops;
> > +struct cachestat;
> >
> >  extern void __init inode_init(void);
> >  extern void __init inode_init_early(void);
> > @@ -830,6 +831,8 @@ void filemap_invalidate_lock_two(struct address_spa=
ce *mapping1,
> >                                struct address_space *mapping2);
> >  void filemap_invalidate_unlock_two(struct address_space *mapping1,
> >                                  struct address_space *mapping2);
> > +void filemap_cachestat(struct address_space *mapping, pgoff_t first_in=
dex,
> > +             pgoff_t last_index, struct cachestat *cs);
>
> 1. Why is this in fs.h instead of pagemap.h?
>
> 2. Why is it not static, since it's only used by the syscall,
> which is also in filemap.c?
>
> > @@ -55,6 +56,9 @@
> >  #include <linux/buffer_head.h> /* for try_to_free_buffers */
> >
> >  #include <asm/mman.h>
> > +#include <uapi/linux/mman.h>
>
> I think this hunk should be:
>
> -#include <asm/mman.h>
> +#include <linux/mman.h>
>
> (linux/mman.h includes uapi/linux/mman.h, which includes asm/mman.h)
>
> > +/**
> > + * filemap_cachestat() - compute the page cache statistics of a mappin=
g
> > + * @mapping: The mapping to compute the statistics for.
> > + * @first_index:     The starting page cache index.
> > + * @last_index:      The final page index (inclusive).
> > + * @cs:      the cachestat struct to write the result to.
> > + *
> > + * This will query the page cache statistics of a mapping in the
> > + * page range of [first_index, last_index] (inclusive). The statistics
> > + * queried include: number of dirty pages, number of pages marked for
> > + * writeback, and the number of (recently) evicted pages.
> > + */
>
> Do we care that this isn't going to work for hugetlbfs?

I ran a quick test using hugetlbfs. It looks like the current
implementation is treating it in accordance to the multi-page
folio case we discussed earlier, i.e:

- Returned number of "pages" is in terms of the number of
base/small pages (i.e 512 dirty pages instead of 1 dirty
huge page etc.)
- If we touch one byte in the huge page, it would report the
entire huge page as dirty, but again in terms of the underlying
pages.

Is this what you have in mind, or is there another edge
case that I'm missing...?

Thanks for the comments and suggestions, Matthew!


>
> > +     rcu_read_lock();
> > +     xas_for_each(&xas, folio, last_index) {
> > +             unsigned long nr_pages;
> > +             pgoff_t folio_first_index, folio_last_index;
> > +
> > +             if (xas_retry(&xas, folio))
> > +                     continue;
> > +
> > +             nr_pages =3D folio_nr_pages(folio);
> > +             folio_first_index =3D folio_pgoff(folio);
> > +             folio_last_index =3D folio_first_index + nr_pages - 1;
> > +
> > +             /* Folios might straddle the range boundaries, only count=
 covered subpages */
>
> s/subpages/pages/
>
