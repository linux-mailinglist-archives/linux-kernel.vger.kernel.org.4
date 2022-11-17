Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57EA62D4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiKQIJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKQIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:08:53 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6823DC6E;
        Thu, 17 Nov 2022 00:08:49 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8CxjdoN7HVj_zcIAA--.23265S3;
        Thu, 17 Nov 2022 16:08:45 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxR1cK7HVj3M8VAA--.39222S2;
        Thu, 17 Nov 2022 16:08:44 +0800 (CST)
Subject: Re: [PATCH v10 2/2] dt-bindings: hpet: add loongson-2 hpet
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221103131202.12481-1-zhuyinbo@loongson.cn>
 <20221103131202.12481-2-zhuyinbo@loongson.cn>
 <c1def742-c10b-beaf-9a77-bd5eed253154@loongson.cn>
Message-ID: <ce61cbea-edca-5cae-799b-9294fe704298@loongson.cn>
Date:   Thu, 17 Nov 2022 16:08:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c1def742-c10b-beaf-9a77-bd5eed253154@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxR1cK7HVj3M8VAA--.39222S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKryxuF1rZFyDCryxXw4kXrb_yoW7XrW5pF
        n7CFZxJrW7Jr1rXwsrtF1jyFy5Zw18J3WDJr1xJFyUJFyDJr1jqr18WF1q9r13Jr48Gr17
        Xr12vr17ur1jyrJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bgAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_Gc
        Wl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCF
        s4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4
        kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY
        6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0jjg7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any updates?

在 2022/11/9 下午5:50, Yinbo Zhu 写道:
> Hi maintainer,
> 
> please help me merge it to upstream.
> 
> In addition, this patch need rely on 
> "https://patchwork.kernel.org/project/linux-clk/list/?series=691497"
> 
> Thanks,
> Yinbo.
> 
> 在 2022/11/3 下午9:12, Yinbo Zhu 写道:
>> Add the Loongson-2 High Precision Event Timer (HPET) binding
>> with DT schema format using json-schema.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> Change in v10:
>>         1. NO change, but other patch in this series of patches set
>>            has changes.
>>                  2. This patch need rely on clock patch, which patchwork
>>            link was 
>> "https://patchwork.kernel.org/project/linux-clk/list/?series=691497".
>> Change in v9:
>>                  1. This patch need rely on clock patch, which patchwork
>>            link was 
>> "https://patchwork.kernel.org/project/linux-clk/list/?series=691497".
>>         2. NO change, but other patch in this series of patches set
>>            has changes.
>> Change in v8:
>>                  1. This patch need rely on clock patch, which patchwork
>>            link was 
>> "https://patchwork.kernel.org/project/linux-clk/list/?series=691497".
>>         2. Add all history change log information.
>> Change in v7:
>>         1. NO change, but other patch in this series of patches set
>>            has changes.
>> Change in v6:
>>         1. NO change, but other patch in this series of patches set
>>            has changes.
>> Change in v5:
>>         1. Replace string loongson2/Loongson2 with Loongson-2/loongson-2.
>>         2. Add the patch review information.
>> Change in v4:
>>                  1. Fixup the clock-names that replace apb-clk with apb.
>>                  2. This patch need rely on clock patch, which patchwork
>>                     link was 
>> "https://patchwork.kernel.org/project/linux-clk/list/?series=688892".
>> Change in v3:
>>         1. Update dts that base on common clock framework.
>> Change in v2:
>>         1. Drop the  "hpet0" label.
>>         2. Modify the hpet node name to timer.
>>
>>   .../bindings/timer/loongson,ls2k-hpet.yaml    | 50 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 51 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml 
>> b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
>> new file mode 100644
>> index 000000000000..30685c8fbead
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/timer/loongson,ls2k-hpet.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson-2 High Precision Event Timer (HPET)
>> +
>> +maintainers:
>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>> +
>> +properties:
>> +  compatible:
>> +    const: loongson,ls2k-hpet
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: SoC apb clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: apb
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    timer@1fe24000 {
>> +        compatible = "loongson,ls2k-hpet";
>> +        reg = <0x1fe24000 0x15f>;
>> +        clocks = <&clk LOONGSON2_APB_CLK>;
>> +        clock-names = "apb";
>> +        interrupt-parent = <&liointc0>;
>> +        interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 52519695a458..939af260fe0f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12030,6 +12030,7 @@ LOONGSON-2 SOC SERIES HPET DRIVER
>>   M:    Yinbo Zhu <zhuyinbo@loongson.cn>
>>   L:    linux-kernel@vger.kernel.org
>>   S:    Maintained
>> +F:    Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
>>   F:    drivers/clocksource/loongson2_hpet.c
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>

