Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982876A04A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjBWJTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjBWJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:19:47 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471048E23;
        Thu, 23 Feb 2023 01:19:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so9350149wms.1;
        Thu, 23 Feb 2023 01:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXb7GwfUN0cPM9ffS/TJOhN7coUOiUmAkZkN563cZ0A=;
        b=gV3Nvd/I3sLagNtoe/0Nixb+GwdroCY8lEBmFhyEcjhaUSbT1MEjcQh8FvqXLxuU1V
         88aqzk0OEArNRcvloLJBr5VvDZTR73SwtEpwh3tuxYARFyqfObt8DChHh4fnsb9qVj3c
         EbNVB1O87gI2d4wJwCI3MpuOz3i3e0iuCUSXh/EWYbHrhaVXGpWKJcsNowaZFHQS/a8/
         Rnw2npFalAOXK8yOWYfmjmPp97R5FiZGCCCWi1JUWoVfkT4Yo9Ug/hGphKZxXNGGCx0M
         Oq+KlketkfabePRdMX5ybr/+v1bXmHn5xwY4zg7LNhUUQE+0VcP0YEBVdzJhiBZxS54y
         qadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXb7GwfUN0cPM9ffS/TJOhN7coUOiUmAkZkN563cZ0A=;
        b=4tk1mNAwY+4IuhXYVUArbjxiWYxVBBCHHTdtIm8sdRYx84ytNMgWLHB6/twb2RvNkK
         /BhV628ym9/n5kupHv/+ojgxv1GG8s5Pu7+Eq3rBP9zbiUPX4G/9hBxZ7XJj9GupGwqn
         7H1NjMxW4iajwvrKOm0OPj+X6lK5Bh5SoT3bHiuyXwPlz+m/R0Ztpq3WWn3YTBjc3kcr
         2DZqFggAlo3v+U80RAFvh6R0L1qUgbwNw1Zj4dMda3UIdLmaDRLFVm6uFyD/uNYjfC0D
         FKP1CU+Ab/y0Wkamf4vRug2QXIx5oyfVbWPcPBO5bwSZ/NRU/t7vzZwKOILA1V/1zmEm
         0OiQ==
X-Gm-Message-State: AO0yUKXORPs0EC1BiXvY549lGETA5+qcMjoZyFvWcQ9nX4OCJjm8wckN
        n45/j9OvfIRaO814m5GNJcs=
X-Google-Smtp-Source: AK7set8Da8KLBgwP2TWYEXBmUT5TzKxe8bZF7sIVo4a4wryItNeUSucRY7Yf2Jh1alUa+EB0mBx+Xg==
X-Received: by 2002:a05:600c:2a08:b0:3dc:5deb:40a0 with SMTP id w8-20020a05600c2a0800b003dc5deb40a0mr8297512wme.8.1677143984188;
        Thu, 23 Feb 2023 01:19:44 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c409200b003db06224953sm11610441wmh.41.2023.02.23.01.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:19:43 -0800 (PST)
Message-ID: <5e66efbf-b33b-a3a2-9723-ea2be30a567d@gmail.com>
Date:   Thu, 23 Feb 2023 10:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 05/14] dma-buf/sync_file: Add SET_DEADLINE ioctl
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230218211608.1630586-1-robdclark@gmail.com>
 <20230218211608.1630586-6-robdclark@gmail.com>
 <37ec0125-8d0b-7d87-321d-ed4c7c7b32a7@amd.com>
 <CAF6AEGtAHXQ05tWoXdbx3_TK+11+XN6J9wuXssSh3PswUhvwgg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAF6AEGtAHXQ05tWoXdbx3_TK+11+XN6J9wuXssSh3PswUhvwgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.02.23 um 17:09 schrieb Rob Clark:
> On Mon, Feb 20, 2023 at 12:27 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 18.02.23 um 22:15 schrieb Rob Clark:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> The initial purpose is for igt tests, but this would also be useful for
>>> compositors that wait until close to vblank deadline to make decisions
>>> about which frame to show.
>>>
>>> The igt tests can be found at:
>>>
>>> https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/fence-deadline
>>>
>>> v2: Clarify the timebase, add link to igt tests
>>>
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>>    drivers/dma-buf/sync_file.c    | 19 +++++++++++++++++++
>>>    include/uapi/linux/sync_file.h | 22 ++++++++++++++++++++++
>>>    2 files changed, 41 insertions(+)
>>>
>>> diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
>>> index af57799c86ce..fb6ca1032885 100644
>>> --- a/drivers/dma-buf/sync_file.c
>>> +++ b/drivers/dma-buf/sync_file.c
>>> @@ -350,6 +350,22 @@ static long sync_file_ioctl_fence_info(struct sync_file *sync_file,
>>>        return ret;
>>>    }
>>>
>>> +static int sync_file_ioctl_set_deadline(struct sync_file *sync_file,
>>> +                                     unsigned long arg)
>>> +{
>>> +     struct sync_set_deadline ts;
>>> +
>>> +     if (copy_from_user(&ts, (void __user *)arg, sizeof(ts)))
>>> +             return -EFAULT;
>>> +
>>> +     if (ts.pad)
>>> +             return -EINVAL;
>>> +
>>> +     dma_fence_set_deadline(sync_file->fence, ktime_set(ts.tv_sec, ts.tv_nsec));
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>    static long sync_file_ioctl(struct file *file, unsigned int cmd,
>>>                            unsigned long arg)
>>>    {
>>> @@ -362,6 +378,9 @@ static long sync_file_ioctl(struct file *file, unsigned int cmd,
>>>        case SYNC_IOC_FILE_INFO:
>>>                return sync_file_ioctl_fence_info(sync_file, arg);
>>>
>>> +     case SYNC_IOC_SET_DEADLINE:
>>> +             return sync_file_ioctl_set_deadline(sync_file, arg);
>>> +
>>>        default:
>>>                return -ENOTTY;
>>>        }
>>> diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
>>> index ee2dcfb3d660..c8666580816f 100644
>>> --- a/include/uapi/linux/sync_file.h
>>> +++ b/include/uapi/linux/sync_file.h
>>> @@ -67,6 +67,20 @@ struct sync_file_info {
>>>        __u64   sync_fence_info;
>>>    };
>>>
>>> +/**
>>> + * struct sync_set_deadline - set a deadline on a fence
>>> + * @tv_sec:  seconds elapsed since epoch
>>> + * @tv_nsec: nanoseconds elapsed since the time given by the tv_sec
>>> + * @pad:     must be zero
>>> + *
>>> + * The timebase for the deadline is CLOCK_MONOTONIC (same as vblank)
>>> + */
>>> +struct sync_set_deadline {
>>> +     __s64   tv_sec;
>>> +     __s32   tv_nsec;
>>> +     __u32   pad;
>> IIRC struct timespec defined this as time_t/long (which is horrible for
>> an UAPI because of the sizeof(long) dependency), one possible
>> alternative is to use 64bit nanoseconds from CLOCK_MONOTONIC (which is
>> essentially ktime).
>>
>> Not 100% sure if there is any preferences documented, but I think the
>> later might be better.
> The original thought is that this maps directly to clock_gettime()
> without extra conversion needed, and is similar to other pre-ktime_t
> UAPI.  But OTOH if userspace wants to add an offset, it is maybe
> better to convert completely to ns in userspace and use a u64 (as that
> is what ns_to_ktime() uses).. (and OFC whatever decision here also
> applies to the syncobj wait ioctls)
>
> I'm leaning towards u64 CLOCK_MONOTONIC ns if no one has a good
> argument against that.

+1 for that.

Regards,
Christian.

>
> BR,
> -R
>
>> Either way the patch is Acked-by: Christian König
>> <christian.koenig@amd.com> for this patch.
>>
>> Regards,
>> Christian.
>>
>>> +};
>>> +
>>>    #define SYNC_IOC_MAGIC              '>'
>>>
>>>    /**
>>> @@ -95,4 +109,12 @@ struct sync_file_info {
>>>     */
>>>    #define SYNC_IOC_FILE_INFO  _IOWR(SYNC_IOC_MAGIC, 4, struct sync_file_info)
>>>
>>> +
>>> +/**
>>> + * DOC: SYNC_IOC_SET_DEADLINE - set a deadline on a fence
>>> + *
>>> + * Allows userspace to set a deadline on a fence, see dma_fence_set_deadline()
>>> + */
>>> +#define SYNC_IOC_SET_DEADLINE        _IOW(SYNC_IOC_MAGIC, 5, struct sync_set_deadline)
>>> +
>>>    #endif /* _UAPI_LINUX_SYNC_H */

