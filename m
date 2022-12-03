Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D686411DF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiLCARO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLCARM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:17:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF059E5A9C;
        Fri,  2 Dec 2022 16:17:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6867A23A;
        Fri,  2 Dec 2022 16:17:18 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF5B93F73B;
        Fri,  2 Dec 2022 16:17:09 -0800 (PST)
Date:   Sat, 3 Dec 2022 00:15:32 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/5] clk: sunxi-ng: d1: Allow building for R528/T113
Message-ID: <20221203001237.51813f71@slackpad.lan>
In-Reply-To: <20221126191319.6404-4-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org>
        <20221126191319.6404-4-samuel@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2022 13:13:17 -0600
Samuel Holland <samuel@sholland.org> wrote:

> Allwinner released some 32-bit ARM (sun8i) SoCs which use the same CCU
> as D1. Allow them to reuse the driver.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Indeed, the clocks are compatible, work (given the next patch) and are
needed on a MangoPi-MQ-R board.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
>  drivers/clk/sunxi-ng/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 78deee2996ce..b547198a2c65 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -13,14 +13,14 @@ config SUNIV_F1C100S_CCU
>  	depends on MACH_SUNIV || COMPILE_TEST
>  
>  config SUN20I_D1_CCU
> -	tristate "Support for the Allwinner D1 CCU"
> +	tristate "Support for the Allwinner D1/R528/T113 CCU"
>  	default y
> -	depends on RISCV || COMPILE_TEST
> +	depends on MACH_SUN8I || RISCV || COMPILE_TEST
>  
>  config SUN20I_D1_R_CCU
> -	tristate "Support for the Allwinner D1 PRCM CCU"
> +	tristate "Support for the Allwinner D1/R528/T113 PRCM CCU"
>  	default y
> -	depends on RISCV || COMPILE_TEST
> +	depends on MACH_SUN8I || RISCV || COMPILE_TEST
>  
>  config SUN50I_A64_CCU
>  	tristate "Support for the Allwinner A64 CCU"

