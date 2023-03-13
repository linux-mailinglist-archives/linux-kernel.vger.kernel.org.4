Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06B86B7EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCMRML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjCMRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:12:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A34673882;
        Mon, 13 Mar 2023 10:11:33 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DHAUDP001571;
        Mon, 13 Mar 2023 12:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678727430;
        bh=9bLRawV7JpSTjU6bheC0tqfSEaV8MxNXsheeotQAqPw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=x1za+trDOmJje1m3EqHNoK/P6o0wsjlbORfpmbeKrIL9PI8xcRt8C/+uCgLNlUMoQ
         ztMP/vek+hM3gc0xOaz9LXMv6hxWjrdKmpxFaiVHIeacIREj1Pqlo69mkZ2byXdhMM
         MjiLF3ewWplgXmrnx3PTymQTvfkcvHUtANMGcJRE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DHATRV004081
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 12:10:29 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 12:10:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 12:10:28 -0500
Received: from [10.250.32.223] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DHARMa124516;
        Mon, 13 Mar 2023 12:10:28 -0500
Message-ID: <c4721d5f-a265-f692-2b57-f0cfcd2702b3@ti.com>
Date:   Mon, 13 Mar 2023 12:10:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 2/6] arm64: dts: ti: k3-am62-main: Add McASP nodes
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
 <20230313-mcasp_upstream-v5-2-d6844707aa8a@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v5-2-d6844707aa8a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 9:49 AM, Jai Luthra wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> Add the nodes for McASP 0-2.
> 
> Use the audio-friendly 96MHz main_1_hsdivout6_clk as clock parent
> instead of the default 100Mhz main_2_hsdivout8_clk source.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 60 ++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index ea683fd77d6a..4da5747987bb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -787,4 +787,64 @@ epwm2: pwm@23020000 {
>   		clock-names = "tbclk", "fck";
>   		status = "disabled";
>   	};
> +
> +	mcasp0: mcasp@2b00000 {

I wonder if we want to switch to generic node naming here, audio-controller@..

> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b00000 0x00 0x2000>,
> +		      <0x00 0x02b08000 0x00 0x400>;
> +		reg-names = "mpu","dat";

Space after ,

> +		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;

Align with space, indent with tab, as you did with "reg" property.

Same for McASP 1/2.

Reviewed-by: Andrew Davis <afd@ti.com>

> +		interrupt-names = "tx", "rx";
> +
> +		dmas = <&main_bcdma 0 0xc500 0>, <&main_bcdma 0 0x4500 0>;
> +		dma-names = "tx", "rx";
> +
> +		clocks = <&k3_clks 190 0>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 190 0>;
> +		assigned-clock-parents = <&k3_clks 190 2>;
> +		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	mcasp1: mcasp@2b10000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b10000 0x00 0x2000>,
> +		      <0x00 0x02b18000 0x00 0x400>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +
> +		dmas = <&main_bcdma 0 0xc501 0>, <&main_bcdma 0 0x4501 0>;
> +		dma-names = "tx", "rx";
> +
> +		clocks = <&k3_clks 191 0>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 191 0>;
> +		assigned-clock-parents = <&k3_clks 191 2>;
> +		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	mcasp2: mcasp@2b20000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b20000 0x00 0x2000>,
> +		      <0x00 0x02b28000 0x00 0x400>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +
> +		dmas = <&main_bcdma 0 0xc502 0>, <&main_bcdma 0 0x4502 0>;
> +		dma-names = "tx", "rx";
> +
> +		clocks = <&k3_clks 192 0>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 192 0>;
> +		assigned-clock-parents = <&k3_clks 192 2>;
> +		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
>   };
> 
