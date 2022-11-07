Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F05661F1AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiKGLUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:20:15 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AB3B15722;
        Mon,  7 Nov 2022 03:20:13 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8BxWtjs6WhjUQUFAA--.14786S3;
        Mon, 07 Nov 2022 19:20:12 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxiFfr6WhjcGwOAA--.22100S3;
        Mon, 07 Nov 2022 19:20:11 +0800 (CST)
Subject: Re: [PATCH 2/2] dt-bindings: interrupt-controller: add yaml for
 LoongArch CPU interrupt controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107023404.26730-1-liupeibao@loongson.cn>
 <20221107023404.26730-2-liupeibao@loongson.cn>
 <b45b8cf8-de9d-7132-1a35-48deeb4b79d5@linaro.org>
 <196e80d8-f4fb-7393-81a5-bca757c805f5@loongson.cn>
 <e92beaac-aa88-0336-cb30-7de438de67c9@linaro.org>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <e5910bf9-b662-a733-57f2-5faccb038cb1@loongson.cn>
Date:   Mon, 7 Nov 2022 19:20:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e92beaac-aa88-0336-cb30-7de438de67c9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxiFfr6WhjcGwOAA--.22100S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQADCmNno+QOXQADsb
X-Coremail-Antispam: 1Uk129KBjvJXoWxCr4fZryDuF4Utw13KrW5Awb_yoW5ZFykpF
        yUCFZxGF4Utr43Cws2g3WFkrnIvrn3Jr109wsxtw17CrnIg343XF42yF95uayrGryxXr4j
        vr10v3WIgFnxJFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
        8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 5:55 PM, Krzysztof Kozlowski wrote:
> On 07/11/2022 10:21, Liu Peibao wrote:
>> On 11/7/22 4:28 PM, Krzysztof Kozlowski wrote:
>>> On 07/11/2022 03:34, Liu Peibao wrote:
>>>
>>> Add commit msg explaining what you are doing here (e.g. the hardware).
>>>
>>
>> I just add this yaml for what I did in patch 1/2 and the header seems enough
>> to describe what I want to, so I did not add the commit log.
> 
> This should instead describe briefly the hardware here.
> 

How about I add the following comments:

"Current LoongArch compatible CPUs support 14 CPU IRQs. We can describe how
the 14 IRQs are wired to the platforms internal interrupt controller cascade
by devicetree."


>>
>>>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>>>> ---
>>>>  .../loongarch,cpu-interrupt-controller.yaml   | 42 +++++++++++++++++++
>>>>  1 file changed, 42 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
>>>> new file mode 100644
>>>> index 000000000000..30b742661a3f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
>>>> @@ -0,0 +1,42 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/interrupt-controller/loongarch,cpu-interrupt-controller.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: LoongArch CPU Interrupt Controller
>>>> +
>>>> +description: >
>>>> +   On LoongArch the loongarch_cpu_irq_of_init() helper can be used to initialize
>>>> +   the 14 CPU IRQs from a devicetree file and create a irq_domain for this IRQ
>>>> +   controller.
>>>> +
>>>> +   With the irq_domain in place we can describe how the 14 IRQs are wired to the
>>>> +   platforms internal interrupt controller cascade.
>>>
>>> This should be the description of hardware, not Linux drivers.
>>>
>>
>> OK, I will remove this in the next version of this patch.
>>
>>>> +
>>>> +maintainers:
>>>> +  - Liu Peibao <liupeibao@loongson.cn>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: loongarch,cpu-interrupt-controller
>>>
>>> You have exactly one and only one type of CPU interrupt controller for
>>> all your Loongarch designs? All current and all future? All?
>>>
>>
>> It is sure of that "all current and recent designs". It is really hard to limit the
>> design in the distant future.
>>
>> And if there is updating, maybe I will add additional things like this:
>> "loongarch,cpu-interrupt-controller-2.0".
> 
> Unless you have a clear versioning of your hardware, adding 2.0 won't be
> correct. Don't you have this for specific SoC?
> 

The "loongarch,cpu-interrupt-controller" now is compatible for all the LoongArch
compatible CPUs, not specific for one chip. And we may keep this CPU interrupt
controller for a long time.

BR,
Peibao

