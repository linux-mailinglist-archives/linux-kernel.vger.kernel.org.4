Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A91648D89
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 09:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLJIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 03:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiLJIBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 03:01:42 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259A329802
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 00:01:41 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q71so5016040pgq.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 00:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0n+FUhQiaxKcO571s8XzqSdYNC+k0Hbm7weCPJfOjM=;
        b=d4DvXaJULzTcjMkvFIFPwPVdOLLkjsUKHRvY7B14PO565vD7N33/z9Yc7kuD6pjeKF
         MiYCkFIm0VGh/YXj4K0KvKE/6Gwq5ohIx1CLBXFp73iofD/FPSY7SknoJSM9acILx0FX
         3JSwyyC8mIr3yv5lhq/sL9LuxVJdDo6oldg1SIKWqQ/koDmoaiQx2sC4jparIU/9/Hh9
         i7DHjPnq9W9Z064iOErtbA5J72XeKlvtVy5bYENBsBkddKryamYokzPifAtLNwQUS7Vq
         0N65KftCjRyUFb/dhlUUgPPCg8cjDD8NWvni0zH1RhZieP/IKrrgpFwLHVaknBWDbv2w
         xfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0n+FUhQiaxKcO571s8XzqSdYNC+k0Hbm7weCPJfOjM=;
        b=7i+U5r8PZBYyhGEqH+7l8ggaC7BvoX1JvOoBu2cbiZ3j5M0xxbBaUl0vXbqGir2lNF
         KYJWP2GjB+WsFwTqSp/hE1qzIEMLjW5gWUb8EABThZ31CK+Ef/Rjmm1E989o+vbGITM1
         EPKtTyfRi0ptgo62jRI/7WIobx61eskzwxFq8Q5cplo3QmJHMK4LDHtJQhYkE3CS5BBS
         W/+xZKFqhjIXbZe3pCDdrT+RnEdR7RSEnGsuASnPwJzY3+pCfL2rifXibbsZXuYql34G
         IawhhOQe6wRCNL8nAqXIzgk3h42o2QGH9NhwlCcJbu0yUE4pQy1sjBt1vYRa1i06Sg3J
         liDg==
X-Gm-Message-State: ANoB5plC4SZsUz4U0VJtST6gE9RlXt29mwbc7FJFFE5p4rZb5/QyZ5ho
        nmoi0QvWIAxTBg5uHw/biLvzwL4NvSu57QvIzbhK/Q==
X-Google-Smtp-Source: AA0mqf6jWqW/YsdFHA9xbvBaztEOl3NU/SQG1lBBQ9K42LuNTbPk5rxq0Q/B5mvwKITYs/+9S5OVcSet3h0XpgQHS20=
X-Received: by 2002:a63:1c22:0:b0:478:c543:89d3 with SMTP id
 c34-20020a631c22000000b00478c54389d3mr14455701pgc.184.1670659300337; Sat, 10
 Dec 2022 00:01:40 -0800 (PST)
MIME-Version: 1.0
References: <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz> <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
 <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz> <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
 <Y5Gbwwp7AlFiltuu@dhcp22.suse.cz> <CAHS8izMhRXMB5QJab5AvuHiWiQUAzUf81-7Y71ueEEnz71dwiQ@mail.gmail.com>
 <Y5HQgpRvPQWteNvz@dhcp22.suse.cz> <CAAPL-u_bEhCCCnepmCuNe7q7qJY3G3wckGvG-QsF2SYpAVXhEA@mail.gmail.com>
 <Y5LtEMYOXtUxsuqs@dhcp22.suse.cz> <CAAPL-u8J_sgnAn1ev-cfZh428UOySxh1aYZUFKq1=dr-KrdTsw@mail.gmail.com>
 <Y5OlmLeDen1c/Nly@dhcp22.suse.cz>
In-Reply-To: <Y5OlmLeDen1c/Nly@dhcp22.suse.cz>
From:   Wei Xu <weixugc@google.com>
Date:   Sat, 10 Dec 2022 00:01:28 -0800
Message-ID: <CAAPL-u8rgW-JACKUT5ChmGSJiTDABcDRjNzW_QxMjCTk9zO4sg@mail.gmail.com>
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, fvdl@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, Dec 9, 2022 at 1:16 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 09-12-22 08:41:47, Wei Xu wrote:
> > On Fri, Dec 9, 2022 at 12:08 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 08-12-22 16:59:36, Wei Xu wrote:
> > > [...]
> > > > > What I really mean is to add demotion nodes to the nodemask along with
> > > > > the set of nodes you want to reclaim from. To me that sounds like a
> > > > > more natural interface allowing for all sorts of usecases:
> > > > > - free up demotion targets (only specify demotion nodes in the mask)
> > > > > - control where to demote (e.g. select specific demotion target(s))
> > > > > - do not demote at all (skip demotion nodes from the node mask)
> > > >
> > > > For clarification, do you mean to add another argument (e.g.
> > > > demotion_nodes) in addition to the "nodes" argument?
> > >
> > > No, nodes=mask argument should control the domain where the memory
> > > reclaim should happen. That includes both aging and the reclaim. If the
> > > mask doesn't contain any lower tier node then no demotion will happen.
> > > If only a subset of lower tiers are specified then only those could be
> > > used for the demotion process. Or put it otherwise, the nodemask is not
> > > only used to filter out zonelists during reclaim it also restricts
> > > migration targets.
> > >
> > > Is this more clear now?
> >
> > In that case, how can we request demotion only from toptier nodes
> > (without counting any reclaimed bytes from other nodes),  which is our
> > memory tiering use case?
>
> I am not sure I follow. Could you be more specific please?

In our memory tiering use case, we would like to proactively free up
memory on top-tier nodes by demoting cold pages to lower-tier nodes.
This is to create enough free top-tier memory for new allocations and
promotions.  How many pages and how often to demote from top-tier
nodes can depend on a number of factors (e.g. the amount of free
top-tier memory, the amount of cold pages, the bandwidth pressure on
lower-tier, the task tolerance of slower memory on performance) and
are controlled by the userspace policies.

Because the purpose of such proactive demotions is to free up top-tier
memory, not to lower the amount of memory charged to the memcg, we'd
like that memory.reclaim can demote the specified amount of bytes from
the given top-tier nodes.  If we have to also provide the lower-tier
nodes to memory.reclaim to allow demotions, the kernel can reclaim
from the lower-tier nodes in the same memory.reclaim request. We then
won't be able to control the amount of bytes to be demoted from
top-tier nodes.

> > Besides, when both toptier and demotion nodes are specified, the
> > demoted pages should only be counted as aging and not be counted
> > towards the requested bytes of try_to_free_mem_cgroup_pages(), which
> > is what this patch tries to address.
>
> This should be addressed by
> http://lkml.kernel.org/r/Y5B1K5zAE0PkjFZx@dhcp22.suse.cz, no?
> --
> Michal Hocko
> SUSE Labs
