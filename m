Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B21633E59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiKVOFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiKVOFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:05:09 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223C167F61;
        Tue, 22 Nov 2022 06:04:24 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AME4BaY029913;
        Tue, 22 Nov 2022 08:04:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669125851;
        bh=a6KIhoL/FHnn9qdoY7rmWPJhql70rszn2U4cEmRZrEg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lv2Zu3g5unm5HBcHPo4N2mtkZO3YrTzmO893TawHeORq15HMozn07PQjrBGPiolrr
         IbxsF+od/I6tsOC+Jv+En9cLl6PPabCLTlW0DwUkvXhzxwigE4qKOtlAJeF+JCmg2A
         vdZ4f3W2tPcqcdFG70202u/Ui82bpP/ROoYc9gXs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AME4BRJ006878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 08:04:11 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 08:04:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 08:04:10 -0600
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AME46uM128116;
        Tue, 22 Nov 2022 08:04:07 -0600
Message-ID: <e5de300b-3410-edc1-1e22-ee3d43fe783e@ti.com>
Date:   Tue, 22 Nov 2022 19:34:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 6/8] arm64: dts: ti: k3-j721s2: Add support for OSPI
 Flashes
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>,
        <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
References: <20221122101616.770050-1-mranostay@ti.com>
 <20221122101616.770050-7-mranostay@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20221122101616.770050-7-mranostay@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/22 15:46, Matt Ranostay wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> J721S2 has an OSPI NOR flash on its SOM connected the OSPI0 instance and a
> QSPI NOR flash on the common processor board connected to the OSPI1
> instance. Add support for the same
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 34 +++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 42 +++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index c787d46f89de..0503e690cfaf 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -206,6 +206,20 @@ mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-pins-default {
>  			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
>  		>;
>  	};
> +
> +	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (A19) MCU_OSPI1_CLK */
> +			J721S2_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (D20) MCU_OSPI1_CSn0 */
> +			J721S2_WKUP_IOPAD(0x060, PIN_OUTPUT, 0) /* (C21) MCU_OSPI1_CSn1 */
> +			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (D21) MCU_OSPI1_D0 */
> +			J721S2_WKUP_IOPAD(0x050, PIN_INPUT, 0) /* (G20) MCU_OSPI1_D1 */
> +			J721S2_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (C20) MCU_OSPI1_D2 */
> +			J721S2_WKUP_IOPAD(0x058, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
> +			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
> +			J721S2_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
> +		>;
> +	};
>  };
>  
>  &main_gpio2 {
> @@ -340,6 +354,26 @@ &usb0 {
>  	maximum-speed = "high-speed";
>  };
>  
> +&ospi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
> +
> +	flash@0{
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <40000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> +
>  &mcu_mcan0 {
>  	status = "okay";
>  	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> index 6930efff8a5a..2ffea00e19d7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> @@ -39,6 +39,28 @@ transceiver0: can-phy0 {
>  	};
>  };
>  
> +&wkup_pmx0 {
> +	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (D19) MCU_OSPI0_CLK */
> +			J721S2_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F15) MCU_OSPI0_CSn0 */
> +			J721S2_WKUP_IOPAD(0x030, PIN_OUTPUT, 0) /* (G17) MCU_OSPI0_CSn1 */
> +			J721S2_WKUP_IOPAD(0x038, PIN_OUTPUT, 0) /* (F14) MCU_OSPI0_CSn2 */
> +			J721S2_WKUP_IOPAD(0x03c, PIN_OUTPUT, 0) /* (F17) MCU_OSPI0_CSn3 */
> +			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (C19) MCU_OSPI0_D0 */
> +			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F16) MCU_OSPI0_D1 */
> +			J721S2_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (G15) MCU_OSPI0_D2 */
> +			J721S2_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (F18) MCU_OSPI0_D3 */
> +			J721S2_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (E19) MCU_OSPI0_D4 */
> +			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (G19) MCU_OSPI0_D5 */
> +			J721S2_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (F19) MCU_OSPI0_D6 */
> +			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (F20) MCU_OSPI0_D7 */
> +			J721S2_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (E18) MCU_OSPI0_DQS */
> +			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20) MCU_OSPI0_LBCLKO */
> +		>;
> +	};
> +};
> +
>  &main_pmx0 {
>  	main_i2c0_pins_default: main-i2c0-pins-default {
>  		pinctrl-single,pins = <
> @@ -79,3 +101,23 @@ &main_mcan16 {
>  	pinctrl-names = "default";
>  	phys = <&transceiver0>;
>  };
> +
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +		spi-max-frequency = <25000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <4>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>

> +};

-- 
Regards,
Vaishnav
