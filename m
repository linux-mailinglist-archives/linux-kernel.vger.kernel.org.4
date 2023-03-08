Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497B76B006E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCHIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCHIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:01:35 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CCBA8816
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:01:18 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id bn17so9101756pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678262477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDCjQdRoF6A1zhDfujzOV2lR68X4W8Elimj1cx25yU4=;
        b=RFHYaEbk6DSYiAz1lTZoih8vQNFrAMNEkE+XlewBarCH6k2LAcfM45zl8kmwsGf+pa
         Sno0I2FW/IuAIfghyHI0y91rtIj7cP1Rladw2lqaxttpc/Py6ZlXhC8BIGfeDlRBEn8E
         XN961D8BJQ184gOzrMa1zG7rj+XtUtAx2w3nxPKCwfGqxmDeKgrLYJiL4PshuL83niGr
         fzswSigrSW2b+JVX05Zp+qw567GF/XjJgXKa0ll1IIpMUkmyUivaJ9i8LALi76Rw0M3o
         Gh6NAoRntcLGXJudMmaxOixDMXHDipxw5mNda28POlO89EE/up7rbQ60hbRmkKuwvVGI
         7CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678262477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDCjQdRoF6A1zhDfujzOV2lR68X4W8Elimj1cx25yU4=;
        b=k/gLHpnDLR0P4jq9HFyzEaX3n/axNFCHnSV6XbyfTng13F7PR5PTnKWEmxNbfESbHG
         EhpNs7AnQ8Ia6XZV//oq9Z+1VCPWTGJjc1ySG9tE210hM222YR2TsOtpYr7ATciaSKuX
         tMf9iAn3f1iKFEeRtHPcoX84sQ8gIoTjYgnUAb7KvA2zzTq46ptS/wVuOrEVnGTxJUnC
         BL/FGppOUwUban6oVqJ0AyluJ+UBFTp3xcEfEK7oIpzBF1Cel1I9XEaq8w3iD06+sYQk
         Se4v8+ClSCM/LykUpZvKjc9dPbg3j0lyIv6kUwVh74LA87tklMTuMjz4MptYuWThpg+C
         9VoQ==
X-Gm-Message-State: AO0yUKV1eXA8dWZuVRNUZdvfzDnrLXjfmComfr1T9O/ikA3IJl5XDGIX
        JDi2S7Z7lGv+1Qgnf2KQVoOgXEGkahD06EkPD0VMHg==
X-Google-Smtp-Source: AK7set/iDU5Vu20LLrxF5Rc8c5+JIbDs4GtTogpTn0zH7aKFI8T4Fi0wzw4zjfpv0K+BdW3GyqGzGUzId9wJmXrofQg=
X-Received: by 2002:a62:86c5:0:b0:5e9:57b1:5bda with SMTP id
 x188-20020a6286c5000000b005e957b15bdamr7043669pfd.3.1678262477425; Wed, 08
 Mar 2023 00:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <CAKfTPtAYpkQVDBR0mcymVgu7aYY5rN1svW713mGJxbewHGJRqQ@mail.gmail.com>
 <CAKfTPtAOFthDtQj=EGbTzwG6ZE7GPpp_3Xg9wVr_8epO+fiFjw@mail.gmail.com> <d4d849e3-ea4b-1f84-b287-513fb7bff415@huawei.com>
In-Reply-To: <d4d849e3-ea4b-1f84-b287-513fb7bff415@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Mar 2023 09:01:05 +0100
Message-ID: <CAKfTPtAVrmPCwuJ55e6TLrVjQnsgDAdg2rGY_0DXcJGzBft15Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 14:41, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/3/7 18:26, Vincent Guittot =E5=86=99=E9=81=93:
> > On Mon, 6 Mar 2023 at 14:53, Vincent Guittot <vincent.guittot@linaro.or=
g> wrote:
> >>
> >> On Mon, 6 Mar 2023 at 13:57, Zhang Qiao <zhangqiao22@huawei.com> wrote=
:
> >>>
> >>> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
> >>> entity being placed") fix an overflowing bug, but ignore
> >>> a case that se->exec_start is reset after a migration.
> >>>
> >>> For fixing this case, we reset the vruntime of a long
> >>> sleeping task in migrate_task_rq_fair().
> >>>
> >>> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being p=
laced")
> >>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> >>
> >> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>
> >>> ---
> >>>
> >>> v1 -> v2:
> >>> - fix some typos and update comments
> >>> - reformat the patch
> >>>
> >>> ---
> >>>  kernel/sched/fair.c | 76 ++++++++++++++++++++++++++++++++-----------=
--
> >>>  1 file changed, 55 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 7a1b1f855b96..74c9918ffe76 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -4648,11 +4648,45 @@ static void check_spread(struct cfs_rq *cfs_r=
q, struct sched_entity *se)
> >>>  #endif
> >>>  }
> >>>
> >>> +static inline bool entity_is_long_sleep(struct sched_entity *se)
> >>> +{
> >>> +       struct cfs_rq *cfs_rq;
> >>> +       u64 sleep_time;
> >>> +
> >>> +       if (se->exec_start =3D=3D 0)
> >>> +               return false;
> >>> +
> >>> +       cfs_rq =3D cfs_rq_of(se);
> >>> +       sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> >>> +       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>> +               return true;
> >>> +
> >>> +       return false;
> >>> +}
> >>> +
> >>> +static inline u64 sched_sleeper_credit(struct sched_entity *se)
> >>> +{
> >>> +       unsigned long thresh;
> >>> +
> >>> +       if (se_is_idle(se))
> >>> +               thresh =3D sysctl_sched_min_granularity;
> >>> +       else
> >>> +               thresh =3D sysctl_sched_latency;
> >>> +
> >>> +       /*
> >>> +        * Halve their sleep time's effect, to allow
> >>> +        * for a gentler effect of sleepers:
> >>> +        */
> >>> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >>> +               thresh >>=3D 1;
> >>> +
> >>> +       return thresh;
> >>> +}
> >>> +
> >>>  static void
> >>>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int ini=
tial)
> >>>  {
> >>>         u64 vruntime =3D cfs_rq->min_vruntime;
> >>> -       u64 sleep_time;
> >>>
> >>>         /*
> >>>          * The 'current' period is already promised to the current ta=
sks,
> >>> @@ -4664,23 +4698,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sch=
ed_entity *se, int initial)
> >>>                 vruntime +=3D sched_vslice(cfs_rq, se);
> >>>
> >>>         /* sleeps up to a single latency don't count. */
> >>> -       if (!initial) {
> >>> -               unsigned long thresh;
> >>> -
> >>> -               if (se_is_idle(se))
> >>> -                       thresh =3D sysctl_sched_min_granularity;
> >>> -               else
> >>> -                       thresh =3D sysctl_sched_latency;
> >>> -
> >>> -               /*
> >>> -                * Halve their sleep time's effect, to allow
> >>> -                * for a gentler effect of sleepers:
> >>> -                */
> >>> -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >>> -                       thresh >>=3D 1;
> >>> -
> >>> -               vruntime -=3D thresh;
> >>> -       }
> >>> +       if (!initial)
> >>> +               vruntime -=3D sched_sleeper_credit(se);
> >>>
> >>>         /*
> >>>          * Pull vruntime of the entity being placed to the base level=
 of
> >>> @@ -4689,8 +4708,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int initial)
> >>>          * the base as it may be too far off and the comparison may g=
et
> >>>          * inversed due to s64 overflow.
> >>>          */
> >>> -       sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> >>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>> +       if (entity_is_long_sleep(se))
> >>>                 se->vruntime =3D vruntime;
> >>>         else
> >>>                 se->vruntime =3D max_vruntime(se->vruntime, vruntime)=
;
> >>> @@ -7635,7 +7653,23 @@ static void migrate_task_rq_fair(struct task_s=
truct *p, int new_cpu)
> >>>         if (READ_ONCE(p->__state) =3D=3D TASK_WAKING) {
> >>>                 struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> >>>
> >>> -               se->vruntime -=3D u64_u32_load(cfs_rq->min_vruntime);
> >>> +               /*
> >>> +                * We determine whether a task sleeps for long by che=
cking
> >>> +                * se->exec_start, and if it is, we sanitize its vrun=
time at
> >>> +                * place_entity(). However, after a migration, this d=
etection
> >>> +                * method fails due to se->exec_start being reset.
> >>> +                *
> >>> +                * For fixing this case, we add the same check here. =
For a task
> >>> +                * which has slept for a long time, its vruntime shou=
ld be reset
> >>> +                * to cfs_rq->min_vruntime with a sleep credit. Becau=
se waking
> >>> +                * task's vruntime will be added to cfs_rq->min_vrunt=
ime when
> >>> +                * enqueue, we only need to reset the se->vruntime of=
 waking task
> >>> +                * to a credit here.
> >>> +                */
> >>> +               if (entity_is_long_sleep(se))
> >
> > I completely overlooked that we can't use rq_clock_task here. Need to
> > think a bit more on this
>
> Hi,Vincent,
>
> How about using exec_start of the parent sched_entity instant of rq_clock=
_task()?

How do we handle sched_entity without a parent sched_entity ?



>
> If during the waking sched_entity sleep, there are sibling sched_entity r=
unning,
> than `pse->exec_start` was up to date.
> If the cfs_rq was idle, we don't have a problem of possible overflow.
>
> static inline bool vruntime_need_sanitized(struct sched_entity *se)
> {
>         struct sched_entity *pse =3D parent_entity(se);
>         u64 diff ;
>
>         if (se->exec_start =3D=3D 0 || !pse)
>                 return false;
>
>         diff =3D pse->exec_start - se->exec_start;
>         if ((s64)diff > 60LL * NSEC_PER_SEC)
>                 return true;
>
>         return false;
> }
>
> Thanks.
> ZhangQiao.
>
> >
> >>> +                       se->vruntime =3D -sched_sleeper_credit(se);
> >>> +               else
> >>> +                       se->vruntime -=3D u64_u32_load(cfs_rq->min_vr=
untime);
> >>>         }
> >>>
> >>>         if (!task_on_rq_migrating(p)) {
> >>> --
> >>> 2.17.1
> >>>
> > .
> >
