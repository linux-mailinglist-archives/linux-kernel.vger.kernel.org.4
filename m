Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC6B6C935B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCZJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:19:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB80974D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:19:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i5so24461228eda.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHZVFQkvBzOY5c4akiAgaCUw1iB4MGS8We/N4ruh3k8=;
        b=gqqvpvRZ0SdoxCmQqae1KSjIEjDh2PjxWE9UOelHJdAZQNfXsfpIUmhQzlSEEoqf+o
         mfQUctvn6msdbvoegyTomav7T+kjGRO3PRvwcyFXV0AWKAuqXbCTVILx//2bumI7cxGH
         KBI+kaEhRIdAt97A53YpSBEBjoJNNyonkARH4XdfaqZYtZfwdnvQNSF39wUcd7my8HKj
         m/Qtv/qshyPbwYZ1/LnrqlafjseLlHovhJs61rABrFLmZoZ/3APhoBnDgGLBifFPCQ5z
         ezjlApqFuRBYlMEJPbb34cSN6GyqZUfrFT7g8FLDS8hztVQrLVgzQQ3W+yW5jubhPOhh
         l8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHZVFQkvBzOY5c4akiAgaCUw1iB4MGS8We/N4ruh3k8=;
        b=stHpo2NjEocD1eLR9jC4pSJZdOaJ/PljOn5w0KqHHe49SxC0/OJOlpW2/PLu02l5gS
         V2Iob9nDotgWwhVqiE+RQWAqychEZE7sLuCmCp3JJurep93Fr3WYZ4vEo+OMjGwu4bag
         AeHJuMJmWLqjHe7q4Bweep6eNIdsmpBhQ1TyQd3dGPMBiWmqmU/bh4OOpHBdmCFrx/P9
         TnZS97k7dgfrrl/MG290c0W6V1h/h8TKyar0hg+PA0ZPwM8lIpVDaHozyQejMeHj6uzK
         uT5DZj845WdsFCH83VCjH8ONmTsnVkv+aLKeBLFtE64hZEo5SEP8HdU6MLTtkPR6mhh2
         OyDA==
X-Gm-Message-State: AAQBX9dqniI3zygtmhZ7aqZnlkfY1l5FyOCjM0vvHjqglEWO1xnHZF85
        972QEGujhr+pw/bGhHr1cBs=
X-Google-Smtp-Source: AKy350YY0uqokPOGnxU+dnpux6gC0xC75d1rTwE9/7vPu2Z8GpOMozFb6sLJdMp92bUZ13hIuhS3MA==
X-Received: by 2002:a17:906:1514:b0:92b:ae6c:23e7 with SMTP id b20-20020a170906151400b0092bae6c23e7mr8926676ejd.56.1679822369040;
        Sun, 26 Mar 2023 02:19:29 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:87fb:f6c5:5d64:ee25? ([2a02:908:1256:79a0:87fb:f6c5:5d64:ee25])
        by smtp.gmail.com with ESMTPSA id c24-20020a50d658000000b00501d5432f2fsm8382000edj.60.2023.03.26.02.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 02:19:28 -0700 (PDT)
Message-ID: <2631edac-a57e-638d-226c-08ea3d9b6b8d@gmail.com>
Date:   Sun, 26 Mar 2023 11:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v13 01/10] drm/shmem-helper: Switch to reservation lock
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>
References: <20230314022659.1816246-1-dmitry.osipenko@collabora.com>
 <20230314022659.1816246-2-dmitry.osipenko@collabora.com>
 <6b5644cf-6229-f99b-d429-a45d724493ee@collabora.com>
 <20c88807-8513-a816-aed9-5cd67eb5c1ed@collabora.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20c88807-8513-a816-aed9-5cd67eb5c1ed@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.03.23 um 15:58 schrieb Dmitry Osipenko:
> On 3/15/23 16:46, Dmitry Osipenko wrote:
>> On 3/14/23 05:26, Dmitry Osipenko wrote:
>>> @@ -633,7 +605,10 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
>>>   		return ret;
>>>   	}
>>>   
>>> +	dma_resv_lock(shmem->base.resv, NULL);
>>>   	ret = drm_gem_shmem_get_pages(shmem);
>>> +	dma_resv_unlock(shmem->base.resv);
>> Intel CI reported locking problem [1] here. It actually was also
>> reported for v12, but I missed that report because of the other noisy
>> reports.
>>
>> [1]
>> https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_114671v2/shard-snb5/igt@prime_vgem@sync@rcs0.html
>>
>> The test does the following:
>>
>> 1. creates vgem
>> 2. export it do dmabuf
>> 3. mmaps dmabuf
>>
>> There is an obvious deadlock there. The DRM code assumes that mmap() is
>> unlocked, while for dma-buf it's locked. I'll see how to fix it for v14.
>>
> Christian, there is a deadlock problem in drm_gem_shmem_mmap() once we
> move drm-shmem to use resv lock. The current dma-buf locking policy
> claims that importer holds the lock for mmap(), but DRM code assumes
> that obj->mmap() handles the locking itself and then the same
> obj->mmap() code path is used by both dma-buf DRM and a usual DRM object
> paths. Hence importer -> dma_buf_mmap_internal()[takes the lock] ->
> exporter -> drm_gem_shmem_mmap()[takes the lock] deadlocks.
>
> I was looking at how to fix it and to me the best option is to change
> the dma-buf locking policy, making exporter responsible for handling the
> resv lock. Changing DRM code mmap lockings might be possible too [moving
> locking to drm_gem_mmap_obj()], but will be very messy and doesn't feel
> intuitive.
>
> Want to get yours thoughts on this before sending out the dma-buf mmap()
> policy-change patch. Does the new mmap() locking policy sound good to
> you? Thanks!


IIRC we tried that before and ran into problems.

dma_buf_mmap() needs to swap the backing file of the VMA and for this 
calls fput() on the old file.

This fput() in turn could (in theory) grab the resv lock as well and 
there isn't anything we could do about that.

Just information from the back of my memory, probably best if you double 
check that.

Regards,
Christian.
