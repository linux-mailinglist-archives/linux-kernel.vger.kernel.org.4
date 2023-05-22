Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436E570C5D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjEVTMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjEVTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:12:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAED9B0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:12:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96fffe11714so197518866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684782766; x=1687374766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RH0Zf6SSIW6QoBUKPWp/zoQijLydPGslM9QKv8h/5w=;
        b=oph+D4WWLxlnyEmFPNjgsPeJBISPU+KD4UUa9fg3DYqpUFyUcSy2A8sXDz1JY90HSj
         xzoIZxLys2edI8VLxZ8SUICa6hs3ltLdhVckgRuVX12qWbyO/5/P5pXToBwghYmBImM4
         GxRtg+DjoFlZs2IQbw0GRuJkLAWdEq1jL02CeY8Oq1Vw/LZ24lXVPWKiu9wvC6wvwqZe
         4zxJGa7IFF9hpOxgj4zYfuwN4QgxA9EJl+uW/GIm5xFwfzg32f6498xgXrNJY+sWojOs
         3i26c1lUlOX7fCy8Iy8fJMXZc8FzORlXncsYSBRN0ku1dfkTcxAIO4l1uhBY/2ohh+8c
         +YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684782766; x=1687374766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RH0Zf6SSIW6QoBUKPWp/zoQijLydPGslM9QKv8h/5w=;
        b=QKXjmeYwggruo91b9oQxuHElJ8YdvK/E7eihGRDFHF2JOKN3mRvyBck+egoZtnYCAg
         5/si3N2Wz4V1T57QrT0UBvrIVARLq/6LDuvIwqnoMUvoVnO7OJfG+xxs/OaYy08N0qNs
         yuc99AbpGmIMMTXJBduNKzfJcs2cmE/zgYOEUZsAL21JXCqNOc99/POY41A8imI9oSJf
         ZnjpY05nBaCc3fDAutEeZ5vRoWzgd1fUQMqVmfo4mbN3FwHMhNE3zOnoAGXnNc5g41U5
         INkUqvJjwNfQ+TaygWX0iBqPNyZ70NptH9s0ZEfTykbt4BhHBfyUbLuCpvdjYPSw4yGT
         V60A==
X-Gm-Message-State: AC+VfDzkirTWfURma8qWO7mj4zZpvcnO/YX02zTjyly0RoSJQT5h3CYo
        z7ilSv7mPzdtvt0ydT1a4eU=
X-Google-Smtp-Source: ACHHUZ51p7wdPuwDp950is/pz1bFqE/LofFB2M9EBORGJoNj3EX0tf2KmXVRNkRcdY8N+GBHZZwCwA==
X-Received: by 2002:a17:907:3fa8:b0:965:6075:d100 with SMTP id hr40-20020a1709073fa800b009656075d100mr13228831ejc.39.1684782766162;
        Mon, 22 May 2023 12:12:46 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15c4:ff00:1a51:43c9:7f06:6b44? ([2a00:e180:15c4:ff00:1a51:43c9:7f06:6b44])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906085800b0096f887f29d2sm3474738ejd.62.2023.05.22.12.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 12:12:45 -0700 (PDT)
Message-ID: <07ce00de-c686-05c6-3f27-f8857417ef10@gmail.com>
Date:   Mon, 22 May 2023 21:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] amdgpu: validate drm_amdgpu_gem_va addrs for all ops
Content-Language: en-US
To:     Chia-I Wu <olvaffe@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc:     Philip Yang <Philip.Yang@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Danijel Slivka <danijel.slivka@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Mukul Joshi <mukul.joshi@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Suren Baghdasaryan <surenb@google.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
References: <20230509183301.1745462-1-olvaffe@gmail.com>
 <CAPaKu7TqUt1L-5RUuwEagr2UUs8maOO+FSoS2PEoP9eO1-JJSw@mail.gmail.com>
 <CADnq5_OsGqg7CoNVgtgr91a+pyBtJzoUOBXHKmGMcOM9hLFkwQ@mail.gmail.com>
 <CAPaKu7SQ0NkDVN3NNRoJxGRQ8x2T2uXcxZJEkt7g2CkEzVU3Sg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAPaKu7SQ0NkDVN3NNRoJxGRQ8x2T2uXcxZJEkt7g2CkEzVU3Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.05.23 um 20:49 schrieb Chia-I Wu:
> On Thu, May 18, 2023 at 1:12 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Wed, May 17, 2023 at 5:27 PM Chia-I Wu <olvaffe@gmail.com> wrote:
>>> On Tue, May 9, 2023 at 11:33 AM Chia-I Wu <olvaffe@gmail.com> wrote:
>>>> Extend the address and size validations to AMDGPU_VA_OP_UNMAP and
>>>> AMDGPU_VA_OP_CLEAR by moving the validations to amdgpu_gem_va_ioctl.
>>>>
>>>> Internal users of amdgpu_vm_bo_map are no longer validated but they
>>>> should be fine.
>>>>
>>>> Userspace (radeonsi and radv) seems fine as well.
>>> Does this series make sense?
>> I think so, I haven't had a chance to go through this too closely yet,
>> but amdgpu_vm_bo_map() is used by ROCm as well so we'd need to make
>> sure that removing the checks in patch 1 wouldn't affect that path as
>> well.  The changes in patch 2 look good.  Also, these patches are
>> missing your SOB.
> Indeed.  kfd_ioctl_alloc_memory_of_gpu, for example, does not validate
> va.  I need to keep the validation in amdgpu_vm_bo_map for it at
> least.  I guess it is more ideal for kfd_ioctl_alloc_memory_of_gpu to
> validate, but I am not familiar with amdkfd..
>
> I can keep the existing validations, and duplicate them in
> amdgpu_gem_va_ioctl to cover AMDGPU_VA_OP_UNMAP/AMDGPU_VA_OP_CLEAR.

The key point is that unmap and clear don't need those validations.

It's perfectly valid to request unmap of an unaligned mapping, it will 
just fail because we can't find that mapping.

Regards,
Christian.

>
>> Thanks,
>>
>> Alex
>>
>>
>> Alex

