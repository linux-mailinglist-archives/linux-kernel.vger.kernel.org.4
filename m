Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5908B675F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjATUwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjATUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:52:02 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5672E1633A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:51:58 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id x7so5111431qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdhFwaO8jvi38wzgBJTqgOhr7S3cjuxIo0ahdVDzYdA=;
        b=jBgWmZ0Bx3t3n9WRqm1ogW/JQSWbn7jttKlp299aTYvNyZTW6artrtpJq+DW27Xz7P
         vYWJltW3GkhMGCDonVukPZWRIty3acfo7IFDIuBXn5ZkZF+1JQg5xKn4vDqXvJPZSsO2
         txRU6zQXrjIT0pMqYAtURO1I5ywDwvX9UYHj4FNxqhiWmBLeIzRsetPSCZqfhE/Yi8XO
         K5AUgPcRp6GjkvKyLFVfkFDSWkaXRqkRBDE/1bxDnACh7GxZ4Al7W18e49TGQhVgwxft
         JCMkqY8YP1cZsWmrP+rB2NIcZJgcY9GMfR+gEeAUovwOjPS46P+7VXPajqSIdF351fBL
         pFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdhFwaO8jvi38wzgBJTqgOhr7S3cjuxIo0ahdVDzYdA=;
        b=pbVMQlwIpvF4BwN4FUEUurUkOlGvkPJvCx503mRTXbvBV9h2cXPmqQ+je096ErCZ1g
         1zC98gOeubVMGys75b6Orh39l3qy9g5eR1t0HNmhej5s+EpMlIDTjgpoImShI257iY5t
         deRVedjnRDdneWbBMGve1K5z64A8wmPZ4hv3VbtxX9EI+4kd5EdCfPh9iO0fvPpn196H
         gAh3IoUVfkvAZ9pCRI+viWCYAsD5pY3papO3JD8S5dDKWzejqqyx7dXugkOZFu0t9GEs
         BlMknanNVLqP7BaGjP4qUFA7mft8YSpRG8AuZT0DGx6gDdfJFSpfn7mMtxkZqCuLc7VW
         2lqw==
X-Gm-Message-State: AFqh2krE2v3MM3YuvkMsqGmPYvp/Ppbi091CP7ys/hN9m5s34QZVNVqd
        TJ7SgcJKhXSP9HOHrxR7eI0=
X-Google-Smtp-Source: AMrXdXt+4k+Xs3D6k2X+aPJ2MGAfcaj30OyvcHlaplP0O8ez9G/zsSlkc7p6xH8mnLddZhJT/gxCCw==
X-Received: by 2002:ac8:748e:0:b0:3b6:2e37:3394 with SMTP id v14-20020ac8748e000000b003b62e373394mr19330282qtq.27.1674247917425;
        Fri, 20 Jan 2023 12:51:57 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id ce15-20020a05622a41cf00b003b62e9c82ebsm8572830qtb.48.2023.01.20.12.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 12:51:56 -0800 (PST)
Message-ID: <31646cc6-0ed7-89b8-06f9-aaa584ef8047@gmail.com>
Date:   Fri, 20 Jan 2023 15:51:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/2] riscv: Kconfig: Allow RV32 to build with no MMU
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
 <20230119052642.1112171-2-Mr.Bossman075@gmail.com> <Y8pJ4y7FyBDQPqIT@wendy>
 <056f0d30-d340-fdc4-3744-1cdedd8b4048@gmail.com> <Y8r9GuyUAfJWYY5Z@spud>
 <Y8r+B3TZpeI32iTz@spud>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <Y8r+B3TZpeI32iTz@spud>
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



On 1/20/23 15:48, Conor Dooley wrote:
> On Fri, Jan 20, 2023 at 08:44:10PM +0000, Conor Dooley wrote:
>> On Fri, Jan 20, 2023 at 12:39:06PM -0500, Jesse Taube wrote:
>>> On 1/20/23 02:59, Conor Dooley wrote:
>>>> Since you'll have to re-submit, making sure that allowing !MMU on rv32
>>>> doesn't break the build due to canaan k210 drivers being enabled despite
>>>> relying on 64-bit divisions, I've got some nits for you.
>>> Not sure what driver needs 64bit, but sense !MMU was only selected by 64BIT.
>>
>> LKP reported a build error for it:
>> https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel.com/
>>
>>> This should work.
>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>> index 69774bb362d6..b9835b8ede86 100644
>>> --- a/arch/riscv/Kconfig.socs
>>> +++ b/arch/riscv/Kconfig.socs
>>> @@ -43,7 +43,7 @@ config SOC_VIRT
>>>
>>>   config SOC_CANAAN
>>>          bool "Canaan Kendryte K210 SoC"
>>> -       depends on !MMU
>>> +       depends on !MMU && 64BIT
>>>          select CLINT_TIMER if RISCV_M_MODE
>>>          select SERIAL_SIFIVE if TTY
>>>          select SERIAL_SIFIVE_CONSOLE if TTY
>>
>> I don't think this is the correct fix for the problem - the drivers
>> really should not do implicit 64-bit divisions IMO.
>> Linux has division helpers for them in math64.h.
>> None of the other SoCs have a dependency on 64BIT and I'd not been keen
>> on adding on here.
>>
>> I suspect the fix is as simple as the below, but I'd need to go test it.
>>
>> Thanks,
>> Conor.
>>
>> --- 8< ---
>>  From ecfa79ad1b24f68cfccb77d666e443293d52d066 Mon Sep 17 00:00:00 2001
>> From: Conor Dooley <conor.dooley@microchip.com>
>> Date: Fri, 20 Jan 2023 20:36:29 +0000
>> Subject: [PATCH] clk: k210: remove an implicit 64-bit division
>>
>> The K210 clock driver depends on SOC_CANAAN, which is only selectable
>> when !MMU on RISC-V. !MMU is not possible on 32-bit yet, but patches
>> have been sent for its enabling. The kernel test robot reported this
>> implicit 64-bit division there.
Oh I missed the bots email oops.

undefined reference to `__udivdi3'
Poor linker isn't linking with libgcc

>>
>> Replace the implicit division with an explicit one.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel.com/
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>> Since it was always guarded such that it only ever built for 64-bit, I
>> am not sure that a fixes tag is needed, but it would be:
>> Fixes: c6ca7616f7d5 ("clk: Add RISC-V Canaan Kendryte K210 clock driver")
>> ---
>>   drivers/clk/clk-k210.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
>> index 67a7cb3503c3..17c5bfb384ad 100644
>> --- a/drivers/clk/clk-k210.c
>> +++ b/drivers/clk/clk-k210.c
>> @@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk_hw *hw,
>>   	f = FIELD_GET(K210_PLL_CLKF, reg) + 1;
>>   	od = FIELD_GET(K210_PLL_CLKOD, reg) + 1;
>>   
>> -	return (u64)parent_rate * f / (r * od);
>> +	return div_u64(parent_rate * f, r * od);
> 
> Nope, that's wrong. I omitted the cast...
> 
> 	return div_u64((u64)parent_rate * f, r * od);
Ah that's a much better fix, shall I prepend this to the set and author you?

> 
>>   }
>>   
>>   static const struct clk_ops k210_pll_ops = {
>> -- 
>> 2.39.0
>>
> 
> 
> 
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
