Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD8627981
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiKNJvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKNJua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:50:30 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4D585F98;
        Mon, 14 Nov 2022 01:50:27 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxbdpiD3JjMd0GAA--.20741S3;
        Mon, 14 Nov 2022 17:50:26 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxj+BfD3JjTX8SAA--.49498S2;
        Mon, 14 Nov 2022 17:50:23 +0800 (CST)
Subject: Re: [PATCH v1 2/2] dt-bindings: gpio: add loongson series gpio
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, zhuyinbo@loongson.cn,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        richard.liu@st.com, Arnaud Patard <apatard@mandriva.com>,
        Hongbing Hu <huhb@lemote.com>,
        Huacai Chen <chenhuacai@kernel.org>
References: <20221108092107.28996-1-zhuyinbo@loongson.cn>
 <20221108092107.28996-2-zhuyinbo@loongson.cn>
 <d9edb6e1-c3da-0f5b-546d-37d8151aaa35@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <d5457109-3bcb-e7d3-067d-9e4acd66ac17@loongson.cn>
Date:   Mon, 14 Nov 2022 17:50:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d9edb6e1-c3da-0f5b-546d-37d8151aaa35@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxj+BfD3JjTX8SAA--.49498S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw45JryxJw4fXF4rXFWrZrb_yoWxArWUp3
        WUAFsrZwsFgF13Cr4YgFnrArn3Ar1kCw1rur9xC347tryqkwn3JF4SgFykW3Z3WryUX3W7
        Xrsxu3yrGw15A3DanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI
        0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCj
        c4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TrW5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/8 下午11:28, Krzysztof Kozlowski 写道:
> On 08/11/2022 10:21, Yinbo Zhu wrote:
>> Add the Loongson series gpio binding with DT schema format using
>> json-schema.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   .../bindings/gpio/loongson,ls-gpio.yaml       | 154 ++++++++++++++++++
>>   MAINTAINERS                                   |  11 ++
>>   2 files changed, 165 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> new file mode 100644
>> index 000000000000..9d335262ddcc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> @@ -0,0 +1,154 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpio/loongson,ls-gpio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson series GPIO controller.
>> +
>> +maintainers:
>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - loongson,ls2k-gpio
>> +      - loongson,ls7a-gpio
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  ngpios: true
> 
> minimum? maximum?
okay, I got it.
> 
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +
>> +  gpio-controller: true
>> +
>> +  gpio-ranges: true
>> +
>> +  loongson,conf_offset:
> 
> No underscores in node names. Plus comments from Linus seem to apply
> here as well. Drop it entirely or explain why this is not part of
> compatible, why this is needed and why encoding programming model
> address in DT matches the DT...
Add it is to distinguish differnt address in different platform.
and I had drop them and initial them in kernel driver that depend
on diffent compatible.
> 
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate this GPIO configuration offset address.
>> +
>> +  loongson,out_offset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate this GPIO output value offset address.
> 
> Drop
> 
>> +
>> +  loongson,in_offset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate this GPIO input value offset address.
> 
> Drop
> 
> 
>> +
>> +  loongson,gpio_base:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      This option indicate the first GPIO number in this node.
> 
> Drop
> 
> 
>> +
>> +  loongson,support_irq:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      This option indicate this GPIO whether support interrupt.
> 
> Drop
> 
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 64
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - ngpios
>> +  - "#gpio-cells"
>> +  - gpio-controller
>> +  - gpio-ranges
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    gpio0: gpio@1fe00500 {
>> +      compatible = "loongson,ls2k-gpio";
>> +      reg = <0x1fe00500 0x38>;
>> +      ngpios = <64>;
>> +      #gpio-cells = <2>;
>> +      gpio-controller;
>> +      gpio-ranges = <&pctrl 0 0 15>,
>> +                    <&pctrl 16 16 15>,
>> +                    <&pctrl 32 32 10>,
>> +                    <&pctrl 44 44 20>;
>> +      loongson,conf_offset = <0>;
>> +      loongson,out_offset = <0x10>;
>> +      loongson,in_offset = <0x20>;
>> +      loongson,gpio_base = <0>;
>> +      loongson,support_irq;
>> +      interrupt-parent = <&liointc1>;
>> +      interrupts = <28 IRQ_TYPE_LEVEL_LOW>,
>> +                   <29 IRQ_TYPE_LEVEL_LOW>,
>> +                   <30 IRQ_TYPE_LEVEL_LOW>,
>> +                   <30 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <26 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <>,
> 
> What's this?
There was no interrupt function in this gpio.
> 
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <>,
>> +                   <>,
> 
> What's this?
> 
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>,
>> +                   <27 IRQ_TYPE_LEVEL_LOW>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 916b2d9cffc0..878b8320ac3b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12048,6 +12048,17 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>>   F:	drivers/soc/loongson/loongson2_guts.c
>>   
>> +LOONGSON SERIES GPIO DRIVER
>> +M:	Richard Liu, STMicroelectronics <richard.liu@st.com>
>> +M:	Arnaud Patard <apatard@mandriva.com>
>> +M:	Hongbing Hu <huhb@lemote.com>
>> +M:	Huacai Chen <chenhuacai@kernel.org>
>> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> Are they all maintainers of this driver?
add huacai and myself as maintainer.
> 
>> +L:	linux-gpio@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> +F:	drivers/gpio/gpio-loongson.c
>> +
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>   M:	Sathya Prakash <sathya.prakash@broadcom.com>
>>   M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> 
> Best regards,
> Krzysztof
> 

