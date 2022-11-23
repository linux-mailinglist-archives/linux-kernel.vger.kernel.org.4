Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71C4636C71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiKWVfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238437AbiKWVfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:35:51 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744BAAD9BC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:35:50 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z9so12862ilu.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EX+iSv5Kmy5pWCU6qHN1XnjDJL0rBeY3pl3KxgAVckk=;
        b=b10RFWNVd2zdnGJldXFMotlCMISNPpbAzPXwCC5XB8K/O/Qbxo1Ykr+Zuquy4KnQSk
         lKbKgLl4YVXUUIbNQcg1k2vfYUL/kXk9P2ZAUFfJQo3Px5Y0bCin92+iywsxg10EQVt7
         0FY75zZqhlN3tWEw3A3qYZ2TRd/08fVttj4P/scn6P1bnladNhDGTWayjha7X6U+CpJN
         b38YMKfSeRVcLfp9Y37JUNqic5+IbvKMNR43YOReL++Rv01/RMyGSZIgXIwn4rHPEoeC
         YH+VtwM2w0aqHPvjnAb+X4HkbzzlmL9i5ZqCTZWX3xB1s434D+chabHVk6p7xjglB4bA
         9Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EX+iSv5Kmy5pWCU6qHN1XnjDJL0rBeY3pl3KxgAVckk=;
        b=hzcvF+914HkTuCbPkqfNR+IX/COU3oxme2pZGNK0n4GdqwtzWh/OjhhwL0avxlSdza
         h4BzaiXVBQ/eCNYl6zfskQ93CfFyaH1NS2xts03ea0uWKWxGIY44nltTCJCyIKsY3Vqg
         NTWTdx0hoDPGnpPzIhlA0CT9wHGyG3dmPccJbVNytrqivWTcPS0untYKassQ622eJQEy
         zVFsw4QIfoaxawAEj0vyxj82uSWvVlT2fOyOfgRNP7O5Ybdk29ZEufeJCR0CTm1OvFuo
         suW12Tr2MSeHm2K+oIJkxQvGv+LqPUfOyP13EopzNw9tb9Y0ah1uoc/2dKbzr4XNw7/3
         Cq7A==
X-Gm-Message-State: ANoB5plravvraMPxCyGRFi3L60Dsa/w6TW6fLxIFgyzHqkImzWMrWbO+
        d/HOlhgSmgEA7voRT/WXmqTIcQqVg9oVTxDb7qyNCA==
X-Google-Smtp-Source: AA0mqf4lP2z0kK6TvyHZz0JLFcWM6gHSYEk5ZOkGXDWYkpJ3buhfHLrH7I5bora7wiW364oiw31YycSlb+NPj0VS0Ew=
X-Received: by 2002:a05:6e02:10d0:b0:302:bb08:3c22 with SMTP id
 s16-20020a056e0210d000b00302bb083c22mr8957829ilj.147.1669239349596; Wed, 23
 Nov 2022 13:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
In-Reply-To: <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Nov 2022 13:35:13 -0800
Message-ID: <CAJD7tkZNW=u1TD-Fd_3RuzRNtaFjxihbGm0836QHkdp0Nn-vyQ@mail.gmail.com>
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
To:     Mina Almasry <almasrymina@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
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

On Wed, Nov 23, 2022 at 1:21 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Wed, Nov 23, 2022 at 10:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Hello Mina,
> >
> > On Tue, Nov 22, 2022 at 12:38:45PM -0800, Mina Almasry wrote:
> > > Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > > reclaim""), the proactive reclaim interface memory.reclaim does both
> > > reclaim and demotion. This is likely fine for us for latency critical
> > > jobs where we would want to disable proactive reclaim entirely, and is
> > > also fine for latency tolerant jobs where we would like to both
> > > proactively reclaim and demote.
> > >
> > > However, for some latency tiers in the middle we would like to demote but
> > > not reclaim. This is because reclaim and demotion incur different latency
> > > costs to the jobs in the cgroup. Demoted memory would still be addressable
> > > by the userspace at a higher latency, but reclaimed memory would need to
> > > incur a pagefault.
> > >
> > > To address this, I propose having reclaim-only and demotion-only
> > > mechanisms in the kernel. There are a couple possible
> > > interfaces to carry this out I considered:
> > >
> > > 1. Disable demotion in the memory.reclaim interface and add a new
> > >    demotion interface (memory.demote).
> > > 2. Extend memory.reclaim with a "demote=<int>" flag to configure the demotion
> > >    behavior in the kernel like so:
> > >       - demote=0 would disable demotion from this call.
> > >       - demote=1 would allow the kernel to demote if it desires.
> > >       - demote=2 would only demote if possible but not attempt any
> > >         other form of reclaim.
> >
> > Unfortunately, our proactive reclaim stack currently relies on
> > memory.reclaim doing both. It may not stay like that, but I'm a bit
> > wary of changing user-visible semantics post-facto.
> >
> > In patch 2, you're adding a node interface to memory.demote. Can you
> > add this to memory.reclaim instead? This would allow you to control
> > demotion and reclaim independently as you please: if you call it on a
> > node with demotion targets, it will demote; if you call it on a node
> > without one, it'll reclaim. And current users will remain unaffected.
>
> Hello Johannes, thanks for taking a look!
>
> I can certainly add the "nodes=" arg to memory.reclaim and you're
> right, that would help in bridging the gap. However, if I understand
> the underlying code correctly, with only the nodes= arg the kernel
> will indeed attempt demotion first, but the kernel will also merrily
> fall back to reclaiming if it can't demote the full amount. I had
> hoped to have the flexibility to protect latency sensitive jobs from
> reclaim entirely while attempting to do demotion.
>
> There are probably ways to get around that in the userspace. I presume
> the userspace can check if there is available memory on the node's
> demotion targets, and if so, the kernel should demote-only. But I feel
> that wouldn't be reliable as the demotion logic may change across
> kernel versions. The userspace may think the kernel would demote but
> instead demotion failed due to whatever heuristic introduced into the
> new kernel version.
>
> The above is just one angle of the issue. Another angle (which Yosry
> would care most about I think) is that at Google we call
> memory.reclaim mainly when memory.current is too close to memory.max
> and we expect the memory usage of the cgroup to drop as a result of a
> success memory.reclaim call. I suspect once we take in commit
> 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg reclaim""),
> we would run into that regression, but I defer to Yosry here, he may
> have a solution for that in mind already.

We don't exactly rely on memory.current, but we do have a separate
proactive reclaim policy today from demotion, and we do expect
memory.reclaim to reclaim memory and not demote it. So it is important
that we can control reclaim vs. demotion separately. Having
memory.reclaim do demotions by default is not ideal for our current
setup, so at least having a demote= argument to control it (no
demotions, may demote, only demote) is needed.

>
> For these reasons, what do you think about adding both the "nodes="
> and "demote=" args from my patch series to memory.reclaim? With these
> args the default memory.reclaim behavior would suit meta as-is (no
> change) but we would be able to configure it to address our use cases
> as well.
>
> As always, thanks for taking the time to review!
