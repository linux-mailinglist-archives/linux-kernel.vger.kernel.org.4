Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B419763B2C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiK1UKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiK1UKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:10:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69265E5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:10:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso7040977pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LrWhoa/Wn/Otd/OEE6O5+GU+sWhxvmWKhnQriMwolNQ=;
        b=Ft3K8vNpguhkxGVviUoZ0VbAZbXap64K+Z8vTx6lvjef85eskOiDN+PNPQx1ONGzBL
         XqMQxY1yaif+QgDSgxQDNdhTzf4M037bMP/ZQJD4NpyGc6/1wCeMKz1s+K5kMgWRhuZS
         xsvPM6oN1lkGBRggysG6A59OmQmKzNKqkZNm/ns+2+sGUfY3nrAcvx0ZI5hpmhQsdHiS
         Rv9fS3ySEubOBKkEpCt+pqKGeahw+ADG8Sk1AbOu1DNv7GapdB0MXcRiubbImtzs7g8E
         GzfXasmCzGfVhX5wBQjMGw0oUzgCyaygTUEajcbLlENdGdgR4b4mRcs6ZglvP+inVymB
         HuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrWhoa/Wn/Otd/OEE6O5+GU+sWhxvmWKhnQriMwolNQ=;
        b=p3w0xSwxpCVWrnfDVmk2LSJF0ghAiyMeGcCHDGC1slXUT/OexOFsRlktsNIgBg1RVd
         JcMOGNX6Wxi/3Ilpt8F9zrSRzXh1niaNe/NJnEo7fjFDrkOKfc0BOfnXCnfsq4epcjSD
         Fd6efWvDur0B9Fwk/yo//xaH9K8VRIwpbNzzhYSqdRBxNlYPDK+ISaSHHzk+yI8DWfGR
         ayuL8oHaWm3Fp0kvUd/y6M/+5u2n1Vgw99KZiFsDu8hT4a0oucNSTGjPV3QF93zka8kG
         zLyRYfEGElPazneep/iK86stCAAeHEwD7hJ1OvigAuQlhRqn2tgcdQWseBTgl10lXf4b
         Skuw==
X-Gm-Message-State: ANoB5pnvHj7LXdmDejFd4jOx8cjfZ6TGCwVupAl9hq42Hq6jyfOg8qF4
        dXjcKl32iHqKhkxWm534qktSRRXpHDA73EGvx+U=
X-Google-Smtp-Source: AA0mqf4PTB+8hgR9blsjPRLxL0XGfnedeyPd8FdLPLwJS2r6KI+2cktFVM5MgcPuatdnueCBv7xFW3X8VMSQpU7dvcs=
X-Received: by 2002:a17:90a:4302:b0:20a:e469:dc7d with SMTP id
 q2-20020a17090a430200b0020ae469dc7dmr54086687pjg.97.1669666213792; Mon, 28
 Nov 2022 12:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20221128180252.1684965-1-jannh@google.com> <20221128180252.1684965-2-jannh@google.com>
 <CAHbLzkp7+ZrXkoYcVtqrd2mQN3FZ4Y6tyeZCd31Oubz=+esaJQ@mail.gmail.com> <CAG48ez0iS2BZd9BAXZLBA3D0fzNePSLWoXqAbYWsTig4nN5FrQ@mail.gmail.com>
In-Reply-To: <CAG48ez0iS2BZd9BAXZLBA3D0fzNePSLWoXqAbYWsTig4nN5FrQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 28 Nov 2022 12:10:02 -0800
Message-ID: <CAHbLzkrAsFvUoavXrF_R4aZZm-02Fa7tF0E24TGEsAn8owbDuw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/khugepaged: Fix GUP-fast interaction by sending IPI
To:     Jann Horn <jannh@google.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:57 AM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Nov 28, 2022 at 8:54 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Mon, Nov 28, 2022 at 10:03 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> > > collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
> > > ensure that the page table was not removed by khugepaged in between.
> > >
> > > However, lockless_pages_from_mm() still requires that the page table is not
> > > concurrently freed or reused to store non-PTE data. Otherwise, problems
> > > can occur because:
> > >
> > >  - deposited page tables can be freed when a THP page somewhere in the
> > >    mm is removed
> > >  - some architectures store non-PTE information inside deposited page
> > >    tables (see radix__pgtable_trans_huge_deposit())
> > >
> > > Additionally, lockless_pages_from_mm() is also somewhat brittle with
> > > regards to page tables being repeatedly moved back and forth, but
> > > that shouldn't be an issue in practice.
> > >
> > > Fix it by sending IPIs (if the architecture uses
> > > semi-RCU-style page table freeing) before freeing/reusing page tables.
> > >
> > > As noted in mm/gup.c, on configs that define CONFIG_HAVE_FAST_GUP,
> > > there are two possible cases:
> > >
> > >  1. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set, causing
> > >     tlb_remove_table_sync_one() to send an IPI to synchronize with
> > >     lockless_pages_from_mm().
> > >  2. CONFIG_MMU_GATHER_RCU_TABLE_FREE is unset, indicating that all
> > >     TLB flushes are already guaranteed to send IPIs.
> > >     tlb_remove_table_sync_one() will do nothing, but we've already
> > >     run pmdp_collapse_flush(), which did a TLB flush, which must have
> > >     involved IPIs.
> >
> > I'm trying to catch up with the discussion after the holiday break. I
> > understand you switched from always allocating a new page table page
> > (we decided before) to sending IPIs to serialize against fast-GUP,
> > this is fine to me.
> >
> > So the code now looks like:
> >     pmdp_collapse_flush()
> >     sending IPI
> >
> > But the missing part is how we reached "TLB flushes are already
> > guaranteed to send IPIs" when CONFIG_MMU_GATHER_RCU_TABLE_FREE is
> > unset? ARM64 doesn't do it IIRC. Or did I miss something?
>
> From arch/arm64/Kconfig:
>
> select MMU_GATHER_RCU_TABLE_FREE
>
> CONFIG_MMU_GATHER_RCU_TABLE_FREE is not a config option that the user
> can freely toggle; it is an option selected by the architecture.

Aha, I see :-) BTW, shall we revert "mm: gup: fix the fast GUP race
against THP collapse"? It seems not necessary anymore if this approach
is used IIUC.

Reviewed-by: Yang Shi <shy828301@gmail.com>
