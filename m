Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8372C6EE44C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjDYOyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjDYOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:54:01 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A71185
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:53:59 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3ef36d814a5so123971cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682434439; x=1685026439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuHDHNbt3YJMpWIFNXP+FapXExBGYAbfn2VNS6xxy2g=;
        b=3wdXyXUdCfEJ1PKKPxXw1hnxrcgJoof23Fft2xwDNj16EUlR6sBu/ux+lOoQdX9mTZ
         e2BRSjTCs9l7X9oUi+fPAAuXsSwHcteEToRQPn7b9KTC/4cwubgpyzQK0721XQAMiz7H
         sxVlSZLOiYKZ/6Qya9jf6FexCVkIecEMjK/cVqebQ5CeVm7M4KGSpY5ZppIrW/HUXbtO
         /niMKgmmS7uMW4FkEjNt/z6cU33zr8l9ehgomcU1aobyBycDCOCUbbS3hSgRFfBWIu3t
         bNxOgW0NXMRybcy+TIP3DNAdi/oFukH7ClGp5zSv5HwtFYk7vvUTA+UTYl4wKz2qXc+1
         a6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682434439; x=1685026439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuHDHNbt3YJMpWIFNXP+FapXExBGYAbfn2VNS6xxy2g=;
        b=Mr8VNf/FweVAy3K7+XlUnwvYI2gQH3MQA77p8fQvMQKVlxlW3MXeGeWbl0eKcBIyW1
         rUq/LB19NNknVQE/jr8Q3TRN0sLnusqGdSBqD8IW/xKUPZzCHk5K+AwhDU+sj/Mvw9cK
         RZP2htji9qRt02Is5nsfRasPgfa95kjPjOIZfOdXJVFyBQSaJM04InYdgpCCdRoj0KE9
         F+6jiZM+oJUvwFbSi5Hm0pMjE/pt5CxtoTncnJUk/w/TVa47eY+Pspp/UeLIv1Z0YmRh
         fsvC5z9a4dKFIGE7ob3szxohdTMYsceCudnxiGkOA9SA6oSWiw/9mdunRH5p7ZVp3VjV
         El2g==
X-Gm-Message-State: AAQBX9fSBo02vM1tK24wWWB41yzXdFzzGKQxg8lJQzbwuWJoL9xqpban
        xSMlSKtwjnPK6dkkDmzMjJqeXKRr8/prVArWnE+N
X-Google-Smtp-Source: AKy350YPcxVGafDPRLbb4ctabGlwgtvcZ/5g0hxjb/Hn+qc+0StApEbZnTUOtMhy6gYrQv+TPf/tBeu6gQ7OkzrmF2I=
X-Received: by 2002:a05:622a:1801:b0:3ef:5008:336f with SMTP id
 t1-20020a05622a180100b003ef5008336fmr354227qtc.1.1682434438727; Tue, 25 Apr
 2023 07:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com> <20230411042511.1606592-7-jstultz@google.com>
 <20230422103618.GE1214746@hirez.programming.kicks-ass.net>
In-Reply-To: <20230422103618.GE1214746@hirez.programming.kicks-ass.net>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 25 Apr 2023 15:53:47 +0100
Message-ID: <CANDhNCqL5GRm0m+pON0n7KD-n=zj1bidZ+m2cHsgDP5D8jZF8Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] locking/mutex: Expose mutex_owner()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 11:36=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Apr 11, 2023 at 04:25:03AM +0000, John Stultz wrote:
>
> >  include/linux/mutex.h  | 2 ++
> >  kernel/locking/mutex.c | 5 +++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> > index 8f226d460f51..ebdc59cb0bf6 100644
> > --- a/include/linux/mutex.h
> > +++ b/include/linux/mutex.h
> > @@ -118,6 +118,8 @@ do {                                               =
                       \
> >  extern void __mutex_init(struct mutex *lock, const char *name,
> >                        struct lock_class_key *key);
> >
> > +extern struct task_struct *mutex_owner(struct mutex *lock);
> > +
> >  /**
> >   * mutex_is_locked - is the mutex locked
> >   * @lock: the mutex to be queried
> > diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> > index 45f1b7519f63..cbc34d5f4486 100644
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -81,6 +81,11 @@ static inline struct task_struct *__mutex_owner(stru=
ct mutex *lock)
> >       return (struct task_struct *)(atomic_long_read(&lock->owner) & ~M=
UTEX_FLAGS);
> >  }
> >
> > +struct task_struct *mutex_owner(struct mutex *lock)
> > +{
> > +     return __mutex_owner(lock);
> > +}
> > +
> >  static inline struct task_struct *__owner_task(unsigned long owner)
> >  {
> >       return (struct task_struct *)(owner & ~MUTEX_FLAGS);
>
>
> Urgh, no.
>
> It exposes mutex_owner() far wider than it should be, and also it turns
> what should be a simple load into a function call :/
>
> Looking at the lastest patches I have here this used to be an inline in
> kernel/locking/mutex.h and kernel/sched/core.c got to #include
> "../locking/mutex.h".

Sure. I'll rework it this way.

Thanks again for the feedback, and apologies for any frustration caused.
-john
