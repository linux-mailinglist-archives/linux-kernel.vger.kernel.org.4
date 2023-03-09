Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D65B6B1C32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCIHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCIHWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:22:42 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B656D58B1;
        Wed,  8 Mar 2023 23:22:39 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dx_5c9iQlkvEgKAA--.13861S3;
        Thu, 09 Mar 2023 15:22:37 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxnb43iQlkDklQAA--.13408S3;
        Thu, 09 Mar 2023 15:22:34 +0800 (CST)
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-2-zhuyinbo@loongson.cn>
 <8d20dcfb-480b-3f1a-02b0-294a05a566f7@linaro.org>
 <dd2e6c68-7460-caa1-0d54-53aeb5619a18@loongson.cn>
 <ecd867a1-207d-774f-882b-22f0973286ae@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <9bfeef4b-f498-12d1-6f21-97289a3127bd@loongson.cn>
Date:   Thu, 9 Mar 2023 15:22:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ecd867a1-207d-774f-882b-22f0973286ae@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxnb43iQlkDklQAA--.13408S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFW3Gw47Aw13GrykAr1xAFb_yoW5Ar1fpw
        1fCa1DtFyxKF1xZwnaqa48GrZIy34rJ3Z8XF12gFy7GFyqva4YqF4agF1q93y7AF4xGayD
        ZF4jg3yxuF1UArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF04k20xvE74
        AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2oGQDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/9 下午2:23, Krzysztof Kozlowski 写道:
> On 09/03/2023 03:08, zhuyinbo wrote:
>> 在 2023/3/8 下午7:30, Krzysztof Kozlowski 写道:
>>> On 08/03/2023 03:59, Yinbo Zhu wrote:
>>>> Add the Loongson platform spi binding with DT schema format using
>>>> json-schema.
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> ---
>>>>    .../bindings/spi/loongson,ls-spi.yaml         | 47 +++++++++++++++++++
>>>>    MAINTAINERS                                   |  6 +++
>>>>    2 files changed, 53 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>> Filename matching the compatible.
>> loongson,ls-spi.yaml is for ls2k-spi and ls7a-spi, I will add following
>> desription:
>>
>>
>> properties:
>>     compatible:
>>       enum:
>>         - loongson,ls2k-spi
>>         - loongson,ls7a-spi
> OK then.

I was to explain why that yaml was name as "loongson,ls-spi.yaml"  
rather than "loongson,ls2k-spi.yaml"

because that need consider about  yaml filename to match 
"loongson,ls2k-spi" and "loongson,ls7a-spi".

>
>>>> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>> new file mode 100644
>>>> index 000000000000..8a13a96b3818
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>> @@ -0,0 +1,47 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: "http://devicetree.org/schemas/spi/loongson,ls-spi.yaml#"
>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> Drop the quotes. What was the base of your code here?
>> okay, I will drop the quotes.    and I don't got it  about the code base
>> that you said.
>>
>> you meaning is advice me add a line  as follows ?
> I meant, from which other file did you copy it?
okay,  but I maybe forgot it,  I should be refer other spi yaml file.
>
>>>> +
>>>> +  clock-names:
>>>> +    const: boot
>>> Drop clock-names, not needed for single entry.
>> if drop the clock-names entry, the yaml file will compile fail.
> Obviously you have to also drop it from DTS and driver...

drop clock-names should be not  affect my driver,  but I notice other 
lots of arm64 platform dts

was keep clock-names and clock in dts when use grep search "clock-names".

[zhuyinbo@localhost www.kernel.org]$ grep -rns "clock-names" arch/arm64/

arch/arm64/boot/dts/sprd/sc9863a.dtsi:280:            clock-names = 
"apb_pclk";
arch/arm64/boot/dts/sprd/sc9863a.dtsi:305:            clock-names = 
"apb_pclk";
arch/arm64/boot/dts/sprd/sc9863a.dtsi:330:            clock-names = 
"apb_pclk";
arch/arm64/boot/dts/sprd/sc9863a.dtsi:367:            clock-names = 
"apb_pclk";

>
>
> Best regards,
> Krzysztof

