Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188E36B6D50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCMCJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMCJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:09:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5620B28E9E;
        Sun, 12 Mar 2023 19:09:23 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxMI_ShQ5kycoLAA--.16518S3;
        Mon, 13 Mar 2023 10:09:22 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax97zJhQ5kS8NVAA--.16519S3;
        Mon, 13 Mar 2023 10:09:18 +0800 (CST)
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn,
        zhuyinbo@loongson.cn
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-2-zhuyinbo@loongson.cn>
 <8d20dcfb-480b-3f1a-02b0-294a05a566f7@linaro.org>
 <dd2e6c68-7460-caa1-0d54-53aeb5619a18@loongson.cn>
 <ecd867a1-207d-774f-882b-22f0973286ae@linaro.org>
 <9bfeef4b-f498-12d1-6f21-97289a3127bd@loongson.cn>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <29b2a024-8b5a-70ff-17b6-0fb46d871925@loongson.cn>
Date:   Mon, 13 Mar 2023 10:09:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9bfeef4b-f498-12d1-6f21-97289a3127bd@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Ax97zJhQ5kS8NVAA--.16519S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGr13XrWUXF1kZF1rGFykXwb_yoW5uF1Upr
        n3Ca1DtryxGF1xXwn7ta48Gr90y34rJw1DXr12qFy7GF9Fqa4jqF4aqF1q9347AF4xJayD
        XF4Yg3yxur1UAr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b4AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz4
        8v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1tl1PUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/9 下午3:22, zhuyinbo 写道:
>
> 在 2023/3/9 下午2:23, Krzysztof Kozlowski 写道:
>> On 09/03/2023 03:08, zhuyinbo wrote:
>>> 在 2023/3/8 下午7:30, Krzysztof Kozlowski 写道:
>>>> On 08/03/2023 03:59, Yinbo Zhu wrote:
>>>>> Add the Loongson platform spi binding with DT schema format using
>>>>> json-schema.
>>>>>
>>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>> ---
>>>>>    .../bindings/spi/loongson,ls-spi.yaml         | 47 
>>>>> +++++++++++++++++++
>>>>>    MAINTAINERS                                   |  6 +++
>>>>>    2 files changed, 53 insertions(+)
>>>>>    create mode 100644 
>>>>> Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>> Filename matching the compatible.
>>> loongson,ls-spi.yaml is for ls2k-spi and ls7a-spi, I will add following
>>> desription:
>>>
>>>
>>> properties:
>>>     compatible:
>>>       enum:
>>>         - loongson,ls2k-spi
>>>         - loongson,ls7a-spi
>> OK then.
>
> I was to explain why that yaml was name as "loongson,ls-spi.yaml" 
> rather than "loongson,ls2k-spi.yaml"
>
> because that need consider about  yaml filename to match 
> "loongson,ls2k-spi" and "loongson,ls7a-spi".
>
>>
>>>>> diff --git 
>>>>> a/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml 
>>>>> b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..8a13a96b3818
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>>> @@ -0,0 +1,47 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: "http://devicetree.org/schemas/spi/loongson,ls-spi.yaml#"
>>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>> Drop the quotes. What was the base of your code here?
>>> okay, I will drop the quotes.    and I don't got it  about the code 
>>> base
>>> that you said.
>>>
>>> you meaning is advice me add a line  as follows ?
>> I meant, from which other file did you copy it?
> okay,  but I maybe forgot it,  I should be refer other spi yaml file.
>>
>>>>> +
>>>>> +  clock-names:
>>>>> +    const: boot
>>>> Drop clock-names, not needed for single entry.
>>> if drop the clock-names entry, the yaml file will compile fail.
>> Obviously you have to also drop it from DTS and driver...
>
> drop clock-names should be not  affect my driver,  but I notice other 
> lots of arm64 platform dts
>
> was keep clock-names and clock in dts when use grep search "clock-names".
>
> [zhuyinbo@localhost www.kernel.org]$ grep -rns "clock-names" arch/arm64/
>
> arch/arm64/boot/dts/sprd/sc9863a.dtsi:280:            clock-names = 
> "apb_pclk";
> arch/arm64/boot/dts/sprd/sc9863a.dtsi:305:            clock-names = 
> "apb_pclk";
> arch/arm64/boot/dts/sprd/sc9863a.dtsi:330:            clock-names = 
> "apb_pclk";
> arch/arm64/boot/dts/sprd/sc9863a.dtsi:367:            clock-names = 
> "apb_pclk";

so , if you think it is okay I will keep clock-names and clock in yaml 
file like other platform.

>
>>
>>
>> Best regards,
>> Krzysztof

