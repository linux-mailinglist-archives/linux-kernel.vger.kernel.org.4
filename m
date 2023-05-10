Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AD6FD771
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjEJGxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbjEJGxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:53:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78F2711;
        Tue,  9 May 2023 23:52:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0FCA9547;
        Wed, 10 May 2023 08:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683701570;
        bh=OA5IMvg27+YNKH6wENecm9zZzWr2YKDiGkZuvnB4baQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHUEpXC/e78k9beO8Xr8cEnMVLr/gDRVuEi2ZmPXynTd4hpVrxygYM624NEc7Lck3
         JoHhe1RQEOPKBuJ+G1x/pwlyJd0jNigOzlzJb7uKJWVQG/ToHjPP/DFlEIER+cxKAw
         f6glFuIn6CMxSWUNjJHiTfuSwsZD3QkyVRuql4T4=
Date:   Wed, 10 May 2023 09:52:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/23] arm64: zynqmp: Describe TI phy as ethernet-phy-id
Message-ID: <20230510065253.GA11711@pendragon.ideasonboard.com>
References: <cover.1683034376.git.michal.simek@amd.com>
 <9eefc40c727928e0c7b794a3a2e061ecf6ea230c.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9eefc40c727928e0c7b794a3a2e061ecf6ea230c.1683034376.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Tue, May 02, 2023 at 03:35:29PM +0200, Michal Simek wrote:
> TI DP83867 is using strapping based on MIO pins. Tristate setup can influce
> PHY address. That's why switch description with ethernet-phy-id compatible
> string which enable calling reset. PHY itself setups phy address after
> power up or reset.

I'm sorry but I don't understand this :-(

> Phy reset is done via gpio.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Checkpatch is reporting issue
> warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented
> but it should be fully aligned with
> Documentation/devicetree/bindings/net/ethernet-phy.yaml
> ---
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 23 +++++++++++------
>  .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    | 25 +++++++++++--------
>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 22 ++++++++++------
>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 22 ++++++++++------
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 ++++++++++------
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 22 ++++++++++------
>  6 files changed, 90 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 13c43324f1d2..c193579400cf 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU102 RevA
>   *
> - * (C) Copyright 2015 - 2021, Xilinx, Inc.
> + * (C) Copyright 2015 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -200,13 +201,19 @@ &gem3 {
>  	phy-mode = "rgmii-id";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@21 {
> -		reg = <21>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> -		/* reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>; */
> +	mdio: mdio {

The "mdio" label isn't needed. Same below.

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@21 {
> +			#phy-cells = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <21>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> index f7d718ff116b..00b930f20718 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU102 RevB
>   *
> - * (C) Copyright 2016 - 2021, Xilinx, Inc.
> + * (C) Copyright 2016 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -16,16 +17,20 @@ / {
>  
>  &gem3 {
>  	phy-handle = <&phyc>;
> -	phyc: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> -		/* reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>; */
> +	mdio: mdio {
> +		phyc: ethernet-phy@c {
> +			#phy-cells = <0x1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <0xc>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
> +		/* Cleanup from RevA */
> +		/delete-node/ ethernet-phy@21;
>  	};
> -	/* Cleanup from RevA */
> -	/delete-node/ ethernet-phy@21;
>  };
>  
>  /* Fix collision with u61 */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 485585c491f4..11c1eaef9f53 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU104
>   *
> - * (C) Copyright 2017 - 2021, Xilinx, Inc.
> + * (C) Copyright 2017 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -109,12 +110,19 @@ &gem3 {
>  	phy-mode = "rgmii-id";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@c {
> +			#phy-cells = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <0xc>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 44ec9edd2452..c06c138fa3e5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU104
>   *
> - * (C) Copyright 2017 - 2021, Xilinx, Inc.
> + * (C) Copyright 2017 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -114,12 +115,19 @@ &gem3 {
>  	phy-mode = "rgmii-id";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@c {
> +			#phy-cells = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <0xc>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 09773b7200f8..52cdec33f190 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU106
>   *
> - * (C) Copyright 2016 - 2021, Xilinx, Inc.
> + * (C) Copyright 2016 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -212,12 +213,19 @@ &gem3 {
>  	phy-mode = "rgmii-id";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@c {
> +			#phy-cells = <1>;
> +			reg = <0xc>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index e0305dcbb010..699cc9ce7898 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU111
>   *
> - * (C) Copyright 2017 - 2021, Xilinx, Inc.
> + * (C) Copyright 2017 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -172,12 +173,19 @@ &gem3 {
>  	phy-mode = "rgmii-id";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gem3_default>;
> -	phy0: ethernet-phy@c {
> -		reg = <0xc>;
> -		ti,rx-internal-delay = <0x8>;
> -		ti,tx-internal-delay = <0xa>;
> -		ti,fifo-depth = <0x1>;
> -		ti,dp83867-rxctrl-strap-quirk;
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		phy0: ethernet-phy@c {
> +			#phy-cells = <1>;
> +			compatible = "ethernet-phy-id2000.a231";
> +			reg = <0xc>;
> +			ti,rx-internal-delay = <0x8>;
> +			ti,tx-internal-delay = <0xa>;
> +			ti,fifo-depth = <0x1>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			reset-gpios = <&tca6416_u22 6 GPIO_ACTIVE_LOW>;
> +		};
>  	};
>  };
>  

-- 
Regards,

Laurent Pinchart
