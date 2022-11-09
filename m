Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BBE6226BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKIJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKIJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:19:29 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95EFC13E8A;
        Wed,  9 Nov 2022 01:19:27 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8BxXbeecGtjbIQFAA--.8427S3;
        Wed, 09 Nov 2022 17:19:26 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPuCbcGtjj3kPAA--.42914S2;
        Wed, 09 Nov 2022 17:19:24 +0800 (CST)
Subject: Re: [PATCH v8 2/2] dt-bindings: hpet: add loongson-2 hpet
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
References: <20221103065351.32603-1-zhuyinbo@loongson.cn>
 <20221103065351.32603-2-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <b0aed9f8-f82e-3d74-4299-4d77445c2170@loongson.cn>
Date:   Wed, 9 Nov 2022 17:19:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221103065351.32603-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPuCbcGtjj3kPAA--.42914S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr1UurykCFyfAFW5Gw17Wrg_yoW5tFy3pa
        n7Can3Jr4xtF13u393KFyIkFn5Z3s5AasFgr17K34UGryDXF15XF1Ika4DZw43CrWxWayI
        qFySkr1UKayjkrJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2
        AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU42YLDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainer,

please help me merge it to upstream.
in addition, this patch need rely on 
"https://patchwork.kernel.org/project/linux-clk/list/?series=691497"

thanks,
Yinbo.

ÔÚ 2022/11/3 ÏÂÎç2:53, Yinbo Zhu Ð´µÀ:
> Add the Loongson-2 High Precision Event Timer (HPET) binding
> with DT schema format using json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Change in v8:
>                  1. This patch need rely on clock patch, which patchwork
> 		   link was "https://patchwork.kernel.org/project/linux-clk/list/?series=691497".
> 		2. Add all history change log information.
> Change in v7:
> 		1. NO change, but other patch in this series of patches set
> 		   has changes.
> Change in v6:
> 		1. NO change, but other patch in this series of patches set
> 		   has changes.
> Change in v5:
> 		1. Replace string loongson2/Loongson2 with Loongson-2/loongson-2.
> 		2. Add the patch review information.
> Change in v4:
>                  1. Fixup the clock-names that replace apb-clk with apb.
>                  2. This patch need rely on clock patch, which patchwork
>                     link was "https://patchwork.kernel.org/project/linux-clk/list/?series=688892".
> Change in v3:
> 		1. Update dts that base on common clock framework.
> Change in v2:
> 		1. Drop the  "hpet0" label.
> 		2. Modify the hpet node name to timer.
> 
>   .../bindings/timer/loongson,ls2k-hpet.yaml    | 50 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 51 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> new file mode 100644
> index 000000000000..30685c8fbead
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/loongson,ls2k-hpet.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-2 High Precision Event Timer (HPET)
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    const: loongson,ls2k-hpet
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: SoC apb clock
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    timer@1fe24000 {
> +        compatible = "loongson,ls2k-hpet";
> +        reg = <0x1fe24000 0x15f>;
> +        clocks = <&clk LOONGSON2_APB_CLK>;
> +        clock-names = "apb";
> +        interrupt-parent = <&liointc0>;
> +        interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 52519695a458..939af260fe0f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12030,6 +12030,7 @@ LOONGSON-2 SOC SERIES HPET DRIVER
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-kernel@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
>   F:	drivers/clocksource/loongson2_hpet.c
>   
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
> 

