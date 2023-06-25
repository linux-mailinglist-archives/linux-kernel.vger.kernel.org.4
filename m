Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4726573D19F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjFYPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFYPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:09:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A265D1B7;
        Sun, 25 Jun 2023 08:09:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5577900c06bso1811729a12.2;
        Sun, 25 Jun 2023 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687705771; x=1690297771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVh54AiRY2maqm1BEPVTl5/CxTXjv6X2NhvFWQ0OjHo=;
        b=OeBpPFSU5Wd+JbWFjSswSCQXtUYVAO0lZDuCsi1G5knHa0bFyzGYkxEdqy8mbzb6p+
         rZUXm+fkrocHcXbxB/HNGZ/CjLJB1XfADG2DpgpGnpsx8s0JtdtLQnZvRuz+8coU/B0+
         d8HBqXguCt3GcopFRUAar84OzO4WdGkO3CkkdaRY0nDsusWEfSpcbNujtYHW6SdFneIH
         thKxYEkBvIC3B4xqJvVzT1vboI5gyEWRy2IuqIX8SMxQ909wSVkJLmXLkHtr8R6eLB0g
         pbmjwdQ+FvZqtEHDFK72blGPcnPyQe2MhOGVAvPLFxdnrIPP6H0hjKvjmDXb2DuPvifD
         tvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687705771; x=1690297771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aVh54AiRY2maqm1BEPVTl5/CxTXjv6X2NhvFWQ0OjHo=;
        b=NX0vntbh8U1YRM4TTtHlLIrsWmMZIwWsBtAMvjah9wY257drcAHEtJpvr9nleePk++
         cWjrVyKPr8Dv9CQ7NrwaARP/+3s/w3ztoUECOt1IjYPNossRwrZQY2DH/W/ebpfNNSeG
         y43dUXxvR2YXRuFQB/8yJZgv+O6CqS4IPCCp14Q4+DKGF4tabOcdOkEUJ7QCdwxPlNOe
         8olGqd4rC7DV383kfir2/WZTuVXEUDza4lXclZoWw/XcbGC/TFhF0nqItfCL+RNsXr1J
         UqQdB4e/lyVH7Y8M3pyfDHFk3zk8dMCZyCgReS2HB/RN/r0/lA2EUV6K4TMjUs9fS05e
         1yBg==
X-Gm-Message-State: AC+VfDzU3nzXDnKjymn3occNuKS4hqKSm5hwBleN/PVQrdG6snGLxR7f
        6IuTC1ZrfIHOsGvn1AF4Ws0=
X-Google-Smtp-Source: ACHHUZ4nWcnXGi3AXbtLp2opVZDYOjhgbrKiCWFd+K0O248eUCpZd8yRMmQ9rFFRQ+//TmTNItdgdA==
X-Received: by 2002:a17:902:a705:b0:1b1:a9e7:5d4b with SMTP id w5-20020a170902a70500b001b1a9e75d4bmr4933953plq.22.1687705770998;
        Sun, 25 Jun 2023 08:09:30 -0700 (PDT)
Received: from [0.0.0.0] ([5.180.77.117])
        by smtp.gmail.com with ESMTPSA id iz13-20020a170902ef8d00b001b7fe13c97csm686590plb.72.2023.06.25.08.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 08:09:30 -0700 (PDT)
Message-ID: <20281f01-2cc9-892e-beea-eb2bb91e3ca5@gmail.com>
Date:   Sun, 25 Jun 2023 23:09:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V1 1/3] Revert "RISC-V: mark hibernation as nonportable"
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        mpe@ellerman.id.au, arnd@arndb.de, rppt@kernel.org,
        samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
 <20230625140931.1266216-2-songshuaishuai@tinylab.org>
 <20230625-multiple-diaper-1db88a75314e@spud>
From:   Song Shuai <suagrfillet@gmail.com>
In-Reply-To: <20230625-multiple-diaper-1db88a75314e@spud>
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


Sorry for the delayed reply,
My tinylab email went something wrong, I'll use gmail in this thread.

在 2023/6/25 22:18, Conor Dooley 写道:
> On Sun, Jun 25, 2023 at 10:09:29PM +0800, Song Shuai wrote:
>> This reverts commit ed309ce522185583b163bd0c74f0d9f299fe1826.
>>
>> With the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the
>> linear mapping") reverted, the MIN_MEMBLOCK_ADDR points the kernel
>> load address which was placed at a PMD boundary.
> 
>> And firmware always
>> correctly mark resident memory, or memory protected with PMP as
>> per the devicetree specification and/or the UEFI specification.
> 
> But this is not true? The versions of OpenSBI that you mention in your
> cover letter do not do this.
> Please explain.
> 

At this time, OpenSbi [v0.8,v1.3) and edk2(RiscVVirt) indeed don't obey 
the DT/UEFI spec. This statement is excerpted from "Reserved memory for 
resident firmware" part from the upcoming riscv/boot.rst. It isn't 
accurate for now. How about deleting this one?

Actually with 3335068f8721 reverted, the change of MIN_MEMBLOCK_ADDR can 
avoid the mapping of firmware memory, I will make it clear in the next 
version.

>> So those regions will not be mapped in the linear mapping and they
>> can be safely saved/restored by hibernation.
>>
>> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>> ---
>>   arch/riscv/Kconfig | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 5966ad97c30c..17b5fc7f54d4 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -800,11 +800,8 @@ menu "Power management options"
>>   
>>   source "kernel/power/Kconfig"
>>   
>> -# Hibernation is only possible on systems where the SBI implementation has
>> -# marked its reserved memory as not accessible from, or does not run
>> -# from the same memory as, Linux
>>   config ARCH_HIBERNATION_POSSIBLE
>> -	def_bool NONPORTABLE
>> +	def_bool y
>>   
>>   config ARCH_HIBERNATION_HEADER
>>   	def_bool HIBERNATION
>> -- 
>> 2.20.1
>>
