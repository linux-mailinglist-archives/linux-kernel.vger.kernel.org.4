Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE336A0F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjBWSOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBWSOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:14:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD0B55060
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:14:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cq23so45098002edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VG9TRi7KY1FPj+JgMoZ9/Bap5BH1LM2HcOOT/7ev4eA=;
        b=D2wc9ublqoinhiPSET5Dt0IY9YkjUb0e1mbrI5aveVWbYaT5mTOY1SmpkdzdcDCXhy
         0tKgbqq35FTY2mCV9OliNawcLPyYie3JC/ov3fv+B8xEzv008yfXCoExBDaHBPUFIGQ9
         XcSO0t72+wVLJSh7AyZjyJdtIqHS30Q6JS3FZAWYfJQCWaOeuiKlk7PWsh5/OSZrnz5S
         hHJwPirimq5+UX1iA5mmqF6u7koMXvksCK4sS9mgfpt+uQJwsnQSVfzocj0q4CNGiWOc
         29XttugOluiL6gDHvkBeGMLGDVE5ZWt+GrVdqPTAnU4uE3qHk1suzlCFjuCHJJfJismS
         +Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VG9TRi7KY1FPj+JgMoZ9/Bap5BH1LM2HcOOT/7ev4eA=;
        b=V5v+lWeKAlsZaWWHxdb0f/TU1A989R392s3BR/F5FhUkHoeAQoKm6nYapoj9LtditO
         nXKW+6gPe6Bw3lb/gxzklpR8HgzwtjzxuKGCNr1s1C71cIZ2F35nlsss0FViaxNIzI1g
         J4iykxQ4kV6o3STx9uLxcqCcu7oR2bwpuSGU8ProewsMP4TmaBy2BZaJyAfx+tAAiiiA
         a886UW6WAz6vY9eitCdZoc5ITN/HIUnBONVTtk4DWpj78VZq+0aMCCqf7SeWBCfK8/KR
         dotTtglIwMoUz384C9Cpy6CvU654+QvNU+n9c3VCrqHd3v8gShmlQvuV9YB8uJWpi1M7
         N9rA==
X-Gm-Message-State: AO0yUKWdj/BWsbE+l1pPrtut8XQ5JGct/AXsZ1ZAzB5gZxynJ6jjiEzR
        gzSydNb7LmXQWE34ALf2MVoFMoeOVp+oeqipQcdK+g==
X-Google-Smtp-Source: AK7set/fznoiZVzWuf/NgldnM/1EIBNaNGC+xwH7MsYZEI1nAXsD+W5oxnFFkoYiFjJHmikErXMuBVLtqBs4WAeI1M4=
X-Received: by 2002:a17:907:c907:b0:8d8:4578:18e0 with SMTP id
 ui7-20020a170907c90700b008d8457818e0mr5898667ejc.10.1677176080683; Thu, 23
 Feb 2023 10:14:40 -0800 (PST)
MIME-Version: 1.0
References: <Y/Ua6VcNe/DFh7X4@nvidia.com> <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com> <87o7pmnd0p.fsf@nvidia.com> <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com> <Y/bHNO7A8T3QQ5T+@nvidia.com> <CABdmKX18MY19bnsxN5W38Z9zmoaZx+S4+zzN_5XCYDBruwPrLg@mail.gmail.com>
 <Y/eiLBo88pgr2IUm@nvidia.com> <CAJD7tkadBRP22qP63-SjKSch1im9sHLoMzc6c2h10+ggbuxqMg@mail.gmail.com>
 <Y/esMBOyTaJnv5CW@nvidia.com>
In-Reply-To: <Y/esMBOyTaJnv5CW@nvidia.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Feb 2023 10:14:04 -0800
Message-ID: <CAJD7tkZHZrxK_szH=5tdDZzhDTNXpBVD-e+79RzFmpp_ZYMcBA@mail.gmail.com>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:11 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Feb 23, 2023 at 10:03:50AM -0800, Yosry Ahmed wrote:
> > On Thu, Feb 23, 2023 at 9:28 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Thu, Feb 23, 2023 at 09:18:23AM -0800, T.J. Mercier wrote:
> > >
> > > > > Solving that problem means figuring out when every cgroup stops using
> > > > > the memory - pinning or not. That seems to be very costly.
> > > > >
> > > > This is the current behavior of accounting for memfds, and I suspect
> > > > any kind of shared memory.
> > > >
> > > > If cgroup A creates a memfd, maps and faults in pages, shares the
> > > > memfd with cgroup B and then A unmaps and closes the memfd, then
> > > > cgroup A is still charged for the pages it faulted in.
> > >
> > > As we discussed, as long as the memory is swappable then eventually
> > > memory pressure on cgroup A will evict the memfd pages and then cgroup
> > > B will swap it in and be charged for it.
> >
> > I am not familiar with memfd, but based on
> > mem_cgroup_swapin_charge_folio() it seems like if cgroup B swapped in
> > the pages they will remain charged to cgroup A, unless cgroup A is
> > removed/offlined. Am I missing something?
>
> Ah, I don't know, Tejun said:
>
> "but it can converge when page usage transfers across cgroups
> if needed."
>
> Which I assumed was swap related but I don't know how convergence
> works.

I believe that's the case for file-backed pages, but I do not believe
it's the case for swap-backed pages.

>
> Jason
