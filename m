Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E616EF4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbjDZMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbjDZMtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:49:19 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C148EC9;
        Wed, 26 Apr 2023 05:48:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QCmnPh037978;
        Wed, 26 Apr 2023 07:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682513329;
        bh=3ws5zKPEfE4Ifd7md6CIVe5EF0uPGAT8qRb1QnaTW+I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QUmzRSSuVi3nL8guNvwc+BDHUpAWMcLjRsakB7HIRTxEK+dUP4jhgvdRY0PGr3Srh
         jSQjc/x/g9t50TNzRDkXh8NGgAW/5kfV5zu6bl6WJ1UC0tH/sHvdhK0W89+XaIZdPO
         /zd/HvuIpDUSW6AFUCNSKYTpz/DrCXzVObPiKZ2g=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QCmnnh117303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 07:48:49 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 07:48:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 07:48:48 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QCmmpU019878;
        Wed, 26 Apr 2023 07:48:48 -0500
Date:   Wed, 26 Apr 2023 07:48:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Udit Kumar <u-kumar1@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <m-chawdhry@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH 5/5] arm64: dts: ti: k3-j7200: Add bootph-pre-ram for
 u-boot
Message-ID: <20230426124848.2af7ombywlsqkbva@autistic>
References: <20230426103219.1565266-1-u-kumar1@ti.com>
 <20230426103219.1565266-6-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230426103219.1565266-6-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:02-20230426, Udit Kumar wrote:
> Adding bootph-pre-ram property for pin mux needed by
> uboot.
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 5 +++++
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi           | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 2cdfd957dd12..1bcb94aec588 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -81,7 +81,9 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
>  };
>  
>  &wkup_pmx0 {
> +	bootph-pre-ram;
>  	mcu_uart0_pins_default: mcu_uart0_pins_default {
> +		bootph-pre-ram;
>  		pinctrl-single,pins = <
>  			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
>  			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
> @@ -91,6 +93,7 @@ J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
>  	};
>  
>  	wkup_uart0_pins_default: wkup_uart0_pins_default {
> +		bootph-pre-ram;
>  		pinctrl-single,pins = <
>  			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
>  			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
> @@ -125,7 +128,9 @@ J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
>  };
>  
>  &main_pmx0 {
> +	bootph-pre-ram;
>  	main_uart0_pins_default: main_uart0_pins_default {
> +		bootph-pre-ram;
>  		pinctrl-single,pins = <
>  			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
>  			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index 269424154771..d2500837a0e8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -119,7 +119,9 @@ J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
>  };
>  
>  &wkup_pmx2 {
> +	bootph-pre-ram;
>  	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
> +			bootph-pre-ram;
>  			pinctrl-single,pins = <
>  			J721E_WKUP_IOPAD(0x98, PIN_INPUT_PULLUP, 0) /* (F20) WKUP_I2C0_SCL */
>  			J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
> @@ -129,6 +131,7 @@ J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
>  
>  &main_pmx0 {
>  	main_i2c0_pins_default: main-i2c0-pins-default {
> +		bootph-pre-ram;
>  		pinctrl-single,pins = <
>  			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
>  			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
> -- 
> 2.34.1
> 

There are a bunch of other nodes that neeed bootph-pre-ram -> lets first
ensure all the nodes needed for u-boot is present (esm is still in
discussion) then add bootph-pre-ram and related ones in a follow on series.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
