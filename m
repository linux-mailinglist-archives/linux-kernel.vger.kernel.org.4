Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF46A0F02
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjBWSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBWSEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:04:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E9C55C09
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:04:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i34so19950398eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=USwxvTrM3itz7MA/18FaPbrVGvaCj22AfDbh21ZkNzo=;
        b=BhTeM1KHPOiptIazaVYWZ4TGpZCI3Iui0ngWB6eT0QeLw3/KHRkUGPvpKPPYJxhlnO
         NDPPOe0WuiZKWa7BgQM8O/0xv3ESGdUO1ScZfovh1kfSoZTrAN0yP0WgT+6kzNWAn7Bi
         dlc4rYkysGymNVLdZdBUXgsGHTKpLkcIgo+UKDhMc1VgBZVmSrd3WUN7Ph8QdE9s5OF6
         fdPLSGbTNGyuE7Jzkc+FB9u78owmdgvub7Vp9a0vBCR0KkVX8SpThqay5zCYt6ZY+1jH
         7VIubHXsT2NOpaCJ/rtJK/L9Eq9tVCW+5Q1FZQ0ij6uyqm4vr7VKfpVLT2k3L8kQWIKv
         16mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USwxvTrM3itz7MA/18FaPbrVGvaCj22AfDbh21ZkNzo=;
        b=hS37UV22m5T8dICGRDeicprKOba5SZUZygq8hiXMSlueUWkD+8F27kXuDjzi1xfD0t
         eoagIyHd/sfuTf3UR2yRJANsqAOWklBY4CAQmdV843XqgPwOBK4qOhnWIfHeqNbOOLS9
         nUC3Z5rXoDDktACGIyqQz6YRKqxIHWYqoPb2ap8g9HMMH1XpSyLYXbwLLZFxf1JA6hkF
         3nxZChdcpsyeOByCEC0uFkEUJiDyPZUcDVNAx31b+NKEoGqK3+CwwrZm6H1YyTr0JQx+
         1mrx22YD6TJSk+QDRje66ONTDROjac1WS9AGaj4A+sFcD7OqVm4/n8SDUnzn1MVW3JHM
         ilnw==
X-Gm-Message-State: AO0yUKXhWlnuP/+pnD70Rx0vRi7/cb0WcWRNOSs1nVN6FT4sUQ5FtOPl
        pl0mMc4GKrrj6+j3sjjqpwjhuRSDzow4YmtATx11TyFhHpdYYhEGrcM=
X-Google-Smtp-Source: AK7set/PJNzgjTo1sYVS/ZVGj9bU9ocB71ixYAEGo96NUqMqWqi9x45N5eF1dL/eqPotSJPmg2BbB5m+VXz+sduUm9k=
X-Received: by 2002:a17:906:3b47:b0:87a:3b3f:b9da with SMTP id
 h7-20020a1709063b4700b0087a3b3fb9damr10156763ejf.10.1677175467829; Thu, 23
 Feb 2023 10:04:27 -0800 (PST)
MIME-Version: 1.0
References: <Y/UEkNn0O65Pfi4e@nvidia.com> <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com> <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com> <87o7pmnd0p.fsf@nvidia.com> <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com> <Y/bHNO7A8T3QQ5T+@nvidia.com> <CABdmKX18MY19bnsxN5W38Z9zmoaZx+S4+zzN_5XCYDBruwPrLg@mail.gmail.com>
 <Y/eiLBo88pgr2IUm@nvidia.com>
In-Reply-To: <Y/eiLBo88pgr2IUm@nvidia.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Feb 2023 10:03:50 -0800
Message-ID: <CAJD7tkadBRP22qP63-SjKSch1im9sHLoMzc6c2h10+ggbuxqMg@mail.gmail.com>
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

On Thu, Feb 23, 2023 at 9:28 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Feb 23, 2023 at 09:18:23AM -0800, T.J. Mercier wrote:
>
> > > Solving that problem means figuring out when every cgroup stops using
> > > the memory - pinning or not. That seems to be very costly.
> > >
> > This is the current behavior of accounting for memfds, and I suspect
> > any kind of shared memory.
> >
> > If cgroup A creates a memfd, maps and faults in pages, shares the
> > memfd with cgroup B and then A unmaps and closes the memfd, then
> > cgroup A is still charged for the pages it faulted in.
>
> As we discussed, as long as the memory is swappable then eventually
> memory pressure on cgroup A will evict the memfd pages and then cgroup
> B will swap it in and be charged for it.

I am not familiar with memfd, but based on
mem_cgroup_swapin_charge_folio() it seems like if cgroup B swapped in
the pages they will remain charged to cgroup A, unless cgroup A is
removed/offlined. Am I missing something?

>
> > FWIW this is also the behavior I was trying to use to attribute
> > dma-buffers to their original allocators. Whoever touches it first
> > gets charged as long as the memory is alive somewhere.
> >
> > Can't we do the same thing for pins?
>
> If pins are tracked independently from memcg then definately not,
> a process in cgroup A should never be able to make a charge on cgroup
> B as a matter of security.
>
> If pins are part of the memcg then we can't always turn the pin
> request in to a NOP - the current cgroup always has to be charged for
> the memory. Otherwise what is the point from a security perspective?
>
> Jason
