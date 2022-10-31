Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66466139EA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiJaPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJaPVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:21:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192DF11472;
        Mon, 31 Oct 2022 08:21:46 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VFLe99008531;
        Mon, 31 Oct 2022 10:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667229700;
        bh=ivwd/rVBE3ksKvYI9kBd9lldFarWaNKMhn52QAdm9ck=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cEA/p5hSql10H8BCNeO6qZ1WWqv2CMamwYww/LhwVjvfvE1NGJFC1dU/qngCVWTzF
         YBV+wUEc4jpxRModSLKm2auHKzKQWNTAO8m9hPO3LQqy0z6rPDsstrUEbVA3VSaQD7
         zVRLK4lgOx8B3bqKB8Rv8htKvRa2M/4v8l8gXUPQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VFLeGj018433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 10:21:40 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 10:21:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 10:21:39 -0500
Received: from [10.250.35.234] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VFLdlY036825;
        Mon, 31 Oct 2022 10:21:39 -0500
Message-ID: <e855fc1f-ea6d-71b7-db32-5f34b4802f63@ti.com>
Date:   Mon, 31 Oct 2022 10:21:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721s2-main: Enable crypto
 accelerator
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221031135416.350010-1-j-choudhary@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221031135416.350010-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 8:54 AM, Jayesh Choudhary wrote:
> Add the node for SA2UL for supporting hardware crypto algorithms,
> including SHA1, SHA256, SHA512, AES, 3DES and AEAD suites.
> Add rng node for hardware random number generator.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> 
> Changes have been tested on local j721s2-evm board. Tcrypt tests
> and crypto self-tests were passing.
> 
> Changelog v1 -> v2:
> - change the TI_SCI flag from shared to exclusive as OP-TEE uses MCU
>    domain SA2UL instance and not the main domain instance
> - remove the 'dma-coherent' property (Binding changes are merged)
> - add the rng node which can be used as well for hwrng along with
>    optee-rng
>    
> v1 patch: https://lore.kernel.org/all/20220628054518.350717-1-j-choudhary@ti.com/
> 
> Testing log: https://gist.github.com/Jayesh2000/26acf0e63f7edcd4b267122e4c73b9a8
> 
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index d1ec26110376..7b828afc9280 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -72,6 +72,26 @@ main_pmx0: pinctrl@11c000 {
>   		pinctrl-single,function-mask = <0xffffffff>;
>   	};
>   
> +	main_crypto: crypto@4e00000 {
> +		compatible = "ti,j721e-sa2ul";
> +		reg = <0x00 0x4e00000 0x00 0x1200>;
> +		power-domains = <&k3_pds 297 TI_SCI_PD_EXCLUSIVE>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x04e00000 0x00 0x04e00000 0x00 0x30000>;
> +
> +		dmas = <&main_udmap 0xca40>, <&main_udmap 0x4a40>,
> +				<&main_udmap 0x4a41>;
> +		dma-names = "tx", "rx1", "rx2";
> +
> +		rng: rng@4e10000 {
> +			compatible = "inside-secure,safexcel-eip76";
> +			reg = <0x0 0x4e10000 0x0 0x7d>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&k3_clks 297 1>;

This "clocks" property can be dropped now [0].

Otherwise, LGTM

Acked-by: Andrew Davis <afd@ti.com>

[0] d7e8c41016471 dt-bindings: rng: omap_rng: Drop requirement for clocks

> +		};
> +	};
> +
>   	main_uart0: serial@2800000 {
>   		compatible = "ti,j721e-uart", "ti,am654-uart";
>   		reg = <0x00 0x02800000 0x00 0x200>;
