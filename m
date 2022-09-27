Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A482E5EC0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiI0LLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiI0LKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:10:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D17B551A0C;
        Tue, 27 Sep 2022 04:08:31 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOKo2TJjNbsiAA--.63954S2;
        Tue, 27 Sep 2022 19:08:25 +0800 (CST)
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to
 json-schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        =?UTF-8?B?5YiY5L2p5a6d?= <liupeibao@loongson.cn>,
        zhuyinbo@loongson.cn, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        =?UTF-8?B?5YiY5L2p5a6d?= <liupeibao@loongson.cn>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <20220921015605.17078-2-zhuyinbo@loongson.cn>
 <fb901889-d769-ba56-d4cb-2d9d8b50f74f@linaro.org>
 <28a78a10.a7dd.1835f5aaf90.Coremail.zhuyinbo@loongson.cn>
 <a44244f2-fb96-0483-b529-d0f2b0b7e5d8@linaro.org>
 <4febe7e4.a96c.18362d997e3.Coremail.zhuyinbo@loongson.cn>
 <20220924174258.GA1011284-robh@kernel.org>
 <4ce14e3c.bf79.18377f44118.Coremail.zhuyinbo@loongson.cn>
 <1f3e153b-da8a-43fa-162f-9bea2ed3ef78@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <08dd2ab1-552f-d139-ce01-5d82f6c05a6a@loongson.cn>
Date:   Tue, 27 Sep 2022 19:08:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1f3e153b-da8a-43fa-162f-9bea2ed3ef78@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxBOKo2TJjNbsiAA--.63954S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4UGF4UtrWrJw4rAry5Jwb_yoWfJw4kpF
        47CayUCr4kJr1UZw1xK3WUCFn0q3s8tr4DXrnxGw18Jryqqw13XF42qr15uryxGr1jqFWU
        ZrWvgw12gFyDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/26 下午2:21, Krzysztof Kozlowski 写道:
> On 26/09/2022 06:00, Yinbo Zhu wrote:
>>
>>
>>> -----原始邮件-----
>>> 发件人: "Rob Herring" <robh@kernel.org>
>>> 发送时间:2022-09-25 01:42:58 (星期日)
>>> 收件人: "朱银波" <zhuyinbo@loongson.cn>
>>> 抄送: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zhanghongchen <zhanghongchen@loongson.cn>
>>> 主题: Re: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
>>>
>>> On Thu, Sep 22, 2022 at 09:39:30AM +0800, 朱银波 wrote:
>>>>
>>>>
>>>>> -----原始邮件-----
>>>>> 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>>>>> 发送时间:2022-09-21 17:31:11 (星期三)
>>>>> 收件人: "朱银波" <zhuyinbo@loongson.cn>
>>>>> 抄送: "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zhanghongchen <zhanghongchen@loongson.cn>
>>>>> 主题: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
>>>>>
>>>>> On 21/09/2022 11:22, 朱银波 wrote:
>>>>>>> -----原始邮件-----
>>>>>>> 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>>>>>>> 发送时间:2022-09-21 15:05:00 (星期三)
>>>>>>> 收件人: "Yinbo Zhu" <zhuyinbo@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
>>>>>>> 抄送: zhanghongchen <zhanghongchen@loongson.cn>
>>>>>>> 主题: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
>>>>>>>
>>>>>>> On 21/09/2022 03:56, Yinbo Zhu wrote:
>>>>>>>> Convert the loongson2 thermal binding to DT schema format using
>>>>>>>> json-schema.
>>>>>>> Incorrect subject and incorrect commit msg. There is no conversion here.
>>>>>> Our soc architecture is the loongson2 series, so we will modify it accordingly.
>>>>> How the soc architecture is related to my comment that you do not
>>>>> perform conversion?
>>>> I got it, and I will aad a conversion.
>>>>>>>> Signed-off-by: Yinbo Zhu <c>
>>>>>>>> ---
>>>>>>>> Change in v2:
>>>>>>>> 		1. Add description and type about the "id".	
>>>>>>>> 		2. Make the filename was based on compatible.
>>>>>>>>
>>>>>>>>   .../bindings/thermal/loongson2-thermal.yaml   | 52 +++++++++++++++++++
>>>>>>>>   1 file changed, 52 insertions(+)
>>>>>>>>   create mode 100644 Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..2994ae3a56aa
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>>>>>
>>>>>>> No improvements here. You ignore my comments, so I am going to NAK it.
>>>>>> I don't get your point, that dts compatible is "loongson,loongson2-thermal", so this driver file name is named
>>>>>> loongson2-thermal that according what you said about "Filename based on compatible."
>>>>>> If what I understand is not what you expect, please tell me how to modify it.
>>>>>
>>>>> Filename must match the compatible, so: loongson,loongson2-thermal.yaml
>>>> I got it, and I will add a conversion.
>>>>>>>
>>>>>>>> @@ -0,0 +1,52 @@
>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>> +%YAML 1.2
>>>>>>>> +---
>>>>>>>> +$id: http://devicetree.org/schemas/thermal/loongson2-thermal.yaml#
>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>> +
>>>>>>>> +title: Thermal sensors on loongson2 SoCs
>>>>>>>> +
>>>>>>>> +maintainers:
>>>>>>>> +  - zhanghongchen <zhanghongchen@loongson.cn>
>>>>>>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>>>>> +
>>>>>>>> +properties:
>>>>>>>> +  compatible:
>>>>>>>> +    const: loongson,loongson2-thermal
>>>>>>>> +
>>>>>>>> +  reg:
>>>>>>>> +    maxItems: 1
>>>>>>>> +
>>>>>>>> +  id:
>>>>>>>> +    $ref: '//schemas/types.yaml#/definitions/uint32'
>>>>>>> No improvements here, so let me be specific - you need to really justify
>>>>>>> such property or it cannot go to schema.
>>>>>> The loongson2_thermal.c driver need parse this "id" property.
>>>>> This is not reason to add properties to DT. DT describes the hardware,
>>>>> not driver behavior.
>>>>>
>>>>> Why hardware needs arbitrary, additional addressing number instead of
>>>>> standard unit address?
>>>> The loongson2 series soc supports up to four sensors, but the 2K1000 has only one sensor, so the ID must be 0.
>>>> For the 2K1000, in order to distinguish the differences between different hardware in the Loongson2 SoC series,
>>>> the ID is added to the dts
>>> Differences in SoCs is what 'compatible' is for. If 'loongson2' is not a
>>> specific SoC, then your compatible string is not specific enough.
>> If other loongson2 platforms are different from the thermal sensor, I will add compatible
>> "loongson,loongson2-thermal-xxx", please you note.
> No, this compatible looks wrong then. What is your SoC model number? You
> called loongson2 a "series", so that's not appropriate. Compatible
> should be specific.
okay, I got it. I will add this change in v4.
>
>>>>>>>> +    description: |
>>>>>>>> +      Specify the thermal sensor id.
>>>>>>>> +    minimum: 0
>>>>>>>> +    maximum: 3
>>>>>>>> +
>>>>>>>> +  interrupts:
>>>>>>>> +    maxItems: 1
>>>>>>>> +
>>>>>>>> +  "#thermal-sensor-cells":
>>>>>>>> +    const: 1
>>> If one SoC only has 1 sensor, then this could be 0. However, you don't
>>> have to do that, but it's another way to distinguish differences.
>> okay ,I got it.
>>>>>>>> +
>>>>>>>> +required:
>>>>>>>> +  - compatible
>>>>>>>> +  - reg
>>>>>>>> +  - id
>>>>>>>> +  - interrupt-parent
>>>>>>> Why?
>>>>>> The interrupts of our dts do not specify an interrupt parent,
>>>>>> eg. interrupts = <7 IRQ_TYPE_LEVEL_LOW>
>>>>>> so we need to add an interrupt parent property.
>>>>> You can add but I am asking why is it required?
>>>> Since there is more than one interrupt controller in the Loongson2 series soc, that need to specify the interrupt
>>>> controller in the dts, that is, the interrupt parent.   If different interrupt parents are used in dts, the interrupt
>>>> numbers are different.
>>> It is perfectly valid for the 'interrupt-parent' to be in *any* parent
>>> node. So it is never required by any binding.
>> I don't get your meaning, You mean I can add it in the dts, but I don't need to add it in the binding file, right?
> You should not add it to the binding because it is not related to the
> device itself.
okay, I got it.
>
>>> Rob
>>
>> 本邮件及其附件含有龙芯中科的商业秘密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制或散发）本邮件及其附件中的信息。如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。
>> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it.
> Don't include such footers. We cannot talk over confidential emails and
> you clearly state that here.
>
> Best regards,
> Krzysztof

sorry, I will remove it.


TKs,

Yinbo Zhu

