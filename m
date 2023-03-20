Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2E6C133C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjCTN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjCTN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:26:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E588D24725
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:26:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u20so6448176pfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679318807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fgTt2Ao0ISWSUH3uhfkiBoC8HyvGwhHuixHsaZdKFU=;
        b=NOKmCUsfoxAIWkNMwy+/UWwl4Z67ce5g8wFCbadXaSfkxUYcH6mZskKk7dorEqEBcy
         Zj5DhpJFqSjMVEyGLaS4G6X/3ELMnSiL7zAZguIKTfJHAbM9lulQ/gsFQs59hW/0kBa4
         wJtvnEV3y/kjs7J0imUlxwMk1pl8G3NuCq9QIQnEDWlmh/N8GDN2o21/jp2b1hPSIzmF
         SgEHawi9n5Z8TWFy9jd1lJbQklx2Rzk2fgosDTR8B8hLEGyVQ+qsKOe0X4xVlbtquJNi
         lWjFoFB4SMrVIC6aclw8IFlymzzSm6/9hhrFP1qG7Le+8YCxrJQKc4HvyOw4i/7K1HqI
         rfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679318807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fgTt2Ao0ISWSUH3uhfkiBoC8HyvGwhHuixHsaZdKFU=;
        b=G2KiJ/+yw+nLosdkUdmO/1IyjtczpqgC23xst2W3yFWX1e9AS4yyy/9vkxhdixmX1T
         RIQMPpRBUkmhpdnZnbSzNUzfUwmjxCa7pCxoYnXEYFsUsJRs33aoKgYOs2DCGPLrO2bY
         AMvqLz2tQ3ZY0Ep+aHxUDo894jjqy7MGkz8oifJqvXdIl/pTVsC5s+qRjkQKmMY/5Ywo
         +7UgGGnKFTt6UjSmkRuwDXwssN1oIoLhuN51HGVYUKHZSywpAReR5Wdux1qIfKBtJtWB
         jXn6L5rcr6MaeK3c43UI+K29TiL0zcw3eT3+vWK2h+GguXCBguSxOHa/l5EUEE1e4vAp
         ELEQ==
X-Gm-Message-State: AO0yUKXyHGKx09CU8+2TPZ8/EmD/KGH7c87WgjoSWguThs1epJ0vMrWg
        i+Qrye4Sgm2BKRDnGvTe5Hct3taI/CFHyrYEBqm/tA==
X-Google-Smtp-Source: AK7set90mTaGguMUli06F/qC2JcjSTOHtck3FWOY6WoE4T4u2ATWF/ctlvNzELkk+E0LkU3f8D8i+oIOKQPr6LvfG7g=
X-Received: by 2002:a63:7519:0:b0:50b:cf00:7d2e with SMTP id
 q25-20020a637519000000b0050bcf007d2emr1884550pgc.11.1679318807094; Mon, 20
 Mar 2023 06:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230317160810.107988-1-vincent.guittot@linaro.org>
 <f0f7bce7-4d98-c5d0-5e75-55f27a9a0d69@huawei.com> <df2cccda-1550-b06b-aa74-e0f054e9fb9d@arm.com>
In-Reply-To: <df2cccda-1550-b06b-aa74-e0f054e9fb9d@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 20 Mar 2023 14:26:35 +0100
Message-ID: <CAKfTPtADr6ds6kmfE73J-33fT6mkziGZ4=x45rpwmGhv-u1f2A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 at 13:29, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>
> On 18/03/2023 08:45, Zhang Qiao wrote:
> >
> >
> > =E5=9C=A8 2023/3/18 0:08, Vincent Guittot =E5=86=99=E9=81=93:
> >> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being pl=
aced")
> >> fixes an overflowing bug, but ignore a case that se->exec_start is res=
et
> >> after a migration.
> >>
> >> For fixing this case, we delay the reset of se->exec_start after
> >> placing the entity which se->exec_start to detect long sleeping task.
> >>
> >> In order to take into account a possible divergence between the clock_=
task
> >> of 2 rqs, we increase the threshold to around 104 days.
> >>
> >>
> >> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being pl=
aced")
> >> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> ---
> >>
> >> My last proposal was not yet correct as the exec_start was not always
> >> reset after migrating a task. I finally found this solution which keep=
s
> >> the long sleep detection to one place as well as the reset of se->exec=
_start.
> >>
> >
> > Tested-by: Zhang Qiao <zhangqiao22@huawei.com>
> >
> > I have retested it with this version, and the result is fine.
> >
> > -------
> >
> >  Performance counter stats for 'hackbench -g 44 -f 20 --process --pipe =
-l 60000 -s 100' (10 runs):
> >
> >              80.10 +- 1.22 seconds time elapsed  ( +-  1.53% )
>
> [...]
>
> >> @@ -8701,7 +8734,7 @@ static void attach_task(struct rq *rq, struct ta=
sk_struct *p)
> >>      lockdep_assert_rq_held(rq);
> >>
> >>      WARN_ON_ONCE(task_rq(p) !=3D rq);
> >> -    activate_task(rq, p, ENQUEUE_NOCLOCK);
> >> +    activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_MIGRATED);
> >>      check_preempt_curr(rq, p, 0);
>
> Why not:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b9bc1ab67aaa..96dd3a62e683 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7674,7 +7674,10 @@ static void migrate_task_rq_fair(struct task_struc=
t *p, int new_cpu)
>                 se->vruntime -=3D u64_u32_load(cfs_rq->min_vruntime);
>         }
>
> -       if (!task_on_rq_migrating(p)) {
> +       if (task_on_rq_migrating(p)) {
> +               /* We have migrated, no longer consider this task hot */
> +               se->exec_start =3D 0;

mainly to keep the clear of se->exec_start =3D 0 in one place to ease
the maintenance


> +       } else {
>                 remove_entity_load_avg(se);
>
>                 /*
> @@ -8726,7 +8729,7 @@ static void attach_task(struct rq *rq, struct task_=
struct *p)
>         lockdep_assert_rq_held(rq);
>
>         WARN_ON_ONCE(task_rq(p) !=3D rq);
> -       activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_MIGRATED);
> +       activate_task(rq, p, ENQUEUE_NOCLOCK);
>         check_preempt_curr(rq, p, 0);
>  }
>
>
> entity_is_long_sleeper() will bail early for these rq-migrating tasks
> for which a long-sleep test would make little sense anyway.
>
> Plus move_queued_task() (e.g. from sched_exex()) would be covered as well=
.
