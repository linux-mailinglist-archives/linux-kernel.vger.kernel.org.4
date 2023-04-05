Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD306D8661
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjDES4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjDES4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:56:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A603A59E3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:56:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i5so143725521eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680720990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUHx9jRHzGk0Yj8qja9+zPdMg8UV3tc3NMpsClxL/uU=;
        b=PcOksGvousVNSQ3cXdcS8HWqwXWWJcKA52C1lMjGVEUryaoo1tPpsv5kRcDXnrszeS
         JdYnxSepPg5yJ/fPSprlLRsupbI62wkDmZPCcKllTgOwxHqMqudEkwjw8ZhEs+8EK2a1
         NUk4+UWeR0EaIswYspERC1kivvjsa0dWn2wnvu2WB9gk8GukcN9hVPDOmbhPQBLeN2uB
         1jkZr4RwvxyVz3l3W89ZzOJwJB0ceoUCOYSHY8WiICNTCCA85y6wjPi+rNU0oBwOYs2l
         N/U/n1chu5ml11hqxoxCZ1NlwaqbYeH6RnTye7Bn3qrwMNnUgKCvlLNecFKJWushISY0
         CU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680720990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUHx9jRHzGk0Yj8qja9+zPdMg8UV3tc3NMpsClxL/uU=;
        b=v6xrKuWXKJNNkh7kDnJEdd2QlKAsCm4ueeAjJ6r0aKDLtr9Gqq/KAx2+X5dwkO3PXd
         5ku2XUaRzkBB/+k7pkzih2a+V1v7gvJ6zi0NuYSW4kTpOalYB/iuNBMeRTyh6rrm9DFq
         mNDZrxcLnlujRUQMqR2a0tfvqoWPesjJpBwl5lZP7kadtM7xZTCSF6ilM7F2zKIWe/d9
         Fl/n3iTuzolf4NAL+ww0T3/4PAGZ2yBaNNr4TmMU2ps3VAIEhAT3feirx9JswU2r/QpG
         JqZOPz8IR7SD3BP0btbYOsshsF4Nxi4TipSS/116z4p1LN1Nf5IVPxZSm5mQkk4nYddB
         HDeQ==
X-Gm-Message-State: AAQBX9f0GP9qhmC/Zd4nADxmgqO9Vc3dgi7CSrxbG5TNN2nOTRjO7bEx
        XU4AEnBgC5yeIUns1u/wDORQBUShcL0WRqkSFUZUCA==
X-Google-Smtp-Source: AKy350bHaZuNUXPKWqtZZFlNYtm/KTUiWTEcxIzQpbSGE4xeqztd4ciQVHBO4lwV5nrlqSYhHlA8ehPxdZppf/JJggY=
X-Received: by 2002:a17:906:95cf:b0:933:f6e8:26d9 with SMTP id
 n15-20020a17090695cf00b00933f6e826d9mr2247603ejy.15.1680720989801; Wed, 05
 Apr 2023 11:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230404001353.468224-1-yosryahmed@google.com>
 <20230404143824.a8c57452f04929da225a17d0@linux-foundation.org>
 <CAJD7tkbZgA7QhkuxEbp=Sam6NCA0i3cZJYF4Z1nrLK1=Rem+Gg@mail.gmail.com>
 <20230404145830.b34afedb427921de2f0e2426@linux-foundation.org>
 <CAJD7tkZCmkttJo+6XGROo+pmfQ+ppQp6=qukwvAGSeSBEGF+nQ@mail.gmail.com>
 <20230404152816.cec6d41bfb9de4680ae8c787@linux-foundation.org>
 <20230404153124.b0fa5074cf9fc3b9925e8000@linux-foundation.org>
 <CAJD7tkYFZGJqZ278stOWDyW3HgMP8iyAZu8hSG+bV-p9YoVxig@mail.gmail.com> <20230405114841.248dffb65526383823c71d60@linux-foundation.org>
In-Reply-To: <20230405114841.248dffb65526383823c71d60@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 5 Apr 2023 11:55:53 -0700
Message-ID: <CAJD7tkZm2-Xx1axfhMH9wD4cJK5ySwg=kn9oXWeSBAR4npNp2Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Ignore non-LRU-based reclaim in memcg reclaim
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 11:48=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 4 Apr 2023 16:46:30 -0700 Yosry Ahmed <yosryahmed@google.com> wro=
te:
>
> > > But the key question remains: how desirable is a backport?
> > >
> > > Looking at the changelogs I'm not seeing a clear statement of the
> > > impact upon real-world users' real-world workloads.  (This is a hint)=
.
> > > So I am unable to judge.
> > >
> > > Please share your thoughts on this.
> >
> > I think it's nice to have but not really important. It occasionally
> > causes writes to memory.reclaim to report false positives and *might*
> > cause unnecessary retrying when charging memory, but probably too rare
> > to be a practical problem.
> >
> > Personally, I intend to backport to our kernel at Google because it's
> > a simple enough fix and we have occasionally seen test flakiness
> > without it.
> >
> > I have a reworked version of the series that only has 2 patches:
> > - simple-two-liner-patch (actually 5 lines)
> > - one patch including all refactoring squashed (introducing
> > flush_reclaim_state() with the huge comment, introducing
> > mm_account_reclaimed_pages(), and moving set_task_reclaim_state()
> > around).
> >
> > Let me know if you want me to send it as v5, or leave the current v4
> > if you think backporting is not generally important.
>
> Let's have a look at that v5 and see what people think?

Sent v5 [1]. Thanks Andrew!

[1]https://lore.kernel.org/lkml/20230405185427.1246289-1-yosryahmed@google.=
com/
