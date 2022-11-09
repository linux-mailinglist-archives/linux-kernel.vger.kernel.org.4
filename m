Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581C96227EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiKIKEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:04:28 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 964B95F42;
        Wed,  9 Nov 2022 02:04:26 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8BxHdkpe2tjXIcFAA--.17490S3;
        Wed, 09 Nov 2022 18:04:25 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_1cne2tj4n8PAA--.43117S2;
        Wed, 09 Nov 2022 18:04:24 +0800 (CST)
Subject: Re: [PATCH v6 2/2] dt-bindings: soc: add loongson-2 chipid
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20221104024835.3570-1-zhuyinbo@loongson.cn>
 <20221104024835.3570-2-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <8e904fec-4405-0b23-c25d-9e1931fbca8f@loongson.cn>
Date:   Wed, 9 Nov 2022 18:04:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221104024835.3570-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_1cne2tj4n8PAA--.43117S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF4fuFWfXr15ZryxGw1ftFb_yoW5WFyfpa
        nxCas5KF4xt3W7uanxKa4Ik3Z8ZF93AanFgF47tw15GrWqgw1Fqw13KayDZwsrZr1xXayj
        9FyS9rWY9FW8Cr7anT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bBxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxk0xIA0c2
        IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY
        6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU5-Vy3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintaier,

please help me merge it to upstream.

thanks,
Yinbo.
ÔÚ 2022/11/4 ÉÏÎç10:48, Yinbo Zhu Ð´µÀ:
> Add the Loongson-2 SoC chipid binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Change in v6:
> 		1. NO change, but other patch in this series of patches set	
> 		   has changes.
> Change in v5:
> 		1. Add all history change log information.
> 		2. Add reviewed-by information.
> Change in v4:
> 		1. NO change, but other patch in this series of patches set	
> 		   has changes.
> Change in v3:
> 		1. Drop "driver" and describe instead what is GUTS, including
> 		   its acronym.
> 		2. Add desciption about the SoC register.
> 		3. Fixup dts node name.
> 		4. Replace string loongson2/Loongson2 with loongson-2/Loongson-2
>                     in binding file and commit message.
> Change in v2:
> 		1. NO change, but other patch in this series of patches set	
> 		   has changes.
> 
>   .../bindings/hwinfo/loongson,ls2k-chipid.yaml | 38 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 39 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml b/Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
> new file mode 100644
> index 000000000000..9d0c36ec1982
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwinfo/loongson,ls2k-chipid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-2 SoC ChipID
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +description: |
> +  Loongson-2 SoC contains many groups of global utilities register
> +  blocks, of which the ChipID group registers record SoC version,
> +  feature, vendor and id information.
> +
> +properties:
> +  compatible:
> +    const: loongson,ls2k-chipid
> +
> +  reg:
> +    maxItems: 1
> +
> +  little-endian: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    chipid: chipid@1fe00000 {
> +        compatible = "loongson,ls2k-chipid";
> +        reg = <0x1fe00000 0x3ffc>;
> +        little-endian;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20ce056ae207..916b2d9cffc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12045,6 +12045,7 @@ LOONGSON-2 SOC SERIES GUTS DRIVER
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	loongarch@lists.linux.dev
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>   F:	drivers/soc/loongson/loongson2_guts.c
>   
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
> 

