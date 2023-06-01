Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054737197B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjFAJwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjFAJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:52:07 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BB11D7;
        Thu,  1 Jun 2023 02:52:03 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Bxy_JCanhkrz4DAA--.7169S3;
        Thu, 01 Jun 2023 17:52:02 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axgjg3anhk7wWEAA--.16821S3;
        Thu, 01 Jun 2023 17:51:57 +0800 (CST)
Subject: Re: [PATCH v11 1/2] dt-bindings: spi: add loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <20230522071030.5193-2-zhuyinbo@loongson.cn>
 <20230524-pouncing-variable-c520e85f8db8@wendy>
 <b1e3d199-de5a-f8d5-9159-4965e9e1f5ef@loongson.cn>
 <20230524-relative-trimmer-046fb26a7764@wendy>
 <99b362c2-640c-9150-26ee-e9add4483886@loongson.cn>
 <2196dd29-93ee-00f7-65b4-ede73aa8ba77@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <1b141df2-3e31-089e-1e05-0e268b60d074@loongson.cn>
Date:   Thu, 1 Jun 2023 17:51:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2196dd29-93ee-00f7-65b4-ede73aa8ba77@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axgjg3anhk7wWEAA--.16821S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3WF1UAr4kCF1DZw1UKw1UAwb_yoW7XF43pa
        17CF17GF4YyF12yrZ2qa48CFWav3s3JFyDXFsrGw1UCF90qF1Yqr4xKFs8u3Z7CF1xGFW7
        XFW0gr17KF4UAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8sL05UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/1 上午3:46, Krzysztof Kozlowski 写道:
> On 25/05/2023 04:22, zhuyinbo wrote:
>>
>>
>> 在 2023/5/24 下午6:29, Conor Dooley 写道:
>>> On Wed, May 24, 2023 at 05:44:38PM +0800, zhuyinbo wrote:
>>>>
>>>>
>>>> 在 2023/5/24 下午4:56, Conor Dooley 写道:
>>>>> On Mon, May 22, 2023 at 03:10:29PM +0800, Yinbo Zhu wrote:
>>>>>> Add the Loongson platform spi binding with DT schema format using
>>>>>> json-schema.
>>>>>>
>>>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> ---
>>>>>>     .../bindings/spi/loongson,ls2k-spi.yaml       | 41 +++++++++++++++++++
>>>>>>     MAINTAINERS                                   |  6 +++
>>>>>>     2 files changed, 47 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..d0be6e5378d7
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>> @@ -0,0 +1,41 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/spi/loongson,ls2k-spi.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Loongson SPI controller
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: /schemas/spi/spi-controller.yaml#
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    enum:
>>>>>> +      - loongson,ls2k-spi
>>>>>
>>>>> I am sorry to jump in here at such a late stage with a (potentially)
>>>>> trivial question. "ls2k" is the SoC family rather than a specific model
>>>>> as far as I understand.
>>>>> The answer is probably yes, but do all SoCs in the family have an
>>>>> identical version of the IP?
>>>>
>>>>
>>>> No, but the spi supported by this loongson spi driver are all the same
>>>> identical version, and other type or verion spi will be supported as
>>>> needed in the future.
>>>
>>> Does having a catch-all compatible make sense then when not all SoCs in
>>> the ls2k family will actually be able to use this driver?
>>
>>
>> Yes, it is make sense as it can reduce the workload of the community.
>> For the Loongson platform, the versions of spi peripherals are almost
>> the same, except for a few  or individual SoCs.  And we have also
>> discussed compatible internally, and we tend to define it this way.
> 
> So you have chosen different path than what's clearly recommended by
> community, existing experience and documentation:
> 
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
> 
> Family names are not accepted as specific compatibles. Whenever they
> were accepted, it lead to problems. All the time.


Thank you for your documentation and advice and the Loongson platform
have loongson-2h (ls2h), loongson-2k (ls2k), loongson-2p (ls2p) or other
series SoC, which loongson-2 seems to be the family name you mentioned
and the "loongson,ls2k-spi" should be a speific compatible name.

> 
> https://lore.kernel.org/all/20220822181701.GA89665-robh@kernel.org/
> https://lore.kernel.org/all/78651e07-6b3e-4243-8e1f-fcd1dfb3ffe1@www.fastmail.com/
> https://lore.kernel.org/all/288f56ba9cfad46354203b7698babe91@walle.cc/
> https://lore.kernel.org/all/106e443a-e765-51fe-b556-e4e7e2aa771c@linaro.org/
> and many many more discussions.
> 
> You should choose carefully, because we will keep NAK-ing adding
> properties to circumvent missing compatibles.


I have read the documention and patch link that you mentioned and it
seems to advice that We don't have wildcard names in the compatible
string and use wildcard names that will cause issue. and the compatible
"loongson,ls2k-spi" that wasn't a wildcard names, and if the loongson-2k
spi controller hardware upgraded or changed the I will use
"loongson,ls2k-spi-version" as a compatible, such as,
"loongson,ls2k-spi-v1.1", "loongson,ls2k-spi-v1.1a" or other.

>>
>>> Or am I misunderstanding and all ls2k SoCs do work with this driver and
>>> you were talking about other, future products?
>>
>> Actually, in 2k500 has one special type spi was only one cs and their's
>> register definition was different from common type spi thus this driver
>> doesn't support but this driver can support another common type spi in
>> 2k500.  for this special type spi I will add support as needed in the
>> future.
> 
> Bindings are for hardware, not driver. What does your driver support or
> does not, matters less.


okay, I got it, and the loongson spi bindings was for loongson spi
controller hardware. if the spi controller hardware not changed in
different ls2k SoC and the spi compatible should be same thus loongson
spi compatible seems to be adhere to the bindings aggrement.

Thanks

