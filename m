Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0774E67CAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbjAZM0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjAZM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:26:30 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF64A1C310;
        Thu, 26 Jan 2023 04:26:29 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30QCQOrf017905;
        Thu, 26 Jan 2023 06:26:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674735984;
        bh=tFW7aRPyTBES8+llQgQYOcg06QbfnuOKflYk0qlDeS0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=OVqnShcCyGMDaxECBaQtvQ0NwpX9ulb9ZdqISh3DfekLISDhJtfP3mF9ThIFxyaF4
         AmPczUZzDK1vREd70nXrmpme7sqQHXaEGt4XAVedZg/bF6dHCyvc4ypEPa8Y0gQ933
         Z/8bVkVHkGDb+JcGFW+Tz36592ZxedLct8s1JxsE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30QCQOxO039453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Jan 2023 06:26:24 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 26
 Jan 2023 06:26:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 26 Jan 2023 06:26:24 -0600
Received: from [10.250.234.92] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30QCQKcU012290;
        Thu, 26 Jan 2023 06:26:21 -0600
Message-ID: <b61a183e-7316-0cfc-0118-b0cfeea1577f@ti.com>
Date:   Thu, 26 Jan 2023 17:56:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v8 3/8] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support
 of OSPI
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230123095733.31657-1-r-gunasekaran@ti.com>
 <20230123095733.31657-4-r-gunasekaran@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230123095733.31657-4-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/01/23 3:27 pm, Ravi Gunasekaran wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Add support for two instance of OSPI in J721S2 SoC.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
> Link: https://lore.kernel.org/r/20221122101616.770050-4-mranostay@ti.com
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 0af242aa9816..d404b595316e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -306,4 +306,43 @@
>  			ti,cpts-periodic-outputs = <2>;
>  		};
>  	};
> +
> +	fss: bus@47000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +

make dtbs W=12

Warning (unit_address_vs_reg): /bus@100000/bus@28380000/bus@47000000: node has a unit name, but no reg or ranges property


> +		ospi0: spi@47040000 {
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
> +			reg = <0x00 0x47040000 0x00 0x100>,
> +			      <0x5 0x0000000 0x1 0x0000000>;

Also, please follow existing convention

			      <0x05 0x00000000 0x01 0x0000000>;

> +			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 109 5>;
> +			assigned-clocks = <&k3_clks 109 5>;
> +			assigned-clock-parents = <&k3_clks 109 7>;
> +			assigned-clock-rates = <166666666>;
> +			power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		ospi1: spi@47050000 {
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
> +			reg = <0x00 0x47050000 0x00 0x100>,
> +			      <0x7 0x0000000 0x1 0x0000000>;

			      <0x07 0x00000000 0x01 0x0000000>;

> +			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 110 5>;
> +			power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +	};
>  };
