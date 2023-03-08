Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F12C6AFD18
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCHCyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCHCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:54:31 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DAC9312F;
        Tue,  7 Mar 2023 18:54:27 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id nv15so10320850qvb.7;
        Tue, 07 Mar 2023 18:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678244067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96nRitXXABGOXpVS0aSB6wCBLIuREpSpzba47Egz9KA=;
        b=ZyJy478U/EIxnQEgkHvq6j7IA4lX7DXBRMB3RgY1Ytxt0ku1qElBxA6jNoI0Fv0V1c
         d5bhydNHBBfdXx8u8vyOZu59Ywj0w4NEQdcXEkj5bIjsrryoK7/3lveC3w3RFoQDwTxp
         p+s5/tUC5zRsZElKRppZUZV7VgBwoY07Nc/pKRFoCkPLW7+cRjYrjjOwBAvsQbcKcP04
         lYOt7PQC+/0qQUyYBdBespXNIVwui0/iEmqahIHUjh4Aw7td9HdnLhVsCso4W/rt61xX
         2gdsGiAT960e/qxhnCAnjVRrEmU/OtmzkVAVRiBDbMDznx9B5AXfNHpe8UCbA9TG+OWt
         JFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678244067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96nRitXXABGOXpVS0aSB6wCBLIuREpSpzba47Egz9KA=;
        b=EcDdFS2YR3/16RXz9RN8U7EXvlHiYiAMdHC7iFBfnzRoOc9VudabtdfMu0gWxSs14j
         yhr3e/CisovjeiUn7pzvHw2kYr3VjAA3h0dRrHtG3dlJQMWR8isU8yE3ko9B3ba0XgWS
         +aN861koWkaPk8zDy/kON1eOrGPZy+r/TFeM9bBiEsmdpwodjYHErv9XcFop+mz+yM7h
         RLPHhHDYiWydy07ea+4CNSP5OpaVweNcXhxE/eOE9grGkcS19jPDM26IyZfboFjjSJeC
         EQ/b9jPwpoLterhRMUje4HH7brbqXYj0zFBoltVJdRsEPgT2SbA0+wBj5ToC42vMj1rl
         upMw==
X-Gm-Message-State: AO0yUKUqqG21T7ZDiGXzHP2zdYEOxgJa63NcvBioHJgYi7QlWvg7zMfg
        VFHoTh4xK7wPOBiKeKZHo5k=
X-Google-Smtp-Source: AK7set8L3OEORXhcnFkSDGO1VM/i5FFhi7QOZmDS+2urUpMfw8GZhzylnJIB32fSoQWw2fTuJuYLvw==
X-Received: by 2002:a05:6214:5012:b0:537:6e29:e9e9 with SMTP id jo18-20020a056214501200b005376e29e9e9mr30960704qvb.21.1678244066699;
        Tue, 07 Mar 2023 18:54:26 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id s4-20020a372c04000000b0074283b87a4esm10546013qkh.90.2023.03.07.18.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 18:54:26 -0800 (PST)
Message-ID: <7280914e-59e3-ba6d-4324-a29c1c0b4ce8@gmail.com>
Date:   Tue, 7 Mar 2023 21:54:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/3] Add RISC-V 32 NOMMU support
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
 <42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org>
 <556ce787-80eb-dc48-f8d6-83e415538e36@opensource.wdc.com>
 <f8f291d9-2723-4ab8-3020-49018757d470@gmail.com>
 <62852ee1-3763-3323-c3a8-f1e84f70204a@infradead.org>
 <c7941231-8ebd-dea5-81f8-3180cfc3f286@gmail.com>
 <1d858dbb-ae85-95a0-3e46-b67017733c04@infradead.org>
 <db3b3412-9616-d13c-3374-48647325e057@infradead.org>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <db3b3412-9616-d13c-3374-48647325e057@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 21:51, Randy Dunlap wrote:
> 
> 
> On 3/7/23 18:33, Randy Dunlap wrote:
>>
>>
>> On 3/7/23 18:30, Jesse Taube wrote:
>>>
>>>
>>> On 3/7/23 21:16, Randy Dunlap wrote:
>>>> Hi--
>>>>
>>>> On 3/7/23 17:26, Jesse Taube wrote:
>>>>>
>>>>>
>>>>> On 2/28/23 23:42, Damien Le Moal wrote:
>>>>>> On 3/1/23 13:07, Randy Dunlap wrote:
>>>>>>> Hi--
>>>>>>>
>>>>>>> On 2/28/23 16:26, Jesse Taube wrote:
>>>>>>>> This patch-set aims to add NOMMU support to RV32.
>>>>>>>> Many people want to build simple emulators or HDL
>>>>>>>> models of RISC-V this patch makes it possible to
>>>>>>>> run linux on them.
>>>>>>>>
>>>>>>>> Yimin Gu is the original author of this set.
>>>>>>>> Submitted here:
>>>>>>>> https://lists.buildroot.org/pipermail/buildroot/2022-November/656134.html
>>>>>>>>
>>>>>>>> Though Jesse T rewrote the Dconf.
>>>>>>>
>>>>>>> Dconf?
>>>>>>>
>>>>>>>>
>>>>>>>> The new set:
>>>>>>>> https://lists.buildroot.org/pipermail/buildroot/2022-December/658258.html
>>>>>>>> ---
>>>>>>>> V1->V2:
>>>>>>>>     - Add Conor's clock patch for implicit div64
>>>>>>>>     - Fix typo in commit title 3/3
>>>>>>>>     - Fix typo in commit description 2/3
>>>>>>>> V2->V3
>>>>>>>>     - Change from defconfig file to a PHONY config
>>>>>>>> ---
>>>>>>>
>>>>>>> Is this 'rv32_nommu_virt_defconfig' target the only build target
>>>>>>> that is supported?
>>>>>>>
>>>>>>> I ask because I applied the 3 patches and did 25 randconfig builds.
>>>>>>> 5 of them failed the same way:
>>>>>>>
>>>>>>> riscv32-linux-ld: drivers/soc/canaan/k210-sysctl.o: in function `k210_soc_early_init':
>>>>>>> k210-sysctl.c:(.init.text+0x78): undefined reference to `k210_clk_early_init'
>>>>> I can not recreate this error.
>>>>> can you send me the .config you used.
>>>>>
>>>>> Thanks,
>>>>> Jesse Taube
>>>>
>>>> Sure, it's attached.
>>>
>>> Hmmm, it links fine for me.
>>>
>>> objdump -x vmlinux | grep k210_clk_early_init
>>> 81e40124 g     F .init.text     00000088 k210_clk_early_init
>>>
>>> gcc version 11.3.0 (Buildroot 2022.11-361-g1be0d438f7)
>>> GNU assembler version 2.38 (riscv32-buildroot-linux-uclibc)
>>> GNU ld (GNU Binutils) 2.38
>>>
>>> what gcc version are you using?
>>
>>
>> gcc (SUSE Linux) 12.2.1 20230124 [revision 193f7e62815b4089dfaed4c2bd34fd4f10209e27]
>> from opensuse Tumbleweed.
>>
>> I'll try it on a current tree...
> 
> OK, I don't know how it happened. I cannot reproduce it now.
> The failing .config files has CONFIG_MMU is not set (for RV32I), which
> appears to be impossible.
These patches add `CONFIG_MMU is not set` (for RV32I).
But no worries it seems to be a non issue  now.

Your thoughts Damien?

Thanks,
Jesse Taube
> 
> Sorry to bother you.
> 
> Thanks.
> 
>>>>
>>>>>> Arg. Forgot about that. k210 is rv64 only and while the clk driver could still
>>>>>> compile test with rv32 (or any arch), that driver provides the
>>>>>> k210_clk_early_init() function which is called very early in the boot process
>>>>>> from k210_soc_early_init(), which is an SOC_EARLY_INIT_DECLARE() call. The
>>>>>> problem may be there. Probably should be disabled for rv32 if no SoC need that
>>>>>> sort of early init call.
>>>>>>
>>>>>>>
>>>>>>> because
>>>>>>> # CONFIG_COMMON_CLK_K210 is not set
>>>>>>>
>>>>>>>
>>>>>>> Maybe SOC_CANAAN needs some more selects for required code?
>>>>>>>
>>>>>>>> Conor Dooley (1):
>>>>>>>>      clk: k210: remove an implicit 64-bit division
>>>>>>>>
>>>>>>>> Jesse Taube (1):
>>>>>>>>      riscv: configs: Add nommu PHONY defconfig for RV32
>>>>>>>>
>>>>>>>> Yimin Gu (1):
>>>>>>>>      riscv: Kconfig: Allow RV32 to build with no MMU
>>>>>>>>
>>>>>>>>     arch/riscv/Kconfig     | 5 ++---
>>>>>>>>     arch/riscv/Makefile    | 4 ++++
>>>>>>>>     drivers/clk/clk-k210.c | 2 +-
>>>>>>>>     3 files changed, 7 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>
> 
