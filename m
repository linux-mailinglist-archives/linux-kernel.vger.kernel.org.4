Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03F3622675
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKIJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKIJMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:12:44 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3423123BF2;
        Wed,  9 Nov 2022 01:11:53 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxOdjXbmtj6YMFAA--.15961S3;
        Wed, 09 Nov 2022 17:11:51 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxr+DWbmtje3gPAA--.43114S2;
        Wed, 09 Nov 2022 17:11:50 +0800 (CST)
Subject: Re: [PATCH v9 3/3] dt-bindings: clock: add loongson-2 clock
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221103050032.29236-1-zhuyinbo@loongson.cn>
 <20221103050032.29236-3-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <450c73ad-0008-1e32-6081-00ef54072dc1@loongson.cn>
Date:   Wed, 9 Nov 2022 17:11:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221103050032.29236-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxr+DWbmtje3gPAA--.43114S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF4UJrW8AFWxCrW3Ary5Arb_yoW5KF48pF
        sxCas5JFWIyF17uFsxKa4xtwn5uas7AFyqvw42ka4DAr98Xw1jqF1xKas8Z39xJryxZa9F
        vF1S9r4UuanrC3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jetC7UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainer,

Please help me merge this patch to upstream.

thanks,
Yinbo.

ÔÚ 2022/11/3 ÏÂÎç1:00, Yinbo Zhu Ð´µÀ:
> Add the Loongson-2 clock binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Change in v9:
> 		1. Add all history changlog information.
> Change in v8:
> 		1. NO change, but other patch in this series of patches has
> 		   changes.
> Change in v7:
> 		1. NO change, but other patch in this series of patches has
> 		   changes.
> Change in v6:
> 		1. NO change, but other patch in this series of patches has
> 		   changes.
> Change in v5:
> 		1. NO change, but other patch in this series of patches has
> 		   changes.
> Change in v4:
> 		1. NO change, but other patch in this series of patches has
> 		   changes.
> Change in v3:
> 		1. Drop redundant (last) binding from the title.
> 		2. Drop "- |" between ref_100m node and clk node.
> Change in v2:
> 		1. Drop "Binding" string in the title.
> 		2. Drop entire allOf and move the contents to top level.
> 		3. Change string "refclk_100m" to "ref_100m".
> 
>   .../bindings/clock/loongson,ls2k-clk.yaml     | 63 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 64 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> new file mode 100644
> index 000000000000..63a59015987e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/loongson,ls2k-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-2 SoC Clock Control Module
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +description: |
> +  Loongson-2 SoC clock control module is an integrated clock controller, which
> +  generates and supplies to all modules.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: 100m ref
> +
> +  clock-names:
> +    items:
> +      - const: ref_100m
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      The clock consumer should specify the desired clock by having the clock
> +      ID in its "clocks" phandle cell. See include/dt-bindings/clock/loongson,ls2k-clk.h
> +      for the full list of Loongson-2 SoC clock IDs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ref_100m: clock-ref-100m {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <100000000>;
> +        clock-output-names = "ref_100m";
> +    };
> +
> +    clk: clock-controller@1fe00480 {
> +        compatible = "loongson,ls2k-clk";
> +        reg = <0x1fe00480 0x58>;
> +        #clock-cells = <1>;
> +        clocks = <&ref_100m>;
> +        clock-names = "ref_100m";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b3d7bb18350..7afaf6d72800 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12022,6 +12022,7 @@ LOONGSON-2 SOC SERIES CLOCK DRIVER
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-clk@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
>   F:	drivers/clk/clk-loongson2.c
>   F:	include/dt-bindings/clock/loongson,ls2k-clk.h
>   
> 

