Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA0F670D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAQXSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAQXSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:18:01 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C1153565
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:05:28 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 203so35692992yby.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dwj8xbw0bnEL25Qq4gmjxS00IOeAjG6GNQxAdbnWO2A=;
        b=Dz70IjXMbGEDAEUfGYkAjARcQ1aaCB4C/yV4J6ap8RocWxiLCyWOuVOLCBBQakbozM
         9ThYUJ2KetdMGb1OtZwAPbQdTeKDKGOTXmZPv7NRZfHpQ/EtRgE8Ld6EbmyV5wGLlFfD
         AmFXyZvQdUOwQq4pgbxz9auvXTWcfQa87IMGGXpePOrO4iwYcAZ75BGEQVE7OIxHdtIF
         iD+cVHzpbMidwELSER4I/Iw3wY397BVq3STlFx+qXjWhSLJBTofB3gwY/gj9toQTJM4R
         jBMlUAVfbUhJueWyXvCfLluIrDwiqZ2eF2H8pnWKIRVh1BJHTVXCcWs41PWRMqbf3FUo
         viIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwj8xbw0bnEL25Qq4gmjxS00IOeAjG6GNQxAdbnWO2A=;
        b=oDb6gYKNvfzTxEuB5E19U5b/KsYxmV2WNh50Il56rb4GW+jhGAQC4FKi08O9EIwcbR
         MUrdyQgvOG7A0HVBGP+MI8JY/qIHX110rRxXFbc/P33Piq+kO4X3HKKgdkHjimR90wWb
         gdIdO5mCLi6zJCs1EaFxjK1DbDJ+lzgl/LU8pz6xGV7GeqfE8kGKw6W1vRB3IXB9lEa4
         uEluQychN6Zu/2Mi3ncRrt+p8sRHzWeInnFGArMqDaRHa45xocEYOrCQIE3ZBRyEmTkN
         3eJX1ll/CH0nW+BChY1lSuLVLMeEDa3sXY6F3Nv5KJc4h7RjbYC4dnZaHXyIhTrDPH5o
         z2qA==
X-Gm-Message-State: AFqh2kpZSAxOI/9AsRLF+6eN9ufewVVkXCEiMjooI1+k0cVvCC1JJnLV
        +W/RLdJOmn6cx0uvdQm9+YA9YrcV0ROIU/3iW5R2/Q==
X-Google-Smtp-Source: AMrXdXv6CeeFzN1+4R4tdHg/IKJ5C4l7PaOinzVK4PGVJM9c7GIhFphMdEPkr6ezjD9k28ifY1AtMqJwzv7bPIGABGE=
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr457605ybo.380.1673989527114; Tue, 17 Jan
 2023 13:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-19-surenb@google.com>
 <Y8a9+ywh65fmuKvv@dhcp22.suse.cz> <CAG48ez2Adwqs8Vvm3YUKwpx8qzV1wWtnUdWVo1UphjzADjMZQQ@mail.gmail.com>
In-Reply-To: <CAG48ez2Adwqs8Vvm3YUKwpx8qzV1wWtnUdWVo1UphjzADjMZQQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 13:05:15 -0800
Message-ID: <CAJuCfpHrRAQBPD68PFr0wcbV4fYTEYgxFj0AeeOn6W1sszw9xw@mail.gmail.com>
Subject: Re: [PATCH 18/41] mm/khugepaged: write-lock VMA while collapsing a
 huge page
To:     Jann Horn <jannh@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Tue, Jan 17, 2023 at 12:28 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Jan 17, 2023 at 4:25 PM Michal Hocko <mhocko@suse.com> wrote:
> > On Mon 09-01-23 12:53:13, Suren Baghdasaryan wrote:
> > > Protect VMA from concurrent page fault handler while collapsing a huge
> > > page. Page fault handler needs a stable PMD to use PTL and relies on
> > > per-VMA lock to prevent concurrent PMD changes. pmdp_collapse_flush(),
> > > set_huge_pmd() and collapse_and_free_pmd() can modify a PMD, which will
> > > not be detected by a page fault handler without proper locking.
> >
> > I am struggling with this changelog. Maybe because my recollection of
> > the THP collapsing subtleties is weak. But aren't you just trying to say
> > that the current #PF handling and THP collapsing need to be mutually
> > exclusive currently so in order to keep that assumption you have mark
> > the vma write locked?
> >
> > Also it is not really clear to me how that handles other vmas which can
> > share the same thp?
>
> It's not about the hugepage itself, it's about how the THP collapse
> operation frees page tables.
>
> Before this series, page tables can be walked under any one of the
> mmap lock, the mapping lock, and the anon_vma lock; so when khugepaged
> unlinks and frees page tables, it must ensure that all of those either
> are locked or don't exist. This series adds a fourth lock under which
> page tables can be traversed, and so khugepaged must also lock out that one.
>
> There is a codepath in khugepaged that iterates through all mappings
> of a file to zap page tables (retract_page_tables()), which locks each
> visited mm with mmap_write_trylock() and now also does
> vma_write_lock().
>
>
> I think one aspect of this patch that might cause trouble later on, if
> support for non-anonymous VMAs is added, is that retract_page_tables()
> now does vma_write_lock() while holding the mapping lock; the page
> fault handling path would probably take the locks the other way
> around, leading to a deadlock? So the vma_write_lock() in
> retract_page_tables() might have to become a trylock later on.
>
> Related: Please add the new VMA lock to the big lock ordering comments
> at the top of mm/rmap.c. (And maybe later mm/filemap.c, if/when you
> add file VMA support.)

Thanks for the clarifications and the warning. I'll add appropriate
comments and will take this deadlocking scenario into account when
later implementing support for file-backed page faults.
