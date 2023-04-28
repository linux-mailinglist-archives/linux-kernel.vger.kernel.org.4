Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E215D6F1DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbjD1RuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346201AbjD1RuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:50:08 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34501725;
        Fri, 28 Apr 2023 10:50:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33SHntMH078361;
        Fri, 28 Apr 2023 12:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682704195;
        bh=UmLy3leFONTqML0fyVMnhcJxGeeiWVx5wIHVOgo9Bp0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=t7TbCY7tEhG+ylshMCysSVXU4vAQTc97COIq7rjRJ38AP07HPKdQaMLz/SyLnNAbb
         pej53Y7kBTwD+RonFtf7LPZV/0ogghFnvRIo8Sym7htesBJZh9PLzMn2wPrjYkH0tz
         HiKDFPEuT+ZJksrjem0biHo0heUK33LIUr7atwOI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33SHntIx082240
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Apr 2023 12:49:55 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Apr 2023 12:49:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Apr 2023 12:49:54 -0500
Received: from [10.249.133.214] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33SHnpQI034469;
        Fri, 28 Apr 2023 12:49:52 -0500
Message-ID: <0f553758-c2cc-ce70-47e0-99e08c2d94a1@ti.com>
Date:   Fri, 28 Apr 2023 23:19:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add support for
 ADC nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>
References: <20230412100949.850513-1-b-kapoor@ti.com>
 <20230412100949.850513-2-b-kapoor@ti.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20230412100949.850513-2-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2023 3:39 PM, Bhavya Kapoor wrote:
> J784S4 has two instances of 8 channel ADCs in MCU domain. Add support
> for both ADC nodes.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index f04fcb614cbe..cb5ba5e94ec7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -342,4 +342,44 @@ cpts@3d000 {
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
> +				<&main_udmap 0x7401>;

Please fix alignment issue:

		dmas = <&main_udmap 0x7400>,
		       <&main_udmap 0x7401>;

> +		dma-names = "fifo0", "fifo1";
> +		status = "disabled";
> +
> +		adc {
> +				#io-channel-cells = <1>;
> +				compatible = "ti,am3359-adc";

Excessive indentation

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
> +				<&main_udmap 0x7403>;

ditto

> +		dma-names = "fifo0", "fifo1";
> +		status = "disabled";
> +
> +		adc {
> +				#io-channel-cells = <1>;
> +				compatible = "ti,am3359-adc";

Same here

> +		};
> +	};
>  };
