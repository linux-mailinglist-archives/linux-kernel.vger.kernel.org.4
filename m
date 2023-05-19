Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19FE70900A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjESGwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 02:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjESGww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 02:52:52 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7922E5C;
        Thu, 18 May 2023 23:52:49 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cxd+nAHGdk_BcKAA--.17607S3;
        Fri, 19 May 2023 14:52:48 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxoOS9HGdk73hpAA--.47775S3;
        Fri, 19 May 2023 14:52:46 +0800 (CST)
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
 <b4bc7385-3706-8aa3-0117-d106fd47a45e@loongson.cn>
 <3f81816a-b7a8-cc3a-0052-a2177bfb58c4@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <9c49fd36-2b87-b25a-c799-c5845718def6@loongson.cn>
Date:   Fri, 19 May 2023 14:52:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3f81816a-b7a8-cc3a-0052-a2177bfb58c4@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxoOS9HGdk73hpAA--.47775S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3WrW7tFyxJF18Xr4DuFyfWFg_yoW7GFy8pa
        yUKF4qyrWDJr1Syw48tw18C3yFvrWkKFW5Wrn8XryxCw4qvr1Iyr17KF15u342kr1xJw12
        9Fyjy397CF45AFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUManUUUUU=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/18 下午10:15, Krzysztof Kozlowski 写道:
> On 18/05/2023 14:15, zhuyinbo wrote:
>>
>>
>> 在 2023/5/18 下午3:15, Krzysztof Kozlowski 写道:
>>> On 18/05/2023 05:23, zhuyinbo wrote:
>>>>
>>>>
>>>> 在 2023/5/17 下午11:00, Krzysztof Kozlowski 写道:
>>>>> On 17/05/2023 09:31, Yinbo Zhu wrote:
>>>>>> Add the Loongson-2 SoC Power Management Controller binding with DT
>>>>>> schema format using json-schema.
>>>>>>
>>>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>>
>>>>> ...
>>>>>
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    items:
>>>>>> +      - enum:
>>>>>> +          - loongson,ls2k-pmc
>>>>>> +      - const: syscon
>>>>>> +
>>>>>> +  reg:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  interrupts:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  suspend-address:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description:
>>>>>> +      This option indicate this PM suspend address.
>>>>>
>>>>> This tells me nothing. Drop "This option indicate this" and rephrase
>>>>> everything to actually describe this property. Why would the address
>>>>> differ on given, specific SoC? It looks like you just miss compatibles.
>>>>> Anyway this needs much more explanation so we can judge whether it fits DT.
>>>>
>>>> Hi Krzysztof,
>>>>
>>>> I will add following description about "suspend-address", please review.
>>>
>>> Thanks.
>>>
>>>>
>>>> The "suspend-address" is a ACPI S3 (Suspend To RAM) firmware entry
>>>
>>> Why do we add properties for ACPI? This does not seem right.
>>
>>
>> 1.  The suspend-address value was dependent on specific platform
>>       firmware code and it tends to be confiurable. if it is a fixed value
>>       that seems not friendly or the ACPI S3 will not work.
> 
>> 2. the PM driver need according to it to indicate that current SoC
>>      whether support ACPI S3, because some Loongson-2 SoC doesn't support
> 
> For this you have dedicated compatibles. Which points to the fact that
> you missed them here.


Sorry, I may not have explained it clearly before. In fact, this is a
consideration for the future, and currently all SoC supports s3.
Add corresponding compatibles as needed in the future.

> 
>>      ACPI S3 but support other ACPI mode, so the PM driver need has a
>>      check. if no this check and other ACPI mode will not work.
> 
> Sure, but it is not really relevant to the bindings... or rather: should
> not be relevant. Bindings are for hardware or in this case also for
> firmware, but not for driver.

okay, I got it.

> 
>>
>> Base on the above two points, this property was necessary.
> 
> I did not object in my last response...


Yes, but I misunderstood your meaning before.

> 
>> Using this property "suspend-address" can make the firmware entry
>> address configurable, and then the kernel can also indicate whether
>> the current SoC supports S3
>>
>> In addition, from kernel code perspective, the property
>> "suspend-address" was to initialize "loongarch_suspend_addr"
> 
> Again, how does it matter what kernel does?


okay, I got it.

> 
>>
>> S3 call flow:
>> enter_state -> loongson_suspend_enter -> bios's loongarch_suspend_addr
>>
>> SYM_FUNC_START(loongson_suspend_enter)
>>           SETUP_SLEEP
>>           bl              __flush_cache_all
>>
>>           /* Pass RA and SP to BIOS */
>>           addi.d          a1, sp, 0
>>           la.pcrel        a0, loongson_wakeup_start
>>           la.pcrel        t0, loongarch_suspend_addr
>>           ld.d            t0, t0, 0
>>           jirl            a0, t0, 0 /* Call BIOS's STR sleep routine */
>>
>>
>> Please
>>> reword to skip ACPI stuff, e.g. deep sleep states (Suspend to RAM).
>>
>>
>> Sorry, I don't got your point.
> 
> You have DT platform, so why do you use it with ACPI in the first place?
> If you have ACPI, then please drop all this and make your life easier.


okay, I got it, I will reword to skip ACPI stuff in bindings for 
"suspend-address" property description.

> 
> If this is booted without ACPI, which would justify DT, drop the
> references to ACPI. I gave you example what to use instead. If you don't
> like it, no problem, reword in different way.

okay, I got it.

> 
>>
>>>
>>>
>>>> address which was jumped from kernel and it's value was dependent on
>>>> specific platform firmware code.
>>>
>>> "entry address which was jumped" <- the address cannot jump. Please
>>> explain who is jumping here - boot CPU? each suspended CPU? I guess the
>>> first as CPUs are offlined, right?
>>
>> The boot CPU was jumping to firmware and finish remaining process in
>> firmware that was what ACPI S3 required and other CPUs (No-boot CPU)
>> have been offline before entering firmware.
> 
> Then fix the description.

okay, I got it.

> 
>>
>>>
>>>> In addition, the PM driver need
>>>> according to it to indicate that current SoC whether support ACPI S3.
>>>
>>> Skip references to driver.
>>
>>
>> Sorry, I don't got your point.  Could you elaborate on it?
> 
> If you change driver, you change bindings? No.
> 
> Bindings are for hardware, not for driver. Whatever your driver is doing
> usually does not matter for the bindings and should not be included.


okay, I got it. I will skip references to driver in bindings for 
"suspend-address" property description.

Thanks.

