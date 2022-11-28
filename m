Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC6F63B2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiK1UMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiK1UMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:12:06 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A74FAD5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:12:05 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id g26so7841603iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ef+VxAVqyHNr3SIX9M4C8tTATvFzdBIjqbBoKeAT+Q=;
        b=WBerXZPwEY1ilK6ZRkS8aWtbp5YXuT+JdxrGYFOKDBn4r0Q4V2jugeRsZXa3Ock23K
         S6pwgBWt6in8Yxc4ZlJm4tP1WFl5QZy2PzhQp7BhODjl6SOS81LGOY+BlbVVdeYZFDUw
         ocrv43TXSTsP3mf1H2S/2ARq/DcyWeojRiMr2Kt2nhhnn2zsy8obV4Drstznj4/gxz90
         NImGfj5rl/1U3K+x3BtTEe/zCDf/ElQ6PEOLNQroeQvJMJ0L51px6T3M7e5AfTvUlcRo
         Xvq9IMZv2VXbij3sp942Lrk7TpfkTLelHENbRsgwt5nIBP/hw3PDS3rlSZuWYo4X2v8y
         ViWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ef+VxAVqyHNr3SIX9M4C8tTATvFzdBIjqbBoKeAT+Q=;
        b=wFDS8aflqsj/pQtO4NUjH+knmmMHJ5UoWb6oVut/+qgfAGoOP+tn6DZUR1pNjFogHl
         Zs9kmFxtPWunSuF+KFyKDpITC6lydowKc9XIHHZSV3r5G7nlRk/YRX0JRerd0bdLHz8s
         F0/dXP07Yvdsohk2D9AAoh+iuJkyEh1Lqy7m88VSmDQMoNfL39PKwoZnNKxeaLFFFE0a
         DPCJS5GyVx9oiMITpnP2iZ99wsRjP7l6h+HEFP+EDaCmnFUFnUMJe88ZHQ2xX5tK2tNt
         ckXoXcOhxJc9yVh846CxhtTGqGb9HrmTEaztd880/9tidgniNaEpzmxeeYahpU8Hai0A
         TJzQ==
X-Gm-Message-State: ANoB5pkIPqDKp3Zzw4gXkb6kBO0fX51nEouC8kWh2ilhpgFgUHNDiZ9E
        Ese2MsfbTmNNRd863WLHGNByV86R8p0mEDvsK4VgKw==
X-Google-Smtp-Source: AA0mqf6q73ZTVx3zBynrC3mn6j/laWnf08B+SH0wU0NXTLKIdZBH0dXhTwxc0bf0O7UxA8dd02ampkkuFzk1DnCQUTM=
X-Received: by 2002:a5d:8f84:0:b0:6d9:56fc:ef25 with SMTP id
 l4-20020a5d8f84000000b006d956fcef25mr15350157iol.56.1669666325140; Mon, 28
 Nov 2022 12:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20221128180252.1684965-1-jannh@google.com> <20221128180252.1684965-2-jannh@google.com>
 <CAHbLzkp7+ZrXkoYcVtqrd2mQN3FZ4Y6tyeZCd31Oubz=+esaJQ@mail.gmail.com>
 <CAG48ez0iS2BZd9BAXZLBA3D0fzNePSLWoXqAbYWsTig4nN5FrQ@mail.gmail.com> <CAHbLzkrAsFvUoavXrF_R4aZZm-02Fa7tF0E24TGEsAn8owbDuw@mail.gmail.com>
In-Reply-To: <CAHbLzkrAsFvUoavXrF_R4aZZm-02Fa7tF0E24TGEsAn8owbDuw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Nov 2022 21:11:29 +0100
Message-ID: <CAG48ez2CdMMOWsD3yo8-EEDc9x19Jdp6B8fJxtsRMNccF3_xCg@mail.gmail.com>
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

On Mon, Nov 28, 2022 at 9:10 PM Yang Shi <shy828301@gmail.com> wrote:
> On Mon, Nov 28, 2022 at 11:57 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Mon, Nov 28, 2022 at 8:54 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Mon, Nov 28, 2022 at 10:03 AM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> > > > collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
> > > > ensure that the page table was not removed by khugepaged in between.
> > > >
> > > > However, lockless_pages_from_mm() still requires that the page table is not
> > > > concurrently freed or reused to store non-PTE data. Otherwise, problems
> > > > can occur because:
> > > >
> > > >  - deposited page tables can be freed when a THP page somewhere in the
> > > >    mm is removed
> > > >  - some architectures store non-PTE information inside deposited page
> > > >    tables (see radix__pgtable_trans_huge_deposit())
> > > >
> > > > Additionally, lockless_pages_from_mm() is also somewhat brittle with
> > > > regards to page tables being repeatedly moved back and forth, but
> > > > that shouldn't be an issue in practice.
> > > >
> > > > Fix it by sending IPIs (if the architecture uses
> > > > semi-RCU-style page table freeing) before freeing/reusing page tables.
> > > >
> > > > As noted in mm/gup.c, on configs that define CONFIG_HAVE_FAST_GUP,
> > > > there are two possible cases:
> > > >
> > > >  1. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set, causing
> > > >     tlb_remove_table_sync_one() to send an IPI to synchronize with
> > > >     lockless_pages_from_mm().
> > > >  2. CONFIG_MMU_GATHER_RCU_TABLE_FREE is unset, indicating that all
> > > >     TLB flushes are already guaranteed to send IPIs.
> > > >     tlb_remove_table_sync_one() will do nothing, but we've already
> > > >     run pmdp_collapse_flush(), which did a TLB flush, which must have
> > > >     involved IPIs.
> > >
> > > I'm trying to catch up with the discussion after the holiday break. I
> > > understand you switched from always allocating a new page table page
> > > (we decided before) to sending IPIs to serialize against fast-GUP,
> > > this is fine to me.
> > >
> > > So the code now looks like:
> > >     pmdp_collapse_flush()
> > >     sending IPI
> > >
> > > But the missing part is how we reached "TLB flushes are already
> > > guaranteed to send IPIs" when CONFIG_MMU_GATHER_RCU_TABLE_FREE is
> > > unset? ARM64 doesn't do it IIRC. Or did I miss something?
> >
> > From arch/arm64/Kconfig:
> >
> > select MMU_GATHER_RCU_TABLE_FREE
> >
> > CONFIG_MMU_GATHER_RCU_TABLE_FREE is not a config option that the user
> > can freely toggle; it is an option selected by the architecture.
>
> Aha, I see :-) BTW, shall we revert "mm: gup: fix the fast GUP race
> against THP collapse"? It seems not necessary anymore if this approach
> is used IIUC.

Yeah, I agree.

> Reviewed-by: Yang Shi <shy828301@gmail.com>

Thanks!
