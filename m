Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F596CC075
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjC1NSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1NSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:18:22 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C4A6596;
        Tue, 28 Mar 2023 06:18:21 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SDIAAf085333;
        Tue, 28 Mar 2023 08:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680009490;
        bh=t9mag6Twi++9ybyExIrMOyUQBl/6de7PvFrviaBAhqc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fDO4T2bfFGz1BOtwbdCgv+9vhebEJxsjrmnrhItdJvwth1GA5zXRJTapV1qaxA3X0
         +RJ3JgvXs/wJosR3vnkhPK/oozaifAv/t0Rzx+IyBdcW6fB8v2Wl313zd4LRiWm66c
         MscAE27cEsR6L1jilFecYA2f3q6F0ZQZd4WCJYTM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SDIAL3107274
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 08:18:10 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 08:18:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 08:18:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SDIALa112749;
        Tue, 28 Mar 2023 08:18:10 -0500
Date:   Tue, 28 Mar 2023 08:18:10 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: Enable Type-C port
 for USB0
Message-ID: <20230328131810.x2j6uvwzhniclvwf@evoke>
References: <20230328124315.123778-1-rogerq@kernel.org>
 <20230328124315.123778-3-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230328124315.123778-3-rogerq@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:43-20230328, Roger Quadros wrote:
> USB0 is a Type-C port with dual data role and power sink.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      |  4 ++
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 44 ++++++++++++++++++-
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  4 --
>  3 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> index b2ca19e3042e..a3c3609833fd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> @@ -225,3 +225,7 @@ ldo4_reg: ldo4 {
>  		};
>  	};
>  };
> +
> +&usb0 {
> +	dr_mode = "peripheral";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index cdc0858dd1b2..13fdaa9ce4e7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -136,6 +136,35 @@ AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
>  	};
>  };
>  
> +&main_i2c0 {
> +	typec_pd: tps6598x@3f {
> +		compatible = "ti,tps6598x";
> +		reg = <0x3f>;
> +		interrupt-parent = <&exp1>;
> +		interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names = "irq";
> +
> +		connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			self-powered;
> +			data-role = "dual";
> +			power-role = "sink";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					usb_con_hs: endpoint {
> +						remote-endpoint = <&usb0_hs_ep>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &main_i2c1 {
>  	exp1: gpio@22 {
>  		compatible = "ti,tca6424";
> @@ -150,7 +179,7 @@ exp1: gpio@22 {
>  				   "UART1_FET_BUF_EN", "WL_LT_EN",
>  				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
>  				   "CSI_GPIO2", "PRU_3V3_EN",
> -				   "HDMI_INTn", "TEST_GPIO2",
> +				   "HDMI_INTn", "PD_I2C_IRQ",
>  				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
>  				   "MCASP1_FET_SEL", "UART1_FET_SEL",
>  				   "TSINT#", "IO_EXP_TEST_LED";
> @@ -256,3 +285,16 @@ partition@3fc0000 {
>  		};
>  	};
>  };
> +
> +&usb0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	usb-role-switch;
> +
> +	port@0 {
> +		reg = <0>;
> +		usb0_hs_ep: endpoint {
> +		    remote-endpoint = <&usb_con_hs>;
> +	       };
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 80e8b9b9a5f5..e3223088b90c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -264,10 +264,6 @@ &usbss1 {
>  	ti,vbus-divider;
>  };
>  
> -&usb0 {
> -	dr_mode = "peripheral";
> -};
> -

	How about sk-lp ?

>  &usb1 {
>  	dr_mode = "host";
>  	pinctrl-names = "default";
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
