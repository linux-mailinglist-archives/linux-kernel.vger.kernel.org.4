Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C234D719B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjFALik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFALii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:38:38 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBD89129;
        Thu,  1 Jun 2023 04:38:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dxc_A6g3hksEQDAA--.7089S3;
        Thu, 01 Jun 2023 19:38:34 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxMLA3g3hk+CiEAA--.17827S3;
        Thu, 01 Jun 2023 19:38:32 +0800 (CST)
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
 <69d355ff-90e1-09d2-d4ff-0d7dedc8addb@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <64773170-4cef-9acc-c2d7-f187bc484825@loongson.cn>
Date:   Thu, 1 Jun 2023 19:38:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <69d355ff-90e1-09d2-d4ff-0d7dedc8addb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxMLA3g3hk+CiEAA--.17827S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAFW7GFWrJr45Aw4kZrWxXrb_yoW5ZFWfpa
        1UCFnrKF4DtF12yrZ2g3W8Cr9IvryrJF15Xr47Kr17Ar98tFyaqF1UKFn8uwn7JF18XFW7
        XFW0gw17GF4UJrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF04k20xvE74
        AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzFApUUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/1 上午4:06, Krzysztof Kozlowski 写道:
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
> 
> I missed it - that's a great comment. Hm, I don't know... Reviewing
> Loongson patches is quite a work, so I don't see here reduced workload.


If we do not consider the differences in SPI hardware and consider the
differences in SoC, it will result for each new a SoC adaptation, a new
compatible patch needs to be submitted to the community but spi hardware
was same and that will increase the workload of the community, It seems
to be more appropriate that use same compatible when spi hardware was
same and use different compatible when spi hardware was different.

> 
> Please read existing guidelines:
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst >
> All of them.
> 

okay, I got it.

Thanks.

