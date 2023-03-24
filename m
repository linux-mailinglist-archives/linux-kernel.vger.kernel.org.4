Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83C6C849C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjCXSQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCXSQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:16:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E11D18160;
        Fri, 24 Mar 2023 11:15:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32OIFgp4068952;
        Fri, 24 Mar 2023 13:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679681742;
        bh=ZAedyZmAc1uPMm0v3PtPciq3+q6eZI+RNS+235LdTHs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=J+9rTO01WWIPRYslfPxRupLw44D3VlmwmTteCjCCvRUI78V1jG7xsbXBl5qi1eXjr
         5RX6oJGAeG3UixAVSNgsiky+DsynVtMGxuLndHbghG+782cYd45Wtna5ggCUAZlasD
         W4wIXDsz/wn2U5gdI54GAEROkzoqO1nBWsEnWi9o=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32OIFgEE072928
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 13:15:42 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 13:15:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 13:15:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32OIFgqw033739;
        Fri, 24 Mar 2023 13:15:42 -0500
Date:   Fri, 24 Mar 2023 13:15:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am625-sk: Enable Type-C port for
 USB0
Message-ID: <20230324181542.luvmpvjx2uclic52@reemerge>
References: <20230324133150.43224-1-rogerq@kernel.org>
 <20230324133150.43224-3-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230324133150.43224-3-rogerq@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:31-20230324, Roger Quadros wrote:
> USB0 is a Type-C port with dual data role and power sink.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 40 ++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index be027fad5f61..c80b12943881 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -315,6 +315,33 @@ &main_i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_i2c0_pins_default>;
>  	clock-frequency = <400000>;
> +
> +	tps6598x@3f {
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
>  };
>  
>  &main_i2c1 {
> @@ -336,7 +363,7 @@ exp1: gpio@22 {
>  				   "UART1_FET_BUF_EN", "WL_LT_EN",
>  				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
>  				   "CSI_GPIO2", "PRU_3V3_EN",
> -				   "HDMI_INTn", "TEST_GPIO2",
> +				   "HDMI_INTn", "PD_I2C_IRQ",
>  				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
>  				   "MCASP1_FET_SEL", "UART1_FET_SEL",
>  				   "TSINT#", "IO_EXP_TEST_LED";
> @@ -486,7 +513,16 @@ &usbss1 {
>  };
>  
>  &usb0 {
> -	dr_mode = "peripheral";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	usb-role-switch;
> +
> +	port@0 {
> +		reg = <0>;
> +		usb0_hs_ep: endpoint {
> +			remote-endpoint = <&usb_con_hs>;
> +		};
> +	};
>  };
>  
>  &usb1 {
> -- 
> 2.34.1
> 

Please see thread: 
https://lore.kernel.org/all/20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com/
you might need to rebase off that.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
