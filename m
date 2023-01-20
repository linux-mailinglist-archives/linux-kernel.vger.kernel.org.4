Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FDC675BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjATRjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjATRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:39:22 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2857C564B7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:39:12 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j9so4714316qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUwcPnODL6tkDv1+EEZooXCQzQNc6RaXSg0BM7X5yck=;
        b=HiwKJ0B8Tq/Czmzvwwj3WFQLpQg4XyD1sycR56XD6gZQIrpV2B/W0G3/bD7G+kPeN/
         fUNUt7l8O6BDKRneUBI0nTIYBN3P90cZCv567eleh4T/6U0V8UadYf1YT2M39pM9Bzsk
         X/UD8ELxspxIMH00oddsGsis4zD8Y2Q2vA0nJvVDXg88j1qdaMxX/oweh8tuO9jKbRrq
         pe5NRKabG8x5L6MsyTdHb2dPurmwlUL5TxtwzK+LwO1PcPdIWkk2ZlfYLEEp1rHhOmLC
         Cy+FwEYdm7Gp4+Zoz/kyrpwZdTSffy/MGvB6+XbhQjHwTKH80gLMoYSIIf9tP+xwlXFu
         UMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUwcPnODL6tkDv1+EEZooXCQzQNc6RaXSg0BM7X5yck=;
        b=gE48ieRBwytUDKy5rLTeQIwJ8ftU6b03iu9IC1vUgXl3JBeTQ8iJDg6qoa3purqJkA
         zrg75IgYhYaiirjO8F02IimLNXG/KOQf1bu4GdRk2JGVUxkolmsvWdnCqjUQJiiEtvka
         8F5qFfRbSXJHf4rOLxIXNQyeW7KA2bNN1v4YYPbmJDKxa6+vglBSdvPTtemOJ43mbp++
         IvQ/g/PveKdHgvLJCwQckE6vseL1WIkiLMm3rvQBF8w0B5AFYOp1FvV09eg09SxMDyAt
         MW9AhP67AoB68yLpVcJaEMtR/D/Up5FOB02IWRvuLs6hFEU4L2IghmZiVsNJIw33qCzs
         cxqw==
X-Gm-Message-State: AFqh2krEGDHpNPt0kSCG/e5yWOU8GvNw1y6YTtXIhkty1uS8fN9gurOM
        UPRd26biiutoK73SAPSzgh4=
X-Google-Smtp-Source: AMrXdXut8qn33mbyBanIQct87VFtSEsClB7xkNdQJFYnrNKxxe8k6Ic9jvSF+Utibg/3+zmxkSdVJw==
X-Received: by 2002:ac8:6650:0:b0:3b6:2ce9:baef with SMTP id j16-20020ac86650000000b003b62ce9baefmr20448474qtp.59.1674236351179;
        Fri, 20 Jan 2023 09:39:11 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id fp26-20020a05622a509a00b003a70a675066sm615724qtb.79.2023.01.20.09.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 09:39:09 -0800 (PST)
Message-ID: <056f0d30-d340-fdc4-3744-1cdedd8b4048@gmail.com>
Date:   Fri, 20 Jan 2023 12:39:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/2] riscv: Kconfig: Allow RV32 to build with no MMU
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
 <20230119052642.1112171-2-Mr.Bossman075@gmail.com> <Y8pJ4y7FyBDQPqIT@wendy>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <Y8pJ4y7FyBDQPqIT@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/23 02:59, Conor Dooley wrote:
> Hello!
> 
> Since you'll have to re-submit, making sure that allowing !MMU on rv32
> doesn't break the build due to canaan k210 drivers being enabled despite
> relying on 64-bit divisions, I've got some nits for you.
Not sure what driver needs 64bit, but sense !MMU was only selected by 
64BIT. This should work.
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..b9835b8ede86 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -43,7 +43,7 @@ config SOC_VIRT

  config SOC_CANAAN
         bool "Canaan Kendryte K210 SoC"
-       depends on !MMU
+       depends on !MMU && 64BIT
         select CLINT_TIMER if RISCV_M_MODE
         select SERIAL_SIFIVE if TTY
         select SERIAL_SIFIVE_CONSOLE if TTY

> On Thu, Jan 19, 2023 at 12:26:41AM -0500, Jesse Taube wrote:
>> From: Yimin Gu <ustcymgu@gmail.com>
>>
>> Some RISC-V 32bit ores do not have an MMU, and the kernel should be
> 
>   s/ores/cores
OH thanks sorry for the spelling mistakes.

Thanks,
Jesse Taube
>> able to build for them. This patch enables the RV32 to be built with
>> no MMU support.
>>
>> Signed-off-by: Yimin Gu <ustcymgu@gmail.com>
>> CC: Jesse Taube <Mr.Bossman075@gmail.com>
>> Tested-By: Waldemar Brodkorb <wbx@openadk.org>
> 
> And the automation complains that this tag is not "Tested-by:"
> 
> Thanks,
> Conor.
> 
>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>> ---
>>   arch/riscv/Kconfig | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 59d18881f35b..49759dbe6a8f 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -163,8 +163,8 @@ config MMU
>>   
>>   config PAGE_OFFSET
>>   	hex
>> -	default 0xC0000000 if 32BIT
>> -	default 0x80000000 if 64BIT && !MMU
>> +	default 0xC0000000 if 32BIT && MMU
>> +	default 0x80000000 if !MMU
>>   	default 0xff60000000000000 if 64BIT
>>   
>>   config KASAN_SHADOW_OFFSET
>> @@ -262,7 +262,6 @@ config ARCH_RV32I
>>   	select GENERIC_LIB_ASHRDI3
>>   	select GENERIC_LIB_LSHRDI3
>>   	select GENERIC_LIB_UCMPDI2
>> -	select MMU
>>   
>>   config ARCH_RV64I
>>   	bool "RV64I"
>> -- 
>> 2.39.0
>>
>>
