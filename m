Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B066529DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiLTX20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTX2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:28:25 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3D1A07F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:28:23 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-40b40ff39f1so190073157b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K8qBWuU9lWrXOPNMkI4xvvAbeO7Vw8VxOj8wpST/GOY=;
        b=ZHCUC4sYVijQClbfGy9lCOCGsTxidOH/HGkPOjbsE3ThDWMvFmTmX2PuoejRKKkg0Z
         V5MpGwB2PS28tvdKSV3Ar93uYkMTVuu73YFwoBDlnNO8uwVa5F+WUYhU+pYHhEnnYyhn
         8FWweQ0WcaKZRexuf3rSABxIY66m8E4L266zqla1Qrzpsv1VBF636+o6PffptRRSLcb3
         XHdiGNGl/r4vjwjDV7w+So60AcPtg9mFP1bVcVt+Nsr9LtqYAqKkTCidJPV7XLTxiBfT
         sepGgpIPVmjMVxo/FpwcOLjbeWxE8BcCmn+cTBVy21EeW1ZttCW0Wtf+dr4VxeINxIfX
         JDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8qBWuU9lWrXOPNMkI4xvvAbeO7Vw8VxOj8wpST/GOY=;
        b=JeLv/S8ZC85ilbkYaFMy/rZJh3geB3LnaXjBt5fk3LNuLSqULDc14EkV0C0i9TEFjr
         nGSMC1lYXTe1sNXHP1I3kINhVKUWtryeK+isjsrcv6glFlNb+xoEGNrbLT/CRpwVb+OO
         nL12mggjoK+KGlvaNN4S4btceH9z5J/tgs9QIIE0L3yFl9wEETMh9rWCTm9npNp4PBzn
         Y+2XP77zDA+SosOwjdZgC6thM5fz8cdtRM0jUlOoAnjXKozhLJ8OQYQH5EOdHy/MLvms
         J4SWl6lRZacVFKZ02RPr06akr35owKpM1RxsPoEK7XQjtIQJ+xL0/DOwF/15uuaNeOYb
         T2Mw==
X-Gm-Message-State: AFqh2kqEBnX8ckCIn0ZOskm2fl3zGiEXa2nLHC63XvKZNXoWPYgm2bQK
        /a2XPmIsC4fbVre6qLl56fgMhYGcdXCvqx6ZytiZCQ==
X-Google-Smtp-Source: AMrXdXuIHLK4fsh2qBj6ouNMe+aKaVwdL679K0vPCdyCPv4vWhJXZZeZmAaaxGX7Uhgx8q+63Gl6cprdLjrf+BSBoUc=
X-Received: by 2002:a81:8643:0:b0:3d9:dd22:c785 with SMTP id
 w64-20020a818643000000b003d9dd22c785mr2444880ywf.486.1671578902467; Tue, 20
 Dec 2022 15:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20221220184813.1908318-1-roman.gushchin@linux.dev>
 <CALvZod7WNxj0vdfiEad_xfBACsJu3iA0nF25m4VN3M=yLF4igg@mail.gmail.com> <Y6IiPCg7c1A5fhsC@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y6IiPCg7c1A5fhsC@P9FQF9L96D.corp.robot.car>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Dec 2022 15:28:11 -0800
Message-ID: <CALvZod7q1jcpVyFUSzfL8-mSFa24peqrKDmqnMLwNe2=dNEpaw@mail.gmail.com>
Subject: Re: [PATCH RFC] ipc/mqueue: introduce msg cache
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Sven Luther <Sven.Luther@windriver.com>
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

On Tue, Dec 20, 2022 at 12:59 PM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Tue, Dec 20, 2022 at 11:53:25AM -0800, Shakeel Butt wrote:
> > +Vlastimil
> >
> > On Tue, Dec 20, 2022 at 10:48 AM Roman Gushchin
> > <roman.gushchin@linux.dev> wrote:
> > >
> > > Sven Luther reported a regression in the posix message queues
> > > performance caused by switching to the per-object tracking of
> > > slab objects introduced by patch series ending with the
> > > commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
> > > allocations").
> > >
> > > To mitigate the regression cache allocated mqueue messages on a small
> > > percpu cache instead of releasing and re-allocating them every time.
> > >
> >
> > Seems fine with me but I am wondering what is stopping us to do this
> > caching in the slab layer for all accounted allocations? Does this
> > only make sense for specific scenarios/use-cases?
>
> It's far from trivial, unfortunately. Here we have an mqueue object to associate
> a percpu cache with and the hit rate is expected to be high, assuming the mqueue
> will be used to pass a lot of messages.
>
> With a generic slab cache we return to the necessity of managing
> the per-cgroup x per-slab-cache x per-cpu free list (or some other data structure),
> which is already far from trivial, based on the previous experience. It can
> easily lead to a significant memory waste, which will fully compensate all perf
> wins.
>
> So probably we need some heuristics to allocate caches only for really hot slab
> caches and use some sort of a hash map (keyed by cgroup and slab cache) to
> access freelists. What I miss to commit more time to this project (aside from not
> having it), is the lack of real workloads which will noticeably win from this work.
>
> Sven provided a good example and benchmark to reproduce the regression, so it
> was easy to justify the work.
>

Thanks for the explanation. I think we should add this to the commit
message as well. I do think we should have a general framework for
such caching as there are other users (e.g. io_uring) doing the same
and some future users can take advantage as well e.g. I think this
type of caching will be helpful for filelock_cache as well. Anyways
that can be done in future.
