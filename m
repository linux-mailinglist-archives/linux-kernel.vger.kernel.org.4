Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6D05B2E64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIIGAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIIF77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:59:59 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1D3A17C;
        Thu,  8 Sep 2022 22:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662703197; x=1694239197;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUTNp7tl9jBH5gO6p63V0NMyQAOZJ1ygWfraWfAJrNc=;
  b=ccnlhaOvXpy3BdYkE6kwGoIcdETjfT4NmgzvmVQrovOzeQT3f24hXqb4
   O5Hm63SnR7OOHPWB+IaqIg9oKflS0fScvjxJmgEzZuD9l7HOfAQDmGBhg
   m9obkz0SSDhTc+hvWdJxORDsPwzrUV/hj0iM73jxLwTZeojh7/UQWjtvf
   aE50L2bGez4oQzBwNJ/ZsW6wQiCd6zpYiBP9/9i7dehcGCJ71mru3YbXV
   o3/lTdpzD1qFc7zPkUi5lDY4XAhiwk2fExZ5IHtH2mk9hvRMFM9rDbXWQ
   S+gX3lJVw0aEWP92GsRqV3gSCJ2JvOneb4jdZneqeTQetQPFeHlBUmkIs
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,302,1654552800"; 
   d="scan'208";a="26081637"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Sep 2022 07:59:54 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 09 Sep 2022 07:59:54 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 09 Sep 2022 07:59:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662703194; x=1694239194;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=TUTNp7tl9jBH5gO6p63V0NMyQAOZJ1ygWfraWfAJrNc=;
  b=AxeWm9HI5bnejNpj7Z7edWKWGzR0EVA6/0v1TRV/yqJqfOc8RqK/xJKK
   j4I32uEkLFqFDO0e/MSnqZrct4idEozUIvP/xEW4sW6AxmAS5RY6XTd9b
   RYLJ4RsPGyzYlj3w3dUG4m7Fh9lKTLezdhSWg31sehyJndFDiNFQrMFHr
   92BTBGsRl1cV1hxfKI2Gj6slmdjuqQOM0jpbgMCR2/Q5+F3HZBw/plH9G
   kRAj2L7KvgADOI9LMmpxg6Lyq+trbLt9vI1GdTVccU77S3uYbt+ZNN4o3
   CNqqD2DzfGV2Cfz2DflhwOxgFz+ZUi0Qw2O6XGzk3fzgKt+f9fsnPcCs8
   A==;
X-IronPort-AV: E=Sophos;i="5.93,302,1654552800"; 
   d="scan'208";a="26081636"
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: add PCIe support
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Sep 2022 07:59:54 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5695B280056;
        Fri,  9 Sep 2022 07:59:54 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 09 Sep 2022 07:59:52 +0200
Message-ID: <2530681.Lt9SDvczpP@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220908154903.4100386-1-tharvey@gateworks.com>
References: <20220908154903.4100386-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Am Donnerstag, 8. September 2022, 17:49:03 CEST schrieb Tim Harvey:
> Add PCIe support on the Gateworks GW74xx board. While at it,
> fix the related gpio line names from the previous incorrect values.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../dts/freescale/imx8mp-venice-gw74xx.dts    | 40 +++++++++++++++++--
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts index
> e0fe356b662d..7644db61d631 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> 
>  #include "imx8mp.dtsi"
> 
> @@ -100,6 +101,12 @@ led-1 {
>  		};
>  	};
> 
> +	pcie0_refclk: pcie0-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
>  	pps {
>  		compatible = "pps-gpio";
>  		pinctrl-names = "default";
> @@ -215,8 +222,8 @@ &gpio1 {
>  &gpio2 {
>  	gpio-line-names =
>  		"", "", "", "", "", "", "", "",
> -		"", "", "", "", "", "", "", "",
> -		"pcie3_wdis#", "", "", "pcie1_wdis@", "pcie2_wdis#", "", 
"", "",
> +		"", "", "", "", "", "", "pcie3_wdis#", "",
> +		"", "", "pcie2_wdis#", "", "", "", "", "",
>  		"", "", "", "", "", "", "", "";
>  };
> 
> @@ -562,6 +569,28 @@ &i2c4 {
>  	status = "okay";
>  };
> 
> +&pcie_phy {
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +	fsl,clkreq-unsupported;
> +	clocks = <&pcie0_refclk>;
> +	clock-names = "ref";
> +	status = "okay";
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	reset-gpio = <&gpio2 17 GPIO_ACTIVE_LOW>;
> +	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
> +		 <&clk IMX8MP_CLK_PCIE_ROOT>,
> +		 <&clk IMX8MP_CLK_HSIO_AXI>;
> +	clock-names = "pcie", "pcie_aux", "pcie_bus";

With the still pending dt-binding patch at [1] the clock order shall be
"pcie", "pcie_bus", "pcie_phy".

Best regards,
Alexander

[1] https://lore.kernel.org/lkml/20220822184701.25246-2-Sergey.Semin@baikalelectronics.ru/

> +	assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
> +	assigned-clock-rates = <10000000>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
> +	status = "okay";
> +};
> +
>  /* GPS / off-board header */
>  &uart1 {
>  	pinctrl-names = "default";
> @@ -694,7 +723,6 @@ pinctrl_hog: hoggrp {
>  			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09	
0x40000040 /* DIO0 */
>  			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	
0x40000040 /* DIO1 */
>  			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0x40000040 /
* M2SKT_OFF# */
> -			MX8MP_IOMUXC_SD2_DATA2__GPIO2_IO17	
0x40000150 /* PCIE1_WDIS# */
>  			MX8MP_IOMUXC_SD2_DATA3__GPIO2_IO18	
0x40000150 /* PCIE2_WDIS# */
>  			MX8MP_IOMUXC_SD2_CMD__GPIO2_IO14	0x40000150 /
* PCIE3_WDIS# */
>  			MX8MP_IOMUXC_NAND_DATA00__GPIO3_IO06	
0x40000040 /* M2SKT_RST# */
> @@ -807,6 +835,12 @@ MX8MP_IOMUXC_SD2_DATA1__GPIO2_IO16	0x10
> 
>  		>;
> 
>  	};
> 
> +	pinctrl_pcie0: pciegrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_DATA2__GPIO2_IO17	
0x110
> +		>;
> +	};
> +
>  	pinctrl_pmic: pmicgrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07	
0x140




