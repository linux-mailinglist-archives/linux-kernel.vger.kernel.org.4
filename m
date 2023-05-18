Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD77080FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjERMP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjERMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:15:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5466210A;
        Thu, 18 May 2023 05:15:52 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dxi+r3FmZkStkJAA--.17269S3;
        Thu, 18 May 2023 20:15:51 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axo8D2FmZkxNdnAA--.45800S3;
        Thu, 18 May 2023 20:15:51 +0800 (CST)
Subject: Re: [PATCH v1 2/3] dt-bindings: soc: add loongson-2 pm
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230517073149.31980-1-zhuyinbo@loongson.cn>
 <20230517073149.31980-3-zhuyinbo@loongson.cn>
 <d3791702-4d41-0208-1346-34738a2883b6@linaro.org>
 <4521c591-6fcd-c96a-e2f6-f41f5c191036@loongson.cn>
 <1bbabe6d-b013-9837-8986-205a2b04de14@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <b4bc7385-3706-8aa3-0117-d106fd47a45e@loongson.cn>
Date:   Thu, 18 May 2023 20:15:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1bbabe6d-b013-9837-8986-205a2b04de14@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axo8D2FmZkxNdnAA--.45800S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGw4DuFy3tw45CFWrZF17trb_yoW5Zw13pa
        yjgF4jy34DJr1Fyw48tw18CwsYy395KFWYgr1DW34I9wsrXw1SvFy7KF45u34Ikryxt3yI
        vF1Ut398ZFs8AFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq
        07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxV
        WUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mFADUUUU
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/18 下午3:15, Krzysztof Kozlowski 写道:
> On 18/05/2023 05:23, zhuyinbo wrote:
>>
>>
>> 在 2023/5/17 下午11:00, Krzysztof Kozlowski 写道:
>>> On 17/05/2023 09:31, Yinbo Zhu wrote:
>>>> Add the Loongson-2 SoC Power Management Controller binding with DT
>>>> schema format using json-schema.
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>
>>> ...
>>>
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - loongson,ls2k-pmc
>>>> +      - const: syscon
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  suspend-address:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description:
>>>> +      This option indicate this PM suspend address.
>>>
>>> This tells me nothing. Drop "This option indicate this" and rephrase
>>> everything to actually describe this property. Why would the address
>>> differ on given, specific SoC? It looks like you just miss compatibles.
>>> Anyway this needs much more explanation so we can judge whether it fits DT.
>>
>> Hi Krzysztof,
>>
>> I will add following description about "suspend-address", please review.
> 
> Thanks.
> 
>>
>> The "suspend-address" is a ACPI S3 (Suspend To RAM) firmware entry
> 
> Why do we add properties for ACPI? This does not seem right. 


1.  The suspend-address value was dependent on specific platform
     firmware code and it tends to be confiurable. if it is a fixed value
     that seems not friendly or the ACPI S3 will not work.
2. the PM driver need according to it to indicate that current SoC
    whether support ACPI S3, because some Loongson-2 SoC doesn't support
    ACPI S3 but support other ACPI mode, so the PM driver need has a
    check. if no this check and other ACPI mode will not work.

Base on the above two points, this property was necessary.
Using this property "suspend-address" can make the firmware entry
address configurable, and then the kernel can also indicate whether
the current SoC supports S3

In addition, from kernel code perspective, the property
"suspend-address" was to initialize "loongarch_suspend_addr"

S3 call flow:
enter_state -> loongson_suspend_enter -> bios's loongarch_suspend_addr

SYM_FUNC_START(loongson_suspend_enter)
         SETUP_SLEEP
         bl              __flush_cache_all

         /* Pass RA and SP to BIOS */
         addi.d          a1, sp, 0
         la.pcrel        a0, loongson_wakeup_start
         la.pcrel        t0, loongarch_suspend_addr
         ld.d            t0, t0, 0
         jirl            a0, t0, 0 /* Call BIOS's STR sleep routine */


Please
> reword to skip ACPI stuff, e.g. deep sleep states (Suspend to RAM).


Sorry, I don't got your point.

> 
> 
>> address which was jumped from kernel and it's value was dependent on
>> specific platform firmware code.
> 
> "entry address which was jumped" <- the address cannot jump. Please
> explain who is jumping here - boot CPU? each suspended CPU? I guess the
> first as CPUs are offlined, right?

The boot CPU was jumping to firmware and finish remaining process in
firmware that was what ACPI S3 required and other CPUs (No-boot CPU)
have been offline before entering firmware.

> 
>> In addition, the PM driver need
>> according to it to indicate that current SoC whether support ACPI S3.
> 
> Skip references to driver.


Sorry, I don't got your point.  Could you elaborate on it?

Thanks
Yinbo.

