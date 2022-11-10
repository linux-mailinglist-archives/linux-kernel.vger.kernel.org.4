Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB2624ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiKJTqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJTp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:45:57 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D345A29
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:45:56 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i5so1526434ilc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGo0fE0YRyisie71iUpJssOr+2esv7uUzO4ILEWpRC4=;
        b=DDzS8KVhTiFwp8F/65P3SFU6UQ0Vr4CjeM6CQTVvw2FR6lUG0/FmOg93rI/PSO0eVq
         //x6kbPsLQYYC6/JjzTRuKM/Fhiw6505rlZ3NpGBas4V/8HBtm9iJc5iPUgJHt5MBwMf
         fLO3IqmyjP7Ix6skaJN/R3rjizAok3aZpaZlmGd7qlAlgKOsPeldbQPeFdK8VzQi/kYk
         8vx1jfZlgorCGpGXb6tEhNjcIknlDUsmesQGNYgKwCbFH+cmFsH/mXvWZddJXI3/8zk2
         hJ0Wj6Bc064xI85aiNAeBJImABplCU0CjDQUKn5bUc5y/BKQJt7uLXNglc7JPnPeSXWa
         BVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGo0fE0YRyisie71iUpJssOr+2esv7uUzO4ILEWpRC4=;
        b=WvUbDXw6WJnHnHMZYSRbnZ5JSUPqksc+wMiloK1dtILeS0zyQRt3QCSRCQtMBIxOXe
         5r07X4t56DZyNXeJkEh3tZ7FaMRB101lBn8i82DwFOnxdpsr1n+ftKMzDYzdGj3tcqC1
         nqp6rDok9NDQLo2CwpaLfw5p4oK1LyWkQJKpELsSt11B2gLv+iTL2/CxNhkuzreaeKq+
         YRCNc2IXQfEVlj+KYV2Wqd6fXFtUpi67+NKPyVx1UOwtey2xaqMd0QKAmzCzVAT5zCoh
         hKxStCujgOmyK5rKktmdOpC4f9QepB0dv2W3mX2ZgmFS5KYBgdXD/V+B/TXdNFptjRm+
         OW+A==
X-Gm-Message-State: ACrzQf2UDhIp5uDAGuc3/iuBxWvAo2LgxTGjeMYprw0VTfF3FdWJ1dva
        IR84zkfHSdjx3kQwX4OZ1k96Y/Cb/TtsoL1eYGSJ6A==
X-Google-Smtp-Source: AMsMyM5nFdXVrkG6c5nm2NP24tfVHf8SWNxaob3cFBmurpiN7ikbsAMBgbOqLPdhJCVF4wn4uqcCide21AJILDAr0Ws=
X-Received: by 2002:a92:d909:0:b0:2ff:e1b0:b150 with SMTP id
 s9-20020a92d909000000b002ffe1b0b150mr3608621iln.147.1668109555446; Thu, 10
 Nov 2022 11:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20221110065316.67204-1-lujialin4@huawei.com> <20221110144243.GA10562@blackbody.suse.cz>
 <CAJD7tkat6QAJkPJ-of0xYGbKJ1CyXeC0cMh+U9Nzmddm4pOZ9g@mail.gmail.com>
In-Reply-To: <CAJD7tkat6QAJkPJ-of0xYGbKJ1CyXeC0cMh+U9Nzmddm4pOZ9g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 10 Nov 2022 11:45:19 -0800
Message-ID: <CAJD7tkY227nVROVAntzkxsddrfRQ_yqVC3oQydsux-OUrM840A@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol.c: drains percpu charge caches in memory.reclaim
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Lu Jialin <lujialin4@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Nov 10, 2022 at 11:35 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Thu, Nov 10, 2022 at 6:42 AM Michal Koutn=C3=BD <mkoutny@suse.com> wro=
te:
> >
> > Hello Jialin.
> >
> > On Thu, Nov 10, 2022 at 02:53:16PM +0800, Lu Jialin <lujialin4@huawei.c=
om> wrote:
> > > When user use memory.reclaim to reclaim memory, after drain percpu lr=
u
> > > caches, drain percpu charge caches for given memcg stock in the hope
> > > of introducing more evictable pages.
> >
> > Do you have any data on materialization of this hope?
> >
> > IIUC, the stock is useful for batched accounting to page_counter but it
> > doesn't represent real pages. I.e. your change may reduce the
> > page_counter value but it would not release any pages. Or have I missed
> > a way how it helps with the reclaim?
>
> +1
>
> It looks like we just overcharge the memcg if the number of allocated
> pages are less than the charging batch size, so that upcoming
> allocations can go through a fast accounting path and consume from the
> precharged stock. I don't understand how draining this charge may help
> reclaim.
>
> OTOH, it will reduce the page counters, so if userspace is relying on
> memory.current to gauge how much reclaim they want to do, it will make
> it "appear" like the usage dropped. If userspace is using other
> signals (refaults, PSI, etc), then we would be more-or-less tricking
> it into thinking we reclaimed pages when we actually didn't. In that
> case we didn't really reclaim anything, we just dropped memory.current
> slightly, which wouldn't matter to the user in this case, as other
> signals won't change.

In fact, we wouldn't be tricking anyone because this will have no
effect on the return value of memory.reclaim. We would just be causing
a side effect of very slightly reducing memory.current. Not sure if
this really helps.

>
> The difference in perceived usage coming from draining the stock IIUC
> has an upper bound of 63 * PAGE_SIZE (< 256 KB with 4KB pages), I
> wonder if this is really significant anyway.
>
> >
> > Thanks,
> > Michal
