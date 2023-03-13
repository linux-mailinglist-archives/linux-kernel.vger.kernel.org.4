Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD646B81A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCMTVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCMTVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:21:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FBC88EE8;
        Mon, 13 Mar 2023 12:21:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so52962734edb.10;
        Mon, 13 Mar 2023 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678735266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgRaKTqE1rxLC9XenG0jwsoM702XmOq7V3PQDrUGur4=;
        b=I+8ES40AkjMYBzrGwmgVwjn5pxMuIk1xg2p+BRylmHmPxsH4j1984uNz1Rrbogi3sG
         otFl4ODwNtURr8RwSQ0remtWcQOJJ6hh4v9NDYoqad9NtjCx6OFvsgibIrRKcQEwNpsc
         9RVrgqIWQxh7z05h++izCp6Dy2lIKYxiZDXNjGXxdDshVOPpVLOMhgTkWxBVCBoQ6Rtd
         DWMNAcHOOFSYEbDnmjl2lMm+YUTJddTkT2cLRdeo3YvkX20HO6YYAv54PTO7oL0N7eoN
         X+sHBILIj7FmEXn+dIuH9vG+fPCFyWvaBxHObMBfBjVcN5uhVleoCDl0m5dzupuEarNx
         CBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678735266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgRaKTqE1rxLC9XenG0jwsoM702XmOq7V3PQDrUGur4=;
        b=L8cI3/ZnsE+tC+pJdMPHYek6vATjcVoaC3pH9bp4w7xqQKM2PYsjVNNTIU0AZzP3LY
         ZxntMjjbBqhT0KpHvDG1I9v1Tm9w2Ei65Y+ARt5BSkH1K2MuypJ+/25aazHnvyiUXW3x
         ASS++qykp4fYQs5uCsPY7sM+jU487q2Ri/yzcn19e9VnlMLmSYAtq7Vw05OL15nvqWPm
         fygNtCW0uI/URqpQpT+XUdKvO3rovFUp5Sy5Xcv6CgFDuhDosGI/3WMUC9yF8QiUwhZx
         kgf07prUcApQED7I3RL5gwmXgxpQzsdpyXMqeb5rD/5uM5qew7KIoG2RdS2Fr9nPTi0E
         4Qmw==
X-Gm-Message-State: AO0yUKUjF/7ZloHljp5MidCHzw2WWVkwFcTaOw8Qn0XnFYSZ4SJQryIV
        F3SXbCyaoP1u3F9v2ssnb6UP6qar5QdxzA==
X-Google-Smtp-Source: AK7set8WSgtxMQ1XTeg1HrK7CkFq2qBLpl1zSMNBnNwjnO7AYQH4gRtbqn7OTeRgOs4y29K1rpRrcQ==
X-Received: by 2002:a17:906:8a6d:b0:928:d4f6:6f77 with SMTP id hy13-20020a1709068a6d00b00928d4f66f77mr5859062ejc.29.1678735265944;
        Mon, 13 Mar 2023 12:21:05 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:bd43:b1f4:2a82:c42b? ([2a02:908:1256:79a0:bd43:b1f4:2a82:c42b])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709062f8b00b00923bb9f0c36sm146491eji.127.2023.03.13.12.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 12:21:05 -0700 (PDT)
Message-ID: <88b3960d-41a6-068a-28a7-7afd0c1551c1@gmail.com>
Date:   Mon, 13 Mar 2023 20:21:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Linaro-mm-sig] Re: [PATCH 2/2] drm/msm: Embed the hw_fence in
 msm_gem_submit
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
References: <20230311173513.1080397-1-robdclark@gmail.com>
 <20230311173513.1080397-3-robdclark@gmail.com>
 <b846101c-e6ef-2d3e-9db9-077003b72e57@amd.com>
 <CAF6AEGvH==PPLpdxim4Pi=Q7RA8Ou4NYxvYBW=N8sh9amEqQVQ@mail.gmail.com>
 <0bc78dea-72cb-cadf-5708-39c765f2b7a8@amd.com>
 <CAF6AEGv_UVPLpH4H5083FaQYTEkRz4AbyMq9441ZXZjVbuwH7w@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAF6AEGv_UVPLpH4H5083FaQYTEkRz4AbyMq9441ZXZjVbuwH7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.03.23 um 17:43 schrieb Rob Clark:
> On Mon, Mar 13, 2023 at 9:15 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 13.03.23 um 15:45 schrieb Rob Clark:
>>> On Mon, Mar 13, 2023 at 12:19 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>> Am 11.03.23 um 18:35 schrieb Rob Clark:
>>>>> From: Rob Clark <robdclark@chromium.org>
>>>>>
>>>>> Avoid allocating memory in job_run() by embedding the fence in the
>>>>> submit object.  Since msm gpu fences are always 1:1 with msm_gem_submit
>>>>> we can just use the fence's refcnt to track the submit.  And since we
>>>>> can get the fence ctx from the submit we can just drop the msm_fence
>>>>> struct altogether.  This uses the new dma_fence_init_noref() to deal
>>>>> with the fact that the fence's refcnt is initialized when the submit is
>>>>> created, long before job_run().
>>>> Well this is a very very bad idea, we made the same mistake with amdgpu
>>>> as well.
>>>>
>>>> It's true that you should not have any memory allocation in your run_job
>>>> callback, but you could also just allocate the hw fence during job
>>>> creation and initializing it later on.
>>>>
>>>> I've suggested to embed the fence into the job for amdgpu because some
>>>> people insisted of re-submitting jobs during timeout and GPU reset. This
>>>> turned into a nightmare with tons of bug fixes on top of bug fixes on
>>>> top of bug fixes because it messes up the job and fence lifetime as
>>>> defined by the DRM scheduler and DMA-buf framework.
>>>>
>>>> Luben is currently working on cleaning all this up.
>>> This actually shouldn't be a problem with msm, as the fence doesn't
>>> change if there is a gpu reset.  We simply signal the fence for the
>>> offending job, reset the GPU, and re-play the remaining in-flight jobs
>>> (ie. things that already had their job_run() called) with the original
>>> fences.  (We don't use gpu sched's reset/timeout handling.. when I
>>> migrated to gpu sched I kept our existing hangcheck/recovery
>>> mechanism.)
>> That sounds much saner than what we did.
>>
>> So you basically need the dma_fence reference counting separate to
>> initializing the other dma_fence fields?
> yeah, that was the idea
>
>> What would happen if a dma_fence which is not completely initialized
>> gets freed? E.g. because of an error?
> hmm, yes, this would be a problem since ops->release is not set yet..
> and I'm relying on that to free the submit
>
>> Would it be to much to just keep the handling as it is today and only
>> allocate the dma_fence without initializing it? If necessary we could
>> easily add a dma_fence_is_initialized() function which checks the
>> fence_ops for NULL.
> Yeah, that would also be possible
>
> I guess we could split creation of the fence (initializing ops,
> refcount) and "arming" it later when the seqno is known?  But maybe
> that is going to too many lengths to avoid a separate allocation..

I would really like to avoid that. It give people the opportunity once 
more to do multiple "arm" operations on the same fence, and that was a 
really bad idea for us.

So yeah if that's just to avoid the extra allocation it's probably not 
worth it.

Christian.

>
> BR,
> -R
>
>> Thanks,
>> Christian.
>>
>>> BR,
>>> -R
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>>>> ---
>>>>> Note that this applies on top of https://patchwork.freedesktop.org/series/93035/
>>>>> out of convenience for myself, but I can re-work it to go before
>>>>> depending on the order that things land.
>>>>>
>>>>>     drivers/gpu/drm/msm/msm_fence.c      | 45 +++++++++++-----------------
>>>>>     drivers/gpu/drm/msm/msm_fence.h      |  2 +-
>>>>>     drivers/gpu/drm/msm/msm_gem.h        | 10 +++----
>>>>>     drivers/gpu/drm/msm/msm_gem_submit.c |  8 ++---
>>>>>     drivers/gpu/drm/msm/msm_gpu.c        |  4 +--
>>>>>     drivers/gpu/drm/msm/msm_ringbuffer.c |  4 +--
>>>>>     6 files changed, 31 insertions(+), 42 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
>>>>> index 51b461f32103..51f9f1f0cb66 100644
>>>>> --- a/drivers/gpu/drm/msm/msm_fence.c
>>>>> +++ b/drivers/gpu/drm/msm/msm_fence.c
>>>>> @@ -103,14 +103,9 @@ void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence)
>>>>>         spin_unlock_irqrestore(&fctx->spinlock, flags);
>>>>>     }
>>>>>
>>>>> -struct msm_fence {
>>>>> -     struct dma_fence base;
>>>>> -     struct msm_fence_context *fctx;
>>>>> -};
>>>>> -
>>>>> -static inline struct msm_fence *to_msm_fence(struct dma_fence *fence)
>>>>> +static inline struct msm_gem_submit *fence_to_submit(struct dma_fence *fence)
>>>>>     {
>>>>> -     return container_of(fence, struct msm_fence, base);
>>>>> +     return container_of(fence, struct msm_gem_submit, hw_fence);
>>>>>     }
>>>>>
>>>>>     static const char *msm_fence_get_driver_name(struct dma_fence *fence)
>>>>> @@ -120,20 +115,20 @@ static const char *msm_fence_get_driver_name(struct dma_fence *fence)
>>>>>
>>>>>     static const char *msm_fence_get_timeline_name(struct dma_fence *fence)
>>>>>     {
>>>>> -     struct msm_fence *f = to_msm_fence(fence);
>>>>> -     return f->fctx->name;
>>>>> +     struct msm_gem_submit *submit = fence_to_submit(fence);
>>>>> +     return submit->ring->fctx->name;
>>>>>     }
>>>>>
>>>>>     static bool msm_fence_signaled(struct dma_fence *fence)
>>>>>     {
>>>>> -     struct msm_fence *f = to_msm_fence(fence);
>>>>> -     return msm_fence_completed(f->fctx, f->base.seqno);
>>>>> +     struct msm_gem_submit *submit = fence_to_submit(fence);
>>>>> +     return msm_fence_completed(submit->ring->fctx, fence->seqno);
>>>>>     }
>>>>>
>>>>>     static void msm_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>>>>>     {
>>>>> -     struct msm_fence *f = to_msm_fence(fence);
>>>>> -     struct msm_fence_context *fctx = f->fctx;
>>>>> +     struct msm_gem_submit *submit = fence_to_submit(fence);
>>>>> +     struct msm_fence_context *fctx = submit->ring->fctx;
>>>>>         unsigned long flags;
>>>>>         ktime_t now;
>>>>>
>>>>> @@ -165,26 +160,22 @@ static void msm_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>>>>>         spin_unlock_irqrestore(&fctx->spinlock, flags);
>>>>>     }
>>>>>
>>>>> +static void msm_fence_release(struct dma_fence *fence)
>>>>> +{
>>>>> +     __msm_gem_submit_destroy(fence_to_submit(fence));
>>>>> +}
>>>>> +
>>>>>     static const struct dma_fence_ops msm_fence_ops = {
>>>>>         .get_driver_name = msm_fence_get_driver_name,
>>>>>         .get_timeline_name = msm_fence_get_timeline_name,
>>>>>         .signaled = msm_fence_signaled,
>>>>>         .set_deadline = msm_fence_set_deadline,
>>>>> +     .release = msm_fence_release,
>>>>>     };
>>>>>
>>>>> -struct dma_fence *
>>>>> -msm_fence_alloc(struct msm_fence_context *fctx)
>>>>> +void
>>>>> +msm_fence_init(struct msm_fence_context *fctx, struct dma_fence *f)
>>>>>     {
>>>>> -     struct msm_fence *f;
>>>>> -
>>>>> -     f = kzalloc(sizeof(*f), GFP_KERNEL);
>>>>> -     if (!f)
>>>>> -             return ERR_PTR(-ENOMEM);
>>>>> -
>>>>> -     f->fctx = fctx;
>>>>> -
>>>>> -     dma_fence_init(&f->base, &msm_fence_ops, &fctx->spinlock,
>>>>> -                    fctx->context, ++fctx->last_fence);
>>>>> -
>>>>> -     return &f->base;
>>>>> +     dma_fence_init_noref(f, &msm_fence_ops, &fctx->spinlock,
>>>>> +                          fctx->context, ++fctx->last_fence);
>>>>>     }
>>>>> diff --git a/drivers/gpu/drm/msm/msm_fence.h b/drivers/gpu/drm/msm/msm_fence.h
>>>>> index cdaebfb94f5c..8fca37e9773b 100644
>>>>> --- a/drivers/gpu/drm/msm/msm_fence.h
>>>>> +++ b/drivers/gpu/drm/msm/msm_fence.h
>>>>> @@ -81,7 +81,7 @@ void msm_fence_context_free(struct msm_fence_context *fctx);
>>>>>     bool msm_fence_completed(struct msm_fence_context *fctx, uint32_t fence);
>>>>>     void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence);
>>>>>
>>>>> -struct dma_fence * msm_fence_alloc(struct msm_fence_context *fctx);
>>>>> +void msm_fence_init(struct msm_fence_context *fctx, struct dma_fence *f);
>>>>>
>>>>>     static inline bool
>>>>>     fence_before(uint32_t a, uint32_t b)
>>>>> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
>>>>> index c4844cf3a585..e06afed99d5b 100644
>>>>> --- a/drivers/gpu/drm/msm/msm_gem.h
>>>>> +++ b/drivers/gpu/drm/msm/msm_gem.h
>>>>> @@ -259,10 +259,10 @@ struct msm_gem_submit {
>>>>>         struct ww_acquire_ctx ticket;
>>>>>         uint32_t seqno;         /* Sequence number of the submit on the ring */
>>>>>
>>>>> -     /* Hw fence, which is created when the scheduler executes the job, and
>>>>> +     /* Hw fence, which is initialized when the scheduler executes the job, and
>>>>>          * is signaled when the hw finishes (via seqno write from cmdstream)
>>>>>          */
>>>>> -     struct dma_fence *hw_fence;
>>>>> +     struct dma_fence hw_fence;
>>>>>
>>>>>         /* Userspace visible fence, which is signaled by the scheduler after
>>>>>          * the hw_fence is signaled.
>>>>> @@ -309,16 +309,16 @@ static inline struct msm_gem_submit *to_msm_submit(struct drm_sched_job *job)
>>>>>         return container_of(job, struct msm_gem_submit, base);
>>>>>     }
>>>>>
>>>>> -void __msm_gem_submit_destroy(struct kref *kref);
>>>>> +void __msm_gem_submit_destroy(struct msm_gem_submit *submit);
>>>>>
>>>>>     static inline void msm_gem_submit_get(struct msm_gem_submit *submit)
>>>>>     {
>>>>> -     kref_get(&submit->ref);
>>>>> +     dma_fence_get(&submit->hw_fence);
>>>>>     }
>>>>>
>>>>>     static inline void msm_gem_submit_put(struct msm_gem_submit *submit)
>>>>>     {
>>>>> -     kref_put(&submit->ref, __msm_gem_submit_destroy);
>>>>> +     dma_fence_put(&submit->hw_fence);
>>>>>     }
>>>>>
>>>>>     void msm_submit_retire(struct msm_gem_submit *submit);
>>>>> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
>>>>> index be4bf77103cd..522c8c82e827 100644
>>>>> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
>>>>> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
>>>>> @@ -47,7 +47,7 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
>>>>>                 return ERR_PTR(ret);
>>>>>         }
>>>>>
>>>>> -     kref_init(&submit->ref);
>>>>> +     kref_init(&submit->hw_fence.refcount);
>>>>>         submit->dev = dev;
>>>>>         submit->aspace = queue->ctx->aspace;
>>>>>         submit->gpu = gpu;
>>>>> @@ -65,10 +65,9 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
>>>>>         return submit;
>>>>>     }
>>>>>
>>>>> -void __msm_gem_submit_destroy(struct kref *kref)
>>>>> +/* Called when the hw_fence is destroyed: */
>>>>> +void __msm_gem_submit_destroy(struct msm_gem_submit *submit)
>>>>>     {
>>>>> -     struct msm_gem_submit *submit =
>>>>> -                     container_of(kref, struct msm_gem_submit, ref);
>>>>>         unsigned i;
>>>>>
>>>>>         if (submit->fence_id) {
>>>>> @@ -78,7 +77,6 @@ void __msm_gem_submit_destroy(struct kref *kref)
>>>>>         }
>>>>>
>>>>>         dma_fence_put(submit->user_fence);
>>>>> -     dma_fence_put(submit->hw_fence);
>>>>>
>>>>>         put_pid(submit->pid);
>>>>>         msm_submitqueue_put(submit->queue);
>>>>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>>>>> index 380249500325..a82d11dd5fcf 100644
>>>>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>>>>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>>>>> @@ -716,7 +716,7 @@ static void retire_submits(struct msm_gpu *gpu)
>>>>>                          * been signalled, then later submits are not signalled
>>>>>                          * either, so we are also done.
>>>>>                          */
>>>>> -                     if (submit && dma_fence_is_signaled(submit->hw_fence)) {
>>>>> +                     if (submit && dma_fence_is_signaled(&submit->hw_fence)) {
>>>>>                                 retire_submit(gpu, ring, submit);
>>>>>                         } else {
>>>>>                                 break;
>>>>> @@ -760,7 +760,7 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>>>>
>>>>>         msm_gpu_hw_init(gpu);
>>>>>
>>>>> -     submit->seqno = submit->hw_fence->seqno;
>>>>> +     submit->seqno = submit->hw_fence.seqno;
>>>>>
>>>>>         msm_rd_dump_submit(priv->rd, submit, NULL);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
>>>>> index 57a8e9564540..5c54befa2427 100644
>>>>> --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
>>>>> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
>>>>> @@ -18,7 +18,7 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
>>>>>         struct msm_gpu *gpu = submit->gpu;
>>>>>         int i;
>>>>>
>>>>> -     submit->hw_fence = msm_fence_alloc(fctx);
>>>>> +     msm_fence_init(fctx, &submit->hw_fence);
>>>>>
>>>>>         for (i = 0; i < submit->nr_bos; i++) {
>>>>>                 struct drm_gem_object *obj = &submit->bos[i].obj->base;
>>>>> @@ -37,7 +37,7 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
>>>>>
>>>>>         mutex_unlock(&gpu->lock);
>>>>>
>>>>> -     return dma_fence_get(submit->hw_fence);
>>>>> +     return dma_fence_get(&submit->hw_fence);
>>>>>     }
>>>>>
>>>>>     static void msm_job_free(struct drm_sched_job *job)
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

