Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3955562D4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbiKQIGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbiKQIGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:06:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44AC1716F5;
        Thu, 17 Nov 2022 00:06:43 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8BxLtuS63VjlDcIAA--.23509S3;
        Thu, 17 Nov 2022 16:06:42 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxn+CR63VjgM8VAA--.57669S2;
        Thu, 17 Nov 2022 16:06:41 +0800 (CST)
Subject: Re: [PATCH v9 1/3] dt-bindings: clock: add loongson-2 clock include
 file
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221103050032.29236-1-zhuyinbo@loongson.cn>
 <129c908a-8c6d-6b2b-ef61-e774cf6368b7@loongson.cn>
Message-ID: <398b1c4e-129a-df1e-b522-75bd01d0a732@loongson.cn>
Date:   Thu, 17 Nov 2022 16:06:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <129c908a-8c6d-6b2b-ef61-e774cf6368b7@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxn+CR63VjgM8VAA--.57669S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFyfKw17AF1fXF15tF47Arb_yoWrCFyrpr
        18Cr47Jry7tr4xCr4jqr13try5Zr1UJw1UAF1UAF1UJr17Jw10qr1UXr1Ygr1DXr4kJr1U
        ZF1DCr4UZF4UGrJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_Gc
        Wl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7
        AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU42YLDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Any updates?

在 2022/11/9 下午5:10, Yinbo Zhu 写道:
> Hi maintainer,
> 
> please help me merge it to upstream.
> 
> thanks,
> Yinbo.
> 
> 在 2022/11/3 下午1:00, Yinbo Zhu 写道:
>> This file defines all Loongson-2 SoC clock indexes, it should be
>> included in the device tree in which there's device using the
>> clocks.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> Change in v9:
>>         1. Add all history changelog infomation.
>> Change in v8:
>>         1. No change but this series patch has a change.
>> Change in v7:
>>         1. No change but this series patch has a change.
>> Change in v6:
>>         1. Replace string LOONGSON2 with LOONGSON-2 in MAINTAINERS.
>> Change in v5:
>>         1. Replace loongson2/Loongson2 with loongson-2/Loongson-2.
>>         2. Replace soc with SoC.
>> Change in v4:
>>         1. No change but this series patch has a change.
>> Change in v3:
>>         1. Add the review information.
>> Change in v2:
>>         1. Make filename matching the compatible.
>>         2. Drop weird indentation after define.
>>         3. Add dual license.
>>         4. Use subject prefixes matching the subsystem.
>>
>>   MAINTAINERS                                   |  6 ++++
>>   include/dt-bindings/clock/loongson,ls2k-clk.h | 29 +++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/loongson,ls2k-clk.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3aff8b8723b1..d5d1f2b9fcfd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12018,6 +12018,12 @@ S:    Maintained
>>   F:    
>> Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>>   F:    drivers/thermal/loongson2_thermal.c
>> +LOONGSON-2 SOC SERIES CLOCK DRIVER
>> +M:    Yinbo Zhu <zhuyinbo@loongson.cn>
>> +L:    linux-clk@vger.kernel.org
>> +S:    Maintained
>> +F:    include/dt-bindings/clock/loongson,ls2k-clk.h
>> +
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>   M:    Sathya Prakash <sathya.prakash@broadcom.com>
>>   M:    Sreekanth Reddy <sreekanth.reddy@broadcom.com>
>> diff --git a/include/dt-bindings/clock/loongson,ls2k-clk.h 
>> b/include/dt-bindings/clock/loongson,ls2k-clk.h
>> new file mode 100644
>> index 000000000000..db1e27e792ff
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/loongson,ls2k-clk.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
>> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#ifndef __DT_BINDINGS_CLOCK_LOONGSON2_H
>> +#define __DT_BINDINGS_CLOCK_LOONGSON2_H
>> +
>> +#define LOONGSON2_REF_100M                0
>> +#define LOONGSON2_NODE_PLL                1
>> +#define LOONGSON2_DDR_PLL                2
>> +#define LOONGSON2_DC_PLL                3
>> +#define LOONGSON2_PIX0_PLL                4
>> +#define LOONGSON2_PIX1_PLL                5
>> +#define LOONGSON2_NODE_CLK                6
>> +#define LOONGSON2_HDA_CLK                7
>> +#define LOONGSON2_GPU_CLK                8
>> +#define LOONGSON2_DDR_CLK                9
>> +#define LOONGSON2_GMAC_CLK                10
>> +#define LOONGSON2_DC_CLK                11
>> +#define LOONGSON2_APB_CLK                12
>> +#define LOONGSON2_USB_CLK                13
>> +#define LOONGSON2_SATA_CLK                14
>> +#define LOONGSON2_PIX0_CLK                15
>> +#define LOONGSON2_PIX1_CLK                16
>> +#define LOONGSON2_CLK_END                17
>> +
>> +#endif
>>

