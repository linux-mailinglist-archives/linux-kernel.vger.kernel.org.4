Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F77088F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjERUEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjERUEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:04:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0211172D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B05B651F0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B99CC433EF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684440222;
        bh=nKITgJy7liqGSAvU1qV/vaHdz2NbzxKAJNfHBMK/A6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oJGyPRK5eH+do4d5a06JYGcoZr+p2ZGGjmK2JPVjQF01jinGz9WidVHlZJQOxtHCe
         1BLbheNVoVv9+vdGFC3ag8vqOQ8na/QlTVort+sU0r4gIdghZgYy04Q8hQ2a8h05RL
         8qcD0BeXuBkwYUzImXnVh90Yk7+b5hopu7w8HN/ABbzqpsztrZgB4YGK+rW051vIBP
         lzNqHJxBU1q/r/dGS6TBe5FZ4W6B1TZV2pmq8v9xmyH3ddGIyXdyk1fnvgRwaoyIGU
         nKG35Ak2bLdM9KzkNopyEUmWJ7QVtYI2XUr44KCtnbTKL3Ihfy+07/zJ0XV2h9Momp
         G+BnSHzTgrxPw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2af1ae3a21fso9902681fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:03:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDy9IrAxTP1SKlzVjfWDtOd4+7DBrA+1g7Sq2iIGrfiWqBAMlPBC
        yzg1h0c/PqK2/IR3TWcrWpMAQQDWUDwpc/HGmOE=
X-Google-Smtp-Source: ACHHUZ6LHtdqfkUOrsOnRv3P3RbUrmSu+MY8KwnFonflNO7p7DZ96HkoRvCpFA9UfbfGtazjQPHdV4vQH2HlAr1LX4Y=
X-Received: by 2002:a19:ad02:0:b0:4f3:7b3c:2e16 with SMTP id
 t2-20020a19ad02000000b004f37b3c2e16mr35252lfc.39.1684440220668; Thu, 18 May
 2023 13:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan> <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan> <CAPhsuW6B3O_kWjWwr+UfYO3WRkznFqBNtcecFCSECBSiZBJDsA@mail.gmail.com>
 <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com> <ZGZ5PuQxDnjHlxAY@moria.home.lan>
In-Reply-To: <ZGZ5PuQxDnjHlxAY@moria.home.lan>
From:   Song Liu <song@kernel.org>
Date:   Thu, 18 May 2023 13:03:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Yk4bDFiAxbiGnpUfy-dEwO=dY-D5dQtzwu6fcy3zDCg@mail.gmail.com>
Message-ID: <CAPhsuW7Yk4bDFiAxbiGnpUfy-dEwO=dY-D5dQtzwu6fcy3zDCg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:15=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, May 18, 2023 at 12:03:03PM -0700, Song Liu wrote:
> > On Thu, May 18, 2023 at 11:47=E2=80=AFAM Song Liu <song@kernel.org> wro=
te:
> > >
> > > On Thu, May 18, 2023 at 10:24=E2=80=AFAM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Thu, May 18, 2023 at 10:00:39AM -0700, Song Liu wrote:
> > > > > On Thu, May 18, 2023 at 9:48=E2=80=AFAM Kent Overstreet
> > > > > <kent.overstreet@linux.dev> wrote:
> > > > > >
> > > > > > On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > > > > > > I am working on patches based on the discussion in [1]. I am =
planning to
> > > > > > > send v1 for review in a week or so.
> > > > > >
> > > > > > Hey Song, I was reviewing that thread too,
> > > > > >
> > > > > > Are you taking a different approach based on Thomas's feedback?=
 I think
> > > > > > he had some fair points in that thread.
> > > > >
> > > > > Yes, the API is based on Thomas's suggestion, like 90% from the d=
iscussions.
> > > > >
> > > > > >
> > > > > > My own feeling is that the buddy allocator is our tool for allo=
cating
> > > > > > larger variable sized physically contiguous allocations, so I'd=
 like to
> > > > > > see something based on that - I think we could do a hybrid budd=
y/slab
> > > > > > allocator approach, like we have for regular memory allocations=
.
> > > > >
> > > > > I am planning to implement the allocator based on this (reuse
> > > > > vmap_area logic):
> > > >
> > > > Ah, you're still doing vmap_area approach.
> > > >
> > > > Mike's approach looks like it'll be _much_ lighter weight and highe=
r
> > > > performance, to me. vmalloc is known to be slow compared to the bud=
dy
> > > > allocator, and with Mike's approach we're only modifying mappings o=
nce
> > > > per 2 MB chunk.
> > > >
> > > > I don't see anything in your code for sub-page sized allocations to=
o, so
> > > > perhaps I should keep going with my slab allocator.
> > >
> > > The vmap_area approach handles sub-page allocations. In 5/5 of set [2=
],
> > > we showed that multiple BPF programs share the same page with some
> > > kernel text (_etext).
> > >
> > > > Could you share your thoughts on your approach vs. Mike's? I'm newe=
r to
> > > > this area of the code than you two so maybe there's an angle I've m=
issed
> > > > :)
> > >
> > > AFAICT, tree based solution (vmap_area) is more efficient than bitmap
> > > based solution.
>
> Tree based requires quite a bit of overhead for the rbtree pointers, and
> additional vmap_area structs.
>
> With a buddy allocator based approach, there's no additional state that
> needs to be allocated, since it all fits in struct page.
>
> > > First, for 2MiB page with 64B chunk size, we need a bitmap of
> > >      2MiB / 64B =3D 32k bit =3D 4k bytes
> > > While the tree based solution can adapt to the number of allocations =
within
> > > This 2MiB page. Also, searching a free range within 4kB of bitmap may
> > > actually be slower than searching in the tree.
> > >
> > > Second, bitmap based solution cannot handle > 2MiB allocation cleanly=
,
> > > while tree based solution can. For example, if a big driver uses 3MiB=
, the
> > > tree based allocator can allocate 4MiB for it, and use the rest 1MiB =
for
> > > smaller allocations.
>
> We're not talking about a bitmap based solution for >=3D PAGE_SIZE
> allocations, the alternative is a buddy allocator - so no searching,
> just per power-of-two freelists.
>
> >
> >  Missed one:
> >
> > Third, bitmap based solution requires a "size" parameter in free(). It =
is an
> > overhead for the user. Tree based solution doesn't have this issue.
>
> No, we can recover the size of the allocation via compound_order() -
> hasn't historically been done for alloc_pages() allocations to avoid
> setting up the state in each page for compound head/tail, but it perhaps
> should be (and is with folios, which we've generally been switching to).

If we use compound_order(), we will round up to power of 2 for all
allocations. Does this mean we will use 4MiB for a 2.1MiB allocation?

Thanks,
Song
