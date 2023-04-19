Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22C96E7A61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjDSNOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjDSNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:14:20 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4559D5;
        Wed, 19 Apr 2023 06:14:18 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 43A745FD04;
        Wed, 19 Apr 2023 16:14:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681910057;
        bh=bZtyAsLkB2jeh9skRuWUvaXRtmeFq3JKcKGoxbvsU7Y=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=oGkpHcUxBwp4MIgweRK2GZMqWGevOFOXJdE4voWUZD4KvqcXwuA0Hj13FU9zhGe0n
         kqwUJqLv7rzrWeXdN72CFx4MI+/mY0D1cujDVW4rkR15BpVWIe97k0hW6NxPzH6lCN
         gas64HTcuG2ucyi3ysKZTIa3qYX/icleE3U0s2qy5lZNx/+71FFlOQ9ZxRUsKqRP+f
         k8SPGwZcXzD4lhUulTpnyYJnCnxHaHq0xYEfeUJbgW8+tm5odba7yxJhZ3WMa+maIX
         CpH5IrvyhwCnsTRKwX2cvaEgewSVJkaB1fx1oEVfRo8UBkW6cIGD5GeKd0ebklKd7e
         l7DPvdmLwlPjA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 19 Apr 2023 16:14:17 +0300 (MSK)
Date:   Wed, 19 Apr 2023 16:14:16 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     =Xianwei Zhao <xianwei.zhao@amlogic.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
Message-ID: <20230419131416.cns3xvkbzjeyrnux@CAB-WSD-L081021>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-2-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230419073834.972273-2-xianwei.zhao@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/19 10:42:00 #21127526
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 03:38:33PM +0800, =Xianwei Zhao wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> The C series SoCs are designed for smart IP camera
> applications, which does not belong to Meson series.
> So, Add ARCH_AMLIPC for the new series.
> 
> There are now multiple amlogic SoC seies supported, so group them under
> their own menu. we can easily add new platforms there in the future.
> Introduce ARCH_AMLOGIC to cover all Amlogic SoC series.
> 
> No functional changes introduced.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  arch/arm64/Kconfig.platforms | 12 ++++++++++++
>  arch/arm64/configs/defconfig |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 89a0b13b058d..bfbc817eef8f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -162,12 +162,24 @@ config ARCH_MEDIATEK
>  	  This enables support for MediaTek MT27xx, MT65xx, MT76xx
>  	  & MT81xx ARMv8 SoCs
>  
> +menuconfig ARCH_AMLOGIC
> +	bool "NXP SoC support"

NXP? Did you mean "Amlogic"?

> +
> +if ARCH_AMLOGIC
> +
>  config ARCH_MESON
>  	bool "Amlogic Platforms"
>  	help
>  	  This enables support for the arm64 based Amlogic SoCs
>  	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
>  
> +config ARCH_AMLIPC

Do we really need a different ARCH for Amlogic IPC?
I can imagine that it's not the Meson architecture at all.
But maybe a better solution is just to rename ARCH_MESON to ARCH_AMLOGIC?

> +	bool "Amlogic IPC Platforms"
> +	help
> +	  This enables support for the arm64 based Amlogic IPC SoCs
> +	  such as the C302X, C308L
> +endif
> +
>  config ARCH_MVEBU
>  	bool "Marvell EBU SoC Family"
>  	select ARMADA_AP806_SYSCON
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7790ee42c68a..f231bd1723fd 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -46,7 +46,9 @@ CONFIG_ARCH_LG1K=y
>  CONFIG_ARCH_HISI=y
>  CONFIG_ARCH_KEEMBAY=y
>  CONFIG_ARCH_MEDIATEK=y
> +CONFIG_ARCH_AMLOGIC=y
>  CONFIG_ARCH_MESON=y
> +CONFIG_ARCH_AMLIPC=y
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_ARCH_NXP=y
>  CONFIG_ARCH_LAYERSCAPE=y
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
