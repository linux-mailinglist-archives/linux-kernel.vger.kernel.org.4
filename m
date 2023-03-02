Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F26A8398
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCBNee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCBNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:34:32 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7C42BD8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:34:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so2755776pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vvm49yIZisfOyIXuBIbhM6hRv9goT2gWgCy9ZuaFUA=;
        b=FUXbk/kMjRW7xYzlebsTptUGZcv1h5muQ2ADROmkStm0x741DGmkhRgVyN7ZkXh8qj
         MAnLJxUdqk8xuBOGHfW7mA+cI5J+mDdU7o1CsCp9WcL4wx2miSiDr6jZqn90MMXgrJvW
         tDhU7BMKlmSEw2B6ZLt6IK8PIci7LMt4kbJgrdAoBXVYrH6IFFHrwpsJORwjlGL2hrXE
         Z+8UaHi/AGlxoSZgjP921shSpzTgCwTQjrKXgsYJ6QnVn2A3+KaujsIUIn092xOOTyL0
         4BdTTuO2WSDqmAWJ13knpV2sfqmsMn35+kGyq7w+Q2Wepbf8zIj+KD37WlhXbY0NrNI2
         OMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vvm49yIZisfOyIXuBIbhM6hRv9goT2gWgCy9ZuaFUA=;
        b=N3+drNVQZspKaq/Ctfw7ocasYZSYr/6i1wT+vZQyr9/cFmcQjKExwAto5P7P70sx7r
         AMLKnJ/JCAgG6xgZUTEbSVgu2WYoWMLekOcXdoFyBATen6U2ndDBudRPsgzooWNh2IDL
         KCyCqwCjysip4uzsErMmJ1nQL7A280Y76o9N03dStFByXa2fRnZNzr+cng+ScQD7tZcP
         UmKBJpzWXB2GubjRLjVhsjBt6KA9QmFRVv9a1EMKp1fE3LKonJk+NmzSovcPekFKFeGf
         ASl9FYzAr3pTYhdOPfBYyITDx3hnkwiypgNsHKd8Y7bZNIg0QBcmRSZ0m4J3c4wg1aN4
         Cieg==
X-Gm-Message-State: AO0yUKU/QMjitC73MVJGtTP9U9+0J9pkFDuvksQd3waJjXkyo2t43rol
        1Lt2LUSU7cutA4hqZGd2Kd8kbGDjrkvqzvrNGIFDxA==
X-Google-Smtp-Source: AK7set9xoIG6cvrUXLNbqTKrf9lbajTPKtDfG9lY8JxkKtS8cxP/W1EbNwPE3bJzYKfiw/ir6v9MJy5VSQswmB11WJ4=
X-Received: by 2002:a17:90b:1995:b0:235:1fb7:393c with SMTP id
 mv21-20020a17090b199500b002351fb7393cmr943188pjb.1.1677764070408; Thu, 02 Mar
 2023 05:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20230209193107.1432770-1-rkagan@amazon.de> <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
 <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com> <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
 <Y/xtDWYTKLutOqrM@u40bc5e070a0153.ant.amazon.com> <CAKfTPtAq3yBYBxpR=RO8zxrQduOymqkdAEhigjfCuGfsY1uHsg@mail.gmail.com>
 <1cd19d3f-18c4-92f9-257a-378cc18cfbc7@huawei.com>
In-Reply-To: <1cd19d3f-18c4-92f9-257a-378cc18cfbc7@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Mar 2023 14:34:19 +0100
Message-ID: <CAKfTPtB9oYsKHLF--nVwNT5z-9tCR3bBWd8mPe4NWZ5S3y43Lg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     Roman Kagan <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
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

On Thu, 2 Mar 2023 at 10:36, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/2/27 22:37, Vincent Guittot =E5=86=99=E9=81=93:
> > On Mon, 27 Feb 2023 at 09:43, Roman Kagan <rkagan@amazon.de> wrote:
> >>
> >> On Tue, Feb 21, 2023 at 06:26:11PM +0100, Vincent Guittot wrote:
> >>> On Tue, 21 Feb 2023 at 17:57, Roman Kagan <rkagan@amazon.de> wrote:
> >>>> What scares me, though, is that I've got a message from the test rob=
ot
> >>>> that this commit drammatically affected hackbench results, see the q=
uote
> >>>> below.  I expected the commit not to affect any benchmarks.
> >>>>
> >>>> Any idea what could have caused this change?
> >>>
> >>> Hmm, It's most probably because se->exec_start is reset after a
> >>> migration and the condition becomes true for newly migrated task
> >>> whereas its vruntime should be after min_vruntime.
> >>>
> >>> We have missed this condition
> >>
> >> Makes sense to me.
> >>
> >> But what would then be the reliable way to detect a sched_entity which
> >> has slept for long and risks overflowing in .vruntime comparison?
> >
> > For now I don't have a better idea than adding the same check in
> > migrate_task_rq_fair()
>
> Hi, Vincent=EF=BC=8C
> I fixed this condition as you said, and the test results are as follows.
>
> testcase: hackbench -g 44 -f 20 --process --pipe -l 60000 -s 100
> version1: v6.2
> version2: v6.2 + commit 829c1651e9c4
> version3: v6.2 + commit 829c1651e9c4 + this patch
>
> -------------------------------------------------
>         version1        version2        version3
> test1   81.0            118.1           82.1
> test2   82.1            116.9           80.3
> test3   83.2            103.9           83.3
> avg(s)  82.1            113.0           81.9
>
> -------------------------------------------------
> After deal with the task migration case, the hackbench result has restore=
d.
>
> The patch as follow, how does this look?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff4dbbae3b10..3a88d20fd29e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4648,6 +4648,26 @@ static void check_spread(struct cfs_rq *cfs_rq, st=
ruct sched_entity *se)
>  #endif
>  }
>
> +static inline u64 sched_sleeper_credit(struct sched_entity *se)
> +{
> +
> +       unsigned long thresh;
> +
> +       if (se_is_idle(se))
> +               thresh =3D sysctl_sched_min_granularity;
> +       else
> +               thresh =3D sysctl_sched_latency;
> +
> +       /*
> +        * Halve their sleep time's effect, to allow
> +        * for a gentler effect of sleepers:
> +        */
> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +               thresh >>=3D 1;
> +
> +       return thresh;
> +}
> +
>  static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial=
)
>  {
> @@ -4664,23 +4684,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_e=
ntity *se, int initial)
>                 vruntime +=3D sched_vslice(cfs_rq, se);
>
>         /* sleeps up to a single latency don't count. */
> -       if (!initial) {
> -               unsigned long thresh;
> -
> -               if (se_is_idle(se))
> -                       thresh =3D sysctl_sched_min_granularity;
> -               else
> -                       thresh =3D sysctl_sched_latency;
> -
> -               /*
> -                * Halve their sleep time's effect, to allow
> -                * for a gentler effect of sleepers:
> -                */
> -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
> -                       thresh >>=3D 1;
> -
> -               vruntime -=3D thresh;
> -       }
> +       if (!initial)
> +               vruntime -=3D sched_sleeper_credit(se);
>
>         /*
>          * Pull vruntime of the entity being placed to the base level of
> @@ -4690,7 +4695,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se, int initial)
>          * inversed due to s64 overflow.
>          */
>         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> +       if (se->exec_start !=3D 0 && (s64)sleep_time > 60LL * NSEC_PER_SE=
C)
>                 se->vruntime =3D vruntime;
>         else
>                 se->vruntime =3D max_vruntime(se->vruntime, vruntime);
> @@ -7634,8 +7639,12 @@ static void migrate_task_rq_fair(struct task_struc=
t *p, int new_cpu)
>          */
>         if (READ_ONCE(p->__state) =3D=3D TASK_WAKING) {
>                 struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> +               u64 sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exe=
c_start;
>
> -               se->vruntime -=3D u64_u32_load(cfs_rq->min_vruntime);
> +               if ((s64)sleep_time > 60LL * NSEC_PER_SEC)

You also need to test (se->exec_start !=3D0) here because the task might
migrate another time before being scheduled. You should create a
helper function like below and use it in both place

static inline bool entity_long_sleep(se)
{
        struct cfs_rq *cfs_rq;
        u64 sleep_time;

        if (se->exec_start =3D=3D 0)
                return false;

        cfs_rq =3D cfs_rq_of(se);
        sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
        if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
                return true;

        return false;
}


> +                       se->vruntime =3D -sched_sleeper_credit(se);
> +               else
> +                       se->vruntime -=3D u64_u32_load(cfs_rq->min_vrunti=
me);
>         }
>
>         if (!task_on_rq_migrating(p)) {
>
>
>
> Thanks.
> Zhang Qiao.
>
> >
> >>
> >> Thanks,
> >> Roman.
> >>
> >>
> >>
> >> Amazon Development Center Germany GmbH
> >> Krausenstr. 38
> >> 10117 Berlin
> >> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> >> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> >> Sitz: Berlin
> >> Ust-ID: DE 289 237 879
> >>
> >>
> >>
> > .
> >
