Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15268CA9B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBFXfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBFXff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:35:35 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82BD1204B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:35:33 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m2so38881090ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 15:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PebMER0tSx+oPRhl8r2nT8XfQ1hRr+Ea9P0OXUFJBO8=;
        b=gFiziMfcVl6htohZH8DlPgIj6VdnPBkJp7qScsRATWcBx+1yfn1eAcW9er4AEysOHd
         Xk1Adh1uLwfzboDoZyy3rPGdgXK+RZHyUZ32Ow5GPWlnotZgFwNf1tE4/4f/arM8LZvP
         yRZfnNWC1I694JkleoUgTzrH7QHU0TylPU2krrvGosY2416XSugbuQreh9EzSAQTYxB4
         yAJqZnsDw6WYSXo5hhQBYATmHo6hejbhN1bS6ugPVDTMd1by080RDRh/gUqPTjxRmpwi
         RhJh2zzvqilmf0h2+wraGV49VV+k5Ba5MqNATmTZSGODba5KRZCV1Y7AidKhmrOhn9F8
         pmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PebMER0tSx+oPRhl8r2nT8XfQ1hRr+Ea9P0OXUFJBO8=;
        b=mXnNk5eSFRb7v0vqAM3B4TI08UDXbITHTOl+lzt6A1t9kRWr+IbC0DxE/b2z0yneO4
         DK/cxGLmRW/ITIWpXfBjO1PVMtpy7Q78FBiOTtgmAlfCHANbQ7H8HRsCansdER8oqhmJ
         9ZfBo+UOea07TRaA8Xyqc0wVMnrzi1WcUNemnbI4Rdc/eTxqWJ7oLXvpcRJUbUqakODv
         7H7/dp7GCNeBA98+uaikypi8yqr+GxpnGZ9HH85zJ3nMhHSDJpw0ReMkDx04zPpJq+9v
         q5ISjFb6tuXv3T5/yPpTdVrT12NGKogFWPoHfnXJHMBrmzNDHr8x0L3+Rpt6wK14wOiL
         orFQ==
X-Gm-Message-State: AO0yUKWYgGCvlrOeHQIR44rsFCypYnLCeLZNkvezhY7oN7DCDe3omtdS
        0SZtBQ1YSo3pYoAJr6KVICi+0J9a8RpYAWcjxXRGEg==
X-Google-Smtp-Source: AK7set/LwhzSakQ5P7peQYkQ92BhJVbq00+VQIWbfGe8HACHEPOt/Vfx9S1nCqBe+Ki8mU/16uRn7J/nzy5p/F4cQFg=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr320380ejc.220.1675726532194; Mon, 06 Feb
 2023 15:35:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org> <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org> <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
In-Reply-To: <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Feb 2023 15:34:55 -0800
Message-ID: <CAJD7tkYP_4PbrLumDYaTHN2vh8BmLcmy_hWFDbWeA0p58xmYEw@mail.gmail.com>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
To:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@nvidia.com, jhubbard@nvidia.com, tjmercier@google.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
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

On Mon, Feb 6, 2023 at 3:25 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 02:39:17PM -0800, Yosry Ahmed wrote:
> > On Mon, Feb 6, 2023 at 2:36 PM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > On Mon, Feb 06, 2023 at 02:32:10PM -0800, Yosry Ahmed wrote:
> > > > I guess it boils down to which we want:
> > > > (a) Limit the amount of memory processes in a cgroup can be pinned/locked.
> > > > (b) Limit the amount of memory charged to a cgroup that can be pinned/locked.
> > > >
> > > > The proposal is doing (a), I suppose if this was part of memcg it
> > > > would be (b), right?
> > > >
> > > > I am not saying it should be one or the other, I am just making sure
> > > > my understanding is clear.
> > >
> > > I don't quite understand what the distinction would mean in practice. It's
> > > just odd to put locked memory in a separate controller from interface POV.
> >
> > Assume we have 2 cgroups, A and B. A process in cgroup A creates a
> > tmpfs file and writes to it, so the memory is now charged to cgroup A.
> > Now imagine a process in cgroup B tries to lock this memory.
> > - With (a) the amount of locked memory will count toward's cgroup A's
> > limit, because cgroup A is charged for the memory.
> > - With (b) the amount of locked memory will count toward's cgroup B's
> > limit, because a process in cgroup B is locking the memory.
> >
> > I agree that it is confusing from an interface POV.
>
> Oh yeah, that's confusing. I'd go with (a) for consistency with the rest of
> memcg - locked memory should fit inside e.g. memory.max. The problem with
> shared memory accounting exists for non-locked memory as well and prolly
> best to handle the same way rather than handling differently.

+Michal Hocko +Roman Gushchin +Shakeel Butt for visibility with memcg.

>
> Thanks.
>
> --
> tejun
