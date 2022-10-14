Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6285FE7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJNDsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJNDsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:48:09 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10E5119298C;
        Thu, 13 Oct 2022 20:48:06 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbWvv20hjbtwtAA--.51528S2;
        Fri, 14 Oct 2022 11:47:59 +0800 (CST)
Subject: Re: [PATCH v7 2/2] dt-bindings: thermal: add loongson2k thermal
 binding
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhuyinbo@loongson.cn
References: <20220930021054.22387-1-zhuyinbo@loongson.cn>
 <20220930021054.22387-2-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <21717466-63f9-09b0-e666-61b98ab808f4@loongson.cn>
Date:   Fri, 14 Oct 2022 11:47:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220930021054.22387-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbWvv20hjbtwtAA--.51528S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW7uryUCryrXrWrZFW3trb_yoW5Gr4UpF
        4xCas5CF4vkF17Z39IkFyUCws0qwnayF9rur4xW3W5Kr98Ja4Sq3yagw1DZ393ur1jgFW7
        uFyS9r4UC3WkJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi thermal maintainer

Are there any other suggestions about this patch? If not, please help
merge this patch to upstream.

RRs
Yinbo
ÔÚ 2022/9/30 ÉÏÎç10:10, Yinbo Zhu Ð´µÀ:
> Add the loongson2k thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Change in v7:
> 		1. Split the modification of patch 3 and merge it into this patch.
> 
>   .../thermal/loongson,ls2k-thermal.yaml        | 43 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 44 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> new file mode 100644
> index 000000000000..12f54076bdd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/loongson,ls2k-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal sensors on loongson2k SoCs
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
> index 2efbd5b158b9..0be0f520c032 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11904,6 +11904,7 @@ M:	zhanghongchen <zhanghongchen@loongson.cn>
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-pm@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>   F:	drivers/thermal/loongson2_thermal.c
>   
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SP

> 

