Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7837732950
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbjFPHxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbjFPHxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:53:46 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB17A2945;
        Fri, 16 Jun 2023 00:53:43 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dxh+kFFYxkC+QFAA--.10690S3;
        Fri, 16 Jun 2023 15:53:41 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxKeUCFYxkjAgdAA--.16252S3;
        Fri, 16 Jun 2023 15:53:38 +0800 (CST)
Subject: Re: [PATCH v3 2/3] soc: dt-bindings: add loongson-2 pm
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230615091757.24686-1-zhuyinbo@loongson.cn>
 <20230615091757.24686-3-zhuyinbo@loongson.cn>
 <20230616-entangled-cauterize-1cbde7401b91@wendy>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <9a53089a-3c87-13e1-0bc4-29058ac0ec54@loongson.cn>
Date:   Fri, 16 Jun 2023 15:53:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230616-entangled-cauterize-1cbde7401b91@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxKeUCFYxkjAgdAA--.16252S3
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



在 2023/6/16 下午2:58, Conor Dooley 写道:
> Hey,
> 
> Rob, could you take a look at this please? On v2 while you were away I
> was kinda struggling w/ suspend-address & whether it made sense.
> 
> The v2 & v1 are here:
> https://lore.kernel.org/all/20230522093156.7108-3-zhuyinbo@loongson.cn/
> https://lore.kernel.org/all/20230517073149.31980-3-zhuyinbo@loongson.cn/
> 
> On Thu, Jun 15, 2023 at 05:17:56PM +0800, Yinbo Zhu wrote:
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
> 
> The filename should ideally match one of the compatibles.


I learn about that yaml file name need match this compatible, but here
using a specific compatible as the name of the yaml file seems a bit
inappropriate . After all, this yaml file needs to cover lots of ls2k
series SoC rather than a specific SoC, and the yaml file naming in
kernel drivers is basically the same that use cover a series SoC's way.

> 
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
>> +      - items:
>> +          - enum:
>> +              - loongson,ls2k1000-pmc
>> +              - loongson,ls2k0500-pmc
> 
> I notice the driver only supports one of these two. Is there a reason
> for that?


The driver can support both of the above, and I will add another.

> 
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
>         ^^^
> 
> nit: this label isn't used, so you can drop it.


This lable need to be used by poweroff and reboot node but I don't add
these node that reference pmc here.

Thanks,
Yinbo

