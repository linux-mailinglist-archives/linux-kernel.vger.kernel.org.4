Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260A563B4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiK1WKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiK1WKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:10:34 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4FD22B19
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:10:33 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b4so11868047pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WQ1MDRW1e7gVGBgFgV8gW3QkC9WMZddxzT1WNY3Uo4I=;
        b=CAQUbiNJicl7IXT9VbNf06kK+1kweVcWbM161FF+QmwTQY+Kb5Wbo4aDrG0xE624ea
         At5gqb2RPP+Xs2x0oZp0WgbY1Qfm2JX8ibf5a+SXz4FB6XrbW9wEdDc+aiDuERjx9cag
         Sye31QhoC5MSuhoyFtKFevf2GTpQMRbcOQazEVIEQrMy6EyRrncl56EZVlk9ftPLOuwu
         EPK8N3kQCGUmW+v73jA6zRCgpkIw5G29Phxp4fyslDvidAIiZcw1tp7X703kbDVR65mD
         n5JquNcqqCCTKXykeld0eVnFOddCqKJXAqN9eQaaL4/Dzj2uSbPsZvqLPyDmbTcxAbsa
         KRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQ1MDRW1e7gVGBgFgV8gW3QkC9WMZddxzT1WNY3Uo4I=;
        b=INKzhCUk5QilA+oVN+PZPD5M+W0hQVm79lGB32XjkGYVDTSxKhepqx+oTMIuZ/4Ncy
         RhNSlZPrReT2CK5MQja/MDCzwpon43yxxxbXKyZJuHKiFy5eCCX5ATV29vwFsbQgr345
         YXV8TqoJg2zoVqunsR1mK6iYxyJEotgkvCvnI/+NG7MQ/x+gfCk2d2Grp59+agvPDqIt
         22SYWrrjG4oUWI0ldlYZzxRdOBw0vHgreYBbVRrfBuFE04N0IOmLvGdP6gxjBkX4X0lQ
         7VmoVpDPhbO+QBm6wSBr2Dx3u+3hH29WGUrHwBBBruX6Bn+tW6J0yKREo/nJKlqU3N4w
         7bvA==
X-Gm-Message-State: ANoB5pmII/1LHMK+148jyX06xu+vXstkT9BGu66wn1bDxQ/tFPLMGwc5
        +bBlggx9GA9fXVW7RrC4IC2lmX33lRZb7eUQoQw=
X-Google-Smtp-Source: AA0mqf753EeprsV+YMXIdjS74J0i/eVFqu/EUcs9H4EwXK6tutlx4ij9IbZPCnOWahICuyyi1c85w3bmP0t43DF/hD0=
X-Received: by 2002:a63:225d:0:b0:477:beb8:70f8 with SMTP id
 t29-20020a63225d000000b00477beb870f8mr23454969pgm.281.1669673432639; Mon, 28
 Nov 2022 14:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20221128180252.1684965-1-jannh@google.com> <20221128180252.1684965-2-jannh@google.com>
 <CAHbLzkp7+ZrXkoYcVtqrd2mQN3FZ4Y6tyeZCd31Oubz=+esaJQ@mail.gmail.com>
 <CAG48ez0iS2BZd9BAXZLBA3D0fzNePSLWoXqAbYWsTig4nN5FrQ@mail.gmail.com>
 <CAHbLzkrAsFvUoavXrF_R4aZZm-02Fa7tF0E24TGEsAn8owbDuw@mail.gmail.com> <CAG48ez2CdMMOWsD3yo8-EEDc9x19Jdp6B8fJxtsRMNccF3_xCg@mail.gmail.com>
In-Reply-To: <CAG48ez2CdMMOWsD3yo8-EEDc9x19Jdp6B8fJxtsRMNccF3_xCg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 28 Nov 2022 14:10:21 -0800
Message-ID: <CAHbLzkrfx4TNTFaG2J4DxRT8kXvcV=0mJQ9g64eOZvofazEdEw@mail.gmail.com>
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

On Mon, Nov 28, 2022 at 12:12 PM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Nov 28, 2022 at 9:10 PM Yang Shi <shy828301@gmail.com> wrote:
> > On Mon, Nov 28, 2022 at 11:57 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > On Mon, Nov 28, 2022 at 8:54 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 28, 2022 at 10:03 AM Jann Horn <jannh@google.com> wrote:
> > > > >
> > > > > Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> > > > > collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
> > > > > ensure that the page table was not removed by khugepaged in between.
> > > > >
> > > > > However, lockless_pages_from_mm() still requires that the page table is not
> > > > > concurrently freed or reused to store non-PTE data. Otherwise, problems
> > > > > can occur because:
> > > > >
> > > > >  - deposited page tables can be freed when a THP page somewhere in the
> > > > >    mm is removed
> > > > >  - some architectures store non-PTE information inside deposited page
> > > > >    tables (see radix__pgtable_trans_huge_deposit())
> > > > >
> > > > > Additionally, lockless_pages_from_mm() is also somewhat brittle with
> > > > > regards to page tables being repeatedly moved back and forth, but
> > > > > that shouldn't be an issue in practice.
> > > > >
> > > > > Fix it by sending IPIs (if the architecture uses
> > > > > semi-RCU-style page table freeing) before freeing/reusing page tables.
> > > > >
> > > > > As noted in mm/gup.c, on configs that define CONFIG_HAVE_FAST_GUP,
> > > > > there are two possible cases:
> > > > >
> > > > >  1. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set, causing
> > > > >     tlb_remove_table_sync_one() to send an IPI to synchronize with
> > > > >     lockless_pages_from_mm().
> > > > >  2. CONFIG_MMU_GATHER_RCU_TABLE_FREE is unset, indicating that all
> > > > >     TLB flushes are already guaranteed to send IPIs.
> > > > >     tlb_remove_table_sync_one() will do nothing, but we've already
> > > > >     run pmdp_collapse_flush(), which did a TLB flush, which must have
> > > > >     involved IPIs.
> > > >
> > > > I'm trying to catch up with the discussion after the holiday break. I
> > > > understand you switched from always allocating a new page table page
> > > > (we decided before) to sending IPIs to serialize against fast-GUP,
> > > > this is fine to me.
> > > >
> > > > So the code now looks like:
> > > >     pmdp_collapse_flush()
> > > >     sending IPI
> > > >
> > > > But the missing part is how we reached "TLB flushes are already
> > > > guaranteed to send IPIs" when CONFIG_MMU_GATHER_RCU_TABLE_FREE is
> > > > unset? ARM64 doesn't do it IIRC. Or did I miss something?
> > >
> > > From arch/arm64/Kconfig:
> > >
> > > select MMU_GATHER_RCU_TABLE_FREE
> > >
> > > CONFIG_MMU_GATHER_RCU_TABLE_FREE is not a config option that the user
> > > can freely toggle; it is an option selected by the architecture.
> >
> > Aha, I see :-) BTW, shall we revert "mm: gup: fix the fast GUP race
> > against THP collapse"? It seems not necessary anymore if this approach
> > is used IIUC.
>
> Yeah, I agree.

Since this patch could solve two problems: the use-after-free of the
data page (pinned by fast-GUP) and the page table page and my patch
will be reverted, so could you please catch both issues in this
patch's commit log? I'd like to preserve the description of the issue
fixed by my patch. I think that it is helpful to see the information
about all the fixed problems in one commit instead of digging into
another reverted commit.

>
> > Reviewed-by: Yang Shi <shy828301@gmail.com>
>
> Thanks!
