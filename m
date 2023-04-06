Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B246D9EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbjDFRWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbjDFRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:22:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE71AF05
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:21:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n21so3112064ejz.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680801639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtlyNDbkagfeJUns7FGsP2EZRlOL+2mbeocrLuqlnbY=;
        b=AwsWltL/VpHvXdQKf87/oVoC1m2E4uNobtpitdgpwLeje1cNXvts1vHu5kzfojESKn
         MzjtW5brInubmhLfwD5OB97pIB5nePwyHWy3OeRCL/+hsv3actD6eRwSy5okjuk1cRW+
         gSz7tBr2LWaZ5K2vsj3CJi6+wC6HDbcDJP6vLb6tmo4BZ8xGmrbmR13XqzNlRnApp7t8
         UJv+B5rKCsccMbLShiPQ4OASdH02iSYj2gVv2CP9y99ir6GyWoRpfa6pBvauITcPifa9
         3vaYFRjA5m5Pdz6pcmlqJTyDRIwJEG1aMzjPr/YzVmWg8uztzbaNmUG7Td9LQTCwdG1y
         SIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtlyNDbkagfeJUns7FGsP2EZRlOL+2mbeocrLuqlnbY=;
        b=Q4oe7KpGqTnuO2J1KID3ZtYW7Lp8T9Gahr3Pe+X9Fmmxe7JkPNJyP0zn/6tiMundRd
         n3RIZCC9cUgr/wo2F5mJm/bTTBWskbnzl3mvEDtIV2GEFk7y16k31sbafGUbTtNECfaB
         xAgUb6CyzHhuKqd2igot+omlBaQP60INFK44x/eSYVPDsfoWuz31J1SzpEHI8QwM820k
         Oc3Y5nbxpCtLfOAnZcSTrPrHKRBZOtAdLlTvQ4ZfqB3lpG2hASDDlC7pdCnMGUo5Q64D
         U4olnu7dFaFzOP4UgVBpYjEN/RtyBW04sAxvC8eHe/2UAVoUbXN2MPYDoBP9UR1ydKIh
         xPhw==
X-Gm-Message-State: AAQBX9cEwU8zCaa0MMn3lBOPM3l5zzUk8d+5wnREcTPIdvMIYd2jM0gi
        rGvCiMNV/7me9ZqXMTxG/Gd+ZQ==
X-Google-Smtp-Source: AKy350Z5ja8OXv69Q4N861xpWRuNypHMvKQcyy8MNOjI8nJEe5tqHoKvA2WrFUyQOEwh3OGoqVvWpg==
X-Received: by 2002:a17:906:4b12:b0:93e:2a40:316f with SMTP id y18-20020a1709064b1200b0093e2a40316fmr5786836eju.28.1680801639520;
        Thu, 06 Apr 2023 10:20:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id hb18-20020a170907161200b0093344ef3764sm1050939ejc.57.2023.04.06.10.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:20:39 -0700 (PDT)
Message-ID: <4a462b2e-380a-9fd1-2e84-783cc457e8c2@linaro.org>
Date:   Thu, 6 Apr 2023 19:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 Pym Particles EVB
Content-Language: en-US
To:     =?UTF-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9aa26a9bfb174940a69e5f4fde2a38d7@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9aa26a9bfb174940a69e5f4fde2a38d7@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 09:18, CY_Huang[黃鉦晏] wrote:
> Add Device Trees for Realtek RTD1319 SoC family, RTD1319 SoC and
> Realtek Pym Particles EVB.
> 
> Signed-off-by: cy.huang <cy.huang@realtek.com>
> ---
> v1->v2:
>  * no change
> v1:
>  * RTD1319 SoC and Realtek PymParticle EVB
> 
>  arch/arm64/boot/dts/realtek/Makefile          |   2 +
>  .../boot/dts/realtek/rtd1319-pymparticles.dts |  28 ++
>  arch/arm64/boot/dts/realtek/rtd13xx.dtsi      | 346 ++++++++++++++++++
>  3 files changed, 376 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1319-pymparticles.dts
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> 
> diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
> index ef8d8fcbaa05..ef569b8ebd13 100644
> --- a/arch/arm64/boot/dts/realtek/Makefile
> +++ b/arch/arm64/boot/dts/realtek/Makefile
> @@ -13,3 +13,5 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-bpi-m4.dtb
>  dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-lionskin.dtb
> 
>  dtb-$(CONFIG_ARCH_REALTEK) += rtd1619-mjolnir.dtb
> +
> +dtb-$(CONFIG_ARCH_REALTEK) += rtd1319-pymparticles.dtb
> diff --git a/arch/arm64/boot/dts/realtek/rtd1319-pymparticles.dts b/arch/arm64/boot/dts/realtek/rtd1319-pymparticles.dts
> new file mode 100644
> index 000000000000..6e46bf9ac252
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1319-pymparticles.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-3.0-or-later OR BSD-2-Clause)
> +/*
> + * Copyright (c) 2019-2020 Realtek Semiconductor Corp.
> + */
> +
> +/dts-v1/;
> +
> +#include "rtd13xx.dtsi"
> +
> +/ {
> +       compatible = "realtek,pym-particles", "realtek,rtd1319";
> +       model = "Realtek Pym Particles EVB";
> +
> +       memory@40000 {
> +               device_type = "memory";
> +               reg = <0x00040000 0x7ffc0000>; /* boot ROM to 1 GiB or 2 GiB */
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:460800n8";
> +       };
> +};
> +
> +/* debug console (J1) */
> +&uart0 {
> +       status = "okay";
> +};
> +

Drop stray blank lines. Same in second file.

> diff --git a/arch/arm64/boot/dts/realtek/rtd13xx.dtsi b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> new file mode 100644
> index 000000000000..59af2489e170
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD13xx SoC family
> + *
> + * Copyright (c) 2019-2020 Realtek Semiconductor Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       interrupt-parent = <&gic>;
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       reserved_memory: reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               protected_mem: protected_mem@40000 {

No underscores in node names.

> +                       reg = <0x00040000 0x1000000>;
> +                       no-map;
> +               };
> +
> +               rpc_comm: comm@4080000 {
> +                       reg = <0x04080000 0x1000>;
> +               };
> +
> +               rpc_ringbuf: ringbuf@40ff000 {
> +                       reg = <0x040ff000 0x4000>;
> +               };
> +
> +               audio_heap: audio_heap@4200000 {
> +                       reg = <0x04200000 0xc00000>;
> +               };
> +
> +               media_heap: media_heap@4e00000 {
> +                       reg = <0x04e00000 0x06000000>;
> +               };
> +
> +               audio_fw_mem: audio_fw_mem@10000000 {
> +                       reg = <0x10000000 0x14000>;
> +                       no-map;
> +               };
> +
> +               tee: tee@10100000 {
> +                       reg = <0x10100000 0x04100000>;
> +                       no-map;
> +               };
> +
> +               cma_resrved_0:linux,default_cma {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +                       compatible = "shared-dma-pool";
> +                       size = <0x02000000>;
> +                       alignment = <0x01000000>;
> +                       alloc-ranges=<0x00000000 0x80000000>;
> +                       linux,cma-default;
> +                       linux,contiguous-region;
> +                       reusable;
> +               };
> +
> +               cma_resrved_1:linux,cma_1 {
> +                       compatible = "shared-dma-pool";
> +                       size = <0x02000000>;
> +                       alloc-ranges=<0x14200000 0x0be00000>;
> +                       linux,contiguous-region;
> +                       reusable;
> +                       status = "disabled";
> +               };
> +
> +               cma_resrved_2:linux,cma_2 {
> +                       compatible = "shared-dma-pool";
> +                       size = <0x08000000>;
> +                       alloc-ranges=<0x00000000 0x60000000>;
> +                       linux,contiguous-region;
> +                       reusable;
> +               };
> +
> +               cma_resrved_3:linux,cma_3 {
> +                       compatible = "shared-dma-pool";
> +                       size = <0x10000000>;
> +                       alignment = <0x01000000>;
> +                       alloc-ranges=<0x00000000 0x80000000>;
> +                       linux,contiguous-region;
> +                       reusable;
> +               };
> +
> +               cma_resrved_4:linux,cma_4 {
> +                       compatible = "shared-dma-pool";
> +                       size = <0x02000000>;
> +                       alignment = <0x01000000>;
> +                       linux,contiguous-region;
> +                       reusable;
> +               };
> +
> +               cma_resrved_5:linux,cma_5 {
> +                       compatible = "shared-dma-pool";
> +                       size = <0x01000000>;
> +                       alignment = <0x01000000>;
> +                       alloc-ranges=<0x00000000 0x60000000>;
> +                       linux,contiguous-region;
> +                       reusable;
> +               };
> +
> +               cma_resrved_6:linux,cma_6 {
> +                       compatible = "shared-dma-pool";
> +                       size = <0x02000000>;
> +                       alignment = <0x01000000>;
> +                       alloc-ranges=<0x00000000 0x60000000>;
> +                       linux,contiguous-region;
> +                       reusable;
> +               };
> +
> +               cma_resrved_7:linux,cma_7 {
> +                       compatible = "shared-dma-pool";
> +                       size = <0x01000000>;
> +                       alignment = <0x01000000>;
> +                       alloc-ranges=<0x00000000 0x60000000>;
> +                       linux,contiguous-region;
> +                       reusable;
> +               };
> +
> +               cma_resrved_8:linux,cma_8 {
> +                       compatible = "shared-dma-pool";
> +                       size = <0x06000000>;
> +                       alignment = <0x01000000>;
> +                       alloc-ranges=<0x00000000 0x60000000>;
> +                       linux,contiguous-region;
> +                       reusable;
> +               };
> +
> +               cma_resrved_9:linux,cma_9 {
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +                       size = <0x04000000>;
> +                       alignment = <0x01000000>;
> +                       linux,contiguous-region;
> +                       alloc-ranges=<0x00000000 0x60000000>;
> +               };
> +       };
> +
> +       clocks {
> +               osc27m: osc {

Use consistent naming. If other is "-clk" this should be as well.

> +                       compatible = "fixed-clock";
> +                       clock-frequency = <27000000>;

Isn't this located on the board? Physically on the board?

> +                       clock-output-names = "osc27m";
> +                       #clock-cells = <0>;
> +               };
> +
> +               baudclk: baudclk {

baud-clk

> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <432000000>;
> +                       clock-output-names = "baudclk";
> +               };
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x0>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&l2>;
> +               };
> +
> +               cpu1: cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x100>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&l2>;
> +               };
> +
> +               cpu2: cpu@200 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x200>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&l2>;
> +               };
> +
> +               cpu3: cpu@300 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x300>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&l2>;
> +               };
> +
> +               l2: l2-cache {
> +                       compatible = "cache";
> +               };
> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +                            <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +                            <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +                            <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       arm_pmu: pmu {
> +               compatible = "arm,armv8-pmuv3";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +               interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +       };
> +
> +       psci: psci {
> +               compatible = "arm,psci-1.0";
> +               method = "smc";
> +       };
> +
> +       firmware {
> +               optee {
> +                       compatible = "linaro,optee-tz";
> +                       method = "smc";
> +               };
> +       };
> +
> +       soc@0 {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0x00000000 0x00000000 0x0002e000>, /* boot ROM */
> +                        <0x00030000 0x00030000 0x00030000>, /* PCIE IO*/
> +                        <0xff100000 0xff100000 0x00200000>, /* GIC */
> +                        <0xC0000000 0xC0000000 0x00100000>,
> +                        <0xC1000000 0xC1000000 0x00100000>,
> +                        <0x98000000 0x98000000 0x00200000>; /* rbus */
> +
> +               rbus: rbus@98000000 {
> +                       compatible = "simple-bus";
> +                       reg = <0x98000000 0x200000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0x00000000 0x98000000 0x200000>,
> +                                <0xC0000000 0xC0000000 0x00100000>,
> +                                <0xC1000000 0xC1000000 0x00100000>,
> +                                <0x10030000 0x00030000 0x00030000>; /* PCIE IO*/
> +
> +                       crt: syscon@0 {
> +                               compatible = "syscon", "simple-mfd";

These are not allowed on their own. Your patchset is really not tested
against bindings.

> +                               reg = <0x0 0x1000>;
> +                               reg-io-width = <4>;
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               ranges = <0x0 0x0 0x1000>;
> +                       };
> +
> +                       pinctrl: pinctrl@4e000 {
> +                               compatible = "syscon";

syscon as pinctrl? Nope.

> +                               reg = <0x4e000 0x130>;
> +                               reg-io-width = <4>;
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;

??

> +                               #gpio-range-cells = <3>;
> +                               ranges = <0x0 0x4e000 0x130>;
> +                       };
> +
> +                       iso: syscon@7000 {
> +                               compatible = "syscon", "simple-mfd";

NAK

> +                               reg = <0x7000 0x1000>;
> +                               reg-io-width = <4>;
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;

NAK even more, you do not have children.

> +                               ranges = <0x0 0x7000 0x1000>;
> +                       };
> +
> +                       sb2: syscon@1a000 {
> +                               compatible = "syscon", "simple-mfd";

So your entire SoC is just bunch of syscons and interrupt controller.
That's not suitable for upstream at all. Define a real hardware and a
real DTS.


Best regards,
Krzysztof

