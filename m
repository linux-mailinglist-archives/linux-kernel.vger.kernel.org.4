Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55BB6B7DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCMQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCMQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:43:40 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC37144B6;
        Mon, 13 Mar 2023 09:43:30 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-177ca271cb8so1820363fac.2;
        Mon, 13 Mar 2023 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678725809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgyR+Thhbr0FuHdIQhF7qy2mK/AxSo/8SviTeetvkXs=;
        b=lt9JUNwdkNIT+5dzth4QSsZAjt7rMEDZ3VoenOeB6O9nqKZCJ4Pf/3ADgQnoEBD0Zc
         9AYHfS1hLYo7ke0USbPmz+xacz0/0ZCv6A5cZAcfFvbBm1jzh1kIdNcA+waD1Uq/tEXI
         SlD9v5Ky57powOfnhgb/+knvkKbBFF/nb/vcSulLF1fJoGMwlpmivq4aVhznIVaJA3//
         EDf+TuYSYVoFgWNxFbgVOcKQfFimtGrN9xviAvo2FgsY4EF4pNWwkkSrTxwHopHXazk9
         md1jc9fnDACGlZ1c4/u5kYM+9Zoi6MFRtlEuhsXJhMQhpvHHeSHVDYOoM9P0ZHdSuQ+K
         3uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgyR+Thhbr0FuHdIQhF7qy2mK/AxSo/8SviTeetvkXs=;
        b=h6JsMp4h30SmJaLelhCbBpwvPZxQ9pUmdAZciPahLWSF/fPqE1V6UxoKZugEMWGK/G
         Omwg2ilYsODMNYpJHWtln2q8YEEDvHyt/uPJOe4u3LeoV8sA2xmx4qWbFA0S05sHoCB9
         azW34r8Hjf9tW4rKPkeLUVCRLVhg7MmR8QOlH6bRV8jZRh3AOayW98/7FMovarQMuzgH
         U1b15tg+IGvlu5IFh+NaKECemQ7w0U9PMRyYzpfWzxXHwF8zp2Zj4weCVabBpprOwKjl
         BR7Xs9j99pP17yZ23oqqpMZP51nhlgG9ipJk//kiCyPhYbq45CnQWdKBFkzcKBsSfcgk
         lwIw==
X-Gm-Message-State: AO0yUKW1HtBo4KG95l7YXv5wuFKYjzUaJ9hPQWLbKkVd2/zKZIEsCob9
        9PSaviSiSeHKgvyRKloL6epAhM6OcCpsoWQn+S/OxHPI
X-Google-Smtp-Source: AK7set8mCms2PgaT0OYxKYOKQQqd9uWLZT2sc7yo+IZrY4bA1gnTHpI8HOLFt/Fq8VxwfYM8AjtucX2HgTO1i53z+TI=
X-Received: by 2002:a05:6870:7729:b0:176:3897:6928 with SMTP id
 dw41-20020a056870772900b0017638976928mr12623541oab.5.1678725809280; Mon, 13
 Mar 2023 09:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230311173513.1080397-1-robdclark@gmail.com> <20230311173513.1080397-3-robdclark@gmail.com>
 <b846101c-e6ef-2d3e-9db9-077003b72e57@amd.com> <CAF6AEGvH==PPLpdxim4Pi=Q7RA8Ou4NYxvYBW=N8sh9amEqQVQ@mail.gmail.com>
 <0bc78dea-72cb-cadf-5708-39c765f2b7a8@amd.com>
In-Reply-To: <0bc78dea-72cb-cadf-5708-39c765f2b7a8@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 13 Mar 2023 09:43:17 -0700
Message-ID: <CAF6AEGv_UVPLpH4H5083FaQYTEkRz4AbyMq9441ZXZjVbuwH7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm: Embed the hw_fence in msm_gem_submit
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 9:15=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 13.03.23 um 15:45 schrieb Rob Clark:
> > On Mon, Mar 13, 2023 at 12:19=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Am 11.03.23 um 18:35 schrieb Rob Clark:
> >>> From: Rob Clark <robdclark@chromium.org>
> >>>
> >>> Avoid allocating memory in job_run() by embedding the fence in the
> >>> submit object.  Since msm gpu fences are always 1:1 with msm_gem_subm=
it
> >>> we can just use the fence's refcnt to track the submit.  And since we
> >>> can get the fence ctx from the submit we can just drop the msm_fence
> >>> struct altogether.  This uses the new dma_fence_init_noref() to deal
> >>> with the fact that the fence's refcnt is initialized when the submit =
is
> >>> created, long before job_run().
> >> Well this is a very very bad idea, we made the same mistake with amdgp=
u
> >> as well.
> >>
> >> It's true that you should not have any memory allocation in your run_j=
ob
> >> callback, but you could also just allocate the hw fence during job
> >> creation and initializing it later on.
> >>
> >> I've suggested to embed the fence into the job for amdgpu because some
> >> people insisted of re-submitting jobs during timeout and GPU reset. Th=
is
> >> turned into a nightmare with tons of bug fixes on top of bug fixes on
> >> top of bug fixes because it messes up the job and fence lifetime as
> >> defined by the DRM scheduler and DMA-buf framework.
> >>
> >> Luben is currently working on cleaning all this up.
> > This actually shouldn't be a problem with msm, as the fence doesn't
> > change if there is a gpu reset.  We simply signal the fence for the
> > offending job, reset the GPU, and re-play the remaining in-flight jobs
> > (ie. things that already had their job_run() called) with the original
> > fences.  (We don't use gpu sched's reset/timeout handling.. when I
> > migrated to gpu sched I kept our existing hangcheck/recovery
> > mechanism.)
>
> That sounds much saner than what we did.
>
> So you basically need the dma_fence reference counting separate to
> initializing the other dma_fence fields?

yeah, that was the idea

> What would happen if a dma_fence which is not completely initialized
> gets freed? E.g. because of an error?

hmm, yes, this would be a problem since ops->release is not set yet..
and I'm relying on that to free the submit

> Would it be to much to just keep the handling as it is today and only
> allocate the dma_fence without initializing it? If necessary we could
> easily add a dma_fence_is_initialized() function which checks the
> fence_ops for NULL.

Yeah, that would also be possible

I guess we could split creation of the fence (initializing ops,
refcount) and "arming" it later when the seqno is known?  But maybe
that is going to too many lengths to avoid a separate allocation..

BR,
-R

>
> Thanks,
> Christian.
>
> >
> > BR,
> > -R
> >
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>> ---
> >>> Note that this applies on top of https://patchwork.freedesktop.org/se=
ries/93035/
> >>> out of convenience for myself, but I can re-work it to go before
> >>> depending on the order that things land.
> >>>
> >>>    drivers/gpu/drm/msm/msm_fence.c      | 45 +++++++++++-------------=
----
> >>>    drivers/gpu/drm/msm/msm_fence.h      |  2 +-
> >>>    drivers/gpu/drm/msm/msm_gem.h        | 10 +++----
> >>>    drivers/gpu/drm/msm/msm_gem_submit.c |  8 ++---
> >>>    drivers/gpu/drm/msm/msm_gpu.c        |  4 +--
> >>>    drivers/gpu/drm/msm/msm_ringbuffer.c |  4 +--
> >>>    6 files changed, 31 insertions(+), 42 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/ms=
m_fence.c
> >>> index 51b461f32103..51f9f1f0cb66 100644
> >>> --- a/drivers/gpu/drm/msm/msm_fence.c
> >>> +++ b/drivers/gpu/drm/msm/msm_fence.c
> >>> @@ -103,14 +103,9 @@ void msm_update_fence(struct msm_fence_context *=
fctx, uint32_t fence)
> >>>        spin_unlock_irqrestore(&fctx->spinlock, flags);
> >>>    }
> >>>
> >>> -struct msm_fence {
> >>> -     struct dma_fence base;
> >>> -     struct msm_fence_context *fctx;
> >>> -};
> >>> -
> >>> -static inline struct msm_fence *to_msm_fence(struct dma_fence *fence=
)
> >>> +static inline struct msm_gem_submit *fence_to_submit(struct dma_fenc=
e *fence)
> >>>    {
> >>> -     return container_of(fence, struct msm_fence, base);
> >>> +     return container_of(fence, struct msm_gem_submit, hw_fence);
> >>>    }
> >>>
> >>>    static const char *msm_fence_get_driver_name(struct dma_fence *fen=
ce)
> >>> @@ -120,20 +115,20 @@ static const char *msm_fence_get_driver_name(st=
ruct dma_fence *fence)
> >>>
> >>>    static const char *msm_fence_get_timeline_name(struct dma_fence *f=
ence)
> >>>    {
> >>> -     struct msm_fence *f =3D to_msm_fence(fence);
> >>> -     return f->fctx->name;
> >>> +     struct msm_gem_submit *submit =3D fence_to_submit(fence);
> >>> +     return submit->ring->fctx->name;
> >>>    }
> >>>
> >>>    static bool msm_fence_signaled(struct dma_fence *fence)
> >>>    {
> >>> -     struct msm_fence *f =3D to_msm_fence(fence);
> >>> -     return msm_fence_completed(f->fctx, f->base.seqno);
> >>> +     struct msm_gem_submit *submit =3D fence_to_submit(fence);
> >>> +     return msm_fence_completed(submit->ring->fctx, fence->seqno);
> >>>    }
> >>>
> >>>    static void msm_fence_set_deadline(struct dma_fence *fence, ktime_=
t deadline)
> >>>    {
> >>> -     struct msm_fence *f =3D to_msm_fence(fence);
> >>> -     struct msm_fence_context *fctx =3D f->fctx;
> >>> +     struct msm_gem_submit *submit =3D fence_to_submit(fence);
> >>> +     struct msm_fence_context *fctx =3D submit->ring->fctx;
> >>>        unsigned long flags;
> >>>        ktime_t now;
> >>>
> >>> @@ -165,26 +160,22 @@ static void msm_fence_set_deadline(struct dma_f=
ence *fence, ktime_t deadline)
> >>>        spin_unlock_irqrestore(&fctx->spinlock, flags);
> >>>    }
> >>>
> >>> +static void msm_fence_release(struct dma_fence *fence)
> >>> +{
> >>> +     __msm_gem_submit_destroy(fence_to_submit(fence));
> >>> +}
> >>> +
> >>>    static const struct dma_fence_ops msm_fence_ops =3D {
> >>>        .get_driver_name =3D msm_fence_get_driver_name,
> >>>        .get_timeline_name =3D msm_fence_get_timeline_name,
> >>>        .signaled =3D msm_fence_signaled,
> >>>        .set_deadline =3D msm_fence_set_deadline,
> >>> +     .release =3D msm_fence_release,
> >>>    };
> >>>
> >>> -struct dma_fence *
> >>> -msm_fence_alloc(struct msm_fence_context *fctx)
> >>> +void
> >>> +msm_fence_init(struct msm_fence_context *fctx, struct dma_fence *f)
> >>>    {
> >>> -     struct msm_fence *f;
> >>> -
> >>> -     f =3D kzalloc(sizeof(*f), GFP_KERNEL);
> >>> -     if (!f)
> >>> -             return ERR_PTR(-ENOMEM);
> >>> -
> >>> -     f->fctx =3D fctx;
> >>> -
> >>> -     dma_fence_init(&f->base, &msm_fence_ops, &fctx->spinlock,
> >>> -                    fctx->context, ++fctx->last_fence);
> >>> -
> >>> -     return &f->base;
> >>> +     dma_fence_init_noref(f, &msm_fence_ops, &fctx->spinlock,
> >>> +                          fctx->context, ++fctx->last_fence);
> >>>    }
> >>> diff --git a/drivers/gpu/drm/msm/msm_fence.h b/drivers/gpu/drm/msm/ms=
m_fence.h
> >>> index cdaebfb94f5c..8fca37e9773b 100644
> >>> --- a/drivers/gpu/drm/msm/msm_fence.h
> >>> +++ b/drivers/gpu/drm/msm/msm_fence.h
> >>> @@ -81,7 +81,7 @@ void msm_fence_context_free(struct msm_fence_contex=
t *fctx);
> >>>    bool msm_fence_completed(struct msm_fence_context *fctx, uint32_t =
fence);
> >>>    void msm_update_fence(struct msm_fence_context *fctx, uint32_t fen=
ce);
> >>>
> >>> -struct dma_fence * msm_fence_alloc(struct msm_fence_context *fctx);
> >>> +void msm_fence_init(struct msm_fence_context *fctx, struct dma_fence=
 *f);
> >>>
> >>>    static inline bool
> >>>    fence_before(uint32_t a, uint32_t b)
> >>> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_=
gem.h
> >>> index c4844cf3a585..e06afed99d5b 100644
> >>> --- a/drivers/gpu/drm/msm/msm_gem.h
> >>> +++ b/drivers/gpu/drm/msm/msm_gem.h
> >>> @@ -259,10 +259,10 @@ struct msm_gem_submit {
> >>>        struct ww_acquire_ctx ticket;
> >>>        uint32_t seqno;         /* Sequence number of the submit on th=
e ring */
> >>>
> >>> -     /* Hw fence, which is created when the scheduler executes the j=
ob, and
> >>> +     /* Hw fence, which is initialized when the scheduler executes t=
he job, and
> >>>         * is signaled when the hw finishes (via seqno write from cmds=
tream)
> >>>         */
> >>> -     struct dma_fence *hw_fence;
> >>> +     struct dma_fence hw_fence;
> >>>
> >>>        /* Userspace visible fence, which is signaled by the scheduler=
 after
> >>>         * the hw_fence is signaled.
> >>> @@ -309,16 +309,16 @@ static inline struct msm_gem_submit *to_msm_sub=
mit(struct drm_sched_job *job)
> >>>        return container_of(job, struct msm_gem_submit, base);
> >>>    }
> >>>
> >>> -void __msm_gem_submit_destroy(struct kref *kref);
> >>> +void __msm_gem_submit_destroy(struct msm_gem_submit *submit);
> >>>
> >>>    static inline void msm_gem_submit_get(struct msm_gem_submit *submi=
t)
> >>>    {
> >>> -     kref_get(&submit->ref);
> >>> +     dma_fence_get(&submit->hw_fence);
> >>>    }
> >>>
> >>>    static inline void msm_gem_submit_put(struct msm_gem_submit *submi=
t)
> >>>    {
> >>> -     kref_put(&submit->ref, __msm_gem_submit_destroy);
> >>> +     dma_fence_put(&submit->hw_fence);
> >>>    }
> >>>
> >>>    void msm_submit_retire(struct msm_gem_submit *submit);
> >>> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/m=
sm/msm_gem_submit.c
> >>> index be4bf77103cd..522c8c82e827 100644
> >>> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> >>> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> >>> @@ -47,7 +47,7 @@ static struct msm_gem_submit *submit_create(struct =
drm_device *dev,
> >>>                return ERR_PTR(ret);
> >>>        }
> >>>
> >>> -     kref_init(&submit->ref);
> >>> +     kref_init(&submit->hw_fence.refcount);
> >>>        submit->dev =3D dev;
> >>>        submit->aspace =3D queue->ctx->aspace;
> >>>        submit->gpu =3D gpu;
> >>> @@ -65,10 +65,9 @@ static struct msm_gem_submit *submit_create(struct=
 drm_device *dev,
> >>>        return submit;
> >>>    }
> >>>
> >>> -void __msm_gem_submit_destroy(struct kref *kref)
> >>> +/* Called when the hw_fence is destroyed: */
> >>> +void __msm_gem_submit_destroy(struct msm_gem_submit *submit)
> >>>    {
> >>> -     struct msm_gem_submit *submit =3D
> >>> -                     container_of(kref, struct msm_gem_submit, ref);
> >>>        unsigned i;
> >>>
> >>>        if (submit->fence_id) {
> >>> @@ -78,7 +77,6 @@ void __msm_gem_submit_destroy(struct kref *kref)
> >>>        }
> >>>
> >>>        dma_fence_put(submit->user_fence);
> >>> -     dma_fence_put(submit->hw_fence);
> >>>
> >>>        put_pid(submit->pid);
> >>>        msm_submitqueue_put(submit->queue);
> >>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_=
gpu.c
> >>> index 380249500325..a82d11dd5fcf 100644
> >>> --- a/drivers/gpu/drm/msm/msm_gpu.c
> >>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> >>> @@ -716,7 +716,7 @@ static void retire_submits(struct msm_gpu *gpu)
> >>>                         * been signalled, then later submits are not =
signalled
> >>>                         * either, so we are also done.
> >>>                         */
> >>> -                     if (submit && dma_fence_is_signaled(submit->hw_=
fence)) {
> >>> +                     if (submit && dma_fence_is_signaled(&submit->hw=
_fence)) {
> >>>                                retire_submit(gpu, ring, submit);
> >>>                        } else {
> >>>                                break;
> >>> @@ -760,7 +760,7 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct m=
sm_gem_submit *submit)
> >>>
> >>>        msm_gpu_hw_init(gpu);
> >>>
> >>> -     submit->seqno =3D submit->hw_fence->seqno;
> >>> +     submit->seqno =3D submit->hw_fence.seqno;
> >>>
> >>>        msm_rd_dump_submit(priv->rd, submit, NULL);
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/m=
sm/msm_ringbuffer.c
> >>> index 57a8e9564540..5c54befa2427 100644
> >>> --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
> >>> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
> >>> @@ -18,7 +18,7 @@ static struct dma_fence *msm_job_run(struct drm_sch=
ed_job *job)
> >>>        struct msm_gpu *gpu =3D submit->gpu;
> >>>        int i;
> >>>
> >>> -     submit->hw_fence =3D msm_fence_alloc(fctx);
> >>> +     msm_fence_init(fctx, &submit->hw_fence);
> >>>
> >>>        for (i =3D 0; i < submit->nr_bos; i++) {
> >>>                struct drm_gem_object *obj =3D &submit->bos[i].obj->ba=
se;
> >>> @@ -37,7 +37,7 @@ static struct dma_fence *msm_job_run(struct drm_sch=
ed_job *job)
> >>>
> >>>        mutex_unlock(&gpu->lock);
> >>>
> >>> -     return dma_fence_get(submit->hw_fence);
> >>> +     return dma_fence_get(&submit->hw_fence);
> >>>    }
> >>>
> >>>    static void msm_job_free(struct drm_sched_job *job)
>
