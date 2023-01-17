Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C266E78B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjAQUL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjAQUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:07:18 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676BF3FF19
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:01:19 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4c131bede4bso436004177b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LIZZvFyQtXHixD5sWfvEaQUvi24ljYnGZNh2fBEIyp4=;
        b=CjLP+GN4eJ8YGFZvjoqXnYn0mL/Nm9o57f+7WOJDJDHEjmOn/4ZZF6+enYJUFh56p6
         ZjMUPNGSRgQRosE3EMtoX1RXdV9HlQD3govS4EbUA9vX5E0lvyII7jNgKbkxa9q55Ofi
         5fHxRCrBasHddp+A5FhlnIGxMd1HsMsFjjUSptfu2Xn/GYum5SsgoXsfxk+bQ6S1eMxn
         TjquS1QRX6eEGqUoWMTLZ0Uen7LLC6vfFjMFZvmVjQlE+SMKypaTTEwOKRHnLLugiZMU
         Ca7UGjlXIklsuObkggD1KlRzV4LfytQE7UWnMkJIywJkawE+81OksYcPHkL0icjcL46L
         ZAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIZZvFyQtXHixD5sWfvEaQUvi24ljYnGZNh2fBEIyp4=;
        b=k3XtvN9KtVQaimpV4ThfrF4s2x8dQbKe8JWDVNJ2CxQPYqj6m5y75L0oz67n/y6UJR
         Agz8pB69BjSJZDfMexqd8xyEoRYO0gmmnMpBdQJXAZjTq0MCDObxEcq5os2+vJwLgzri
         b3CjjIEdtdhRNp+WXCJydVSYEpxDJT0H4p0zBpqtHRvXYzCK+qYG0U7UjKovjlZkdQqX
         7TQzWyfiKciKte1oufqazF8Cmh9k0XiHRvQ7sRm6V3Pb2AGPLkb0l05oZNVrwZWHHB4c
         wXEbaaLi5IRFwyezrGq1Lo+E6gcY1OC3D6VPkcLckhbYK6IfOpf/GbaBMNYbsg0Zpsny
         DcOw==
X-Gm-Message-State: AFqh2koozn9jdZ1Lrjcfxbw7AiuJJmW/rPwoOLHvFgi7B/Vz1PfmaBf0
        TQgGKmnKPv078+AM/xLyHlg+BUhrwhzHroKSxMRIEg==
X-Google-Smtp-Source: AMrXdXuXSHUCPjq8vGtgRecAo+K4qxgIc9+GydwwGOLIiPEqHLP5AyNSTg15twzR8exVpLWal97Wzf6SyesXXn7pY10=
X-Received: by 2002:a81:9105:0:b0:3dc:fd91:ef89 with SMTP id
 i5-20020a819105000000b003dcfd91ef89mr459982ywg.347.1673982078402; Tue, 17 Jan
 2023 11:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-41-surenb@google.com>
 <CAG48ez1=-tY8nrsX+T=AJBmW05E8sAvZNj80Wev9sGwR9NZysQ@mail.gmail.com>
In-Reply-To: <CAG48ez1=-tY8nrsX+T=AJBmW05E8sAvZNj80Wev9sGwR9NZysQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 11:01:07 -0800
Message-ID: <CAJuCfpHSZouW44MqdZxpAB_NAdimdU2kcZ2sDo2mfNCf_nmL3w@mail.gmail.com>
Subject: Re: [PATCH 40/41] mm: separate vma->lock from vm_area_struct
To:     Jann Horn <jannh@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
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

On Tue, Jan 17, 2023 at 10:34 AM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > vma->lock being part of the vm_area_struct causes performance regression
> > during page faults because during contention its count and owner fields
> > are constantly updated and having other parts of vm_area_struct used
> > during page fault handling next to them causes constant cache line
> > bouncing. Fix that by moving the lock outside of the vm_area_struct.
> > All attempts to keep vma->lock inside vm_area_struct in a separate
> > cache line still produce performance regression especially on NUMA
> > machines. Smallest regression was achieved when lock is placed in the
> > fourth cache line but that bloats vm_area_struct to 256 bytes.
>
> Just checking: When you tested putting the lock in different cache
> lines, did you force the slab allocator to actually store the
> vm_area_struct with cacheline alignment (by setting SLAB_HWCACHE_ALIGN
> on the slab or with a ____cacheline_aligned_in_smp on the struct
> definition)?

Yep, I tried all these combinations and still saw noticeable regression.
