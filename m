Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13B763C6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiK2RyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiK2RyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:54:01 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7AE3134B;
        Tue, 29 Nov 2022 09:53:59 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ATHrl5e129474;
        Tue, 29 Nov 2022 11:53:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669744427;
        bh=OlbUvwSRO5NoPFoWtyXeblUmFGtTGFTosZPDs/UZ6QQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Y2j79Eze27aIAEA/RmC5XYAT5mqToFBbgUUL61XLUv9PSCwrGoxAQKKepRFt+7Y2Y
         Zd7hHopizWLuFaXzHR1PkcFZ8pGuPXi5t3fPbreu/Z0/sJNQiJQLa4wNLVlduDMjoF
         fAcmE064jYxMhHH8DLb0/NaMHDRkPe84OWqSmrRA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ATHrlsU021148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Nov 2022 11:53:47 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 29
 Nov 2022 11:53:47 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 29 Nov 2022 11:53:47 -0600
Received: from [10.250.38.44] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ATHrksN025398;
        Tue, 29 Nov 2022 11:53:46 -0600
Message-ID: <a88349a2-94ac-1980-1998-a45ac5525f6b@ti.com>
Date:   Tue, 29 Nov 2022 11:53:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 7/8] arm64: dts: ti: k3-j721s2-main: Add PCIe device
 tree node
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>,
        <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221122101616.770050-1-mranostay@ti.com>
 <20221122101616.770050-8-mranostay@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221122101616.770050-8-mranostay@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 4:16 AM, Matt Ranostay wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Add PCIe1 RC device tree node for the single PCIe instance present on
> the j721s2.
> 
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 41 ++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 2858ba589d54..27631ef32bf5 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -841,6 +841,47 @@ serdes0: serdes@5060000 {
>   		};
>   	};
>   
> +	pcie1_rc: pcie@2910000 {

NIT: Not sure we need to call this "_rc", and "1", 0 index these names for
consistency, "pcie0".

> +		compatible = "ti,j7200-pcie-host", "ti,j721e-pcie-host";
> +		reg = <0x00 0x02910000 0x00 0x1000>,
> +		      <0x00 0x02917000 0x00 0x400>,
> +		      <0x00 0x0d800000 0x00 0x00800000>,
> +		      <0x00 0x18000000 0x00 0x00001000>;
> +		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
> +		interrupt-names = "link_state";
> +		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> +		device_type = "pci";
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x074>;
> +		max-link-speed = <3>;
> +		num-lanes = <4>;
> +		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 276 41>;
> +		clock-names = "fck";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0xff>;
> +		vendor-id = <0x104c>;
> +		device-id = <0xb013>;
> +		msi-map = <0x0 &gic_its 0x0 0x10000>;
> +		dma-coherent;
> +		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
> +			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
> +		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
> +		#interrupt-cells = <1>;

Is this node the interrupt controller or is it the "interrupt-controller"?
Actually, what is that node? I don't see it in the binding docs..

Andrew

> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie1_intc 0>, /* INT A */
> +				<0 0 0 2 &pcie1_intc 0>, /* INT B */
> +				<0 0 0 3 &pcie1_intc 0>, /* INT C */
> +				<0 0 0 4 &pcie1_intc 0>; /* INT D */
> +
> +		pcie1_intc: interrupt-controller {
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic500>;
> +			interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
> +		};
> +	};
> +
>   	main_mcan0: can@2701000 {
>   		compatible = "bosch,m_can";
>   		reg = <0x00 0x02701000 0x00 0x200>,
