Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11B77089E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjERUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjERUw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160E91995
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25CCA65238
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BABC433A8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684443082;
        bh=Mcohg/XV/wrFIOA2dbWQp4WbXXb3DOZC5jV/ZprWGFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TbsWqD+7b4kGi8NsWgROO6O/Pg+2Iwrj15TYHLq1bbeELPriTHIdqkvLswmNAS6Dj
         SPn0mKlINpuG6hfj44KfMIItwAO/E2AkD39atTJGumGCc/SyeCHLUbSjQ/FnAJuu2c
         wbPRCQb6Z9nGI9maqjChMf20UcDuSCN7ooLRGJDf2Q8KnkukixjTkJCQn+DeSSOwU+
         VI7qIhIYN541GRrb3XjZZ1ynUgGVkK+N7wtfaFg9SE+9PEhazXxnf/ZHw29L55jpM+
         +FCBp3GRPnAO/x4Mzn5t7Bygy/T5tMt1wVcx/GQCiMp7b6U2kWSDBHxmHFQjyqyAYE
         9MmEzJ6hjv2pQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ac836f4447so26658451fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:51:22 -0700 (PDT)
X-Gm-Message-State: AC+VfDw3ut3Rxq2GxkeHtq1LmhAbnl4fjRbry4woNGClcLJZ043jeydL
        uq86n0DNBmYUETax/EbjRtdLBBuxvSHIwU56/g0=
X-Google-Smtp-Source: ACHHUZ5OEA6kaXJKZOVU8MfSLnsAK59aRs1t/9/zhbRzGVU8wITXI6PQO0WrhEk35bpZ+lXbRRWq44o636fx3BTcX2s=
X-Received: by 2002:a19:ad02:0:b0:4f2:509b:87ba with SMTP id
 t2-20020a19ad02000000b004f2509b87bamr55370lfc.50.1684443080480; Thu, 18 May
 2023 13:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan> <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan> <CAPhsuW6B3O_kWjWwr+UfYO3WRkznFqBNtcecFCSECBSiZBJDsA@mail.gmail.com>
 <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com> <ZGZ5PuQxDnjHlxAY@moria.home.lan>
In-Reply-To: <ZGZ5PuQxDnjHlxAY@moria.home.lan>
From:   Song Liu <song@kernel.org>
Date:   Thu, 18 May 2023 13:51:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4A8H00MV=tT9Gs_mtjn7o9KOzPjhwhdWDJMbY_9=9RrQ@mail.gmail.com>
Message-ID: <CAPhsuW4A8H00MV=tT9Gs_mtjn7o9KOzPjhwhdWDJMbY_9=9RrQ@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

To allocate memory for text, we will allocate 2MiB, make it ROX, and then
use it for many small allocations. IIUC, buddy allocator will use unallocat=
ed
parts of this page for metadata. I guess this may be a problem, as the
whole page is ROX now, and we have to use text_poke to write to it.

OTOH, if we allocate extra memory for metadata (tree based solution),
all the metadata operations can be regular read/write.

Thanks,
Song
