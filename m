Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095196E1A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDNCvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDNCvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:51:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C52C9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:51:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso3364156pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1681440691; x=1684032691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52dTXDeasU3qeAPixz48OWdPDQAgiBEqkhzYoyavubA=;
        b=ztmp0d0ENV/7cH9KnXyHx5Ng3dqjGSytavxqAGT5jFzqqKceLfNaAr60SAqxj3MQTV
         zixFfp92J5qEQ66MBxP7rUvGquIZGyx9O9qYOZthZkAiqr1NqX8Uk0X/BMUTM+pXaH1z
         DHOUJzUeWzCwmO80uuMDtRMdqXR1OgsMlElVjlt+Pw6S87uxL8+HUoNmaPx1NTvwxSmI
         9qXvjDrYZpp3NZ+2XZq8bAsrsdAhpQuAHfYScWefEm7h4xcobedu9Ac1Cn/UUOfqCCpU
         cOzrQ7PUh3Qn/IuDWu+ndlKTbtqL1ihta0PYQl0pl/yxdSWdOorgfzuaaK6WhWC1/zcO
         eTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681440691; x=1684032691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52dTXDeasU3qeAPixz48OWdPDQAgiBEqkhzYoyavubA=;
        b=keCHwPYcCvqyoVS1l0kylNgWMOw17Iu0aqvKpDc+1arDQMJ6GKF6QfNubSrDoD7YBD
         1pxkD5+sUKow/x2IyUyYimUAu3Fu4uGm3A1sMtXFIX/rRcyIApLKC2D9w2qqP88dE+Fb
         Nz64jhvAgXdQeUsgoc7oYiTPUnPOo33SJnDgXkbzju6TBlHs6K/BJewpZE6fvZwvmnUr
         mvmF8eHT2K/97pJDQaytgHJS90zRUBBlrVhyMzaTtQHTRTi8ua6J0mMpY8P6Z+0N+qK0
         5F+CUur6MwuTd9tAX1Vqou0MZCsZREUh1h32fHUDVKy0y7+DVr8oePS8/DkfweEORYyh
         SEGA==
X-Gm-Message-State: AAQBX9evEVp1iZmf6DwoZQqHEjWhhoRYWIHHPPzNZg6N0ahSfYhdtqcp
        DC9LGMuS+Gd/XvsZ5YzqO8tNJw==
X-Google-Smtp-Source: AKy350ai1GwoaP7hcrIv3V8SdFcLeiYB/1L3j7Pjabe9qVevpRPDt5e20MLhKX8LOT1eoDXFt4XVGQ==
X-Received: by 2002:a17:902:cad1:b0:1a6:6fe3:df8d with SMTP id y17-20020a170902cad100b001a66fe3df8dmr982543pld.8.1681440690708;
        Thu, 13 Apr 2023 19:51:30 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:4457:c267:5e09:481b? ([2400:4050:a840:1e00:4457:c267:5e09:481b])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709026b4700b001a1ed2fce9asm2102285plt.235.2023.04.13.19.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 19:51:30 -0700 (PDT)
Message-ID: <0d3f78ba-edff-5e64-2a3a-b2d7ec9b609a@daynix.com>
Date:   Fri, 14 Apr 2023 11:51:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: virtio-iommu hotplug issue
To:     eric.auger@redhat.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
 <20230413104041.GA3295191@myrica>
 <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
 <9a765411-00ad-307e-9ca2-f6a7defba9cc@redhat.com>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <9a765411-00ad-307e-9ca2-f6a7defba9cc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/04/13 22:39, Eric Auger wrote:
> Hi,
> 
> On 4/13/23 13:01, Akihiko Odaki wrote:
>> On 2023/04/13 19:40, Jean-Philippe Brucker wrote:
>>> Hello,
>>>
>>> On Thu, Apr 13, 2023 at 01:49:43PM +0900, Akihiko Odaki wrote:
>>>> Hi,
>>>>
>>>> Recently I encountered a problem with the combination of Linux's
>>>> virtio-iommu driver and QEMU when a SR-IOV virtual function gets
>>>> disabled.
>>>> I'd like to ask you what kind of solution is appropriate here and
>>>> implement
>>>> the solution if possible.
>>>>
>>>> A PCIe device implementing the SR-IOV specification exports a virtual
>>>> function, and the guest can enable or disable it at runtime by
>>>> writing to a
>>>> configuration register. This effectively looks like a PCI device is
>>>> hotplugged for the guest.
>>>
>>> Just so I understand this better: the guest gets a whole PCIe device PF
>>> that implements SR-IOV, and so the guest can dynamically create VFs?
>>> Out
>>> of curiosity, is that a hardware device assigned to the guest with VFIO,
>>> or a device emulated by QEMU?
>>
>> Yes, that's right. The guest can dynamically create and delete VFs.
>> The device is emulated by QEMU: igb, an Intel NIC recently added to
>> QEMU and projected to be released as part of QEMU 8.0.
>  From below description In understand you then bind this emulated device
> to VFIO on guest, correct?

Yes, that's correct.

>>
>>>
>>>> In such a case, the kernel assumes the endpoint is
>>>> detached from the virtio-iommu domain, but QEMU actually does not
>>>> detach it.
> The QEMU virtio-iommu device executes commands from the virtio-iommu
> driver and my understanding is the VFIO infra is not in trouble here. As
> suggested by Jean, a detach command probably is missed.

VFIO just illustrates the problem and the origin of the problem is 
indeed virtio-iommu.

Regards,
Akihiko Odaki

>>>>
>>>> This inconsistent view of the removed device sometimes prevents the
>>>> VM from
>>>> correctly performing the following procedure, for example:
>>>> 1. Enable a VF.
>>>> 2. Disable the VF.
>>>> 3. Open a vfio container.
>>>> 4. Open the group which the PF belongs to.
>>>> 5. Add the group to the vfio container.
>>>> 6. Map some memory region.
>>>> 7. Close the group.
>>>> 8. Close the vfio container.
>>>> 9. Repeat 3-8
>>>>
>>>> When the VF gets disabled, the kernel assumes the endpoint is
>>>> detached from
>>>> the IOMMU domain, but QEMU actually doesn't detach it. Later, the
>>>> domain
>>>> will be reused in step 3-8.
>>>>
>>>> In step 7, the PF will be detached, and the kernel thinks there is no
>>>> endpoint attached and the mapping the domain holds is cleared, but
>>>> the VF
>>>> endpoint is still attached and the mapping is kept intact.
>>>>
>>>> In step 9, the same domain will be reused again, and the kernel
>>>> requests to
>>>> create a new mapping, but it will conflict with the existing mapping
>>>> and
>>>> result in -EINVAL.
>>>>
>>>> This problem can be fixed by either of:
>>>> - requesting the detachment of the endpoint from the guest when the PCI
>>>> device is unplugged (the VF is disabled)
>>>
>>> Yes, I think this is an issue in the virtio-iommu driver, which
>>> should be
>>> sending a DETACH request when the VF is disabled, likely from
>>> viommu_release_device(). I'll work on a fix unless you would like to
>>> do it
>>
>> It will be nice if you prepare a fix. I will test your patch with my
>> workload if you share it with me.
> 
> I can help testing too
> 
> Thanks
> 
> Eric
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>>> - detecting that the PCI device is gone and automatically detach it on
>>>> QEMU-side.
>>>>
>>>> It is not completely clear for me which solution is more appropriate
>>>> as the
>>>> virtio-iommu specification is written in a way independent of the
>>>> endpoint
>>>> mechanism and does not say what should be done when a PCI device is
>>>> unplugged.
>>>
>>> Yes, I'm not sure it's in scope for the specification, it's more about
>>> software guidance
>>>
>>> Thanks,
>>> Jean
>>
> 
