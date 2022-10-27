Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8387760EED5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiJ0Dwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiJ0Dwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:52:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBC4D8A7D7;
        Wed, 26 Oct 2022 20:52:44 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8CxjdqLAFpjv8QCAA--.10763S3;
        Thu, 27 Oct 2022 11:52:43 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJleEAFpjbZEFAA--.2104S2;
        Thu, 27 Oct 2022 11:52:37 +0800 (CST)
Subject: Re: [PATCH v2 2/2] dt-bindings: soc: add loongson2 guts
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        zhuyinbo@loongson.cn, Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025035128.21068-1-zhuyinbo@loongson.cn>
 <20221025035128.21068-2-zhuyinbo@loongson.cn>
 <7c67c721-685a-fa0e-ab4b-41b7de3ea0a0@linaro.org>
 <52de60bd-8aa5-a461-9bca-ce8e6f82ead8@loongson.cn>
 <ae7cf416-f7b9-2316-5bb2-0043651ed0fd@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <7bd6db22-210b-d8ff-7476-b2e38dc7c683@loongson.cn>
Date:   Thu, 27 Oct 2022 11:52:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ae7cf416-f7b9-2316-5bb2-0043651ed0fd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJleEAFpjbZEFAA--.2104S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw45Ww4DKrW8GrW5ur45KFg_yoW7XF4fpF
        4xCFWDKFW8Jr129wsIq3W8AF4a9as7A3WUWrnrG3429Fyq9a4ftwsxKr98uF18JryxXFW2
        vFWjg3yS9F4DAFJanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jsWrXUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/26 下午10:10, Krzysztof Kozlowski 写道:
> On 26/10/2022 03:22, Yinbo Zhu wrote:
>>
>>
>> 在 2022/10/26 上午3:40, Krzysztof Kozlowski 写道:
>>> On 24/10/2022 23:51, Yinbo Zhu wrote:
>>>> Add the loongson2 soc guts driver binding with DT schema format
>>>> using json-schema.
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> ---
>>>>    .../soc/loongson/loongson,ls2k-guts.yaml      | 37 +++++++++++++++++++
>>>
>>> Looks like wrong location, although difficult to judge because you did
>>> not describe the hardware at all. If this is chipinfo-like device, then
>>> Documentation/devicetree/bindings/hwinfo/.
yes it is a chipinfo/socinfo device, I will following your advice.
>> My guts driver is refer fsl platform. It was was to manage and access
>> global utilities register block for SoC and it was only used in SoC
>> platform. when driver need use Soc ops to do some function the this
>> driver was needed.  the dcfg (device config) was a function in guts
>> (global utilities) block.
> 
> I can barely understand it.
My description is about chipinfo/socinfo definition. and I have a look
/bindings/hwinfo/, I think move binding file to hwinfo that is okay for me.

Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml

> 
>> For these type of driver, other platforms were initially placed on
>> Documentation/devicetree/bindings/arm/   if it is arm/arm64
>> architecture. Later, move it to the soc directory.
>>
>> Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> 
> How is this related? This is Layerscape, not Loongson2. Describe the
> hardware you are adding bindings for.
The driver functions/type are the same, the driver was register a struct 
soc_device_attribute by soc_device_register then other peripheral driver
can call SoC ops, such as soc_device_match.

then layerscape guts module bindings are placed in
Documentation/devicetree/bindings/soc/, the loongson guts module 
bindings was follow that layerscape and are placed in
Documentation/devicetree/bindings/soc/

In a words,  It is a question about where the binding file should be 
placed.  I think move binding file to hwinfo that is okay for me.
> 
>>
>> So, do you still think it is inappropriate to place it in the soc dir?
>>>
>>>
>>>>    MAINTAINERS                                   |  1 +
>>>>    2 files changed, 38 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>>> new file mode 100644
>>>> index 000000000000..2502f8aeb74d
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>>> @@ -0,0 +1,37 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-guts.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Loongson2 GUTS driver.
>>>
>>> Drop "driver." unless you refer to some hardware (like motor driver?).
>> this need refer hardware soc datasheet to gain soc register (global
>> utilities register block ).
>> so keep "driver" string that whether was more appropriate?
> 
> What? I cannot parse it.
> 
> Did you understand my comment? If yes, please point to Wikipedia article
> explaining this "Driver" you refer to.
I will remove the "driver" string.
> 
> 
>>>
>>>> +
>>>> +maintainers:
>>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> +
>>>> +description: |
>>>> +  GUTS driver was to manage and access global utilities block. Initially
>>>
>>> Drop "driver" and describe instead what is GUTS, including its acronym,
>>>
>>>> +  only reading SVR and registering soc device are supported.
>>>
>>> Entire sentence describe Linux driver - drop it. Instead describe the
>>> device, the hardware.
>>>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: loongson,ls2k-guts
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  little-endian: true
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    guts: guts@1fe00000 {
>>>
>>> Node names should be generic.
>> dcfg/scfg (device cfg/ soc cfg)was the key function of guts (global
>> utilities) block. and guts name I was refer fsl soc driver.
>> "drivers/soc/fsl/guts.c"
>> this binding file was follows of fsl guts.
>> Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
>> Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
>>
>> or, I was use scfg as node name, Do you think it's appropriate?
> 
> No, these are not generic node names.
I was refer "ti,k3-socinfo.yaml",  Do you think it's appropriate that 
socinfo as node name?
> 
>>
>>
>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Best regards,
> Krzysztof
> 

