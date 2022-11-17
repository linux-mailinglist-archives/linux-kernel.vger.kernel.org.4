Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC5062D496
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiKQIDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKQIDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:03:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59B4ABF6;
        Thu, 17 Nov 2022 00:03:42 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxDdnd6nVjOzcIAA--.23274S3;
        Thu, 17 Nov 2022 16:03:41 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqFfb6nVjLM8VAA--.39376S2;
        Thu, 17 Nov 2022 16:03:40 +0800 (CST)
Subject: Re: [PATCH v12 2/2] dt-bindings: thermal: add loongson-2 thermal
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221114024709.7975-1-zhuyinbo@loongson.cn>
 <20221114024709.7975-2-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <7963d36a-6898-79c8-2d19-9c4bd1cc36f6@loongson.cn>
Date:   Thu, 17 Nov 2022 16:03:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221114024709.7975-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxqFfb6nVjLM8VAA--.39376S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxury3Wr18uw47AryDWF13twb_yoW5tFykpF
        4UCas8Crs2vF17uanIkFyxCrs0vFnayF9Fvr4xKwn8Kr98t34ft3y7K3WDZ393CryxWFW7
        uFyF9r4UCF1DArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0ow
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jca93UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainer,

Could you help me merge my patch?

Thanks,
Yinbo.

ÔÚ 2022/11/14 ÉÏÎç10:47, Yinbo Zhu Ð´µÀ:
> Add the Loongson-2 thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Change in v12:
> 		1. NO change, but other patch in this series of patches set
> 		   has changes.
> Change in v11:
> 		1. NO change, but other patch in this series of patches set
> 		   has changes.
> Change in v10:
> 		1. Add all history change log information.
> Change in v9:
> 		1. NO change, but other patch in this series of patches set
> 		   has changes.
> Change in v8:
>                  1. Replace string Loongson2/loongson2 with Loongson-2/loongson-2.
> Change in v7:
> 		1. Split the modification of patch 3 and merge it into this patch.
> Change in v6:
> 		1. Fix the warning "reg: [[0, 534779136], [0, 48]] is too long"
> 		   when compile the yaml.
> Change in v5:
> 		1. Keep use same quotes "'" in all places.
> Change in v4:
> 		1. Fixup the compatible.
> 		2. Update the binding file name.
> 		3. Include irq.h to fix compile issue.
> Change in v3:
> 		1. Remove the sensor id.
> 		2. Remove the interrupt-parent in thermal required property.
> 		3. Update the thermal binding file name.
> 		4. Fixup the commit log information.
> Change in v2:
> 		1. Add description and type about the "id".	
> 		2. Make the filename was based on compatible.
> 
>   .../thermal/loongson,ls2k-thermal.yaml        | 43 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 44 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> new file mode 100644
> index 000000000000..c0637e2d6d57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/loongson,ls2k-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal sensors on Loongson-2 SoCs
> +
> +maintainers:
> +  - zhanghongchen <zhanghongchen@loongson.cn>
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    const: loongson,ls2k-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#thermal-sensor-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#thermal-sensor-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    thermal: thermal-sensor@1fe01500 {
> +        compatible = "loongson,ls2k-thermal";
> +        reg = <0x1fe01500 0x30>;
> +        interrupt-parent = <&liointc0>;
> +        interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +        #thermal-sensor-cells = <1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d867573fe4c..182129c73ed5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12018,6 +12018,7 @@ M:	zhanghongchen <zhanghongchen@loongson.cn>
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-pm@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>   F:	drivers/thermal/loongson2_thermal.c
>   
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
> 

