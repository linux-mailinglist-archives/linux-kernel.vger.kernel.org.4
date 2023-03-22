Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2486C57F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjCVUnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCVUnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:43:03 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6FB6A1D4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:35:33 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id f17so485135oiw.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679517333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu2h90EZXqqHnyGZP4tgcVDI/BkonpfX71PdMnP2qng=;
        b=sAi9bJxYdLbyJKHPVeLX9P2IMP6CgkBF1FpWKDkRsF8ghgVdnmw9vDzl8QKIbumoKT
         jjFFVu/YCvhK90/C6pHDTwsVCm3jGdRB2gbCop2YEzS7kQDCcKcGbDw+lG++eHx8c409
         sz9VFRegHeiIUA84h0x/j/RxptMPgbvmKBHWGgUaX+GzuoUbuc/hW36Ka1WXJj2FEK2Z
         Zc8g7d+Hm6zCCJhfOzO/7qm6uo3sNfWashWeWb3vjSXwN1MMoKXaTEIVVKotKx3bG+p/
         3Xz9cpi57M8fsEZa0oL3u2K6+Utgy8zxcvwqGZfTzFM4bjo05MFF4ITSQnM8YYzTNgUb
         TO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679517333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pu2h90EZXqqHnyGZP4tgcVDI/BkonpfX71PdMnP2qng=;
        b=vmhdFq0Xd+anvij93UJIe3k3ma9AWro98cs3vZYXqipGXI6Ot5lunmR0BZWHSHiKJh
         gaQrWasWYCSbQtmilm/VsBmONQNxm/IH7b49+IowlTab/IEqNGwR9gxFf5XCOxTnBui+
         hsbhSloCkC2PMLztVS7zI9Z3J3yZZgc3v6w4USNuEE9CpUqVb5PRp/Oe8x14pdnFSQoZ
         woEkaVNIbsIICZT3bIk2hUU2juA6DzqRBxqhtpcJ7D/cUn9YTlYyAf9wfMj6hJ+KgTt/
         fK+4SEN/abjJoLhscvysG0P8o9w6jZNGF3GCpF71IhCq3S6YUbkCodDz+rgN/HA/WMVu
         uDaw==
X-Gm-Message-State: AO0yUKXIWKY03BhuMacFnZK6yhFsiCaPwAR5NHkmFlokUI6yYCz/eQxV
        IfRb9WafzKcb+Fg649qeEaFnK69NIFlg7qodzKMkmw==
X-Google-Smtp-Source: AK7set/XYe1wMF+7wLYZVYgrV4t33p0T+/N6QzvxPf4OmD6B6DvIPknLcrE6fStrvlMQzxzjxM4pkmqcZ3hA1Y+Gujo=
X-Received: by 2002:a05:6808:b22:b0:386:cb70:3828 with SMTP id
 t2-20020a0568080b2200b00386cb703828mr1388301oij.4.1679517332852; Wed, 22 Mar
 2023 13:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230308100414.37114-1-jiahao.os@bytedance.com>
 <4972a8be-d300-a66e-7fac-a83f11b56fbf@bytedance.com> <CAEXW_YRG0Bw4U1+zOPpjRPQEeKNDMrs7x-ZE-W00aifn7heG4g@mail.gmail.com>
In-Reply-To: <CAEXW_YRG0Bw4U1+zOPpjRPQEeKNDMrs7x-ZE-W00aifn7heG4g@mail.gmail.com>
From:   Vineeth Pillai <vineethrp@google.com>
Date:   Wed, 22 Mar 2023 16:35:20 -0400
Message-ID: <CA+HDTgT0sjt38E4-2uQs_2t1GSsYFDqz3porOx-WQbt8x9hhXw@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Minor optimize pick_next_task() when
 core-sched enable
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
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

Merging two threads.

On Tue, Mar 21, 2023 at 5:40=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
> >
> > CPU0 and CPU1 are two CPUs on the same core, task0 and task2 are the
> > highest priority tasks on rq0 and rq1 respectively, task2 is @max
> > on the entire core.

> I'm assuming this all starts by rq0 doing a pick and getting task0.
> Because any other selection would go down the whole !need_sync route.
>
I think this could also happen when rq1 starts the pick due to task2 wakeup
while task0 was running in rq0. In this case, core->core_cookie would be se=
t
and we take the need_sync path I guess.

> > In the case that 'max' has a zero cookie, instead of continuing to
> > search for a runnable task on rq0 that matches @max's cookie, we
> > choose idle for rq0 directly.
> > At this time, it is obviously better to choose task1 to run for rq0,
> > which will increase the CPU utilization.
> > Therefore, we queue tasks with zero cookies in core_tree, and record
> > the number of non-zero cookie tasks of each rq to detect the status
> > of the sched-core.
>
> I do remember this as a known issue (more of a known but unimplemented
> optimization) which happens when you have a high priority non-cookie
> task which is in front of several low priority ones on the same
> thread/rq. Adding +Vineeth Pillai to see if he remembers the issue.
>
Yes, I remember this as one of the 2 issues we noticed, but could not get t=
o
fixing it. Here we have non-cookied tasks considered special as a side effe=
ct
of implementation(non-cookied tasks not in core rbtree) and hence we force =
idle
if max is non-cookied and the highest prio task on the sibling is cookied.

The other issue was - we don't update core rbtree when vruntime changes and
this can cause starvation of cookied task if there are more than one task w=
ith
the same cookie on an rq.

> >  static inline void dequeue_task(struct rq *rq, struct task_struct *p, =
int flags)
> >  {
> > - if (sched_core_enabled(rq))
> > - sched_core_dequeue(rq, p, flags);
> > + sched_core_dequeue(rq, p, flags);
> >
> >  if (!(flags & DEQUEUE_NOCLOCK))
> >  update_rq_clock(rq);

> Yeah, this is an absolute no-no, it makes the overhead of the second rb
> tree unconditional.

I agree. Could we keep it conditional by enqueuing 0-cookied tasks only whe=
n
coresched is enabled, just like what we do for cookied tasks? This is still=
 an
overhead where we have two trees storing all the runnable tasks but in
different order. We would also need to populate core rbtree from cfs rbtree
on coresched enable and empty the tree on coresched disable.

Thanks,
Vineeth
