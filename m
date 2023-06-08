Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459AB727C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbjFHKA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjFHKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:00:55 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D03F32700;
        Thu,  8 Jun 2023 03:00:40 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxL_DHpoFkYHwAAA--.1906S3;
        Thu, 08 Jun 2023 18:00:39 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxFOTEpoFk2DcHAA--.23000S3;
        Thu, 08 Jun 2023 18:00:38 +0800 (CST)
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-2-zhuyinbo@loongson.cn>
 <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
 <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
 <6bfc2a22-6901-0858-7b90-bc4c52c66810@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <bd2d7830-3ab6-0906-b06a-83d3e0a96749@loongson.cn>
Date:   Thu, 8 Jun 2023 18:00:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6bfc2a22-6901-0858-7b90-bc4c52c66810@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxFOTEpoFk2DcHAA--.23000S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/8 下午4:53, Krzysztof Kozlowski 写道:
> On 08/06/2023 10:39, zhuyinbo wrote:
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    .../bindings/spi/loongson,ls2k-spi.yaml       | 41 +++++++++++++++++++
>>>>    MAINTAINERS                                   |  6 +++
>>>>    2 files changed, 47 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>> new file mode 100644
>>>> index 000000000000..423ee851edd5
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>
>>> Filename based on compatible.
>>
>>
>> There will be more ls2k series SoC spi device in the future thus I still
>> use "loongson,ls2k-spi.yaml" for cover it.
> 
> Add them now.


The 2k0500 doesn't support CCF and not use CCF to gain clock and We
internally tend to prioritize supporting 2k1000.

> 
>>
>>>
>>>> @@ -0,0 +1,41 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/spi/loongson,ls2k-spi.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Loongson SPI controller
>>>> +
>>>> +maintainers:
>>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/spi/spi-controller.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - loongson,ls2k1000-spi
>>>
>>> No compatibles for other devices? Didn't we have big discussion about this?
>>>
>>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>>
>>
>> There are other ls2k SPI devices compatible, such as,
>> "loongson,ls2k0500-spi", "loongson,ls2k2000-spi" but currently I plan to
>> add ls2k1000 spi device first, Other ls2k SoC spi device adaptation may
>> require some additional work and I will add it later.
> 
> Previously you claimed this serves entire family, so I don't understand
> why you need to fix something. Why previously it was working for entire
> family but now it does not?


It can work was for ls2k1000 and ls2k0500 and it specifically refers to
spi driver. but 2k0500 doesn't implementing a clock driver and doesn't
use CCF to gain clock but can use "clock-frequency".  Is it necessary to
obtain a clock based on CCF? If it's necessary, then it seems that it
can only added 2k1000 spi first.

Thanks,
Yinbo



