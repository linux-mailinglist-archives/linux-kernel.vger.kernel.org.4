Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC86A1C29
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjBXM3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjBXM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:29:39 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E9D4AFFB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:29:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cq23so53894722edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U85lTxPI8HIs2MT3aO7tP2yErKRCDhWpRh7/zVvSLog=;
        b=liy+RpRYt9hKtRpYroQyOZxM8Aubo4//jHKIjZgJULpAq9lydt6znuXyl/U57A4PHt
         8HvYPsbb/fq2cSTUS0wEjqqWeAWIoVkaLpVavkL9MiPJGVzQYqCKIbhPV5RkWZbixIvU
         keaOQaK0iJkmjUfS6y34hBsuMKSenkXK6OXspeQ8uNbGVqS1shcO3jZusPCeDZJHRfoP
         XkAUKAUUevKLWObDVUpedBkgIaf3K8wNLRSCPiX73J6jqZV2R0iqeN+zKnXk5YiQDg5n
         IaLK/G5M5h0B8arsk010YkCpQZJY2eypArHT5IDhU75It14RtXsNoy4ZrPU6/MWsoe55
         MyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U85lTxPI8HIs2MT3aO7tP2yErKRCDhWpRh7/zVvSLog=;
        b=rcVeWGAcAz0VNyyq08sRuJHQh1TIC8QWZxmBNeNZBNqFwPwSUk7/NbfGtqhypm9ZqM
         41+d2FMpw1dh03iILUfsFHQ+We5D73pWH42tAIkDaTNHbqEb+N39ePa6yEfiAr0quNo7
         qY3OZU8vaDM0V8djUckPIL8C83T52KtvLSzT938D8W8FFzfxrNcMlgtDtT+btOjZ37Cv
         UnUqXZthB5xuuYIQ7WApDe7N9Tz4BiFbTQDOZavb2OkqwozZrUjzvlp57heSJLMIsjfr
         WQPF03YvcTTpB9m4hchGuP4t0Udn0mCEg51rCN59Wkv9aSyA3eA2UGXhPICP+MaMCC2p
         JZqQ==
X-Gm-Message-State: AO0yUKVeZmjhW1QUy7TTcIHRN+lOVqxjMM/FYLNT8+zwrLdtB5N5E21k
        Aktou9TPaDmUXsZvw5Aqeis=
X-Google-Smtp-Source: AK7set/2k+NoF04T/r4/iDr+s6FsBtskm8fAFCDcFKs7ndguqNOR2fbGOfP36c9887hiFQgd0pimqQ==
X-Received: by 2002:aa7:cd77:0:b0:4ad:7301:fe77 with SMTP id ca23-20020aa7cd77000000b004ad7301fe77mr15505929edb.9.1677241774381;
        Fri, 24 Feb 2023 04:29:34 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:35e:38c6:dafc:5dd2? ([2a02:908:1256:79a0:35e:38c6:dafc:5dd2])
        by smtp.gmail.com with ESMTPSA id g5-20020a50ee05000000b004af728bf265sm1074330eds.44.2023.02.24.04.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 04:29:33 -0800 (PST)
Message-ID: <43016018-4d0a-94dc-ce93-b4bff2dce71c@gmail.com>
Date:   Fri, 24 Feb 2023 13:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: amdgpu didn't start with pci=nocrs parameter, get error "Fatal
 error during GPU init"
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CABXGCsMbqw2qzWSCDfp3cNrYVJ1oxLv8Aixfm_Dt91x1cvFX4w@mail.gmail.com>
 <a99e6def-68be-3f2b-4e01-ac26cdb80f49@gmail.com>
 <CABXGCsM7JPxtQm6B7vk+ZcXfphgQm=ArJZKiDUdbk9hujyRtmg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsM7JPxtQm6B7vk+ZcXfphgQm=ArJZKiDUdbk9hujyRtmg@mail.gmail.com>
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

Am 24.02.23 um 09:38 schrieb Mikhail Gavrilov:
> On Fri, Feb 24, 2023 at 12:13 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Hi Mikhail,
>>
>> this is pretty clearly a problem with the system and/or it's BIOS and
>> not the GPU hw or the driver.
>>
>> The option pci=nocrs makes the kernel ignore additional resource windows
>> the BIOS reports through ACPI. This then most likely leads to problems
>> with amdgpu because it can't bring up its PCIe resources any more.
>>
>> The output of "sudo lspci -vvvv -s $BUSID_OF_AMDGPU" might help
>> understand the problem
> I attach both lspci for pci=nocrs and without pci=nocrs.
>
> The differences for Cezanne Radeon Vega Series:
> with pci=nocrs:
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Interrupt: pin A routed to IRQ 255
> Region 4: I/O ports at e000 [disabled] [size=256]
> Capabilities: [c0] MSI-X: Enable- Count=4 Masked-
>
> Without pci=nocrs:
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Interrupt: pin A routed to IRQ 44
> Region 4: I/O ports at e000 [size=256]
> Capabilities: [c0] MSI-X: Enable+ Count=4 Masked-
>
>
> The differences for Navi 22 Radeon 6800M:
> with pci=nocrs:
> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Interrupt: pin A routed to IRQ 255
> Region 0: Memory at f800000000 (64-bit, prefetchable) [disabled] [size=16G]
> Region 2: Memory at fc00000000 (64-bit, prefetchable) [disabled] [size=256M]
> Region 5: Memory at fca00000 (32-bit, non-prefetchable) [disabled] [size=1M]

Well that explains it. When the PCI subsystem has to disable the BARs of 
the GPU we can't access it any more.

The only thing we could do is to make sure that the driver at least 
fails gracefully.

Do you still have network access to the box when amdgpu fails to load 
and could grab whatevery is in dmesg?

Thanks,
Christian.

> AtomicOpsCtl: ReqEn-
> Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
> Address: 0000000000000000  Data: 0000
>
> Without pci=nocrs:
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 103
> Region 0: Memory at f800000000 (64-bit, prefetchable) [size=16G]
> Region 2: Memory at fc00000000 (64-bit, prefetchable) [size=256M]
> Region 5: Memory at fca00000 (32-bit, non-prefetchable) [size=1M]
> AtomicOpsCtl: ReqEn+
> Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee00000  Data: 0000
>
>> but I strongly suggest to try a BIOS update first.
> This is the first thing that was done. And I am afraid no more BIOS updates.
> https://rog.asus.com/laptops/rog-strix/2021-rog-strix-g15-advantage-edition-series/helpdesk_bios/
>
> I also have experience in dealing with manufacturers' tech support.
> Usually it ends with "we do not provide drivers for Linux".
>

