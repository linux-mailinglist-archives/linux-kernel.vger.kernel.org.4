Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC963C3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiK2PbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiK2PbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:31:07 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBBA60EBF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:31:03 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id f6so6758143ilu.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uMjNraLB6scr/xv9kM9mpf61HY1js/ZvtGhWlHG2rk8=;
        b=e2HH0dG5vmD1BA10H/FjRsLuqF361HQkMIjd2fOscEY5B1/yxduJlciZ+dvNrFYBsm
         scC3vBN1hlQXikK9x21+E4UlkGiX3srvT/7XmurqXi0b2LdY0xsm4E1izws3WaVNrPcc
         jJkCzD+7a2khe/8FXDY8wXwNjUxoo+NxaWcS5Oap2mSg83+KMPGf1T+D2mrbFrCTYvvY
         Lhv9I9rmVTa0GGM41qyDFFAOkT2vakmP6Jq38DU7slDN2WzlFO4s7s8AILaTaVmAXR1h
         f67tsuAow7TRlWkS9T7oHDNZNg++2n3Hz9VQ1+n3SJc+zkcg1tkq+pcPBvaKyIkLae4B
         gPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMjNraLB6scr/xv9kM9mpf61HY1js/ZvtGhWlHG2rk8=;
        b=ZgsHiaIWp/YoXQKlJGHSXnuMNXZCujofa25FcoBfb7hCvkvhSF8AdEeFRWfALuopgO
         hxpzZ7b00tzYbiTYnPosrBXkgOfDURSoUsgQ5H6jRU1htUXegEAZnXsJvcQFk13FSdlT
         IIO/wklZUhfPh/FE0VMRE/MEmxXKp24+dEv/Gbp26+XrEpMzUchqbR5MxvLR1aBOkpbs
         lZ0Ba5DuIBaILzDr+O63iQyclhuoCEl+1QYhS56z9SRAcluY68VATdsDdh89D/Sy42cw
         50A++NvWsk43Mvd1lzvAhBYCfVuKUfcdcVI31OCt0El5ZoSkt+bWgJ9cNRDg92TtyTCo
         AcEQ==
X-Gm-Message-State: ANoB5pmiKIZAVZ9N0VkJouZJTp/I/KnXWlyaZjW/hxyz3Ngro0d2ZhiI
        CzcvUG2iqmcuYtC4Xgr9D5RHEArtPDhecRza4Le1CZCgQ3Q=
X-Google-Smtp-Source: AA0mqf5H0WkPblZ9WWd2dEdD0H7A50y46L/PoWWxVtSVOwBX/7+zkXb6Rv258KlZroTTNsgYcCkxjub2fARp740h8kk=
X-Received: by 2002:a92:c10f:0:b0:303:1f6a:b30c with SMTP id
 p15-20020a92c10f000000b003031f6ab30cmr2118645ile.254.1669735862770; Tue, 29
 Nov 2022 07:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20221128180252.1684965-1-jannh@google.com> <20221128180252.1684965-2-jannh@google.com>
 <CAHbLzkp7+ZrXkoYcVtqrd2mQN3FZ4Y6tyeZCd31Oubz=+esaJQ@mail.gmail.com>
 <CAG48ez0iS2BZd9BAXZLBA3D0fzNePSLWoXqAbYWsTig4nN5FrQ@mail.gmail.com>
 <CAHbLzkrAsFvUoavXrF_R4aZZm-02Fa7tF0E24TGEsAn8owbDuw@mail.gmail.com>
 <CAG48ez2CdMMOWsD3yo8-EEDc9x19Jdp6B8fJxtsRMNccF3_xCg@mail.gmail.com> <CAHbLzkrfx4TNTFaG2J4DxRT8kXvcV=0mJQ9g64eOZvofazEdEw@mail.gmail.com>
In-Reply-To: <CAHbLzkrfx4TNTFaG2J4DxRT8kXvcV=0mJQ9g64eOZvofazEdEw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Nov 2022 16:30:26 +0100
Message-ID: <CAG48ez09vFC1+0y1z=2xgZ3ZV+Peo28o5u64ZNT-iBS8xv=-4w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/khugepaged: Fix GUP-fast interaction by sending IPI
To:     Yang Shi <shy828301@gmail.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:10 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Nov 28, 2022 at 12:12 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Mon, Nov 28, 2022 at 9:10 PM Yang Shi <shy828301@gmail.com> wrote:
> > > On Mon, Nov 28, 2022 at 11:57 AM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Mon, Nov 28, 2022 at 8:54 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 28, 2022 at 10:03 AM Jann Horn <jannh@google.com> wrote:
> > > > > >
> > > > > > Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> > > > > > collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
> > > > > > ensure that the page table was not removed by khugepaged in between.
> > > > > >
> > > > > > However, lockless_pages_from_mm() still requires that the page table is not
> > > > > > concurrently freed or reused to store non-PTE data. Otherwise, problems
> > > > > > can occur because:
> > > > > >
> > > > > >  - deposited page tables can be freed when a THP page somewhere in the
> > > > > >    mm is removed
> > > > > >  - some architectures store non-PTE information inside deposited page
> > > > > >    tables (see radix__pgtable_trans_huge_deposit())
> > > > > >
> > > > > > Additionally, lockless_pages_from_mm() is also somewhat brittle with
> > > > > > regards to page tables being repeatedly moved back and forth, but
> > > > > > that shouldn't be an issue in practice.
> > > > > >
> > > > > > Fix it by sending IPIs (if the architecture uses
> > > > > > semi-RCU-style page table freeing) before freeing/reusing page tables.
> > > > > >
> > > > > > As noted in mm/gup.c, on configs that define CONFIG_HAVE_FAST_GUP,
> > > > > > there are two possible cases:
> > > > > >
> > > > > >  1. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set, causing
> > > > > >     tlb_remove_table_sync_one() to send an IPI to synchronize with
> > > > > >     lockless_pages_from_mm().
> > > > > >  2. CONFIG_MMU_GATHER_RCU_TABLE_FREE is unset, indicating that all
> > > > > >     TLB flushes are already guaranteed to send IPIs.
> > > > > >     tlb_remove_table_sync_one() will do nothing, but we've already
> > > > > >     run pmdp_collapse_flush(), which did a TLB flush, which must have
> > > > > >     involved IPIs.
> > > > >
> > > > > I'm trying to catch up with the discussion after the holiday break. I
> > > > > understand you switched from always allocating a new page table page
> > > > > (we decided before) to sending IPIs to serialize against fast-GUP,
> > > > > this is fine to me.
> > > > >
> > > > > So the code now looks like:
> > > > >     pmdp_collapse_flush()
> > > > >     sending IPI
> > > > >
> > > > > But the missing part is how we reached "TLB flushes are already
> > > > > guaranteed to send IPIs" when CONFIG_MMU_GATHER_RCU_TABLE_FREE is
> > > > > unset? ARM64 doesn't do it IIRC. Or did I miss something?
> > > >
> > > > From arch/arm64/Kconfig:
> > > >
> > > > select MMU_GATHER_RCU_TABLE_FREE
> > > >
> > > > CONFIG_MMU_GATHER_RCU_TABLE_FREE is not a config option that the user
> > > > can freely toggle; it is an option selected by the architecture.
> > >
> > > Aha, I see :-) BTW, shall we revert "mm: gup: fix the fast GUP race
> > > against THP collapse"? It seems not necessary anymore if this approach
> > > is used IIUC.
> >
> > Yeah, I agree.
>
> Since this patch could solve two problems: the use-after-free of the
> data page (pinned by fast-GUP) and the page table page and my patch
> will be reverted, so could you please catch both issues in this
> patch's commit log? I'd like to preserve the description of the issue
> fixed by my patch. I think that it is helpful to see the information
> about all the fixed problems in one commit instead of digging into
> another reverted commit.

OK, I will rewrite the commit message to describe the overall problem,
including the part addressed by your patch.
