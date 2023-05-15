Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF108703305
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbjEOQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbjEOQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:32:20 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CC199
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:32:18 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FGVmYO054911;
        Mon, 15 May 2023 11:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684168308;
        bh=RFkJBq8JGAaW8auA8QkIsfGBdt7C6TJA6FPA/7/+Jcc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=y2GjJX+6gCsilco40EyyumPC0syDjnhUs1oSHDX2c1AKANzfa/3Myxl+z/VFnb5nb
         NMPAm0ZFnmT1J3kXs6UicacDew01clh6JjiuE/361avcoqfsL9aW5Zo0MZ3REHdAHP
         8TEeyotTjOh/9wZ3IX9ZXbMNzAVf0541LT55tDLQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FGVmKY008199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 11:31:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 11:31:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 11:31:47 -0500
Received: from [10.250.35.77] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FGVlj1088299;
        Mon, 15 May 2023 11:31:47 -0500
Message-ID: <bb8cc8b2-8b59-8d25-da58-36cd2df92a71@ti.com>
Date:   Mon, 15 May 2023 11:31:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 01/10] ARM: Kconfig: move platform selection into its own
 Kconfig file
Content-Language: en-US
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230515160234.289631-1-afd@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230515160234.289631-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 9:02 AM, Andrew Davis wrote:
> Mostly just for better organization for now. This matches what is done on
> some other platforms including ARM64. This also lets us start to reduce
> the number of mach- directories that only exist to store the platform
> selection.
> 
> Start with "Platform selection" and ARCH_VIRT.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Oh, forgot to tag it but this is v2 posting of this series. No changes
from v1, just rebased on v6.4-rc2.

Andrew

>   arch/arm/Kconfig           | 67 +------------------------------------
>   arch/arm/Kconfig.platforms | 68 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+), 66 deletions(-)
>   create mode 100644 arch/arm/Kconfig.platforms
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0fb4b218f665..23e3e344f9c0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -336,72 +336,7 @@ config ARCH_MULTIPLATFORM
>   	  Selecting N here allows using those options, including
>   	  DEBUG_UNCOMPRESS, XIP_KERNEL and ZBOOT_ROM. If unsure, say Y.
>   
> -menu "Platform selection"
> -	depends on MMU
> -
> -comment "CPU Core family selection"
> -
> -config ARCH_MULTI_V4
> -	bool "ARMv4 based platforms (FA526, StrongARM)"
> -	depends on !ARCH_MULTI_V6_V7
> -	# https://github.com/llvm/llvm-project/issues/50764
> -	depends on !LD_IS_LLD || LLD_VERSION >= 160000
> -	select ARCH_MULTI_V4_V5
> -	select CPU_FA526 if !(CPU_SA110 || CPU_SA1100)
> -
> -config ARCH_MULTI_V4T
> -	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
> -	depends on !ARCH_MULTI_V6_V7
> -	# https://github.com/llvm/llvm-project/issues/50764
> -	depends on !LD_IS_LLD || LLD_VERSION >= 160000
> -	select ARCH_MULTI_V4_V5
> -	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
> -		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
> -		CPU_ARM925T || CPU_ARM940T)
> -
> -config ARCH_MULTI_V5
> -	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
> -	depends on !ARCH_MULTI_V6_V7
> -	select ARCH_MULTI_V4_V5
> -	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
> -		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
> -		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
> -
> -config ARCH_MULTI_V4_V5
> -	bool
> -
> -config ARCH_MULTI_V6
> -	bool "ARMv6 based platforms (ARM11)"
> -	select ARCH_MULTI_V6_V7
> -	select CPU_V6K
> -
> -config ARCH_MULTI_V7
> -	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
> -	default y
> -	select ARCH_MULTI_V6_V7
> -	select CPU_V7
> -	select HAVE_SMP
> -
> -config ARCH_MULTI_V6_V7
> -	bool
> -	select MIGHT_HAVE_CACHE_L2X0
> -
> -config ARCH_MULTI_CPU_AUTO
> -	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
> -	select ARCH_MULTI_V5
> -
> -endmenu
> -
> -config ARCH_VIRT
> -	bool "Dummy Virtual Machine"
> -	depends on ARCH_MULTI_V7
> -	select ARM_AMBA
> -	select ARM_GIC
> -	select ARM_GIC_V2M if PCI
> -	select ARM_GIC_V3
> -	select ARM_GIC_V3_ITS if PCI
> -	select ARM_PSCI
> -	select HAVE_ARM_ARCH_TIMER
> +source "arch/arm/Kconfig.platforms"
>   
>   config ARCH_AIROHA
>   	bool "Airoha SoC Support"
> diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
> new file mode 100644
> index 000000000000..ed1f6da11e24
> --- /dev/null
> +++ b/arch/arm/Kconfig.platforms
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Platform selection"
> +	depends on MMU
> +
> +comment "CPU Core family selection"
> +
> +config ARCH_MULTI_V4
> +	bool "ARMv4 based platforms (FA526, StrongARM)"
> +	depends on !ARCH_MULTI_V6_V7
> +	# https://github.com/llvm/llvm-project/issues/50764
> +	depends on !LD_IS_LLD || LLD_VERSION >= 160000
> +	select ARCH_MULTI_V4_V5
> +	select CPU_FA526 if !(CPU_SA110 || CPU_SA1100)
> +
> +config ARCH_MULTI_V4T
> +	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
> +	depends on !ARCH_MULTI_V6_V7
> +	# https://github.com/llvm/llvm-project/issues/50764
> +	depends on !LD_IS_LLD || LLD_VERSION >= 160000
> +	select ARCH_MULTI_V4_V5
> +	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
> +		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
> +		CPU_ARM925T || CPU_ARM940T)
> +
> +config ARCH_MULTI_V5
> +	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
> +	depends on !ARCH_MULTI_V6_V7
> +	select ARCH_MULTI_V4_V5
> +	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
> +		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
> +		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
> +
> +config ARCH_MULTI_V4_V5
> +	bool
> +
> +config ARCH_MULTI_V6
> +	bool "ARMv6 based platforms (ARM11)"
> +	select ARCH_MULTI_V6_V7
> +	select CPU_V6K
> +
> +config ARCH_MULTI_V7
> +	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
> +	default y
> +	select ARCH_MULTI_V6_V7
> +	select CPU_V7
> +	select HAVE_SMP
> +
> +config ARCH_MULTI_V6_V7
> +	bool
> +	select MIGHT_HAVE_CACHE_L2X0
> +
> +config ARCH_MULTI_CPU_AUTO
> +	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
> +	select ARCH_MULTI_V5
> +
> +endmenu
> +
> +config ARCH_VIRT
> +	bool "Dummy Virtual Machine"
> +	depends on ARCH_MULTI_V7
> +	select ARM_AMBA
> +	select ARM_GIC
> +	select ARM_GIC_V2M if PCI
> +	select ARM_GIC_V3
> +	select ARM_GIC_V3_ITS if PCI
> +	select ARM_PSCI
> +	select HAVE_ARM_ARCH_TIMER
