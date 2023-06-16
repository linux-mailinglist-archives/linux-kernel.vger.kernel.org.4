Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD44732A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbjFPIvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343804AbjFPIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:51:13 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20D0530D0;
        Fri, 16 Jun 2023 01:51:09 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxzOp8IoxkjegFAA--.12616S3;
        Fri, 16 Jun 2023 16:51:08 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxluR4IoxknxIdAA--.17041S3;
        Fri, 16 Jun 2023 16:51:05 +0800 (CST)
Subject: Re: [PATCH v3 2/3] soc: dt-bindings: add loongson-2 pm
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230615091757.24686-1-zhuyinbo@loongson.cn>
 <20230615091757.24686-3-zhuyinbo@loongson.cn>
 <efdd8e66-a8dc-1a7e-6ac3-fdbe0ba45204@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <5f50f83d-52f4-276b-1e99-6fef461df80a@loongson.cn>
Date:   Fri, 16 Jun 2023 16:51:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <efdd8e66-a8dc-1a7e-6ac3-fdbe0ba45204@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxluR4IoxknxIdAA--.17041S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/16 下午4:03, Krzysztof Kozlowski 写道:
> On 15/06/2023 11:17, Yinbo Zhu wrote:
>> Add the Loongson-2 SoC Power Management Controller binding with DT
>> schema format using json-schema.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   .../soc/loongson/loongson,ls2k-pmc.yaml       | 53 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 +++
>>   2 files changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>> new file mode 100644
>> index 000000000000..32499bd10f8c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-pmc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson-2 Power Manager controller
>> +
>> +maintainers:
>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
> 
> Drop oneOf, you don't have here many choices.


okay, I got it.

> 
>> +      - items:
>> +          - enum:
>> +              - loongson,ls2k1000-pmc
>> +              - loongson,ls2k0500-pmc
>> +          - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  suspend-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      The "suspend-address" is a deep sleep state (Suspend To RAM)
>> +      firmware entry address which was jumped from kernel and it's
>> +      value was dependent on specific platform firmware code. In
>> +      addition, the PM need according to it to indicate that current
>> +      SoC whether support Suspend To RAM.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    pmc: pm@1fe27000 {
> 
> Node name: system-controller or power-pamanagement
> 
> With these two:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


okay, I will do it.

Thanks,
Yinbo

