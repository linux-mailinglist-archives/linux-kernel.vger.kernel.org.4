Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F486BA636
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCOE3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCOE3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:29:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E229C142;
        Tue, 14 Mar 2023 21:29:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F4Srua010571;
        Tue, 14 Mar 2023 23:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678854533;
        bh=pq0vN+QaBsXk7vZDc5tphUuYOmXyug9paHeytQhvPco=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=skv73KbtLp1aMAC9E5BJle/JJLet1rUfE8GXcwKQqKvpG2zvMyOdOjdhjRtvhrmFP
         jgtg/LDFVnD0SnWtVFLRwnGH40yRF6zsjsOnYrJHMheUw7Jdb3xhWc+YqvVY7KfJ0O
         9SvUTiYxOb0N2qfmwMw4qJoc/wcZJg1qQOENtgbA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F4Sr1K056646
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 23:28:53 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 23:28:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 23:28:52 -0500
Received: from [172.24.145.215] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F4SmLP010477;
        Tue, 14 Mar 2023 23:28:49 -0500
Message-ID: <9b88f21d-d3bd-5780-7cd7-827ff299e7b3@ti.com>
Date:   Wed, 15 Mar 2023 09:58:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 4/6] arm64: dts: ti: k3-am62a-main: Add nodes for McASP
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andrew Davis <afd@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
 <20230313-mcasp_upstream-v5-4-d6844707aa8a@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v5-4-d6844707aa8a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/03/23 20:19, Jai Luthra wrote:
> Same as AM62, AM62A has three instances of McASP which can be used for
> transmitting or receiving digital audio in various formats.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 60 +++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index 393a1a40b68b..7b20c07fab77 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -660,4 +660,64 @@ ecap2: pwm@23120000 {
>   		clock-names = "fck";
>   		status = "disabled";
>   	};
> +
> +	mcasp0: mcasp@2b00000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b00000 0x00 0x2000>,
> +		      <0x00 0x02b08000 0x00 0x400>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;

Andrew's comment for alignment with space is applicable on this patch
as well for all 3 mcasp nodes.
<https://lore.kernel.org/all/c4721d5f-a265-f692-2b57-f0cfcd2702b3@ti.com/>

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>



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
