Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA2654243
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiLVOBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiLVOBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:01:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69380E03E;
        Thu, 22 Dec 2022 06:01:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CBC2B81D61;
        Thu, 22 Dec 2022 14:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB8FC433F0;
        Thu, 22 Dec 2022 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671717665;
        bh=9W4DMIktV9wOqRKH4YYw4WT/SWQbRbPoXOqm82vucUE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lbKbbvOc7Dt/TGiJmMSbe8HWrzqafnohDwNLbSQvcX5O7YpTUNciD+qt09v73OKuW
         IENYZma6VGJwJws24sPpOubRvbWMifmhnaoklBN+HpeAJ1OF4Y4AGVzbbFhr7Rjt+Y
         uniwF5BYyAiG7SMOQ15flJzSt7wVlN5cLthFFSw4qzMRbP0+BrzhkFJ8ypXIHLsALi
         EXo436Nqx8DquvzbD6iiTz74HQegYehQsKIcCNehHBde3AskcUMUGgytMVpd2hVDez
         KcSCDjqjwadrcljlUac/HZcpAZj9B24VYFveW++EFuWdhYPciqOEWPsviyZ7JH12+k
         +l0AK36+PNejw==
Message-ID: <c7baec50-c838-d8fe-d09a-93ee445de045@kernel.org>
Date:   Thu, 22 Dec 2022 15:01:01 +0100
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

Use subject prefixes matching the subsystem (git log --oneline -- ...).


You got this comment already and you did not follow it.
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

Wrong order. v is not before c.


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

Second ignored comment. I'll stop review.


This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

