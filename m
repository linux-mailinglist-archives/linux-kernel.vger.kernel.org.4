Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51416BC3EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCPCna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCPCn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:43:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931CCC67E;
        Wed, 15 Mar 2023 19:43:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3668BB81F15;
        Thu, 16 Mar 2023 02:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1B3C433EF;
        Thu, 16 Mar 2023 02:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678934603;
        bh=hlf59lgFe76U502P48CKYTS/zJCgM/jPmrLWB70347s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3h7PIgyfgeNyElhabHNoEYlOYoRLcMGVW+nFXb3XktUszGLs6stUnfws0GyV/k1N
         UmOQlmR/nlHeVrbU95zC49L3XdRGVLmDZ+xduhH4fTVtX2s3GvUhVCMAkOUGWp3fBW
         s0M/8wgrQw5JDRbc9eSe4E3RPeDpdFxoGgpRhYa7fr5RJqNqlxP/SFe28k20BuPCP2
         /kS2a9zVNsWXoy/1dIUJoIAADICebGUPDqpvyOQkIVnDSHVOci2my3f3a5GGI98gN5
         CTI8CiAQfgzvvsg4vo7iXH3VGrAMOhriM8KbSHD4BrhncHESVihfCWhnaL0JbczoTV
         sfW5x3/MF2bsg==
Date:   Thu, 16 Mar 2023 10:43:05 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 5/5] dts: usb: add StarFive JH7110 USB dts
 configuration.
Message-ID: <20230316024305.GA2322573@nchen-desktop>
References: <20230315104411.73614-1-minda.chen@starfivetech.com>
 <20230315104411.73614-6-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315104411.73614-6-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-15 18:44:11, Minda Chen wrote:
> USB Glue layer and Cadence USB subnode configuration,
> also includes USB and PCIe phy dts configuration.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         |  7 +++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 54 +++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index a132debb9b53..c64476aebc1a 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -236,3 +236,10 @@
>  	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";
>  };
> +
> +&usb0 {
> +	status = "okay";
> +	usbdrd_cdns3: usb@0 {
> +		dr_mode = "peripheral";
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index f70a4ed47eb4..17722fd1be62 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -362,6 +362,60 @@
>  			status = "disabled";
>  		};
>  
> +		usb0: usb@10100000 {
> +			compatible = "starfive,jh7110-usb";
> +			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
> +				 <&stgcrg JH7110_STGCLK_USB0_STB>,
> +				 <&stgcrg JH7110_STGCLK_USB0_APB>,
> +				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
> +				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
> +			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
> +			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
> +				 <&stgcrg JH7110_STGRST_USB0_APB>,
> +				 <&stgcrg JH7110_STGRST_USB0_AXI>,
> +				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
> +			starfive,stg-syscon = <&stg_syscon 0x4 0xc4 0x148 0x1f4>;
> +			starfive,sys-syscon = <&sys_syscon 0x18>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x10100000 0x100000>;

Why it is four entry at ranges? Your address-cells and size-cells are
both 1, and your binding-doc is also three?

Peter
> +
> +			usbdrd_cdns3: usb@0 {
> +				compatible = "cdns,usb3";
> +				reg = <0x0 0x10000>,
> +				      <0x10000 0x10000>,
> +				      <0x20000 0x10000>;
> +				reg-names = "otg", "xhci", "dev";
> +				interrupts = <100>, <108>, <110>;
> +				interrupt-names = "host", "peripheral", "otg";
> +				phys = <&usbphy0>;
> +				phy-names = "cdns3,usb2-phy";
> +				maximum-speed = "super-speed";
> +			};
> +		};
> +
> +		usbphy0: phy@10200000 {
> +			compatible = "starfive,jh7110-usb-phy";
> +			reg = <0x0 0x10200000 0x0 0x10000>;
> +			clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
> +				 <&stgcrg JH7110_STGCLK_USB0_APP_125>;
> +			clock-names = "125m", "app_125";
> +			#phy-cells = <0>;
> +		};
> +
> +		pciephy0: phy@10210000 {
> +			compatible = "starfive,jh7110-pcie-phy";
> +			reg = <0x0 0x10210000 0x0 0x10000>;
> +			#phy-cells = <0>;
> +		};
> +
> +		pciephy1: phy@10220000 {
> +			compatible = "starfive,jh7110-pcie-phy";
> +			reg = <0x0 0x10220000 0x0 0x10000>;
> +			#phy-cells = <0>;
> +		};
> +
>  		stgcrg: clock-controller@10230000 {
>  			compatible = "starfive,jh7110-stgcrg";
>  			reg = <0x0 0x10230000 0x0 0x10000>;
> -- 
> 2.17.1
> 

-- 

Thanks,
Peter Chen
