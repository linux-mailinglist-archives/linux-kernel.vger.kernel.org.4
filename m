Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C264C6AA5F0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCCXxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCCXxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:53:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBF3C33
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:53:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ay14so12984436edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 15:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnDZ9x2blH5V8YINfT6XOEOEFytwM5xt/JuAKzXCEWU=;
        b=CysvhjzJrWfpzLbmZMuln5F1LZXgBzBu4oR3PEjQqN/OQMt+Zh8GTxeYL9ZXR3QmSE
         tyHKB8gKDZRKXHxB0zBebHIXxH0FX3fNke1AHBevQacjZXOEyvedakh+rWEEdRE4HHAe
         D4Ci9kbvYC4wulP/eArIu7vNgMtZjjWcZG0OxuRi2gIxsqyFVj0ZZQobqXhgjoKFfcct
         dCLOTpYmzE01SHLQTatMXTNpuCNlej00nsQS+PVyBCgfb2manXjYDA12QXhAEfjSWtW+
         MqITV/TCHiEoJQJ3W9K4EGzf/rysfbK1CP/4eeauBSBf8P4A9s0zp9pktLwVtUGIyWIk
         +JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnDZ9x2blH5V8YINfT6XOEOEFytwM5xt/JuAKzXCEWU=;
        b=JiyplVzoeu0fI6g6Rck+Dd64WBkXC8hSg3Q4yMjuhq9qYRARme2LoLlKGNkJW4DkPT
         vYuWimLzIBJwn8cNzblOzGbjzs0LhWbv9WEk64by4fUBnDu4Odgor+ywhuv7l0Yq2Uv1
         Wh6js4W//ULgKMkUYY1+f/Ke0d5huWF3Ny7T+2A3/pOkKj3L6gSH30v5Eq37p0l6QAEB
         9nyJITFL5DQoiXtz+IjrxInqZDJWbB/7f7VLldstdm/8Tn/a2/nF6wHBEcPV+69bp7GJ
         gvbkZXmIPrXUa4Bn/zFEgOe2I3fZPfhvEHmKpDAzt8O3aWqR70gF8nz3GceejFI/0FIw
         WXQw==
X-Gm-Message-State: AO0yUKVxGlOA6CLrdAn43fmWoApfXnutKlw3bM7ESRe+bSsU6QZL5AdL
        ct3v5r7YMhr0hSfs9hnTCNp9ig==
X-Google-Smtp-Source: AK7set9JmLUWJX+fB3FtuG1918iXvCOsgAoXJ70x5Nw9+h8/nbjmxtRgVk16QJDub3WUOofqGBZIpQ==
X-Received: by 2002:a17:907:70e:b0:878:955e:b4a4 with SMTP id xb14-20020a170907070e00b00878955eb4a4mr4595666ejb.33.1677887610406;
        Fri, 03 Mar 2023 15:53:30 -0800 (PST)
Received: from [10.203.3.194] ([185.202.34.81])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090634d100b008ee5356801dsm1463032ejb.187.2023.03.03.15.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 15:53:30 -0800 (PST)
Message-ID: <b9a5778c-0eae-28c1-1806-33550345e619@linaro.org>
Date:   Sat, 4 Mar 2023 01:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 12/15] drm/msm: Add deadline based boost support
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
References: <20230302235356.3148279-1-robdclark@gmail.com>
 <20230302235356.3148279-13-robdclark@gmail.com>
 <a5249009-0bec-61a5-4dd2-5728ee3017e3@linaro.org>
 <CAF6AEGtmQu-8LEdm68vXJJSpssXq2AShEdexqTGVW0WO5VmtDQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAF6AEGtmQu-8LEdm68vXJJSpssXq2AShEdexqTGVW0WO5VmtDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 19:03, Rob Clark wrote:
> On Fri, Mar 3, 2023 at 2:10 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On 03/03/2023 01:53, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> Track the nearest deadline on a fence timeline and set a timer to expire
>>> shortly before to trigger boost if the fence has not yet been signaled.
>>>
>>> v2: rebase
>>>
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>>    drivers/gpu/drm/msm/msm_fence.c | 74 +++++++++++++++++++++++++++++++++
>>>    drivers/gpu/drm/msm/msm_fence.h | 20 +++++++++
>>>    2 files changed, 94 insertions(+)
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
>> A small question: do we boost to fit into the deadline or to miss the
>> deadline for as little as possible? If the former is the case, we might
>> need to adjust 3ms depending on the workload.
> 
> The goal is as much to run with higher clock on the next frame as it
> is to not miss a deadline.  Ie. we don't want devfreq to come to the
> conclusion that running at <50% clks is best due to the amount of
> utilization caused by missing ever other vblank.

Ack, thanks for the explanation.

> 
> But 3ms is mostly just "seems like a good compromise" value.  It might change.
> 
> BR,
> -R
> 
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
>>> index 56641408ea74..51b461f32103 100644
>>> --- a/drivers/gpu/drm/msm/msm_fence.c
>>> +++ b/drivers/gpu/drm/msm/msm_fence.c
>>> @@ -8,6 +8,35 @@
>>>
>>>    #include "msm_drv.h"
>>>    #include "msm_fence.h"
>>> +#include "msm_gpu.h"
>>> +
>>> +static struct msm_gpu *fctx2gpu(struct msm_fence_context *fctx)
>>> +{
>>> +     struct msm_drm_private *priv = fctx->dev->dev_private;
>>> +     return priv->gpu;
>>> +}
>>> +
>>> +static enum hrtimer_restart deadline_timer(struct hrtimer *t)
>>> +{
>>> +     struct msm_fence_context *fctx = container_of(t,
>>> +                     struct msm_fence_context, deadline_timer);
>>> +
>>> +     kthread_queue_work(fctx2gpu(fctx)->worker, &fctx->deadline_work);
>>> +
>>> +     return HRTIMER_NORESTART;
>>> +}
>>> +
>>> +static void deadline_work(struct kthread_work *work)
>>> +{
>>> +     struct msm_fence_context *fctx = container_of(work,
>>> +                     struct msm_fence_context, deadline_work);
>>> +
>>> +     /* If deadline fence has already passed, nothing to do: */
>>> +     if (msm_fence_completed(fctx, fctx->next_deadline_fence))
>>> +             return;
>>> +
>>> +     msm_devfreq_boost(fctx2gpu(fctx), 2);
>>> +}
>>>
>>>
>>>    struct msm_fence_context *
>>> @@ -36,6 +65,13 @@ msm_fence_context_alloc(struct drm_device *dev, volatile uint32_t *fenceptr,
>>>        fctx->completed_fence = fctx->last_fence;
>>>        *fctx->fenceptr = fctx->last_fence;
>>>
>>> +     hrtimer_init(&fctx->deadline_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>>> +     fctx->deadline_timer.function = deadline_timer;
>>> +
>>> +     kthread_init_work(&fctx->deadline_work, deadline_work);
>>> +
>>> +     fctx->next_deadline = ktime_get();
>>> +
>>>        return fctx;
>>>    }
>>>
>>> @@ -62,6 +98,8 @@ void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence)
>>>        spin_lock_irqsave(&fctx->spinlock, flags);
>>>        if (fence_after(fence, fctx->completed_fence))
>>>                fctx->completed_fence = fence;
>>> +     if (msm_fence_completed(fctx, fctx->next_deadline_fence))
>>> +             hrtimer_cancel(&fctx->deadline_timer);
>>>        spin_unlock_irqrestore(&fctx->spinlock, flags);
>>>    }
>>>
>>> @@ -92,10 +130,46 @@ static bool msm_fence_signaled(struct dma_fence *fence)
>>>        return msm_fence_completed(f->fctx, f->base.seqno);
>>>    }
>>>
>>> +static void msm_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>>> +{
>>> +     struct msm_fence *f = to_msm_fence(fence);
>>> +     struct msm_fence_context *fctx = f->fctx;
>>> +     unsigned long flags;
>>> +     ktime_t now;
>>> +
>>> +     spin_lock_irqsave(&fctx->spinlock, flags);
>>> +     now = ktime_get();
>>> +
>>> +     if (ktime_after(now, fctx->next_deadline) ||
>>> +                     ktime_before(deadline, fctx->next_deadline)) {
>>> +             fctx->next_deadline = deadline;
>>> +             fctx->next_deadline_fence =
>>> +                     max(fctx->next_deadline_fence, (uint32_t)fence->seqno);
>>> +
>>> +             /*
>>> +              * Set timer to trigger boost 3ms before deadline, or
>>> +              * if we are already less than 3ms before the deadline
>>> +              * schedule boost work immediately.
>>> +              */
>>> +             deadline = ktime_sub(deadline, ms_to_ktime(3));
>>> +
>>> +             if (ktime_after(now, deadline)) {
>>> +                     kthread_queue_work(fctx2gpu(fctx)->worker,
>>> +                                     &fctx->deadline_work);
>>> +             } else {
>>> +                     hrtimer_start(&fctx->deadline_timer, deadline,
>>> +                                     HRTIMER_MODE_ABS);
>>> +             }
>>> +     }
>>> +
>>> +     spin_unlock_irqrestore(&fctx->spinlock, flags);
>>> +}
>>> +
>>>    static const struct dma_fence_ops msm_fence_ops = {
>>>        .get_driver_name = msm_fence_get_driver_name,
>>>        .get_timeline_name = msm_fence_get_timeline_name,
>>>        .signaled = msm_fence_signaled,
>>> +     .set_deadline = msm_fence_set_deadline,
>>>    };
>>>
>>>    struct dma_fence *
>>> diff --git a/drivers/gpu/drm/msm/msm_fence.h b/drivers/gpu/drm/msm/msm_fence.h
>>> index 7f1798c54cd1..cdaebfb94f5c 100644
>>> --- a/drivers/gpu/drm/msm/msm_fence.h
>>> +++ b/drivers/gpu/drm/msm/msm_fence.h
>>> @@ -52,6 +52,26 @@ struct msm_fence_context {
>>>        volatile uint32_t *fenceptr;
>>>
>>>        spinlock_t spinlock;
>>> +
>>> +     /*
>>> +      * TODO this doesn't really deal with multiple deadlines, like
>>> +      * if userspace got multiple frames ahead.. OTOH atomic updates
>>> +      * don't queue, so maybe that is ok
>>> +      */
>>> +
>>> +     /** next_deadline: Time of next deadline */
>>> +     ktime_t next_deadline;
>>> +
>>> +     /**
>>> +      * next_deadline_fence:
>>> +      *
>>> +      * Fence value for next pending deadline.  The deadline timer is
>>> +      * canceled when this fence is signaled.
>>> +      */
>>> +     uint32_t next_deadline_fence;
>>> +
>>> +     struct hrtimer deadline_timer;
>>> +     struct kthread_work deadline_work;
>>>    };
>>>
>>>    struct msm_fence_context * msm_fence_context_alloc(struct drm_device *dev,
>>
>> --
>> With best wishes
>> Dmitry
>>

-- 
With best wishes
Dmitry

