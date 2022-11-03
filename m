Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AFB617CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiKCMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiKCMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:37:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C379014036;
        Thu,  3 Nov 2022 05:36:58 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N33822hZFzpW8Y;
        Thu,  3 Nov 2022 20:33:22 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 20:36:56 +0800
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <xuwei5@huawei.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <yangyicong@hisilicon.com>
Subject: Re: [PATCH next v3 2/2] dt-bindings: gpio: add entry for
 hisilicon,ascend910-gpio
To:     Weilong Chen <chenweilong@huawei.com>, <f.fangjian@huawei.com>
References: <20221101082442.263448-1-chenweilong@huawei.com>
 <20221101082442.263448-2-chenweilong@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <322c65cf-2b89-a73c-ba7e-983ac8fb8b3e@huawei.com>
Date:   Thu, 3 Nov 2022 20:36:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20221101082442.263448-2-chenweilong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/1 16:24, Weilong Chen wrote:
> Add the new compatible for HiSilicon gpio controller driver.
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>

Looks good to me,

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
> Change since v2:
> - No change.
> Link: https://lore.kernel.org/lkml/20221028022453.163186-2-chenweilong@huawei.com/
> 
> Change since v1:
> - Drop "Device Tree Bindings" and reg's description
> - Move description in top-level description.
> - Add gpio-cells to required
> - Use additionalProperties and decimal numbers
> - Use IRQ flags
> - Use vendor,soc-ipblock format
> Link: https://lore.kernel.org/lkml/20221026034219.172880-2-chenweilong@huawei.com/
> 
>  .../gpio/hisilicon,ascend910-gpio.yaml        | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml b/Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
> new file mode 100644
> index 000000000000..735d97d645a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/hisilicon,ascend910-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon common GPIO controller
> +
> +maintainers:
> +  - Jay Fang <f.fangjian@huawei.com>
> +
> +description:
> +  The HiSilicon common GPIO controller can be used for many different
> +  types of SoC such as Huawei Ascend AI series chips.
> +
> +properties:
> +  compatible:
> +    const: hisilicon,ascend910-gpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  ngpios:
> +    minimum: 1
> +    maximum: 32
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - gpio-controller
> +  - "#gpio-cells"
> +  - ngpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gpio@840d0000 {
> +      compatible = "hisilicon,ascend910-gpio";
> +      reg = <0x840d0000 0x1000>;
> +      ngpios = <32>;
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d42e34d1e8e2..74ac2e7a8e4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9212,6 +9212,7 @@ HISILICON GPIO DRIVER
>  M:	Jay Fang <f.fangjian@huawei.com>
>  L:	linux-gpio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
>  F:	drivers/gpio/gpio-hisi.c
>  
>  HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
> 
