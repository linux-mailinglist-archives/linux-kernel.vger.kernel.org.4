Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3962251D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKIIM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKIIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:12:27 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B53F61902F;
        Wed,  9 Nov 2022 00:12:25 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxPLfoYGtjvIAFAA--.6049S3;
        Wed, 09 Nov 2022 16:12:24 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxR1fmYGtjdHAPAA--.24419S2;
        Wed, 09 Nov 2022 16:12:22 +0800 (CST)
Subject: Re: [PATCH v10 2/2] dt-bindings: thermal: add loongson-2 thermal
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
References: <20221103083407.4039-1-zhuyinbo@loongson.cn>
 <20221103083407.4039-2-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <fba09a98-1938-eeae-bf2c-c13200982af7@loongson.cn>
Date:   Wed, 9 Nov 2022 16:12:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221103083407.4039-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxR1fmYGtjdHAPAA--.24419S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWryxZw1xXw1DWF13CF17ZFb_yoW5ury3pF
        4kC3Z8Cr4vvF17uanIkFyxCrs0vrn5tF9rZr4Igwn8Kr98t34ft3y7K3WDZ393ury8WFW7
        ZFy09r4UCF1DArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        ba8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82
        IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
        Xa7IU8SzuJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainer

please help merge this patch to upstream.

Thanks,
Yinbo.

ÔÚ 2022/11/3 ÏÂÎç4:34, Yinbo Zhu Ð´µÀ:
> Add the Loongson-2 thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
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
> index 37ab451d9258..3aff8b8723b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12015,6 +12015,7 @@ M:	zhanghongchen <zhanghongchen@loongson.cn>
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-pm@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>   F:	drivers/thermal/loongson2_thermal.c
>   
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
> 

