Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D9E5BB738
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 10:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIQIZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 04:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIQIZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 04:25:23 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0D2A27A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 01:25:21 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id q26so19501138vsr.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 01:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OWnkPdXKu3Vra2dQWOvgwi58h1KBjnOZlFX9hnEdd7Q=;
        b=JDr1TzcMbmAMAChokHfQnOl3YbvJYwLwo4eptnMbgpTg/AvbiP1G/E0uB0hL1E/PKB
         j7z6kL3QPv7tJzN852LdOY3wvt42yG8KffAy5/xPRAr9YM/uEfaQRlhYtA0WEu2DbNiN
         sEs1lgKpTB6hT9tb0LB3p0LAhSApEeicFFB28aTUzGMtSG8tmP12xmnrI7Ra+GS52/tL
         Bh+u3T9SPc5zJRZyuKabce5hzwOcVSKCFR5lG5jGOS8KCJgt3hQOIDqiWFvUAI1MxKS7
         ON5v0tC6kiOOuvIiijapd8QDhTtzVaiAU5e1H6lIT/Q00JIvz9SgaB/W6MIHNGvb8S90
         Za0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OWnkPdXKu3Vra2dQWOvgwi58h1KBjnOZlFX9hnEdd7Q=;
        b=kO6gq2MQKoWTR8Nx/J5To68JJGX5kkTzg2ThH7spfKyoW+3Hh8WoGxtSWGwY+YMGaW
         mKqMgwsP5vpY7C71egMpaxtlVl9RaL9rrK2DpZhOq9PcDIJaMLiCj0BciDykn2IUzB5L
         MF3tganlB7bx7kvwQuqoOzN7ITPFfSriej/j/MftJp8JV/r4U85vrKXgKOVeMnZ8cxpQ
         aCL1TXIOFJru/29GvkZR+UId2lLUP2IFiEDMHwsa6KOj9ObcHaCobnjFbhxVvChACEp9
         lQS1eznHfD69O/qGOzMn8n29M13xsuUeW7TdAZgfKwwt+orPO6CyypZ/DJMeAeRwoaeL
         lK2Q==
X-Gm-Message-State: ACrzQf3PgWMRPjI5IcBkEG1XJMr3M1OZHFpyGyyOcnlKIn6DHlHwTTYq
        /mNJcbz1kzTQQ00v+yrILaqwSj8buSSIR2KrDV1P3HiB3u50Hg==
X-Google-Smtp-Source: AMsMyM5tw7tey7pw+h3W7lbyoEHyV4uKxGVlol1rnMiFY9PpvXjI3oFhOU2gjjg24sbixaCFvbqa0KVVN2Tnyf7401w=
X-Received: by 2002:a05:6102:3309:b0:39a:e5eb:8508 with SMTP id
 v9-20020a056102330900b0039ae5eb8508mr123939vsc.65.1663403120873; Sat, 17 Sep
 2022 01:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220911172051.ff5faed962c365e203790137@linux-foundation.org> <CAOUHufbeh=v6gFuxyOA5xOtahL1AGUQYgQZzB7edDaS3hoc-LQ@mail.gmail.com>
In-Reply-To: <CAOUHufbeh=v6gFuxyOA5xOtahL1AGUQYgQZzB7edDaS3hoc-LQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 17 Sep 2022 02:24:44 -0600
Message-ID: <CAOUHufZabH85CeUN-MEMgL8gJGzJEWUrkiM58JkTbBhh-jew0Q@mail.gmail.com>
Subject: Re: [PATCH v14 00/70] Introducing the Maple Tree
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Thu, Sep 15, 2022 at 12:03 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Sun, Sep 11, 2022 at 6:20 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 6 Sep 2022 19:48:38 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> >
> > > Patch series "Introducing the Maple Tree".
> >
> > I haven't seen any issues attributed to maple tree in 2+ weeks.  Unless
> > there be weighty objections, I plan to move this series into mm-stable
> > soon after mglru is added.  Perhaps a week from now.
>
> Tested-by: Yu Zhao <yuzhao@google.com>
>
> stress/fuzzing: arm64, mips64, ppc64 and x86_64
> performance: arm64 (nodejs), mips64 (memcached), ppc64 (specjbb2015)
> and x86_64 (mmtests)
> boot: riscv64
> not covered: m68knommu and s390 (no hardware available)

This should be easy to fix:

  ======================================================
  WARNING: possible circular locking dependency detected
  6.0.0-dbg-DEV #1 Tainted: G S         O
  ------------------------------------------------------
  stress-ng/21813 is trying to acquire lock:
  ffffffff9b043388 (fs_reclaim){+.+.}-{0:0}, at:
kmem_cache_alloc_bulk+0x3f/0x460

  but task is already holding lock:
  ffffa2a509f8d080 (&anon_vma->rwsem){++++}-{3:3}, at: do_brk_flags+0x19d/0x410

  which lock already depends on the new lock.


  the existing dependency chain (in reverse order) is:

  -> #1 (&anon_vma->rwsem){++++}-{3:3}:
         down_read+0x3c/0x50
         folio_lock_anon_vma_read+0x147/0x180
         rmap_walk_anon+0x55/0x230
         try_to_unmap+0x65/0xa0
         shrink_folio_list+0x8c5/0x1c70
         evict_folios+0x6af/0xb50
         lru_gen_shrink_lruvec+0x1b6/0x430
         shrink_lruvec+0xa7/0x470
         shrink_node_memcgs+0x116/0x1f0
         shrink_node+0xb4/0x2e0
         balance_pgdat+0x3b9/0x710
         kswapd+0x2b1/0x320
         kthread+0xe5/0x100
         ret_from_fork+0x1f/0x30

  -> #0 (fs_reclaim){+.+.}-{0:0}:
         __lock_acquire+0x16f4/0x30c0
         lock_acquire+0xb2/0x190
         fs_reclaim_acquire+0x57/0xd0
         kmem_cache_alloc_bulk+0x3f/0x460
         mas_alloc_nodes+0x148/0x1e0
         mas_nomem+0x45/0x90
         mas_store_gfp+0xf3/0x160
         do_brk_flags+0x1f2/0x410
         __do_sys_brk+0x214/0x3b0
         __x64_sys_brk+0x12/0x20
         do_syscall_64+0x3d/0x80
         entry_SYSCALL_64_after_hwframe+0x63/0xcd

  other info that might help us debug this:

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&anon_vma->rwsem);
                                 lock(fs_reclaim);
                                 lock(&anon_vma->rwsem);
    lock(fs_reclaim);

   *** DEADLOCK ***

  2 locks held by stress-ng/21813:
   #0: ffffa285087f2a58 (&mm->mmap_lock#2){++++}-{3:3}, at:
__do_sys_brk+0x98/0x3b0
   #1: ffffa2a509f8d080 (&anon_vma->rwsem){++++}-{3:3}, at:
do_brk_flags+0x19d/0x410
