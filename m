Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E6C654D71
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiLWI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:27:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24735783;
        Fri, 23 Dec 2022 00:27:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C1034CE19AA;
        Fri, 23 Dec 2022 08:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708DCC433EF;
        Fri, 23 Dec 2022 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671784019;
        bh=S/h2/jz6BvSyXxWapChHGU15QNpEWrYlgU5djKg/2Zg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zt9r9Im+gL7T0VXp+ERzWAuFRBDdlKareGSeeR/DgbaxWnv6Op1DgQ01aj8kHLoCL
         LaASiEQ1B3PFLAh7ztfa1ETi83GZSKo7Bx6DZbWtw0+lwUWo+FKzfe/uoKxjIaW6x8
         3lhDVuOC0SxCyLce2CfKhYbc40MQHRH6yKKTcjCsXsYbJKOYjQp4NTJEziQCuzs35a
         Nut/hgvL0KrkmAUM/Q1qH+bZAgWOXjJlVGt80DD4HYfKVC2uaTcGtJtqApLzBq+2G+
         6XcddpJ8YTC8w3EoqpQidOZzkzFxe1U3/6XtHNLZOCpQWthU70DvEClpaELUaOY0qi
         NxlT3hBt5Fh/g==
Message-ID: <36611392-5bdd-4f08-6748-d36c6ffcd470@kernel.org>
Date:   Fri, 23 Dec 2022 09:26:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/2] arm: dts: arm: add arm corstone500 device tree
Content-Language: en-US
To:     Emekcan Aras <emekcan.aras@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222123244.147238-1-emekcan.aras@arm.com>
 <20221222123244.147238-2-emekcan.aras@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221222123244.147238-2-emekcan.aras@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 13:32, Emekcan Aras wrote:
> Corstone500[0] is a platform from arm, which includes Cortex-A cores and
> ideal starting point for feature rich System on Chip (SoC) designs
> based on the Cortex-A5 core.
> 
> These device trees contains the necessary bits to support the
> Corstone 500 FVP (Fixed Virtual Platform) and the
> FPGA MPS3 board.
> 
> 0: https://developer.arm.com/documentation/102262/0000
> 
> Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
> ---
>  arch/arm/boot/dts/Makefile        |   3 +-
>  arch/arm/boot/dts/corstone500.dts | 182 ++++++++++++++++++++++++++++++
>  2 files changed, 184 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/corstone500.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 6aa7dc4db2fc..4dc4df0707dc 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1465,7 +1465,8 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += \
>  	vexpress-v2p-ca5s.dtb \
>  	vexpress-v2p-ca9.dtb \
>  	vexpress-v2p-ca15-tc1.dtb \
> -	vexpress-v2p-ca15_a7.dtb
> +	vexpress-v2p-ca15_a7.dtb \
> +	corstone500.dtb

Why this is vexpress platform? If it is true, then add it to vexpress
bindings... It's confusingi and looks disorganized - some bindings here,
some platform there. Who is overseeing it? Who is maintaining? Who keeps
it consistent with other Arm platforms?

>  dtb-$(CONFIG_ARCH_VIRT) += \
>  	xenvm-4.2.dtb
>  dtb-$(CONFIG_ARCH_VT8500) += \
> diff --git a/arch/arm/boot/dts/corstone500.dts b/arch/arm/boot/dts/corstone500.dts
> new file mode 100644
> index 000000000000..bcca7d736c85
> --- /dev/null
> +++ b/arch/arm/boot/dts/corstone500.dts
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +/*
> + * Copyright (c) 2022, Arm Limited. All rights reserved.
> + *
> + */
> +
> +

kbuild reports that patch does not build. :(

Except that other topics which you did not solve from previous case:
1. Missing maintainers entry
2. One binding file for your Corstone platforms, not for each of it.
3. failing `dtbs_check` (at least failing due to non-compiling DTS).
4. Subject prefix not matching other arm platforms.


Best regards,
Krzysztof

