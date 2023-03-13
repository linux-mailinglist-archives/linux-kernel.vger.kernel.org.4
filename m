Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC7D6B7F65
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjCMRYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjCMRYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:24:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16EB2A980;
        Mon, 13 Mar 2023 10:23:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DH5hqu014893;
        Mon, 13 Mar 2023 12:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678727143;
        bh=rKQXP0FLyZWjbeuKaTkTU6uTb1umMnrPlPhn6yvWxHY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=po6zFtERGHST8JalATIDelTjiYIzdPAUKckABKR34/b7uDi5E8J4aQA9wfKoRvje3
         GFxq+NbvQsZY9iDqBmBADFDOl4TRVRtk24KwtNI7xXdyfPPwqHQHNN6ZMM0jh8ck/m
         rdClJprZa4wwlu9/emv55VvANVSRnLbMmkxn5n3M=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DH5hDP104796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 12:05:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 12:05:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 12:05:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DH5gM3096671;
        Mon, 13 Mar 2023 12:05:42 -0500
Date:   Mon, 13 Mar 2023 12:05:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Bhavya Kapoor <b-kapoor@ti.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Message-ID: <20230313170542.jehrem7egp6lelgf@repeater>
References: <20230313112834.16156-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230313112834.16156-1-b-kapoor@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:58-20230313, Bhavya Kapoor wrote:
> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
> for both instances of 8 channel ADCs for J721s2 SoC.
Drop the second line..

> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> 
> Changelog v3->v4:
> - add leading zeroes to reg address to match existing convention
> - change clock names for adc to 'fck'
> - remove spaces from start of line

Please provide links to previous versions of the patches.

> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
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

Curious: ADCs work without pinmux? any test log?

> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 0af242aa9816..5da5f0cf7009 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -306,4 +306,44 @@ cpts@3d000 {
>  			ti,cpts-periodic-outputs = <2>;
>  		};
>  	};
> +
> +	tscadc0: tscadc@40200000 {
> +		compatible = "ti,am3359-tscadc";
> +		reg = <0x00 0x40200000 0x00 0x1000>;
> +		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 0 0>;
> +		assigned-clocks = <&k3_clks 0 2>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "fck";
> +		dmas = <&main_udmap 0x7400>,
> +			<&main_udmap 0x7401>;
> +		dma-names = "fifo0", "fifo1";
> +		status = "disabled";

If it works without pinmux, why disable by default?

> +
> +		adc {
> +			#io-channel-cells = <1>;
> +			compatible = "ti,am3359-adc";
> +		};
> +	};
> +
> +	tscadc1: tscadc@40210000 {
> +		compatible = "ti,am3359-tscadc";
> +		reg = <0x00 0x40210000 0x00 0x1000>;
> +		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 1 0>;
> +		assigned-clocks = <&k3_clks 1 2>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "fck";
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
>  };
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
