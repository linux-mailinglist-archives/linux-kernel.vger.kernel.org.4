Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E96B9EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCNSge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjCNSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:36:29 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA3B4F7E;
        Tue, 14 Mar 2023 11:35:58 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id bo10so12642626qvb.12;
        Tue, 14 Mar 2023 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678818941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbuPyTjtZPF7OPF+yupul5FSQrj+hiJD5YM/Xn3ImzE=;
        b=RhXHVmCaiwPLRccMA5hIGlVxa9xrFcBP/W4j+g6B7lQKIiSMJeIQMUMsrdsCFiGXVL
         jPEWHUg3G+TyVF3jVOa9Z9xOrfqFc5zUeoQZukyLCORApnxw4jkrbU2zR6tssx39t6Ft
         Q/tJfsPkxV7tUqpI/IishMbAE8v6uJHLHaEE4mGlSBKr3erzjy0pkl0m3cSmZ4WT0QSL
         QVKjAnASogXIDMbSfF5rf4xxJ5n1wE+SFmOWdzRxPtnOzLDrVPIum0N+2nxvDLDiA9kW
         +MrTaP/3CbntgijPGKYj5LdFlbRpkHqbuKelmdNr3Umlv5roRAkv9RK4OoeJH1Db29Bi
         I08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbuPyTjtZPF7OPF+yupul5FSQrj+hiJD5YM/Xn3ImzE=;
        b=hK5so+VwSXuWg1zNep695ddqw0z/6oTBaKdA3K2iLVDrqKw4ySUjxIwCkTE0N0so7K
         /qReWr1CH2KlsXTBX3ZhHNKgttGq0NkyH1gbzsjuxrbK3DQSfZJfoHMpZNQSi7KwTD0V
         cAzwExRP8ZUtP+Ua3l0H45VBLg3JbHF9LSLW6UNWPIuMFBeghoG09q0zAIWgxRtuTk4x
         hrqkoL1K6Qu1eIZ6kwIJVBfsZWRtMnVQ51RZAtQJlcWM2hjf0zBZq2rXoOv75pYmaCpp
         BPwNuv4hVv9Wed8EdP5YSRXW/97sqF/wVuWIfEKIAybSwzmX+EwtJdjUODgLp2V73YCy
         8mpA==
X-Gm-Message-State: AO0yUKWskKExc3BiRxlLZv3dLY6++4MdeRUXSZqu+bDUujn+dctS8CLc
        E1yDBQewfEDi/4iEHrYbXEU=
X-Google-Smtp-Source: AK7set/NLPJ+ot5pa30dDd81YJCU3glEFvfYtS+DdoKz2ryTYscpV5hTdalwhNuUEVW1QVtiGXqn6A==
X-Received: by 2002:a05:622a:390:b0:3af:b6bd:aba7 with SMTP id j16-20020a05622a039000b003afb6bdaba7mr59159758qtx.43.1678818940997;
        Tue, 14 Mar 2023 11:35:40 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id q9-20020a05620a024900b0071eddd3bebbsm2263112qkn.81.2023.03.14.11.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:35:40 -0700 (PDT)
Message-ID: <dd45cdec-55d2-1a46-520d-e1468597c18a@gmail.com>
Date:   Tue, 14 Mar 2023 14:35:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/3] Add RISC-V 32 NOMMU support
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
 <42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org>
 <556ce787-80eb-dc48-f8d6-83e415538e36@opensource.wdc.com>
 <f8f291d9-2723-4ab8-3020-49018757d470@gmail.com>
 <62852ee1-3763-3323-c3a8-f1e84f70204a@infradead.org>
 <c7941231-8ebd-dea5-81f8-3180cfc3f286@gmail.com>
 <1d858dbb-ae85-95a0-3e46-b67017733c04@infradead.org>
 <db3b3412-9616-d13c-3374-48647325e057@infradead.org>
 <7280914e-59e3-ba6d-4324-a29c1c0b4ce8@gmail.com>
 <2ebe4bc5-c11c-89b1-2644-358dc12bdfa5@infradead.org>
 <d3fb242e-646e-50b5-7dba-17b228bb32aa@opensource.wdc.com>
 <416e27cd-0826-9bfa-8ee8-cf70dfb503c1@gmail.com>
 <debe0a4a-126f-2308-d40c-32ed2d9f91e3@opensource.wdc.com>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <debe0a4a-126f-2308-d40c-32ed2d9f91e3@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 23:11, Damien Le Moal wrote:
> On 3/8/23 12:46, Jesse Taube wrote:
>>
>>
>> On 3/7/23 22:42, Damien Le Moal wrote:
>>> On 3/8/23 12:23, Randy Dunlap wrote:
>>>>>> OK, I don't know how it happened. I cannot reproduce it now.
>>>>>> The failing .config files has CONFIG_MMU is not set (for RV32I), which
>>>>>> appears to be impossible.
>>>>> These patches add `CONFIG_MMU is not set` (for RV32I).
>>>>> But no worries it seems to be a non issue  now.
>>>>>
>>>>> Your thoughts Damien?
>>>>>
>>>>
>>>> Thanks for reminding me.
>>>>
>>>> With these 3 patches applied to linux-next-20230307,
>>>> I still get this build error.
>>>
>>> Does this help ?
>>>
>>> diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
>>> index 2527cf5757ec..7796c5f1d109 100644
>>> --- a/drivers/soc/canaan/Kconfig
>>> +++ b/drivers/soc/canaan/Kconfig
>>> @@ -4,7 +4,8 @@ config SOC_K210_SYSCTL
>>>           bool "Canaan Kendryte K210 SoC system controller"
>>>           depends on RISCV && SOC_CANAAN && OF
>>>           default SOC_CANAAN
>>> -        select PM
>>> -        select MFD_SYSCON
>>> +       select COMMON_CLK_K210

Ok so this has nothing to do with my patch-set actually and will happen 
on 64BIT as well.
the commit that brought in this bug is:

RISC-V: stop directly selecting drivers for SOC_CANAAN 
3af577f9826fdddefac42b35fc5eb3912c5b7d85

I have tested the patches Damien here they work on 64BIT and 32BIT.
The change to drivers/clk/Kconfig is not strictly necessary but makes 
scene. I don't think they need to be tested on 32bit so we can omit 
COMPILE_TEST.

If needed i can submit the patches, which I will author under Damien.

As far as I can see there is nothing holding back this set as the issue 
found has no relation to this set.

Thanks,
Jesse Taube

>>> +       select PM
>>> +       select MFD_SYSCON
>>>           help
>>>             Canaan Kendryte K210 SoC system controller driver.
>>>
>>> (just noticed that there are whitespace errors here...)
>>>
>>> Note that both the sysctl and clk driver depend on RISCV. I think these should
>>> probably also depend on 64BIT, and eventually add a "|| COMPILE_TEST" as well.
>>> So something like this:
>>>
>>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>>> index b6c5bf69a2b2..657a36d2640d 100644
>>> --- a/drivers/clk/Kconfig
>>> +++ b/drivers/clk/Kconfig
>>> @@ -431,7 +431,7 @@ config COMMON_CLK_FIXED_MMIO
>>>
>>>    config COMMON_CLK_K210
>>>           bool "Clock driver for the Canaan Kendryte K210 SoC"
>>> -       depends on OF && RISCV && SOC_CANAAN
>>> +       depends on OF && RISCV && SOC_CANAAN && (64BIT || COMPILE_TEST)
>>>           default SOC_CANAAN
>>>           help
>>>             Support for the Canaan Kendryte K210 RISC-V SoC clocks.
>>> diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
>>> index 2527cf5757ec..1745a614d2a7 100644
>>> --- a/drivers/soc/canaan/Kconfig
>>> +++ b/drivers/soc/canaan/Kconfig
>>> @@ -2,9 +2,10 @@
>>>
>>>    config SOC_K210_SYSCTL
>>>           bool "Canaan Kendryte K210 SoC system controller"
>>> -       depends on RISCV && SOC_CANAAN && OF
>>> +       depends on RISCV && SOC_CANAAN && OF && (64BIT || COMPILE_TEST)
>>>           default SOC_CANAAN
>>> -        select PM
>>> -        select MFD_SYSCON
>>> +       select COMMON_CLK_K210
>>> +       select PM
>>> +       select MFD_SYSCON
>>>           help
>>>             Canaan Kendryte K210 SoC system controller driver.
>>>
>>> COMPILE_TEST is optional though, but I do not see any reason why not eventhough
>>> in practice these drivers will likely never end up in 32-bits SoC.
>>>
>>>
>>
>> Oh thanks I was in the in the midst of making a similar patch.
>> Do you want to submit it or shall I. Also thanks for the help with this,
>> was using tag 6.2.
> 
> I am busy with other stuff and do not have time to properly test this. So please
> feel free to go ahead and send something fully tested.
> 
