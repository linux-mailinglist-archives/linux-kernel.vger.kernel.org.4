Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED4160F172
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiJ0HsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiJ0Hrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:47:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D19169CC6;
        Thu, 27 Oct 2022 00:47:51 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Myd4Z0JB8zJnLM;
        Thu, 27 Oct 2022 15:45:02 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 15:47:49 +0800
Subject: Re: [PATCH next 2/2] dt-bindings: gpio: add entry for
 hisilicon,gpio-ascend910
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <f.fangjian@huawei.com>, <linus.walleij@linaro.org>,
        <yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
        <robh+dt@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20221026034219.172880-1-chenweilong@huawei.com>
 <20221026034219.172880-2-chenweilong@huawei.com>
 <30b95e7b-b902-babc-ea78-a2112c80ec7e@linaro.org>
From:   chenweilong <chenweilong@huawei.com>
Message-ID: <050ab042-d51c-1e9a-eb85-8fbec8020211@huawei.com>
Date:   Thu, 27 Oct 2022 15:47:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <30b95e7b-b902-babc-ea78-a2112c80ec7e@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.179.106]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/26 22:46, Krzysztof Kozlowski wrote:
> On 25/10/2022 23:42, Weilong Chen wrote:
>> Add the new compatible for HiSilicon gpio controller driver.
>>
>> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
>> ---
>>  .../gpio/hisilicon,gpio-ascend910.yaml        | 54 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 55 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml b/Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
>> new file mode 100644
>> index 000000000000..912e4b808cae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpio/hisilicon,gpio-ascend910.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: HiSilicon common GPIO controller Device Tree Bindings
> Drop "Device Tree Bindings"
>
>> +
>> +maintainers:
>> +  - Jay Fang <f.fangjian@huawei.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: hisilicon,gpio-ascend910
>> +    description:
>> +      The HiSilicon common GPIO controller can be used for many different
>> +      types of SoC such as Huawei Ascend AI series chips.
> Put this description in top-level description.
>
>> +
>> +  reg:
>> +    description:
>> +      Address and length of the register set for the device.
> Drop description.
>
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  gpio-controller: true
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +
>> +  ngpios:
>> +    minimum: 1
>> +    maximum: 32
>> +
>> +required:
>> +  - compatible
>> +  - gpio-controller
> gpio-cells are not required?
>
>> +  - reg
>> +  - interrupts
>> +  - ngpios
>> +
>> +unevaluatedProperties: false
> Instead:
> additionalProperties: false
>
>> +
>> +examples:
>> +  - |
>> +    gpio@840d0000 {
>> +      compatible = "hisilicon,gpio-ascend910";
>> +      reg = <0x840d0000 0x1000>;
>> +      ngpios = <0x20>;
> Convention for counting is to use decimal numbers.
>
>> +      gpio-controller;
>> +      #gpio-cells = <2>;
>> +      interrupts = <0x0 33 0x4>;
> This looks like standard IRQ flags, so use respective defines.

Sorry, I don't get this, you mean like this? :

interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;

Thanks.

>
> Best regards,
> Krzysztof
>
> .


