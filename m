Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A616C725A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCWVan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCWVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:30:39 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11416BDC9;
        Thu, 23 Mar 2023 14:30:38 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bk5so7977111oib.6;
        Thu, 23 Mar 2023 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679607037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYGawMaA5C9I8og6thwq+8ahieODy/UxjYv744M7Lsg=;
        b=fqEBzCibuTy1u7D82n6S4fav5cTjcJ23V97Sk6kFjjSMEVXnUf5FzEMIjlJZggk0tb
         RUwB+C5pPWNspWTo+0FYKKq7TW91va8rQg68/I7BAYIFYYMykqTwvCnlrIr5OuE2FTjR
         2igatK31JrJmNKovUnU/wWOvYZhd17XGr3eZjJqJbluQZbKTMyKFxP20Rz4+7xoUdcc6
         h/Szlzh2glnSZd92WkIo70de/07202kqssrfn962mYLsqCwl6nGkd7G655dK453BHzsL
         bIZqE+slN7eO7/aOoaox5IyQUbCNffxCZdp67VKA2+59HcTKk6uL4P7mN+kAKJ++qqqC
         t4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679607037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYGawMaA5C9I8og6thwq+8ahieODy/UxjYv744M7Lsg=;
        b=gQSH2jrWL8HMzoXg7jgo1Nf9mFf7AywQ745GgridHqW7o4FC+Dwjk46IoW3mi6taLp
         QBfLND2vqVUQQWv7/apn0Q1XImiu58t59TY/qY8u51Vr4Jjc1nD+R0HXFJVPcbxnjmqd
         ROrCnsJst3QbZDuF+KWQdS4pbSr660CFcj14bBGTpLcaJqLaRMy9DNYSXtCyuBHufzEP
         kKnvg3Bmwowu4oYNSTeLTfewHjauOfEqSi8ayCgmfbA6y/18SmP/BoiUVXxKLseazziJ
         HcAgZNlhAkbTxaiiIcK6p/7VnDhWt3swTxoaaUkVkRf1zSClF/t0TeiKK69E5ApRjY+z
         wXwQ==
X-Gm-Message-State: AO0yUKWY8Ber2/c+ibxxZ++QMYUdayxNGnl2GM3T9wRHlFWBJt7pGaHw
        naPvJrcqrcyHsbNWAUu2kFRAXEBeaQbclrO/jO0=
X-Google-Smtp-Source: AK7set+lQIOQZa6G3yJgfeNWvhx4ZPw9QfSfPP4xMRabuyGwu/M0+lIKerUid2CsL2yKUuudaarY5sPyNjfYKO1ILwk=
X-Received: by 2002:a54:4716:0:b0:384:1e6a:bf10 with SMTP id
 k22-20020a544716000000b003841e6abf10mr36512oik.5.1679607035826; Thu, 23 Mar
 2023 14:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230322224403.35742-1-robdclark@gmail.com> <b9fb81f1-ac9e-cf3f-5cf4-f2d972d3ed3d@amd.com>
 <CAF6AEGvMwZCLntfYeH3Vg_Z7kYynqdVrinp+pmcbREksK1WGMA@mail.gmail.com> <e2fa296b-9b71-a41b-d37d-33f0fac2cd4e@amd.com>
In-Reply-To: <e2fa296b-9b71-a41b-d37d-33f0fac2cd4e@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 23 Mar 2023 14:30:24 -0700
Message-ID: <CAF6AEGvdVca_mnZVo9He9oKVfYp84e_kOPWaxX+K5aV4Es9kcQ@mail.gmail.com>
Subject: Re: [RFC] drm/scheduler: Unwrap job dependencies
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 7:03=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 23.03.23 um 14:54 schrieb Rob Clark:
> > On Thu, Mar 23, 2023 at 12:35=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Am 22.03.23 um 23:44 schrieb Rob Clark:
> >>> From: Rob Clark <robdclark@chromium.org>
> >>>
> >>> Container fences have burner contexts, which makes the trick to store=
 at
> >>> most one fence per context somewhat useless if we don't unwrap array =
or
> >>> chain fences.
> >> Mhm, we intentionally kept them not unwrapped since this way they only
> >> occupy one fence slot.
> >>
> >> But it might be better to unwrap them if you add many of those depende=
ncies.
> >>
> >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>> ---
> >>> tbh, I'm not sure why we weren't doing this already, unless there is
> >>> something I'm overlooking
> >>>
> >>>    drivers/gpu/drm/scheduler/sched_main.c | 43 +++++++++++++++++-----=
----
> >>>    1 file changed, 28 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm=
/scheduler/sched_main.c
> >>> index c2ee44d6224b..f59e5335afbb 100644
> >>> --- a/drivers/gpu/drm/scheduler/sched_main.c
> >>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> >>> @@ -41,20 +41,21 @@
> >>>     * 4. Entities themselves maintain a queue of jobs that will be sc=
heduled on
> >>>     *    the hardware.
> >>>     *
> >>>     * The jobs in a entity are always scheduled in the order that the=
y were pushed.
> >>>     */
> >>>
> >>>    #include <linux/kthread.h>
> >>>    #include <linux/wait.h>
> >>>    #include <linux/sched.h>
> >>>    #include <linux/completion.h>
> >>> +#include <linux/dma-fence-unwrap.h>
> >>>    #include <linux/dma-resv.h>
> >>>    #include <uapi/linux/sched/types.h>
> >>>
> >>>    #include <drm/drm_print.h>
> >>>    #include <drm/drm_gem.h>
> >>>    #include <drm/gpu_scheduler.h>
> >>>    #include <drm/spsc_queue.h>
> >>>
> >>>    #define CREATE_TRACE_POINTS
> >>>    #include "gpu_scheduler_trace.h"
> >>> @@ -665,41 +666,27 @@ void drm_sched_job_arm(struct drm_sched_job *jo=
b)
> >>>        sched =3D entity->rq->sched;
> >>>
> >>>        job->sched =3D sched;
> >>>        job->s_priority =3D entity->rq - sched->sched_rq;
> >>>        job->id =3D atomic64_inc_return(&sched->job_id_count);
> >>>
> >>>        drm_sched_fence_init(job->s_fence, job->entity);
> >>>    }
> >>>    EXPORT_SYMBOL(drm_sched_job_arm);
> >>>
> >>> -/**
> >>> - * drm_sched_job_add_dependency - adds the fence as a job dependency
> >>> - * @job: scheduler job to add the dependencies to
> >>> - * @fence: the dma_fence to add to the list of dependencies.
> >>> - *
> >>> - * Note that @fence is consumed in both the success and error cases.
> >>> - *
> >>> - * Returns:
> >>> - * 0 on success, or an error on failing to expand the array.
> >>> - */
> >>> -int drm_sched_job_add_dependency(struct drm_sched_job *job,
> >>> -                              struct dma_fence *fence)
> >>> +static int _add_dependency(struct drm_sched_job *job, struct dma_fen=
ce *fence)
> >> Please keep the drm_sched_job_ prefix here even for static functions.
> >> The symbol _add_dependency just sucks in a backtrace, especially when
> >> it's tail optimized.
> >>
> >>>    {
> >>>        struct dma_fence *entry;
> >>>        unsigned long index;
> >>>        u32 id =3D 0;
> >>>        int ret;
> >>>
> >>> -     if (!fence)
> >>> -             return 0;
> >>> -
> >>>        /* Deduplicate if we already depend on a fence from the same c=
ontext.
> >>>         * This lets the size of the array of deps scale with the numb=
er of
> >>>         * engines involved, rather than the number of BOs.
> >>>         */
> >>>        xa_for_each(&job->dependencies, index, entry) {
> >>>                if (entry->context !=3D fence->context)
> >>>                        continue;
> >>>
> >>>                if (dma_fence_is_later(fence, entry)) {
> >>>                        dma_fence_put(entry);
> >>> @@ -709,20 +696,46 @@ int drm_sched_job_add_dependency(struct drm_sch=
ed_job *job,
> >>>                }
> >>>                return 0;
> >>>        }
> >>>
> >>>        ret =3D xa_alloc(&job->dependencies, &id, fence, xa_limit_32b,=
 GFP_KERNEL);
> >>>        if (ret !=3D 0)
> >>>                dma_fence_put(fence);
> >>>
> >>>        return ret;
> >>>    }
> >>> +
> >>> +/**
> >>> + * drm_sched_job_add_dependency - adds the fence as a job dependency
> >>> + * @job: scheduler job to add the dependencies to
> >>> + * @fence: the dma_fence to add to the list of dependencies.
> >>> + *
> >>> + * Note that @fence is consumed in both the success and error cases.
> >>> + *
> >>> + * Returns:
> >>> + * 0 on success, or an error on failing to expand the array.
> >>> + */
> >>> +int drm_sched_job_add_dependency(struct drm_sched_job *job,
> >>> +                              struct dma_fence *fence)
> >> Maybe name the new function drm_sched_job_unwrap_add_dependency or
> >> something like this.
> >>
> >> I need to double check, but I think for some cases we don't need or
> >> don't even want this in the driver.
> > I'd be curious to know the cases where you don't want this.. one thing
> > I was thinking about, what if you have a container fence with two
> > contained fences.  One is on the same ctx as the job, one is not but
> > signals sooner.  You end up artificially waiting on both, which seems
> > sub-optimal.
>
> Well resv objects don't contain other containers for example.

I suppose I have the explicit sync case more in mind, where the
dependent fence ends up being a chain or array (if userspace is
merging fence fd's).

> Then we also have an use case in amdgpu where fence need to be
> explicitly waited for even when they are from the same ctx as the job
> because otherwise we wouldn't see everything cache coherent.

This was the kinda weird case I wanted to make sure I wasn't breaking.
I remember seeing something fly by for this, but can't find it now or
remember what amdgpu's solution was..

> On the other hand we currently handle that amdgpu use case differently
> and the extra overhead of unwrapping fences even if they can't be
> containers is probably negligible.
>
> > Anyways, I can make this a new entrypoint which unwraps, and/or rename
> > the internal static function, if we think this is a good idea.
>
> If you think that's unnecessary keeping your original approach is fine
> with me as well.

I'm going to assume unnecessary until someone speaks up with their
weird specific case ;-)

BR,
-R

> Regards,
> Christian.
>
> >
> > BR,
> > -R
> >
> >> Christian.
> >>
> >>> +{
> >>> +     struct dma_fence_unwrap iter;
> >>> +     struct dma_fence *f;
> >>> +     int ret =3D 0;
> >>> +
> >>> +     dma_fence_unwrap_for_each (f, &iter, fence) {
> >>> +             ret =3D _add_dependency(job, f);
> >>> +             if (ret)
> >>> +                     break;
> >>> +     }
> >>> +
> >>> +     return ret;
> >>> +}
> >>>    EXPORT_SYMBOL(drm_sched_job_add_dependency);
> >>>
> >>>    /**
> >>>     * drm_sched_job_add_resv_dependencies - add all fences from the r=
esv to the job
> >>>     * @job: scheduler job to add the dependencies to
> >>>     * @resv: the dma_resv object to get the fences from
> >>>     * @usage: the dma_resv_usage to use to filter the fences
> >>>     *
> >>>     * This adds all fences matching the given usage from @resv to @jo=
b.
> >>>     * Must be called with the @resv lock held.
>
