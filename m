Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6148C648A25
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLIVkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:40:00 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF192FFA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:39:58 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id t5so5742685vsh.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 13:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=20fWTWqG3b1NNXuV0UqK1yxQ/Ktl7cxXS71QLmWNzcs=;
        b=BnhqE1j/P331hqbRIW+1zWjX2X6wDnR895yP+axeKfFphfSMfyTNbZYwuTh1KqoWrX
         g8+5allE98PfMOuEtX1gTvtpIKGLqQNbtIjLIzih3NOOeXIHLfFuTzD1J+84oLDIeUc/
         ytiPO2eNVUlKMT3YRiVYPaL3TC/YqPGZIoVFLL5D/ZhXpa0nNVNtagtGFd/92/BsMhoC
         kHW6h5lEI7nT3JHSq3pks8s8ZY6qZavgBP+0ESTNOJVh6EM5Yi+ZMB82eADgJ55dgG7c
         eL1e/A1iWoeg+HKE400v2Eht3GiPWflB+K0ov7T6fDO7W304XB4TPbg5whESSa/VHuvn
         Lx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20fWTWqG3b1NNXuV0UqK1yxQ/Ktl7cxXS71QLmWNzcs=;
        b=J0z1AOGLOHDm9U25hzR30jabr8dtz1u/svPo4J1FzUVpcLLxxlV77P2NpTOSiMtTRU
         cpLnWzZfrk8W4Bcyl+s5TH3rwC3NSDTK3TyHgCM+J5GybQAP5lF2NOzutGszimvw+ILk
         iNPW2+T1tJuqP1+rlfTyyX2aUJGXbAr9tn18qGBmB09p6+9otD1+lIulWz0S9aaPHgRh
         7UYK6JnHIQzwp7SouYy6B/mOUkYtZoEeYcj4/P/8XAQKjjEmT8daJHtBkSoEf1e57Jhn
         uxYtgzWDSG6EmuyRCRfjMgGCM7AmyCbhbIp8n/ZJ5b5UJSOiLsGBAFJ3D2MOJy4dOAZy
         xRug==
X-Gm-Message-State: ANoB5pncrRzxNIm2w2WcjRn9G1PqacidHF5Gq1MQJEjmaiVb3rueiQEQ
        4brDPRLck8liG0rRuG3vSEFSSq0a8RN/6LDtp1Ed8A==
X-Google-Smtp-Source: AA0mqf79LwG4XbYGxkIBYEJjxz+6ThdW7CDhmx6hjMBhsMOa+WjsBHRBigeL1N5n84sx4YuEJ/CENPIg7E/Qenvq558=
X-Received: by 2002:a67:fe53:0:b0:3b1:3d9a:6932 with SMTP id
 m19-20020a67fe53000000b003b13d9a6932mr9775580vsr.59.1670621997768; Fri, 09
 Dec 2022 13:39:57 -0800 (PST)
MIME-Version: 1.0
References: <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz> <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
 <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz> <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
 <Y5Gbwwp7AlFiltuu@dhcp22.suse.cz> <CAHS8izMhRXMB5QJab5AvuHiWiQUAzUf81-7Y71ueEEnz71dwiQ@mail.gmail.com>
 <Y5HQgpRvPQWteNvz@dhcp22.suse.cz> <CAAPL-u_bEhCCCnepmCuNe7q7qJY3G3wckGvG-QsF2SYpAVXhEA@mail.gmail.com>
 <Y5LtEMYOXtUxsuqs@dhcp22.suse.cz> <CAAPL-u8J_sgnAn1ev-cfZh428UOySxh1aYZUFKq1=dr-KrdTsw@mail.gmail.com>
 <Y5OlmLeDen1c/Nly@dhcp22.suse.cz>
In-Reply-To: <Y5OlmLeDen1c/Nly@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 9 Dec 2022 13:39:44 -0800
Message-ID: <CAHS8izPxMJzy_Axixkydvsw0ODHz9R7XU6WAtGJKZuMH0i=ANA@mail.gmail.com>
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Xu <weixugc@google.com>,
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

I think putting the demotion sources and demotion targets in the same
nodemask is a bit confusing, and prone to error. IIUC the user puts
both the demotion source and the demotion target in the nodemaks, and
the kernel infers which is which depending on whether the node is a
top-tier node, or a bottom tier node. I think in the future this will
become ambiguous. What happens in the future when the user when the
machine has N memory tiers and the user specifies a node in a middle
tier in the nodemask? Does that mean the user wants demotion from or
to this node? Middle memory tiers can act as both...

I think if your goal is to constrain demotion targets then a much more
clear and future proof way is to simply add a second arg to
memory.reclaim "allowed_demotion_targets=".\

> > In that case, how can we request demotion only from toptier nodes
> > (without counting any reclaimed bytes from other nodes),  which is our
> > memory tiering use case?
>
> I am not sure I follow. Could you be more specific please?
>
> > Besides, when both toptier and demotion nodes are specified, the
> > demoted pages should only be counted as aging and not be counted
> > towards the requested bytes of try_to_free_mem_cgroup_pages(), which
> > is what this patch tries to address.
>
> This should be addressed by
> http://lkml.kernel.org/r/Y5B1K5zAE0PkjFZx@dhcp22.suse.cz, no?

I think I provided a test case in [1] showing very clearly that this
breaks one of our use cases, i.e. the use case where the user is
asking to demote X bytes from the top tier nodes to the lower tier
nodes. I would not like to proceed with a fix that breaks one of our
use cases. I believe I provided in this patch a fix that caters to all
existing users, and we should take the fix in this patch over a fix
that breaks use cases.

[1] https://lore.kernel.org/all/CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com/

> --
> Michal Hocko
> SUSE Labs
