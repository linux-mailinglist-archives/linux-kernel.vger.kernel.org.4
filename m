Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CD86EE1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjDYMYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjDYMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:24:51 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFEA116;
        Tue, 25 Apr 2023 05:24:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PCOXHE064447;
        Tue, 25 Apr 2023 07:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682425473;
        bh=k7Ux6DQ0nSZK+7IivtDppNZ1trpjUsbPWKpm4qi7TCk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=W3N+5ro8X4gOJDx97YaryJ2dDj/mKa8p0OJ5Noyn2T55Mu8a3xTdHJeEGwxHBRGKb
         UPECzVmId+OePX3wP8nrCieqqPKWxMihDqr0HQ/k78grGHfnenSeu+CYT3IOSmKuSC
         CRRUc/55OH++E0gY1H9MLFuAnfZgHxm1oogDEZWs=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PCOX16120419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 07:24:33 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 07:24:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 07:24:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PCOW1L019505;
        Tue, 25 Apr 2023 07:24:32 -0500
Date:   Tue, 25 Apr 2023 07:24:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Bryan Brattlof <bb@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: dts: k3-am62a7-sk: Describe main_uart1 and wkup_uart
Message-ID: <20230425122432.jhnb7rddrpii3jeg@palpitate>
References: <20230424183355.68360-1-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230424183355.68360-1-bb@ti.com>
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

Please fix $subject: arm64: dts: ti:

On 13:33-20230424, Bryan Brattlof wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> wkup_uart and main_uart1 on this platform is used by tifs and DM
> firmwares. Describe them for completeness including the pinmux.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> [bb@ti.com: updated pinmux]
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 40 +++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index f6a67f072dca6..65caa5611d6d5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -17,7 +17,9 @@ / {
>  	model = "Texas Instruments AM62A7 SK";
>  
>  	aliases {
> +		serial0 = &wkup_uart0;
>  		serial2 = &main_uart0;
> +		serial3 = &main_uart1;
>  		mmc1 = &sdhci1;
>  	};
>  
> @@ -114,11 +116,38 @@ led-0 {
>  	};
>  };
>  
> +&mcu_pmx0 {
> +	wkup_uart0_pins_default: wkup-uart0-pins-default {
> +		pinctrl-single,pins = <
> +			AM62AX_MCU_IOPAD(0x0024, PIN_INPUT, 0) /* (C9) WKUP_UART0_RXD */
> +			AM62AX_MCU_IOPAD(0x0028, PIN_OUTPUT, 0) /* (E9) WKUP_UART0_TXD */
> +			AM62AX_MCU_IOPAD(0x002c, PIN_INPUT, 0) /* (C10) WKUP_UART0_CTSn */
> +			AM62AX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C8) WKUP_UART0_RTSn */
> +		>;
> +	};
> +};
> +
> +/* WKUP UART0 is used for DM firmware logs */
> +&wkup_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	status = "reserved";
> +};
> +
>  &main_pmx0 {
>  	main_uart0_pins_default: main-uart0-pins-default {
>  		pinctrl-single,pins = <
> -			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
> -			AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
> +			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (E14) UART0_RXD */
> +			AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (D15) UART0_TXD */
> +		>;
> +	};
> +
> +	main_uart1_pins_default: main-uart1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x01e8, PIN_INPUT, 1) /* (C17) I2C1_SCL.UART1_RXD */
> +			AM62AX_IOPAD(0x01ec, PIN_OUTPUT, 1) /* (E17) I2C1_SDA.UART1_TXD */
> +			AM62AX_IOPAD(0x0194, PIN_INPUT, 2) /* (C19) MCASP0_AXR3.UART1_CTSn */
> +			AM62AX_IOPAD(0x0198, PIN_OUTPUT, 2) /* (B19) MCASP0_AXR2.UART1_RTSn */
>  		>;
>  	};
>  
> @@ -254,6 +283,13 @@ &main_uart0 {
>  	pinctrl-0 = <&main_uart0_pins_default>;
>  };
>  
> +/* Main UART1 is used for TIFS firmware logs */
> +&main_uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart1_pins_default>;
> +	status = "reserved";
> +};
> +
>  &usbss1 {
>  	status = "okay";
>  };
> 
> base-commit: 891db0c48efb48c3af334006f9d7ea6a0aa49cb9
> -- 
> 2.40.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
