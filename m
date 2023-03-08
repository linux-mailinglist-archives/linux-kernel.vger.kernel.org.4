Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF3D6AFCEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCHCa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHCaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:30:24 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DB39662F;
        Tue,  7 Mar 2023 18:30:23 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id r16so15199709qtx.9;
        Tue, 07 Mar 2023 18:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678242622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwm1K4ols2eiQIRxOttu3y7Xz4azJwmHdDxzSRJ6x94=;
        b=fm6c2F6neK6PHR42UlUD9L4qBI5U6gfj8j2gNX0YJzRcR7njORuBrRvl7vURZ8fbqS
         rCtgJw/x9OQHumm48Vr6OA64s7RfjTvrDJKlm0NSP+EwQ+bgfU3tSxRSZLggJsClqZnT
         BsS0QzjjjHkEbWWhRmZ2haaHVaHWVWQv1bF9s1M1qDULrCbimMkzOziKIIK2CUmbhdc3
         L2eEUftSYDo3gQXgnD2q4d8bGtaz3VyuzwcXh413L4lB2iowAplsjiR/RoJKni/ZJA09
         8xq+OcOkjpLvhv5ok+ULaoCtmpXWcLUx9gsa7aZQPB1/tjdDdBXNMkluQ3iGbOauBEaz
         zJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678242622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwm1K4ols2eiQIRxOttu3y7Xz4azJwmHdDxzSRJ6x94=;
        b=74VZgZVi93l6xwjPy4c5+lPlMoKYqpZ5SyviLx+/xPiUaOD3L03f7Hx6KbaEeNUj/2
         XZeby5bVxo1BIYlchBn/MRBXqqNpWCqJ2JAUXF5cHDbfKqi7iEpJgtOwnXYZgN/yqjK2
         +yzIrjf9nXhx9ZnLRA0wtCXiAoJZfZyNikJwYq3tJuZ5JRhSkfyQTSYXm8Br0+woluPK
         NKxuMZm0rInSbdgRLrPnkZOPidVB0bnLXYK+Vy4KGU95xo4Bc6+WUQfZ7Q9Lbt0qq8jK
         VbvYlLI6nO5UdAKk8jQ4rLMdixCdV+1ay2zTqgfDIGXe6l0b7AswGObJrrfaHQjbOkKh
         ow/Q==
X-Gm-Message-State: AO0yUKXqE67pz9yuhpXkg2qMj8hhnGeHk5F3AW7Jd3YHwVZULC/kumIO
        dcQ66uC63XQWYvcnsPI75R8=
X-Google-Smtp-Source: AK7set/ztpYCMMWq+qAXTagXXx6tlvdbYERArp/gIov2QhPzggq89VtCbEToC1JcjXZWkBKMNXllkw==
X-Received: by 2002:ac8:7fd5:0:b0:3bf:b75a:d7a7 with SMTP id b21-20020ac87fd5000000b003bfb75ad7a7mr38122459qtk.7.1678242622031;
        Tue, 07 Mar 2023 18:30:22 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id y16-20020a37f610000000b0074308a0124asm10534627qkj.50.2023.03.07.18.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 18:30:21 -0800 (PST)
Message-ID: <c7941231-8ebd-dea5-81f8-3180cfc3f286@gmail.com>
Date:   Tue, 7 Mar 2023 21:30:20 -0500
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
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <62852ee1-3763-3323-c3a8-f1e84f70204a@infradead.org>
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



On 3/7/23 21:16, Randy Dunlap wrote:
> Hi--
> 
> On 3/7/23 17:26, Jesse Taube wrote:
>>
>>
>> On 2/28/23 23:42, Damien Le Moal wrote:
>>> On 3/1/23 13:07, Randy Dunlap wrote:
>>>> Hi--
>>>>
>>>> On 2/28/23 16:26, Jesse Taube wrote:
>>>>> This patch-set aims to add NOMMU support to RV32.
>>>>> Many people want to build simple emulators or HDL
>>>>> models of RISC-V this patch makes it possible to
>>>>> run linux on them.
>>>>>
>>>>> Yimin Gu is the original author of this set.
>>>>> Submitted here:
>>>>> https://lists.buildroot.org/pipermail/buildroot/2022-November/656134.html
>>>>>
>>>>> Though Jesse T rewrote the Dconf.
>>>>
>>>> Dconf?
>>>>
>>>>>
>>>>> The new set:
>>>>> https://lists.buildroot.org/pipermail/buildroot/2022-December/658258.html
>>>>> ---
>>>>> V1->V2:
>>>>>    - Add Conor's clock patch for implicit div64
>>>>>    - Fix typo in commit title 3/3
>>>>>    - Fix typo in commit description 2/3
>>>>> V2->V3
>>>>>    - Change from defconfig file to a PHONY config
>>>>> ---
>>>>
>>>> Is this 'rv32_nommu_virt_defconfig' target the only build target
>>>> that is supported?
>>>>
>>>> I ask because I applied the 3 patches and did 25 randconfig builds.
>>>> 5 of them failed the same way:
>>>>
>>>> riscv32-linux-ld: drivers/soc/canaan/k210-sysctl.o: in function `k210_soc_early_init':
>>>> k210-sysctl.c:(.init.text+0x78): undefined reference to `k210_clk_early_init'
>> I can not recreate this error.
>> can you send me the .config you used.
>>
>> Thanks,
>> Jesse Taube
> 
> Sure, it's attached.

Hmmm, it links fine for me.

objdump -x vmlinux | grep k210_clk_early_init
81e40124 g     F .init.text     00000088 k210_clk_early_init

gcc version 11.3.0 (Buildroot 2022.11-361-g1be0d438f7)
GNU assembler version 2.38 (riscv32-buildroot-linux-uclibc)
GNU ld (GNU Binutils) 2.38

what gcc version are you using?

Thanks,
Jesse Taube

> 
>>> Arg. Forgot about that. k210 is rv64 only and while the clk driver could still
>>> compile test with rv32 (or any arch), that driver provides the
>>> k210_clk_early_init() function which is called very early in the boot process
>>> from k210_soc_early_init(), which is an SOC_EARLY_INIT_DECLARE() call. The
>>> problem may be there. Probably should be disabled for rv32 if no SoC need that
>>> sort of early init call.
>>>
>>>>
>>>> because
>>>> # CONFIG_COMMON_CLK_K210 is not set
>>>>
>>>>
>>>> Maybe SOC_CANAAN needs some more selects for required code?
>>>>
>>>>> Conor Dooley (1):
>>>>>     clk: k210: remove an implicit 64-bit division
>>>>>
>>>>> Jesse Taube (1):
>>>>>     riscv: configs: Add nommu PHONY defconfig for RV32
>>>>>
>>>>> Yimin Gu (1):
>>>>>     riscv: Kconfig: Allow RV32 to build with no MMU
>>>>>
>>>>>    arch/riscv/Kconfig     | 5 ++---
>>>>>    arch/riscv/Makefile    | 4 ++++
>>>>>    drivers/clk/clk-k210.c | 2 +-
>>>>>    3 files changed, 7 insertions(+), 4 deletions(-)
>>>>>
>>>>
>>>
> 
