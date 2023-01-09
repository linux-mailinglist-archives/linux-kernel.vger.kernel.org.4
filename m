Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4AA661DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 05:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbjAIEgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 23:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbjAIEgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:36:00 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1603512ACF;
        Sun,  8 Jan 2023 20:32:07 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3094W01E094451;
        Sun, 8 Jan 2023 22:32:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673238720;
        bh=L/YcW3E7HrdqgZ7WK3MsW8WibkW/Ei71VScJQu/w3eI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=O/fjseBdk+PTn7W03s4cXnOaRu/ME3Z6NkPtt0DWnYhlgVSRAVRM4CNfZgvHe2cYq
         tAzrERgiMI/NVQ5rPP9P8q/u94zYkmFS5KZliG2ITIifjuRNoZy+gFa4zC/ZaovPaD
         mtG0hMmLjM9CRuw0S7Hio7Gaoclj0h0s7otfO6wA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3094W0TR004011
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 Jan 2023 22:32:00 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 8
 Jan 2023 22:32:00 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 8 Jan 2023 22:32:00 -0600
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3094VvDN126682;
        Sun, 8 Jan 2023 22:31:58 -0600
Message-ID: <cb0b5b29-5771-4f8a-ce26-7932d0597d6d@ti.com>
Date:   Mon, 9 Jan 2023 10:01:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>
References: <20221223073559.109760-1-b-kapoor@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221223073559.109760-1-b-kapoor@ti.com>
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



On 23/12/22 13:05, Bhavya Kapoor wrote:
> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
> for 8 channel ADCs for J721s2 SoC.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> 
> Changelog v2->v3:
> 	- Added Newline at the end of files.
> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index a7aa6cf08acd..3bc4f28c809f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>  	pinctrl-0 = <&mcu_mcan1_pins_default>;
>  	phys = <&transceiver2>;
>  };
> +
> +&tscadc0 {
> +	status = "okay";
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> +
> +&tscadc1 {
> +	status = "okay";
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 0af242aa9816..b99021927d2a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -306,4 +306,44 @@ cpts@3d000 {
>  			ti,cpts-periodic-outputs = <2>;
>  		};
>  	};
> -};
> +
> +	tscadc0: tscadc@40200000 {
> +		compatible = "ti,am3359-tscadc";
> +		reg = <0x0 0x40200000 0x0 0x1000>;

Following convention of the file, please use:

		reg = <0x00 0x40200000 0x00 0x1000>;  



> +		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 0 0>;
> +		assigned-clocks = <&k3_clks 0 2>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "adc_tsc_fck";

Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml -> clock-names = "fck"

+/workdir/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: tscadc@40200000: clock-names:0: 'fck' was expected

make dtbs_check will warn you


> +		dmas = <&main_udmap 0x7400>,
> +			<&main_udmap 0x7401>;
> +		dma-names = "fifo0", "fifo1";
> +		status = "disabled";
> +
> +		adc {
> +			#io-channel-cells = <1>;
> +			compatible = "ti,am3359-adc";
> +		};
> +	};
> +
> +	tscadc1: tscadc@40210000 {
> +		compatible = "ti,am3359-tscadc";
> +		reg = <0x0 0x40210000 0x0 0x1000>;

Same here

> +		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 1 0>;
> +		assigned-clocks = <&k3_clks 1 2>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "adc_tsc_fck";

+/workdir/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: tscadc@40210000: clock-names:0: 'fck' was expected

> +		dmas = <&main_udmap 0x7402>,
> +			<&main_udmap 0x7403>;
> +		dma-names = "fifo0", "fifo1";
> +		status = "disabled";
> +
> +		adc {
> +			#io-channel-cells = <1>;
> +			compatible = "ti,am3359-adc";
> +		};
> +	};
> + };

WARNING: please, no spaces at the start of a line                                                                                                                                             
#87: FILE: arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi:349:                                                                                                                              
+ };$ 

Please run ./scripts/checkpatch.pl --strict and fix all the issues
before sending out the patches

-- 
Regards
Vignesh
