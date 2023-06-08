Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789C1727A29
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjFHIkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjFHIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:39:49 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71F0B26B2;
        Thu,  8 Jun 2023 01:39:39 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Ax3erGk4Fkz3cAAA--.1753S3;
        Thu, 08 Jun 2023 16:39:34 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPMrBk4FkkwgHAA--.13964S3;
        Thu, 08 Jun 2023 16:39:31 +0800 (CST)
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
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
Date:   Thu, 8 Jun 2023 16:39:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPMrBk4FkkwgHAA--.13964S3
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



在 2023/6/8 下午3:45, Krzysztof Kozlowski 写道:
> On 08/06/2023 09:28, Yinbo Zhu wrote:
>> Add the Loongson platform spi binding with DT schema format using
>> json-schema.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
> 
> The prefix for SPI should be: "spi: dt-bindings: ". In the same time
> last "bindings" are redundant.


okay, I got it.

> 
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../bindings/spi/loongson,ls2k-spi.yaml       | 41 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 +++
>>   2 files changed, 47 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>> new file mode 100644
>> index 000000000000..423ee851edd5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> 
> Filename based on compatible.


There will be more ls2k series SoC spi device in the future thus I still
use "loongson,ls2k-spi.yaml" for cover it.

> 
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/loongson,ls2k-spi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson SPI controller
>> +
>> +maintainers:
>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - loongson,ls2k1000-spi
> 
> No compatibles for other devices? Didn't we have big discussion about this?
> 
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42


There are other ls2k SPI devices compatible, such as,
"loongson,ls2k0500-spi", "loongson,ls2k2000-spi" but currently I plan to
add ls2k1000 spi device first, Other ls2k SoC spi device adaptation may
require some additional work and I will add it later.

Thanks

