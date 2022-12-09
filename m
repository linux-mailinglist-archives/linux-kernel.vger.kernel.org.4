Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C506486AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLIQmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLIQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:42:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC189307
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:42:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so5514612pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i9EfDV7EBqWGFnaYDO/cpEuxlHa0WTqeQPcdpc0bkis=;
        b=kcLGQWVDzGqnXIK2OUrhHfduI4saLmxlUlFxYA9TOx0BiOqjv8QeRv2rj6gheEKZQz
         0llTw8X/KWAcHOngmarldA48AVKQPn+z1PmtohnnYihrZ8BpShW5/47uz2yu6AO1pUZp
         kGeZ1W0F83IyD+lEuWShFxFquSzpmZfN7w3CW7jBvVCit++L369DBisGLHumCA30U/xm
         CbvT8HwLVYkGLM/pfSv6n83X3ffWEpHZ6ZDA28a9VBmcVaEy65LD2brgEm4bjJo16hJ6
         felu+EU0W3Kzk7v9K0gntBqoxsRvDeglbJGTr0ta4uVF5HWzFyUPTlTLAmdrrCDgDhwN
         S34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9EfDV7EBqWGFnaYDO/cpEuxlHa0WTqeQPcdpc0bkis=;
        b=8QmQ/gL0hIVXqJR6QiXEI2WqjSwIaSmjJZvF2IKjjqA2eTBR9jqNarslUC+H+tiPmh
         t50zxWFBLGQmbZj2syx4Km/lT/2ZCkn89N+bBS4nCE+tc3UKcQVuYsArvkPTXXoFxiEb
         C8KM62h7Uf85hvtKvB9DohpgGB9jOtO/Wm6TEBvrIOqx/toktjGWt1eYbhhXsQylT3rS
         kQpysyTR763JhuTRkZt/wCiy8PLzdpaTtmMJEO+7xqVd6iFbLLdkOKK8E1KQkYN6fveW
         9CsESx+lqV3s41nmp07CzVANZccWh01Pwz2q/yNvgEcsNxbQefw2zUiCHTC+foyQz0co
         EhnA==
X-Gm-Message-State: ANoB5plM15Oqr9iLMxSgtBvAeZYXJ/QJ7JNAroM0PRSc+F09kBE1c/vT
        3icXxkUqg9tboFMIsIzDLFBwHfl35lwnXcqOdUdxYw==
X-Google-Smtp-Source: AA0mqf7ULUiN+XaofS3Qne0MnOWDIr+MNzzEs7jX1BbeeJOaJKhvLNL48/v0L4GOmW52sb8gAXURlFw8L6Zpf/LMyzA=
X-Received: by 2002:a17:90a:5a41:b0:219:41ef:a812 with SMTP id
 m1-20020a17090a5a4100b0021941efa812mr51961934pji.153.1670604120017; Fri, 09
 Dec 2022 08:42:00 -0800 (PST)
MIME-Version: 1.0
References: <Y48zlaimOb/wr8qd@dhcp22.suse.cz> <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
 <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz> <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
 <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz> <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
 <Y5Gbwwp7AlFiltuu@dhcp22.suse.cz> <CAHS8izMhRXMB5QJab5AvuHiWiQUAzUf81-7Y71ueEEnz71dwiQ@mail.gmail.com>
 <Y5HQgpRvPQWteNvz@dhcp22.suse.cz> <CAAPL-u_bEhCCCnepmCuNe7q7qJY3G3wckGvG-QsF2SYpAVXhEA@mail.gmail.com>
 <Y5LtEMYOXtUxsuqs@dhcp22.suse.cz>
In-Reply-To: <Y5LtEMYOXtUxsuqs@dhcp22.suse.cz>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 9 Dec 2022 08:41:47 -0800
Message-ID: <CAAPL-u8J_sgnAn1ev-cfZh428UOySxh1aYZUFKq1=dr-KrdTsw@mail.gmail.com>
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

On Fri, Dec 9, 2022 at 12:08 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 08-12-22 16:59:36, Wei Xu wrote:
> [...]
> > > What I really mean is to add demotion nodes to the nodemask along with
> > > the set of nodes you want to reclaim from. To me that sounds like a
> > > more natural interface allowing for all sorts of usecases:
> > > - free up demotion targets (only specify demotion nodes in the mask)
> > > - control where to demote (e.g. select specific demotion target(s))
> > > - do not demote at all (skip demotion nodes from the node mask)
> >
> > For clarification, do you mean to add another argument (e.g.
> > demotion_nodes) in addition to the "nodes" argument?
>
> No, nodes=mask argument should control the domain where the memory
> reclaim should happen. That includes both aging and the reclaim. If the
> mask doesn't contain any lower tier node then no demotion will happen.
> If only a subset of lower tiers are specified then only those could be
> used for the demotion process. Or put it otherwise, the nodemask is not
> only used to filter out zonelists during reclaim it also restricts
> migration targets.
>
> Is this more clear now?

In that case, how can we request demotion only from toptier nodes
(without counting any reclaimed bytes from other nodes),  which is our
memory tiering use case?

Besides, when both toptier and demotion nodes are specified, the
demoted pages should only be counted as aging and not be counted
towards the requested bytes of try_to_free_mem_cgroup_pages(), which
is what this patch tries to address.

> --
> Michal Hocko
> SUSE Labs
