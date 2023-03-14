Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F696B8741
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCNAx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCNAx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:53:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A624129;
        Mon, 13 Mar 2023 17:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA1DFB8169C;
        Tue, 14 Mar 2023 00:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CC4C433D2;
        Tue, 14 Mar 2023 00:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678755232;
        bh=2DrJLkuUgorhS4aRsd6guPDQJPAJsGtB34wensbN/rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WY9JzQOsxmdcp90IysXxRHkkhGV8wWNmf58MOaA+FZk4ERlXf3bMl5wQer1UN3mQv
         yUbOm3LjT7EPmwgw2eF4yheaBO+tRFveN3uSo0x/CmbjyoEbW1ReETHZRgvcf1f9H5
         v8ithuXN6AXXGybstjwEXOdDlAW2a4V4as9+0pQ+dXm5X2uhjejbnfTb4uD8saak86
         cqrbREA5xHF/FyvXQIIOsydQyQgN4dcN8F1j/nhEjlMFkr7GeqhtNxko+/XLksJuAj
         k6G/tvXzcyRPPiaU94iGBCPzSafc/7DsehDyjVDtHkYGjSd5RezGPNwf4B846tLSED
         7cJDQaQ393rFw==
Date:   Tue, 14 Mar 2023 08:53:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: dts: freescale: imx8qxp-mek: enable cadence
 usb3
Message-ID: <20230314005345.GU143566@dragon>
References: <20230213222229.686072-1-Frank.Li@nxp.com>
 <20230213222229.686072-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213222229.686072-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 05:22:28PM -0500, Frank Li wrote:
> Enable USB3 controller, phy and typec related nodes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index afa883389456..64f20ff44ba7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "imx8qxp.dtsi"
> +#include <dt-bindings/usb/pd.h>
>  
>  / {
>  	model = "Freescale i.MX8QXP MEK";
> @@ -28,6 +29,21 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
>  		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	gpio-sbu-mux {
> +		compatible = "gpio-sbu-mux";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_typec_mux>;
> +		select-gpios = <&lsio_gpio5 9 GPIO_ACTIVE_LOW>;
> +		enable-gpios = <&pca9557_a 7 GPIO_ACTIVE_LOW>;
> +		orientation-switch;
> +
> +		port {
> +			usb3_data_ss: endpoint {
> +				remote-endpoint = <&typec_con_ss>;
> +			};
> +		};
> +	};
>  };
>  
>  &dsp {
> @@ -127,6 +143,44 @@ light-sensor@44 {
>  			};
>  		};
>  	};
> +
> +	ptn5110: tcpc@50 {
> +		compatible = "nxp,ptn5110";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_typec>;
> +		reg = <0x50>;
> +

Unneeded newline.

> +		interrupt-parent = <&lsio_gpio1>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";

Unneeded "okay" status.

> +
> +		port {
> +			typec_dr_sw: endpoint {
> +				remote-endpoint = <&usb3_drd_sw>;
> +			};
> +		};
> +
> +		usb_con1: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "source";
> +			data-role = "dual";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@1 {
> +					reg = <1>;
> +						typec_con_ss: endpoint {

Broken indent alignment.

Shawn

> +							remote-endpoint = <&usb3_data_ss>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  };
>  
>  &lpuart0 {
> @@ -204,6 +258,27 @@ &usdhc2 {
>  	status = "okay";
>  };
>  
> +&usb3_phy {
> +	status = "okay";
> +};
> +
> +&usbotg3 {
> +	status = "okay";
> +};
> +
> +&usbotg3_cdns3 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		usb3_drd_sw: endpoint {
> +			remote-endpoint = <&typec_dr_sw>;
> +		};
> +	};
> +};
> +
> +
>  &vpu {
>  	compatible = "nxp,imx8qxp-vpu";
>  	status = "okay";
> @@ -267,6 +342,18 @@ IMX8QXP_UART0_TX_ADMA_UART0_TX				0x06000020
>  		>;
>  	};
>  
> +	pinctrl_typec: typecgrp {
> +		fsl,pins = <
> +			IMX8QXP_SPI2_SCK_LSIO_GPIO1_IO03                        0x06000021
> +		>;
> +	};
> +
> +	pinctrl_typec_mux: typecmuxgrp {
> +		fsl,pins = <
> +			IMX8QXP_ENET0_REFCLK_125M_25M_LSIO_GPIO5_IO09           0x60
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK			0x06000041
> -- 
> 2.34.1
> 
