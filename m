Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E12863FFC8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 06:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiLBFRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 00:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiLBFRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 00:17:19 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1471D67A1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 21:17:17 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z14so9541pfr.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 21:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXDFMrE1UvonJwna6/qDy1dIKcqVQK/pCVdH6z/kGzg=;
        b=XO5vDtYYGE/vrJRZL9jWWossHYkzldTugmavz8aHWQ1I5R3D2HZ2rBLEi5IDZgzw3t
         NOa/IIA7+JkueaK9aAXvgWQ/Ui12YZ4+T7FFMGXfBUE+97KTYV0MgSu07a/QW2toPXLp
         rtgaOLj4x6l7oq1sQj+eGrTlModC3tN7r5tHY0lbwiUDa27dkMlngWp17EcPudo/FKS/
         YtziY2Z0YZ0lVGKGzJnbNHryh0GoTv0x5UO9WvIjCoXUmSXPAxH/R/wRh+kU59LvmFbe
         BZAhRitKM7cl3dLT+ewft2HG/mSWOJ5Fm7yaBSMHSTkqnvoYfHt7Rgi5/FB+pX7RNp/7
         W/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXDFMrE1UvonJwna6/qDy1dIKcqVQK/pCVdH6z/kGzg=;
        b=I/DUozt1HY0Ol92BSOn1GLVzWw2W04zJ+4KdZgT07TPoeg4i6bSvBjIdlvlty8pndJ
         IByMgYLmB3w1SVsgRrx+PTJp3Yiyv6UFBX80U5FhdamvE4y+Do11yGSjgOVSxDner7xT
         Eiz8iSmafV196arMbr3tbFUSoTJmLdr0lv5X1pYUCwAwfbXJIW28Rje3bMkWiq4Awyxk
         vyC9d1v9rC09jsn/uVqzmIoEppdW466znHnhp+QSZttYa0HsWXfAkw0TjVXFQWzXU+YA
         72oWCFSRMtF/T7rvd5KrGn5762oIQ0f23XzXY833kmcmXvA5RYSrLvJ9CLxj+i1DR9S8
         Oy2A==
X-Gm-Message-State: ANoB5pmc5uLtTHC/NwNKAuSvawBI3qR3TLpWM4WgPy3KFLz/Byhd6qDO
        i8c5d8Leun+bS5m/pMuFDpFqJQ==
X-Google-Smtp-Source: AA0mqf64KfT5K8NMbONNZg0RyISrnBcnpyDV0KjqhI+e4U6B3E5IyPBgeaoyrnNls02jIqo5qGFdlA==
X-Received: by 2002:a63:2306:0:b0:46f:918e:7339 with SMTP id j6-20020a632306000000b0046f918e7339mr42792281pgj.429.1669958237424;
        Thu, 01 Dec 2022 21:17:17 -0800 (PST)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419? ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id p29-20020a635b1d000000b004785d99321asm3368017pgb.86.2022.12.01.21.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 21:17:17 -0800 (PST)
Message-ID: <525ff263-90b3-5b12-da31-171b09f9ad1b@daynix.com>
Date:   Fri, 2 Dec 2022 14:17:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 0/3] KVM: arm64: Handle CCSIDR associativity mismatches
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
References: <20221201104914.28944-1-akihiko.odaki@daynix.com>
 <867czbmlh1.wl-maz@kernel.org>
 <50499ee9-33fe-4f5d-9d0a-76ceef038333@daynix.com>
 <87lenqu37t.wl-maz@kernel.org>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87lenqu37t.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/02 8:13, Marc Zyngier wrote:
> On Thu, 01 Dec 2022 17:26:08 +0000,
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2022/12/01 20:06, Marc Zyngier wrote:
>>> On Thu, 01 Dec 2022 10:49:11 +0000,
>>> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> Thanks for looking into this.
>>>
>>>> M2 MacBook Air has mismatched CCSIDR associativity bits, which makes the
>>>> bits a KVM vCPU sees inconsistent when migrating.
>>>
>>> Can you describe the actual discrepancy? Is that an issue between the
>>> two core types? In which case, nothing says that these two cluster
>>> should have the same cache topology.
>>
>> Yes, the processor has big.LITTLE configuration.
>>
>> On the processor, the valid CSSELR values are 0 (L1D), 1 (L1I), 3
>> (L2D). For each CSSELR values, each cluster has:
>> - 0x700FE03A, 0x203FE01A, 0x70FFE07B
>> - 0x701FE03A, 0x203FE02A, 0x73FFE07B
> 
> This is a perfectly valid configuration. The architecture doesn't
> place any limitation on how different or identical the cache
> hierarchies are from the PoV of each CPU. Actually, most big-little
> systems show similar differences across their clusters.
> 
>>>> It also makes QEMU fail restoring the vCPU registers because QEMU saves
>>>> and restores all of the registers including CCSIDRs, and if the vCPU
>>>> migrated among physical CPUs between saving and restoring, it tries to
>>>> restore CCSIDR values that mismatch with the current physical CPU, which
>>>> causes EFAULT.
>>>
>>> Well, QEMU will have plenty of other problems, starting with MIDRs,
>>> which always reflect the physical one. In general, KVM isn't well
>>> geared for VMs spanning multiple CPU types. It is improving, but there
>>> is a long way to go.
>>
>> On M2 MacBook Air, I have seen no other difference in standard ID
>> registers and CCSIDRs are exceptions. Perhaps Apple designed this way
>> so that macOS's Hypervisor can freely migrate vCPU, but I can't assure
>> that without more analysis. This is still enough to migrate vCPU
>> running Linux at least.
> 
> I guess that MacOS hides more of the underlying HW than KVM does. And
> KVM definitely doesn't hide the MIDR_EL1 registers, which *are*
> different between the two clusters.

It seems KVM stores a MIDR value of a CPU and reuse it as "invariant" 
value for ioctls while it exposes the MIDR value each physical CPU owns 
to vCPU.

This may be a problem worth fixing. My understanding is that while there 
is no serious application which requires vCPU migration among physical 
clusters, crosvm uses KVM on big.LITTLE processors by pinning vCPU to 
physical CPU, and it is a real-world application which needs to be 
supported.

For an application like crosvm, you would expect the vCPU thread gets 
the MIDR value of the physical CPU which the thread is pinned to when it 
calls ioctl, but it can get one of another arbitrary CPU in reality.

Fixing this problem will pose two design questions:

1. Should it expose a value consistent among clusters?

For example, we can change the KVM initialization code so that it 
initializes VPIDR with the value stored as "invariant". This would help 
migrating vCPU among clusters, but if you pin each vCPU thread to a 
distinct phyiscal CPU, you may rather want the vCPU to see the MIDR 
value specific to each physical CPU and to apply quirks or tuning 
parameters according to the value.

2. Should it be invariant or variable?

Fortunately making it variable is easy. Arm provides VPIDR_EL1 register 
to specify the value exposed as MPIDR_EL0 so there is no trapping cost.

...or we may just say the value of MPIDR_EL0 (and possibly other 
"invariant" registers) exposed via ioctl are useless and deprecated.

> 
>>>> Trap CCSIDRs if there are CCSIDR value msimatches, and override the
>>>> associativity bits when handling the trap.
>>>
>>> TBH, I'd rather we stop reporting this stuff altogether.
>>>
>>> There is nothing a correctly written arm64 guest should do with any of
>>> this (this is only useful for set/way CMOs, which non-secure SW should
>>> never issue). It would be a lot better to expose a virtual topology
>>> (one set, one way, one level). It would also save us from the CCSIDRX
>>> silliness.
>>>
>>> The only complexity would be to still accept different topologies from
>>> userspace so that we can restore a VM saved before this virtual
>>> topology.
>>
>> Another (minor) concern is that trapping relevant registers may cost
>> too much. Currently KVM traps CSSELR and CCSIDR accesses with
>> HCR_TID2, but HCR_TID2 also affects CTR_EL0.
> 
> It will have an additional impact (JITs, for example, will take a hit
> if they don't cache that value), but this is pretty easy to mitigate
> if it proves to have too much of an impact. We already have a bunch of
> fast-paths for things that we want to emulate more efficiently, and
> CTR_EL0 could be one of them,
> 
>> Although I'm not sure if the register is referred frequently, Arm
>> introduced FEAT_EVT to trap CSSELR and CSSIDR but not CTR_EL0 so
>> there may be some case where trapping CTR_EL0 is not
>> tolerated. Perhaps Arm worried that a userspace application may read
>> CTR_EL0 frequently.
> 
> FEAT_EVT is one of these "let's add random traps" extensions,
> culminating in FEAT_FGT. Having FEAT_EVT would make it more efficient,
> but we need to support this for all revisions of the architecture.
> 
> So let's first build on top of HCR_EL2.TID2, and only then once we
> have an idea of the overhead add support for HCR_EL2.TID4 for the
> systems that have FEAT_EVT.

That sounds good, I'll write a new series according to this idea.

Regards,
Akihiko Odaki

> 
>> If you think the concern on VM restoration you mentioned and the
>> trapping overhead is tolerable, I'll write a new, much smaller patch
>> accordingly.
> 
> That would great, thanks. There are a number of gotchas around that
> (like the 32bit stuff that already plays the emulation game), but this
> is the right time to start and have something in 6.3 if you keep to it!
> 
> 	M.
> 
