Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906D36E7B48
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjDSNv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjDSNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:51:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69115449
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:51:45 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j11so21942543ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681912304; x=1684504304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8K9O3NGDLuB8eGkmt0nh/Mk9CAnezE0b6A2z9ynpitA=;
        b=trZq/c9Gu/5bsHxpqsoVsDxokcLhEpuIRk6O5e3P43crq1V5aPQ8lYGaYi9OAfsfmR
         j4Uu6wxQfLTGoyXzlsRzXvAikgGKfmbJuqKicY/0HISlPhMHjhLe1vVoVue0W9B9qITa
         UoWeStwJiLl0MnmBCOici7o+8LCn2K1MK3zHqdFLxS2TmIqJuVvL4keR49HCmRIrGjVa
         reTvu/fe5yGAboqmIYhbx4aY3GPxLH0+dHgjf/gOrxDxllOT7UkqfBJMAMyjdYLJXAem
         5qJdUZ6oo+dRD+kuEUPAlCZ6COPyrLyZMITGI+bVdTYOV8JkvQ9Ud18rpL3oTn3R1GYF
         5DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681912304; x=1684504304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8K9O3NGDLuB8eGkmt0nh/Mk9CAnezE0b6A2z9ynpitA=;
        b=D+rtTJBpDU7TNm7fJ0jeuiYQpi1JU400oPowQK/3b4K4LReHyj8bYCx5m8JxNyzJe5
         +193zdguYo6RA0FySoucFSQlpVGQ/eVxrETS2L2E7AFLStjprgFXTH6IZiFWqTCwvczR
         xeDZPDteVxbPs4q0VH4raPnYm/g+6anLdo6UelWuyZagLETeF5oRsizsEqB4uQFPksuT
         iWCfF54OpVqRYbTTpoysGRMxk4kojocO9HvEAJ/mg/E92SgrBljNz1aAT3u+tHZNsgVO
         k5uXZt+z2qQIBOUfl8KXsMSoE3FjqTaZmWA9JOQMvkXPFG8OxquP/mJ4ipeEatgfK/2F
         cMTw==
X-Gm-Message-State: AAQBX9dq/nv93gY5aS42K+cjR2aJvXyqJKWxs/ThmtZRHPGFPno6XXjz
        npX4R3p41cbENoB45E2/qw65O2SSMYlCchYDNBg3SA==
X-Google-Smtp-Source: AKy350Z1wS+9Vt3+jl+8uNC62msc9qdCvYF84r1dbCZWAOJhwvv6spoFybV5r19YXvyjQfa8pcECj8b4sKntUn4cfHY=
X-Received: by 2002:a2e:3e15:0:b0:2a7:82b5:24e7 with SMTP id
 l21-20020a2e3e15000000b002a782b524e7mr762264lja.1.1681912303657; Wed, 19 Apr
 2023 06:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230417051556epcas2p25b57d681bfae498b30ff33f0a96033d6@epcas2p2.samsung.com>
 <20230417051637.103964-1-hy50.seo@samsung.com> <CACT4Y+YnbfUdh5G6cXX2goP2VFfCx=Mr=_ZXAyGyLTHV1EqXwA@mail.gmail.com>
 <058901d971ab$b6a5b640$23f122c0$@samsung.com> <CACT4Y+Z_Yki4TVP5W8EwZbFf+YvOdo9geeN0nUYep1QsgMwiLw@mail.gmail.com>
 <CACT4Y+Z-HkzgJO2a-0ymq6sQo9X7T9sh6f6aNaeqe=X1LGqb5Q@mail.gmail.com> <07c701d972a8$187281d0$49578570$@samsung.com>
In-Reply-To: <07c701d972a8$187281d0$49578570$@samsung.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 19 Apr 2023 15:51:31 +0200
Message-ID: <CACT4Y+aReMGLYua2rCLHgFpS9io5cZC04Q8GLs-uNmrn1ezxYQ@mail.gmail.com>
Subject: Re: [PATCH v1] lib/stackdepot: limit nr_entries size
To:     hoyoung seo <hy50.seo@samsung.com>
Cc:     andreyknvl@gmail.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        vbabka@suse.cz, edumazet@google.com, longman@redhat.com,
        surenb@google.com, elver@google.com, glider@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 at 12:17, hoyoung seo <hy50.seo@samsung.com> wrote:
>
> > -----Original Message-----
> > From: Dmitry Vyukov <dvyukov@google.com>
> > Sent: Tuesday, April 18, 2023 3:54 PM
> > To: hoyoung seo <hy50.seo@samsung.com>
> > Cc: andreyknvl@gmail.com; osalvador@suse.de; akpm@linux-foundation.org;
> > linux-kernel@vger.kernel.org; linux-mm@kvack.org; mhocko@suse.com;
> > vbabka@suse.cz; edumazet@google.com; longman@redhat.com; surenb@google.com;
> > elver@google.com; glider@google.com
> > Subject: Re: [PATCH v1] lib/stackdepot: limit nr_entries size
> >
> > On Tue, 18 Apr 2023 at 08:10, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Tue, 18 Apr 2023 at 06:10, hoyoung seo <hy50.seo@samsung.com> wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Dmitry Vyukov <dvyukov@google.com>
> > > > > Sent: Monday, April 17, 2023 3:20 PM
> > > > > To: SEO HOYOUNG <hy50.seo@samsung.com>
> > > > > Cc: andreyknvl@gmail.com; osalvador@suse.de;
> > > > > akpm@linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > > linux-mm@kvack.org; mhocko@suse.com; vbabka@suse.cz;
> > > > > edumazet@google.com; longman@redhat.com; surenb@google.com;
> > > > > elver@google.com; glider@google.com
> > > > > Subject: Re: [PATCH v1] lib/stackdepot: limit nr_entries size
> > > > >
> > > > > On Mon, 17 Apr 2023 at 07:16, SEO HOYOUNG <hy50.seo@samsung.com>
> > wrote:
> > > > > >
> > > > > > While using the MCQ feature of UFS, dump stack was detected very
> > deeply.
> > > > > > If this continues to happen, depot_alloc_stack() will continue
> > > > > > to exceed STACK_ALLOC_SIZE and STACK_ALLOC_MAX_SLABS, eventually
> > > > > > resulting in the warning "Stack depot reached limit capacity".
> > > > > >
> > > > > > So want to limit the size of entries stored in it.
> > > > > > 25 is a test value, and we found that in a normal case, the
> > > > > > depth of the stack does not exceed 25.
> > > > > >
> > > > > > [ 2479.383395]I[0:launcher-loader: 1719] Stack depot reached
> > > > > > limit capacity [ 2479.383538]I[0:launcher-loader: 1719] WARNING:
> > CPU: 0 PID:
> > > > > > 1719 at lib/stackdepot.c:129 __stack_depot_save+0x464/0x46c [
> > > > > > 2479.385693]I[0:launcher-loader: 1719] pstate: 624000c5 (nZCv
> > > > > > daIF
> > > > > > +PAN -UAO +TCO -DIT -SSBS BTYPE=--) [ 2479.385724]I[0:launcher-
> > loader:
> > > > > > 1719] pc : __stack_depot_save+0x464/0x46c [
> > > > > > 2479.385751]I[0:launcher-loader: 1719] lr :
> > > > > > __stack_depot_save+0x460/0x46c [ 2479.385774]I[0:launcher-loader:
> > > > > > 1719] sp : ffffffc0080073c0 [ 2479.385793]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > x29: ffffffc0080073e0 x28: ffffffd00b78a000 x27:
> > > > > > 0000000000000000 [
> > > > > > 2479.385839]I[0:launcher-loader: 1719] x26: 000000000004d1dd x25:
> > > > > > ffffff891474f000 x24: 00000000ca64d1dd [
> > > > > > 2479.385882]I[0:launcher-loader: 1719] x23: 0000000000000200 x22:
> > > > > > 0000000000000220 x21: 0000000000000040 [
> > > > > > 2479.385925]I[0:launcher-loader: 1719] x20: ffffffc008007440 x19:
> > > > > > 0000000000000000 x18: 0000000000000000 [
> > > > > > 2479.385969]I[0:launcher-loader: 1719] x17: 2065726568207475 x16:
> > > > > 000000000000005e x15: 2d2d2d2d2d2d2d20 [ 2479.386013]I[0:launcher-
> > loader:
> > > > > 1719] x14: 5d39313731203a72 x13: 00000000002f6b30 x12:
> > > > > 00000000002f6af8 [ 2479.386057]I[0:launcher-loader: 1719] x11:
> > 00000000ffffffff x10:
> > > > > ffffffb90aacf000 x9 : e8a74a6c16008800 [ 2479.386101]I[0:launcher-
> > loader:
> > > > > 1719] x8 : e8a74a6c16008800 x7 : 00000000002f6b30 x6 :
> > > > > 00000000002f6af8 [ 2479.386145]I[0:launcher-loader: 1719] x5 :
> > ffffffc0080070c8 x4 :
> > > > > ffffffd00b192380 x3 : ffffffd0092b313c [ 2479.386189]I[0:launcher-
> > loader:
> > > > > 1719] x2 : 0000000000000001 x1 : 0000000000000004 x0 :
> > > > > 0000000000000022 [ 2479.386231]I[0:launcher-loader: 1719] Call trace:
> > > > > > [ 2479.386248]I[0:launcher-loader: 1719]
> > > > > > __stack_depot_save+0x464/0x46c [ 2479.386273]I[0:launcher-loader:
> > > > > > 1719]  kasan_save_stack+0x58/0x70 [ 2479.386303]I[0:launcher-
> > loader:
> > > > > > 1719]  save_stack_info+0x34/0x138 [ 2479.386331]I[0:launcher-
> > loader:
> > > > > > 1719]  kasan_save_free_info+0x18/0x24 [
> > > > > > 2479.386358]I[0:launcher-loader: 1719]
> > > > > > ____kasan_slab_free+0x16c/0x170 [ 2479.386385]I[0:launcher-loader:
> > > > > > 1719]  __kasan_slab_free+0x10/0x20 [ 2479.386410]I[0:launcher-
> > loader:
> > > > > > 1719]  kmem_cache_free+0x238/0x53c [ 2479.386435]I[0:launcher-
> > loader:
> > > > > > 1719]  mempool_free_slab+0x1c/0x28 [ 2479.386460]I[0:launcher-
> > loader:
> > > > > > 1719]  mempool_free+0x7c/0x1a0 [ 2479.386484]I[0:launcher-loader:
> > > > > > 1719]  bvec_free+0x34/0x80 [ 2479.386514]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > bio_free+0x60/0x98 [ 2479.386540]I[0:launcher-loader: 1719]
> > > > > > bio_put+0x50/0x21c [ 2479.386567]I[0:launcher-loader: 1719]
> > > > > > f2fs_write_end_io+0x4ac/0x4d0 [ 2479.386594]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > bio_endio+0x2dc/0x300 [ 2479.386622]I[0:launcher-loader: 1719]
> > > > > > __dm_io_complete+0x324/0x37c [ 2479.386650]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > dm_io_dec_pending+0x60/0xa4 [ 2479.386676]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > clone_endio+0xf8/0x2f0 [ 2479.386700]I[0:launcher-loader: 1719]
> > > > > > bio_endio+0x2dc/0x300 [ 2479.386727]I[0:launcher-loader: 1719]
> > > > > > blk_update_request+0x258/0x63c [ 2479.386754]I[0:launcher-loader:
> > > > > > 1719]  scsi_end_request+0x50/0x304 [ 2479.386782]I[0:launcher-
> > loader:
> > > > > > 1719]  scsi_io_completion+0x88/0x160 [
> > > > > > 2479.386808]I[0:launcher-loader: 1719]
> > > > > > scsi_finish_command+0x17c/0x194 [ 2479.386833]I[0:launcher-loader:
> > > > > > 1719]  scsi_complete+0xcc/0x158 [ 2479.386859]I[0:launcher-loader:
> > > > > > 1719]  blk_mq_complete_request+0x4c/0x5c [
> > > > > > 2479.386885]I[0:launcher-loader: 1719]
> > > > > > scsi_done_internal+0xf4/0x1e0 [ 2479.386910]I[0:launcher-loader:
> > > > > > 1719]  scsi_done+0x14/0x20 [
> > > > > > 2479.386935]I[0:launcher-loader: 1719]
> > > > > > ufshcd_compl_one_cqe+0x578/0x71c [ 2479.386963]I[0:launcher-loader:
> > > > > > 1719]  ufshcd_mcq_poll_cqe_nolock+0xc8/0x150
> > > > > > [ 2479.386991]I[0:launcher-loader: 1719]
> > > > > > ufshcd_intr+0x868/0xc0c [
> > > > > > 2479.387017]I[0:launcher-loader: 1719]
> > > > > > __handle_irq_event_percpu+0xd0/0x348
> > > > > > [ 2479.387044]I[0:launcher-loader: 1719]
> > > > > > handle_irq_event_percpu+0x24/0x74 [ 2479.387068]I[0:launcher-
> > loader:
> > > > > > 1719]  handle_irq_event+0x74/0xe0 [ 2479.387091]I[0:launcher-
> > loader:
> > > > > > 1719]  handle_fasteoi_irq+0x174/0x240 [
> > > > > > 2479.387118]I[0:launcher-loader: 1719]
> > > > > > handle_irq_desc+0x7c/0x2c0 [
> > > > > > 2479.387147]I[0:launcher-loader: 1719]
> > > > > > generic_handle_domain_irq+0x1c/0x28
> > > > > > [ 2479.387174]I[0:launcher-loader: 1719]
> > > > > > gic_handle_irq+0x64/0x158 [
> > > > > > 2479.387204]I[0:launcher-loader: 1719]
> > > > > > call_on_irq_stack+0x2c/0x54 [
> > > > > > 2479.387231]I[0:launcher-loader: 1719]
> > > > > > do_interrupt_handler+0x70/0xa0 [
> > > > > > 2479.387258]I[0:launcher-loader: 1719]  el1_interrupt+0x34/0x68
> > > > > > [
> > > > > > 2479.387283]I[0:launcher-loader: 1719]
> > > > > > el1h_64_irq_handler+0x18/0x24 [ 2479.387308]I[0:launcher-loader:
> > > > > > 1719]  el1h_64_irq+0x68/0x6c [
> > > > > > 2479.387332]I[0:launcher-loader: 1719]
> > > > > > blk_attempt_bio_merge+0x8/0x170 [ 2479.387356]I[0:launcher-loader:
> > > > > > 1719]  blk_mq_attempt_bio_merge+0x78/0x98
> > > > > > [ 2479.387383]I[0:launcher-loader: 1719]
> > > > > > blk_mq_submit_bio+0x324/0xa40 [ 2479.387409]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > __submit_bio+0x104/0x138 [ 2479.387436]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > submit_bio_noacct_nocheck+0x1d0/0x4a0
> > > > > > [ 2479.387462]I[0:launcher-loader: 1719]
> > > > > > submit_bio_noacct+0x618/0x804 [ 2479.387487]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > submit_bio+0x164/0x180 [ 2479.387511]I[0:launcher-loader: 1719]
> > > > > > f2fs_submit_read_bio+0xe4/0x1c4 [ 2479.387537]I[0:launcher-loader:
> > > > > > 1719]  f2fs_mpage_readpages+0x888/0xa4c [
> > > > > > 2479.387563]I[0:launcher-loader: 1719]
> > > > > > f2fs_readahead+0xd4/0x19c [
> > > > > > 2479.387587]I[0:launcher-loader: 1719]  read_pages+0xb0/0x4ac [
> > > > > > 2479.387614]I[0:launcher-loader: 1719]
> > > > > > page_cache_ra_unbounded+0x238/0x288
> > > > > > [ 2479.387642]I[0:launcher-loader: 1719]
> > > > > > do_page_cache_ra+0x60/0x6c [
> > > > > > 2479.387669]I[0:launcher-loader: 1719]
> > > > > > page_cache_ra_order+0x318/0x364 [ 2479.387695]I[0:launcher-loader:
> > > > > > 1719]  ondemand_readahead+0x30c/0x3d8 [
> > > > > > 2479.387722]I[0:launcher-loader: 1719]
> > > > > > page_cache_sync_ra+0xb4/0xc8 [
> > > > > > 2479.387749]I[0:launcher-loader: 1719]  filemap_read+0x268/0xd24
> > > > > > [
> > > > > > 2479.387777]I[0:launcher-loader: 1719]
> > > > > > f2fs_file_read_iter+0x1a0/0x62c [ 2479.387806]I[0:launcher-loader:
> > > > > > 1719]  vfs_read+0x258/0x34c [ 2479.387831]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > ksys_pread64+0x8c/0xd0 [ 2479.387857]I[0:launcher-loader: 1719]
> > > > > > __arm64_sys_pread64+0x48/0x54 [ 2479.387881]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > invoke_syscall+0x58/0x158 [ 2479.387909]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > el0_svc_common+0xf0/0x134 [ 2479.387935]I[0:launcher-loader:
> > > > > > 1719]
> > > > > > do_el0_svc+0x44/0x114 [ 2479.387961]I[0:launcher-loader: 1719]
> > > > > > el0_svc+0x2c/0x80 [ 2479.387985]I[0:launcher-loader: 1719]
> > > > > > el0t_64_sync_handler+0x48/0x114 [
> > > > > > 2479.388010]I[0:launcher-loader: 1719]
> > > > > el0t_64_sync+0x190/0x194 [ 2479.388038]I[0:launcher-loader: 1719]
> > > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > > > >
> > > > > > Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
> > > > > > ---
> > > > > >  lib/stackdepot.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c index
> > > > > > 2f5aa851834e..f158729598a6 100644
> > > > > > --- a/lib/stackdepot.c
> > > > > > +++ b/lib/stackdepot.c
> > > > > > @@ -43,6 +43,7 @@
> > > > > >  #define DEPOT_MAX_POOLS \
> > > > > >         (((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
> > > > > >          (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
> > > > > > +#define DEPO_MAX_DEPTH 25
> > > > > >
> > > > > >  /* Compact structure that stores a reference to a stack. */
> > > > > > union handle_parts { @@ -375,7 +376,7 @@ depot_stack_handle_t
> > > > > > __stack_depot_save(unsigned long *entries,
> > > > > >          * filter_irq_stacks() to simplify all callers' use of stack
> > depot.
> > > > > >          */
> > > > > >         nr_entries = filter_irq_stacks(entries, nr_entries);
> > > > > > -
> > > > > > +       nr_entries = nr_entries > DEPO_MAX_DEPTH ? DEPO_MAX_DEPTH :
> > > > > > + nr_entries;
> > > > > >         if (unlikely(nr_entries == 0) || stack_depot_disabled)
> > > > > >                 goto fast_exit;
> > > > >
> > > > > Hi SEO,
> > > > >
> > > > > The stack overflow errors are related to total number of stacks
> > > > > rather than size of a single stack.
> > > > >
> > > > > filter_irq_stacks() is somehow not working in your case. It's
> > > > > supposed to strip stacks somewhere around el1_interrupt (on
> > > > > interrupt entry), but it's failing to do it.
> > > > > As a result you are getting an effectively infinite amount of
> > > > > random stacks saved.
> > > > >
> > > > >  You need to debug why filter_irq_stacks() is failing in your case
> > > > > and fix that instead.
> > > >
> > > > Hi Vyukov.
> > > >
> > > > Thanks your reply.
> > > > As you say, the filter_irq_stacks()  doesn't seem to be work correctly.
> > > > I checked by print a symbol name, and it looks like the filter itself
> > is wrong.
> > > > __irqentry_text_start -> _stext+0x0/0x66c __irqentry_text_end ->
> > > > _stext+0x0/0x66c
> > > >
> > > > __softirqentry_text_start -> _stext+0x0/0x66c
> > > > __softirqentry_text_end -> __softirqentry_text_end+0x0/0x4 Do you
> > > > have the symbol name you were originally expecting?
> > > >
> > > > The problem seems to be caused by not riding the call stack defined
> > > > by __irqentry_text_start, __irqentry_text_end when h/w irq occurs in
> > our driver.
> > > > If you can tell us the call stack names defined by
> > > > __irqentry_text_start, __irqentry_text_end, it will help us to solve
> > the problem.
> > >
> > > These __irqentry_text_start/end markers should contain all irq entry
> > functions.
> > >
> > > For example, for a random x86 kernel I see:
> > >
> > > $ nm -ngS vmlinux | grep -C 3 irqentry_text
> > > ffffffff8aaeffc0 00000000000008d9 T __do_softirq
> > > ffffffff8aaeffc0 T __kprobes_text_end
> > > ffffffff8aaeffc0 T __kprobes_text_start
> > > ffffffff8aaeffc0 T __softirqentry_text_start
> > > ffffffff8aaf0899 T __softirqentry_text_end
> > > ffffffff8aaf08a0 0000000000000008 T __SCT__tp_func_initcall_level
> > > ffffffff8aaf08a0 T __static_call_text_start
> > > ffffffff8aaf08a8 0000000000000008 T __SCT__tp_func_initcall_start
> > > --
> > > ffffffff8ac0013f T entry_SYSRETQ_end
> > > ffffffff8ac00140 0000000000000049 T xen_error_entry
> > > ffffffff8ac00190 0000000000000cc0 T irq_entries_start
> > > ffffffff8ac00190 T __irqentry_text_start
> > > ffffffff8ac00e50 0000000000000140 T spurious_entries_start
> > > ffffffff8ac00f90 000000000000001f T asm_exc_divide_error
> > > ffffffff8ac00fb0 000000000000001f T asm_exc_overflow
> > > --
> > > ffffffff8ac01570 000000000000001f T
> > > asm_sysvec_kvm_posted_intr_wakeup_ipi
> > > ffffffff8ac01590 000000000000001f T
> > > asm_sysvec_kvm_posted_intr_nested_ipi
> > > ffffffff8ac015b0 000000000000001f T asm_sysvec_kvm_asyncpf_interrupt
> > > ffffffff8ac015d0 T __irqentry_text_end
> > > ffffffff8ac015d0 T swapgs_restore_regs_and_return_to_usermode
> > > ffffffff8ac01624 T restore_regs_and_return_to_kernel
> > > ffffffff8ac01646 T native_irq_return_iret
> > >
> > >
> > > So the __softirqentry_text_start/end range includes only __do_softirq
> > symbol.
> > >
> > > And __irqentry_text_start/end includes asm_exc_divide_error,
> > > asm_exc_overflow, etc.
> > >
> > > This looks reasonable.
> > >
> > > Now for a random arm64 kernel I see this:
> > >
> > > $ nm -nS vmlinux | grep -v "\$x" | grep -C 3 irqentry_text
> > > ffff800008000008 t $d.1
> > > ffff800008010008 000000000000000c t __primary_entry_veneer
> > > ffff800008020000 0000000000000158 t dw_apb_ictl_handle_irq
> > > ffff800008020000 T __irqentry_text_start
> > > ffff800008020000 T _stext
> > > ffff80000802015c 0000000000000d2c T __do_softirq ffff80000802015c T
> > > __irqentry_text_end ffff80000802015c T __softirqentry_text_start
> > > ffff800008020ebc T __entry_text_start ffff800008020ebc T
> > > __softirqentry_text_end
> > > ffff800008021000 0000000000000800 T vectors
> > > ffff800008021800 000000000000007c t __bad_stack ffff80000802187c
> > > 0000000000000068 t el1t_64_sync
> > >
> > > So the __softirqentry_text_start/end range also includes only
> > > __do_softirq symbol.
> > >
> > > And __irqentry_text_start/end includes only dw_apb_ictl_handle_irq.
> > >
> > > I don't know if it's correct for arm64 kernel or not (are there other
> > > irq entry points?).
> > >
> > > If you have other entry points, I think you need to mark them with
> > > __irq_entry macro, which should place them in the section:
> > >
> > > https://protect2.fireeye.com/v1/url?k=e5293872-bab2017e-e528b33d-000ba
> > > bff3563-94c53fd7694dcd3a&q=1&e=9b2ec3db-ced2-42c4-bb11-582c6c482a74&u=
> > > https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Finclude%2
> > > Flinux%2Finterrupt.h%23L829
> > > https://protect2.fireeye.com/v1/url?k=89e07580-d67b4c8c-89e1fecf-000ba
> > > bff3563-69146773540d4a4e&q=1&e=9b2ec3db-ced2-42c4-bb11-582c6c482a74&u=
> > > https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2FA%2Fident%2F__irq_
> > > entry
> >
> > Found examples of proper cut points for irq/softirq for arm64 on syzbot:
> >
> > https://protect2.fireeye.com/v1/url?k=67579613-38ccaf1f-67561d5c-
> > 000babff3563-eef46465f98ddbdb&q=1&e=9b2ec3db-ced2-42c4-bb11-
> > 582c6c482a74&u=https%3A%2F%2Fsyzkaller.appspot.com%2Ftext%3Ftag%3DCrashRep
> > ort%26x%3D131be6be880000
> > Freed by task 2264:
> >  kasan_save_stack+0x2c/0x60 mm/kasan/common.c:45
> >  kasan_set_track+0x2c/0x40 mm/kasan/common.c:52
> > kasan_save_free_info+0x38/0x5c mm/kasan/generic.c:511  ____kasan_slab_free
> > mm/kasan/common.c:236 [inline]
> >  ____kasan_slab_free+0x124/0x1f0 mm/kasan/common.c:200
> >  __kasan_slab_free+0x18/0x24 mm/kasan/common.c:244  kasan_slab_free
> > include/linux/kasan.h:177 [inline]  slab_free_hook mm/slub.c:1724 [inline]
> > slab_free_freelist_hook+0x9c/0x1bc mm/slub.c:1750  slab_free
> > mm/slub.c:3661 [inline]
> >  __kmem_cache_free+0xa4/0x370 mm/slub.c:3674
> >  kfree+0xdc/0x284 mm/slab_common.c:1007
> >  rcu_free_wq+0x9c/0x10c kernel/workqueue.c:3531  rcu_do_batch
> > kernel/rcu/tree.c:2250 [inline]
> >  rcu_core+0x874/0x1b50 kernel/rcu/tree.c:2510  rcu_core_si+0x10/0x1c
> > kernel/rcu/tree.c:2527  _stext+0x28c/0x107c
> >
> >
> > https://protect2.fireeye.com/v1/url?k=8dc95e89-d2526785-8dc8d5c6-
> > 000babff3563-c398fcc416434337&q=1&e=9b2ec3db-ced2-42c4-bb11-
> > 582c6c482a74&u=https%3A%2F%2Fsyzkaller.appspot.com%2Ftext%3Ftag%3DCrashRep
> > ort%26x%3D1147006cc80000
> > Freed by task 21:
> > ...
> >  skb_release_all net/core/skbuff.c:916 [inline]  __kfree_skb
> > net/core/skbuff.c:930 [inline]  consume_skb+0xa4/0x17c
> > net/core/skbuff.c:1098
> >  mac80211_hwsim_tx_frame+0x1cc/0x1f8
> > drivers/net/wireless/mac80211_hwsim.c:2054
> >  mac80211_hwsim_beacon_tx+0x4f0/0x8ec
> > drivers/net/wireless/mac80211_hwsim.c:2116
> >  __iterate_interfaces+0x204/0x460 net/mac80211/util.c:763
> >  ieee80211_iterate_active_interfaces_atomic+0xb4/0x140
> > net/mac80211/util.c:799
> >  mac80211_hwsim_beacon+0xcc/0x1c8
> > drivers/net/wireless/mac80211_hwsim.c:2142
> >  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
> >  __hrtimer_run_queues+0x580/0x10a8 kernel/time/hrtimer.c:1749
> >  hrtimer_run_softirq+0x158/0x220 kernel/time/hrt
>
> Hi Vyukov
>
> Thank you for your help.
> We have resolved the issue. It was caused by not setting
> CONFIG_FUNCTION_TRACER, CONFIG_FUNCTION_GRAPH_TRACER.
> So filter_irq_stacks() does not truncate the irqentry stack.
> It looks like I have to set that CONFIG to required to enable KASAN.
> How about making CONFIG_FUNCTION_TRACER and CONFIG_FUNCTION set to
> default when enabling KASAN?

You mean that entry functions are not added to
__irqentry_text_start/end without these configs?
If yes, then it may be better to always add functions to
__irqentry_text_start/end even if CONFIG_FUNCTION_TRACER is not
enabled.
