Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7062712678
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbjEZMVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjEZMVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:21:03 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA8116
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:20:58 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565a63087e9so10968057b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1685103658; x=1687695658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+jEjLEDhD2buRllEMJKw4DppQentdfOLHhdcxi/Kfc=;
        b=zQHkvx/HeZmD96OlXDZBLe5P/IBWByLfgikdHJZa7KkJrAVKX9LNEjw56ZJ5RRkx4Q
         GkyFmsrCW/t7/z+lQ3IUHbATqFiRVBwtnw08WCKgqZPNycHLp1GYAM+49qQCPps6T/Em
         tGlZv1Yi+U64e31VvIoVSAP+H7IIcgi2rl89dRkr5xwbFNVLK9QFMXcT2xMFETuxTx/J
         abgjK92x93JFeKtt7CknT/ZVkrXrVKubVmpTfsbdFzTSJGdN4SBFM7PXCtRRthhF57QC
         oPXqQrcb/wqjfvLegBMF4xAi4rIuTjg/bmCq4YocueMctvKGCAKVkvEuBQ6Qw6jfEFxt
         XJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685103658; x=1687695658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+jEjLEDhD2buRllEMJKw4DppQentdfOLHhdcxi/Kfc=;
        b=mFWXwvm3WfOBkKvuC/8k7Kf8vXea9OBwsI4Co6S54+NXZLmPZrfK23WPa7snRq0Wb6
         W1/Zj1K/cW9vmUMUwsGGRgP7BzayqsN6XNXGmPSKvFLnSexXDL1nqEosJGe0qm0byAid
         tG6eD6mwWr7uMA348hAewXjp85gmhKaWKgP/0OSDp8DQiB+kKM+pmT8ft+2zc2C9wCEn
         CxAP/6xcIUZ+E+pxiOkX4hW+iQLgc6U5A6Scvad6qV6jOBUAbnySf17d7abtFtI/jncZ
         TJC8k8thYLcBvX7n3P05R19KvhrhnP+NM8QaWHorYuKligHs0U9DLq0X22ZveM06EsCi
         91wA==
X-Gm-Message-State: AC+VfDxkIrx9tU2Vo/MlrWtA1H2wQdclCfzmHItM4biSvXln1P9Ccdq4
        FZs5QXWv+AnDNYhitTBuQvgKaxkykqIrqRaCx64eLg==
X-Google-Smtp-Source: ACHHUZ5tv9zaKf/t6HunrV+Ybq+VV3MhHulgaS/YrK7AQXQeUfEtohCwKIIP2QYdkOSQEWfiizzvYxwQHU9btyb0g7c=
X-Received: by 2002:a0d:d645:0:b0:54f:b6af:ac15 with SMTP id
 y66-20020a0dd645000000b0054fb6afac15mr2006001ywd.51.1685103658035; Fri, 26
 May 2023 05:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684887977.git.peilin.ye@bytedance.com> <429357af094297abbc45f47b8e606f11206df049.1684887977.git.peilin.ye@bytedance.com>
 <faaeb0b0-8538-9dfa-4c1e-8a225e3534f4@mojatatu.com>
In-Reply-To: <faaeb0b0-8538-9dfa-4c1e-8a225e3534f4@mojatatu.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Fri, 26 May 2023 08:20:46 -0400
Message-ID: <CAM0EoM=3iYmmLjnifx_FDcJfRbN31tRnCE0ZvqQs5xSBPzaqXQ@mail.gmail.com>
Subject: Re: [PATCH v5 net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
To:     Pedro Tammela <pctammela@mojatatu.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:39=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.=
com> wrote:
>
> On 23/05/2023 22:20, Peilin Ye wrote:
> > From: Peilin Ye <peilin.ye@bytedance.com>
> >
> > mini_Qdisc_pair::p_miniq is a double pointer to mini_Qdisc, initialized=
 in
> > ingress_init() to point to net_device::miniq_ingress.  ingress Qdiscs
> > access this per-net_device pointer in mini_qdisc_pair_swap().  Similar =
for
> > clsact Qdiscs and miniq_egress.
> >
> > Unfortunately, after introducing RTNL-unlocked RTM_{NEW,DEL,GET}TFILTER
> > requests (thanks Hillf Danton for the hint), when replacing ingress or
> > clsact Qdiscs, for example, the old Qdisc ("@old") could access the sam=
e
> > miniq_{in,e}gress pointer(s) concurrently with the new Qdisc ("@new"),
> > causing race conditions [1] including a use-after-free bug in
> > mini_qdisc_pair_swap() reported by syzbot:
> >
> >   BUG: KASAN: slab-use-after-free in mini_qdisc_pair_swap+0x1c2/0x1f0 n=
et/sched/sch_generic.c:1573
> >   Write of size 8 at addr ffff888045b31308 by task syz-executor690/1490=
1
> > ...
> >   Call Trace:
> >    <TASK>
> >    __dump_stack lib/dump_stack.c:88 [inline]
> >    dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> >    print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:3=
19
> >    print_report mm/kasan/report.c:430 [inline]
> >    kasan_report+0x11c/0x130 mm/kasan/report.c:536
> >    mini_qdisc_pair_swap+0x1c2/0x1f0 net/sched/sch_generic.c:1573
> >    tcf_chain_head_change_item net/sched/cls_api.c:495 [inline]
> >    tcf_chain0_head_change.isra.0+0xb9/0x120 net/sched/cls_api.c:509
> >    tcf_chain_tp_insert net/sched/cls_api.c:1826 [inline]
> >    tcf_chain_tp_insert_unique net/sched/cls_api.c:1875 [inline]
> >    tc_new_tfilter+0x1de6/0x2290 net/sched/cls_api.c:2266
> > ...
> >
> > @old and @new should not affect each other.  In other words, @old shoul=
d
> > never modify miniq_{in,e}gress after @new, and @new should not update
> > @old's RCU state.  Fixing without changing sch_api.c turned out to be
> > difficult (please refer to Closes: for discussions).  Instead, make sur=
e
> > @new's first call always happen after @old's last call, in
> > qdisc_destroy(), has finished:
> >
> > In qdisc_graft(), return -EAGAIN and tell the caller to replay
> > (suggested by Vlad Buslov) if @old has any ongoing RTNL-unlocked filter
> > requests, and call qdisc_destroy() for @old before grafting @new.
> >
> > Introduce qdisc_refcount_dec_if_one() as the counterpart of
> > qdisc_refcount_inc_nz() used for RTNL-unlocked filter requests.  Introd=
uce
> > a non-static version of qdisc_destroy() that does a TCQ_F_BUILTIN check=
,
> > just like qdisc_put() etc.
> >
> > Depends on patch "net/sched: Refactor qdisc_graft() for ingress and cls=
act
> > Qdiscs".
> >
> > [1] To illustrate, the syzkaller reproducer adds ingress Qdiscs under
> > TC_H_ROOT (no longer possible after patch "net/sched: sch_ingress: Only
> > create under TC_H_INGRESS") on eth0 that has 8 transmission queues:
> >
> >    Thread 1 creates ingress Qdisc A (containing mini Qdisc a1 and a2), =
then
> >    adds a flower filter X to A.
> >
> >    Thread 2 creates another ingress Qdisc B (containing mini Qdisc b1 a=
nd
> >    b2) to replace A, then adds a flower filter Y to B.
> >
> >   Thread 1               A's refcnt   Thread 2
> >    RTM_NEWQDISC (A, RTNL-locked)
> >     qdisc_create(A)               1
> >     qdisc_graft(A)                9
> >
> >    RTM_NEWTFILTER (X, RTNL-unlocked)
> >     __tcf_qdisc_find(A)          10
> >     tcf_chain0_head_change(A)
> >     mini_qdisc_pair_swap(A) (1st)
> >              |
> >              |                         RTM_NEWQDISC (B, RTNL-locked)
> >           RCU sync                2     qdisc_graft(B)
> >              |                    1     notify_and_destroy(A)
> >              |
> >     tcf_block_release(A)          0    RTM_NEWTFILTER (Y, RTNL-unlocked=
)
> >     qdisc_destroy(A)                    tcf_chain0_head_change(B)
> >     tcf_chain0_head_change_cb_del(A)    mini_qdisc_pair_swap(B) (2nd)
> >     mini_qdisc_pair_swap(A) (3rd)                |
> >             ...                                 ...
> >
> > Here, B calls mini_qdisc_pair_swap(), pointing eth0->miniq_ingress to i=
ts
> > mini Qdisc, b1.  Then, A calls mini_qdisc_pair_swap() again during
> > ingress_destroy(), setting eth0->miniq_ingress to NULL, so ingress pack=
ets
> > on eth0 will not find filter Y in sch_handle_ingress().
> >
> > This is only one of the possible consequences of concurrently accessing
> > miniq_{in,e}gress pointers.  The point is clear though: again, A should
> > never modify those per-net_device pointers after B, and B should not
> > update A's RCU state.
> >
> > Fixes: 7a096d579e8e ("net: sched: ingress: set 'unlocked' flag for Qdis=
c ops")
> > Fixes: 87f373921c4e ("net: sched: ingress: set 'unlocked' flag for clsa=
ct Qdisc ops")
> > Reported-by: syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/r/0000000000006cf87705f79acf1a@google.c=
om/
> > Cc: Hillf Danton <hdanton@sina.com>
> > Cc: Vlad Buslov <vladbu@mellanox.com>
> > Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
>
> Tested-by: Pedro Tammela <pctammela@mojatatu.com>


Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>


cheers,
jamal
