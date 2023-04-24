Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557C16ED0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjDXOxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjDXOxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7B26580;
        Mon, 24 Apr 2023 07:53:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF98C613E9;
        Mon, 24 Apr 2023 14:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B466DC433EF;
        Mon, 24 Apr 2023 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682348007;
        bh=9CwJJUrhNP6wOsORyqwvzaE9qMKm02sq+6yuG+Ev91U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TBFPs1eWvgDreKyP2z4H6q2ZZgTj7aEde/gln69W0CfM1jNYwm2ZOwXv2yaa6XSZL
         ztShbHl41Mc4mpHTmfQu2bddwtSgvi5v4WdqtnWbnTo0ps12xIf1Xcdpe4Yq6mxI2U
         Yn+El8B1UF43LNtRukJgvLHEi9vqyaGHCHbS9mR2UbwCoT9TBC50+0et1CttRAW/3V
         xeYYEAoBZd3upWJ/U4xW5tiDzxA18r2RFlLxw1yew0gVPMBJ/LwAGhU2ZQcRQWCG1k
         hb2WvoqBSq/pfAfIRHr5Fb9NdhMvH/52K3owwrVA78IjFCjAnpzm3H02CBPH5duf2c
         L+osQEwIwu17Q==
Message-ID: <3f2baded-c5d6-7d94-00f3-6d8fb24262c4@kernel.org>
Date:   Mon, 24 Apr 2023 17:53:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 7/7] riscv: dts: starfive: Add USB dts configuration
 for JH7110
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
 <20230420110052.3182-8-minda.chen@starfivetech.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230420110052.3182-8-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/04/2023 14:00, Minda Chen wrote:
> Add USB wrapper layer and Cadence USB3 controller dts
> configuration for StarFive JH7110 SoC and VisionFive2
> Board.
> USB controller connect to PHY, The PHY dts configuration
> are also added.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         |  7 +++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 44 +++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 1155b97b593d..fa97ebfd93ad 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -221,3 +221,10 @@
>  	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";
>  };
> +
> +&usb0 {
> +	phys = <&usbphy0>;
> +	phy-names = "usb2";
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 29cd798b6732..eee395e19cdb 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -366,6 +366,50 @@
>  			status = "disabled";
>  		};
>  
> +		usb0: usb@10100000 {
> +			compatible = "starfive,jh7110-usb";
> +			reg = <0x0 0x10100000 0x0 0x10000>,
> +			      <0x0 0x10110000 0x0 0x10000>,
> +			      <0x0 0x10120000 0x0 0x10000>;
> +			reg-names = "otg", "xhci", "dev";
> +			interrupts = <100>, <108>, <110>;
> +			interrupt-names = "host", "peripheral", "otg";
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
> +			reset-names = "pwrup", "apb", "axi", "utmi_apb";

All this can really be "cdns,usb3" node. The cdns,usb3 driver should
do reset and clocks init as it is generic.

> +			starfive,stg-syscon = <&stg_syscon 0x4>;
> +			status = "disabled";

Only the syscon handling looks starfive specific so only that handling
should be done in starfive USB driver.

This node should look like this

 
	starfive-usb@4 {
		compatible = "starfive,jh7110-usb";
		starfive,stg-syscon = <&stg_syscon 0x4>;

		usb0: usb@10100000 {
			compatible = "cdns,usb3";
			reg = <0x0 0x10100000 0x0 0x10000>,
			      <0x0 0x10110000 0x0 0x10000>,
			      <0x0 0x10120000 0x0 0x10000>;
			reg-names = "otg", "xhci", "dev";
			interrupts = <100>, <108>, <110>;
			interrupt-names = "host", "peripheral", "otg";
			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
				 <&stgcrg JH7110_STGCLK_USB0_STB>,
				 <&stgcrg JH7110_STGCLK_USB0_APB>,
				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
				 <&stgcrg JH7110_STGRST_USB0_APB>,
				 <&stgcrg JH7110_STGRST_USB0_AXI>,
				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
			reset-names = "pwrup", "apb", "axi", "utmi_apb";
			starfive,stg-syscon = <&stg_syscon 0x4>;
			status = "disabled";
		};
	}

In starfife-usb driver you can use of_platform_default_populate()
to create the cdns,usb3 child for you.

> +		};
> +
> +		usbphy0: phy@10200000 {
> +			compatible = "starfive,jh7110-usb-phy";
> +			reg = <0x0 0x10200000 0x0 0x10000>;
> +			clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
> +				 <&stgcrg JH7110_STGCLK_USB0_APP_125>;
> +			clock-names = "125m", "app_125m";
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

cheers,
-roger
