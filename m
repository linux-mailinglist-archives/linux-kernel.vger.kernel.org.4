Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F865F74E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJGHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJGHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:50:50 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B3BC4C21
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:50:35 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 964D23F838
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1665129032;
        bh=zVbaJWt71VZ4qd8uFrn7B4xqgpqfBaH9DEwYzQrhOEk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EADg/lk65qFLptXNWbC4F9yp0B0ynWTT7ClTbrUOBxT7GGgyWl+bu/afXOP8M5iOT
         g10Obqa3wrr24Oepu9pnpGUfvoXUTe9najuQmKGsc5ItdHFnvnvBmrXsiSgn1MvBPT
         GnARaN2aHpLMmmghgHMwOlpvs8i6KpzTlphr7lt8Tkygiy3t8dE35GWd4aqwgwmpHd
         o89lGSwHRFV592lXsy++njqrnfSNPyPRN7OxYVa51tdpM1uDRci3nuWYjUbjEBF968
         4WHplD95lU/62mR/UVnC/KoaJa7DSLlymmOSJ3nh9okNff13QhVhO6CjhudOZXT2S7
         0D/veS3HiPIGw==
Received: by mail-ed1-f70.google.com with SMTP id q17-20020a056402519100b00459a2e5adbcso3274835edd.16
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVbaJWt71VZ4qd8uFrn7B4xqgpqfBaH9DEwYzQrhOEk=;
        b=pCRcKJlQtSLnYbGrIRMt8fmAj2JkaB8jEMiA3F4dQAie+paH02ryf7YAycKxGqQSV8
         ixjE+7wn5nI8yc2h2tr++V5S0P98YtBGNHTKFER4Hd+SfeMRkqbpYKcMsO9FPFqPfx0K
         YPS2xzxvpgg8ZWLizpnvgRrZ0m4LzKXkgrxDWgzuO6QBe39OUaJ1nrxVFWMKgFoMVJXW
         JhnyHtTQA4ymnVsgfwL4gTKDJJs4anq3oomCWw2v4uXQeHBtXWYvX9caKB2RUWoT/0fj
         D0Kf1Cr223iUWGn7ydm3ai0fl3wZK0sKt5ADgJXM7WjcX+vO9t9jEymsVQqQg1VrUdX4
         ZxqA==
X-Gm-Message-State: ACrzQf1tx/HW0GhlZO/hFWRJOu1tHdZOdUkoF7XwSUd/vEyq9UiZuc3T
        q3vDk2fyn7IspA0piP4rUQ8s0xtvUG9HNqOELiCLEPYR1J3g9oG7fN2GgrbkC7h8ioodCgUmxBY
        EkvGWPjkS9mTgS+oQrxy1eg+hpKg6c6JzKMyL9dQcOw==
X-Received: by 2002:a17:907:d91:b0:78d:1e79:ce66 with SMTP id go17-20020a1709070d9100b0078d1e79ce66mr3014282ejc.736.1665129032223;
        Fri, 07 Oct 2022 00:50:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/+KW33FgtgV5GrcwTwhQQM9epHNgRHzOq6HgXKRR2Iyf5Mug7hhThqTrdJbWXfxdROj5G8A==
X-Received: by 2002:a17:907:d91:b0:78d:1e79:ce66 with SMTP id go17-20020a1709070d9100b0078d1e79ce66mr3014263ejc.736.1665129031895;
        Fri, 07 Oct 2022 00:50:31 -0700 (PDT)
Received: from [192.168.123.94] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id o11-20020a056402038b00b0045467008dd0sm935939edv.35.2022.10.07.00.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 00:50:31 -0700 (PDT)
Message-ID: <4ef86adf-a7c7-5ffc-6acc-9d269ea089ba@canonical.com>
Date:   Fri, 7 Oct 2022 09:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [v4 PATCH 2/3] RISC-V: Update image header
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221006230051.185850-1-atishp@rivosinc.com>
 <20221006230051.185850-3-atishp@rivosinc.com>
 <b1306db2-74c5-c207-7c6d-beba0f1593f4@canonical.com>
 <CAMj1kXENi6rGK5tuU5ny5gAXMGLErx3o8ci3stazq0HJO5QArg@mail.gmail.com>
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXENi6rGK5tuU5ny5gAXMGLErx3o8ci3stazq0HJO5QArg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/22 09:20, Ard Biesheuvel wrote:
> On Fri, 7 Oct 2022 at 01:51, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>>
>>
>> On 10/7/22 01:00, Atish Patra wrote:
>>> Update the RISC-V Linux kernel image headers as per the current header.
>>>
>>> Reference:
>>> <Linux kernel source>/Documentation/riscv/boot-image-header.rst
>>>
>>> 474efecb65dc: ("riscv: modify the Image header to improve compatibility with the ARM64 header")
>>>
>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> ---
>>>    include/grub/riscv32/linux.h | 15 ++++++++-------
>>>    include/grub/riscv64/linux.h | 21 +++++++++++++--------
>>>    2 files changed, 21 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/include/grub/riscv32/linux.h b/include/grub/riscv32/linux.h
>>> index 512b777c8a41..de0dbdcd1be5 100644
>>> --- a/include/grub/riscv32/linux.h
>>> +++ b/include/grub/riscv32/linux.h
>>> @@ -19,20 +19,21 @@
>>>    #ifndef GRUB_RISCV32_LINUX_HEADER
>>>    #define GRUB_RISCV32_LINUX_HEADER 1
>>>
>>> -#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
>>> +#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */
>>
>> Thanks for following up on this series.
>>
>> Considering 69edb312056 ("loader/arm64/linux: Remove magic number header
>> field check") why should this constant exist in GRUB at all?
>>
>> In a follow up patch we could remove it together with
>> GRUB_LINUX_ARM_MAGIC_SIGNATURE, GRUB_LINUX_ARMXX_MAGIC_SIGNATURE, and
>> GRUB_LINUX_ARMXX_MAGIC_SIGNATURE.
>>
> 
> Indeed.
> 
> But by the same reasoning, why do we need per-arch kernel header
> typedefs at all?  The only fields we access are generic PE/COFF header
> fields.

That said I would suggest to put the series in without any further 
iterations and clean up afterwards.

Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> 
>>>
>>> -/* From linux/Documentation/riscv/booting.txt */
>>> +/* From linux/Documentation/riscv/boot-image-header.rst */
>>>    struct linux_riscv_kernel_header
>>>    {
>>>      grub_uint32_t code0;              /* Executable code */
>>>      grub_uint32_t code1;              /* Executable code */
>>> -  grub_uint64_t text_offset; /* Image load offset */
>>> -  grub_uint64_t res0;                /* reserved */
>>> -  grub_uint64_t res1;                /* reserved */
>>> +  grub_uint64_t text_offset; /* Image load offset, little endian */
>>> +  grub_uint64_t image_size;  /* Effective Image size, little endian */
>>> +  grub_uint64_t flags;               /* kernel flags, little endian */
>>> +  grub_uint32_t version;     /* Version of this header */
>>> +  grub_uint32_t res1;                /* reserved */
>>>      grub_uint64_t res2;               /* reserved */
>>>      grub_uint64_t res3;               /* reserved */
>>
>> According to tag next-20221006 of
>> Documentation/riscv/boot-image-header.rst and of
>> arch/riscv/include/asm/image.h this field is called 'magic' and filled
>> it with the string 'RISCV\0\0\0'.
>>
>>> -  grub_uint64_t res4;                /* reserved */
>>> -  grub_uint32_t magic;               /* Magic number, little endian, "RSCV" */
>>> +  grub_uint32_t magic;               /* Magic number, little endian, "RSC\x05" */
>>
>> The Linux kernel documentation calls this field magic2.
>>
>> Of course this is functionally irrelevant as we don't care about the
>> content of both fields.
>>
>>>      grub_uint32_t hdr_offset; /* Offset of PE/COFF header */
>>>    };
>>>
>>> diff --git a/include/grub/riscv64/linux.h b/include/grub/riscv64/linux.h
>>> index 3630c30fbf1a..ea77f8718222 100644
>>> --- a/include/grub/riscv64/linux.h
>>> +++ b/include/grub/riscv64/linux.h
>>> @@ -19,23 +19,28 @@
>>>    #ifndef GRUB_RISCV64_LINUX_HEADER
>>>    #define GRUB_RISCV64_LINUX_HEADER 1
>>>
>>> -#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
>>> +#include <grub/efi/pe32.h>
>>> +
>>> +#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */
>>
>> to be removed in future
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>    #define GRUB_EFI_PE_MAGIC   0x5A4D
>>>
>>> -/* From linux/Documentation/riscv/booting.txt */
>>> +/* From linux/Documentation/riscv/boot-image-header.rst */
>>>    struct linux_riscv_kernel_header
>>>    {
>>>      grub_uint32_t code0;              /* Executable code */
>>>      grub_uint32_t code1;              /* Executable code */
>>> -  grub_uint64_t text_offset; /* Image load offset */
>>> -  grub_uint64_t res0;                /* reserved */
>>> -  grub_uint64_t res1;                /* reserved */
>>> +  grub_uint64_t text_offset; /* Image load offset, little endian */
>>> +  grub_uint64_t image_size;  /* Effective Image size, little endian */
>>> +  grub_uint64_t flags;               /* kernel flags, little endian */
>>> +  grub_uint32_t version;     /* Version of this header */
>>> +  grub_uint32_t res1;                /* reserved */
>>>      grub_uint64_t res2;               /* reserved */
>>> -  grub_uint64_t res3;                /* reserved */
>>> -  grub_uint64_t res4;                /* reserved */
>>> -  grub_uint32_t magic;               /* Magic number, little endian, "RSCV" */
>>> +  grub_uint64_t magic;               /* magic (RISC-V specifc, deprecated)*/
>>> +  grub_uint32_t magic2;              /* Magic number 2 (to match the ARM64 'magic' field pos) */
>>>      grub_uint32_t hdr_offset; /* Offset of PE/COFF header */
>>> +
>>> +  struct grub_coff_image_header coff_image_header;
>>>    };
>>>
>>>    #define linux_arch_kernel_header linux_riscv_kernel_header
