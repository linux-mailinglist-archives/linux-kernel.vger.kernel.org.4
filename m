Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F262B2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiKPFaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKPFa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:30:27 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDDB23E85;
        Tue, 15 Nov 2022 21:30:26 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AG5UAKW101176;
        Tue, 15 Nov 2022 23:30:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668576610;
        bh=Gihq/JvfYiDTTgL4mbNXyfH9/8O3NIuNT2JbrKVK3+g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=FC3Hl5nHr61fBE+UWGGwlY/ffMUN5vWP+FIiylcnsTn21CaXBjebJzi0IadkVcd4M
         Vjpt2+l6FZZHzaW2JlRK45o4U284yqw+wdOHZ7JquXj5F1E7qiS0Z9JaOubYgFT4lt
         gmZHJ3RJxaKaojffuq4LrYacY9NnCpKOatz55CCY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AG5UANE048844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 23:30:10 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 23:30:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 23:30:10 -0600
Received: from [172.24.222.97] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AG5U553019521;
        Tue, 15 Nov 2022 23:30:06 -0600
Message-ID: <278df800-85e9-99f6-e25f-fd5363bdd300@ti.com>
Date:   Wed, 16 Nov 2022 11:00:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721s2-main: Enable crypto
 accelerator
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <afd@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221031200633.26997-1-j-choudhary@ti.com>
From:   Manorit Chawdhry <m-chawdhry@ti.com>
In-Reply-To: <20221031200633.26997-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 01/11/22 01:36, Jayesh Choudhary wrote:
> Add the node for SA2UL for supporting hardware crypto algorithms,
> including SHA1, SHA256, SHA512, AES, 3DES and AEAD suites.
> Add rng node for hardware random number generator.
>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Acked-by: Matt Ranostay <mranostay@ti.com>
> Acked-by: Andrew Davis <afd@ti.com>
> ---
>
> Changes have been tested on local j721s2-evm board. Tcrypt tests
> and crypto self-tests were passing.
>
> Changelog v2 -> v3:
> - remove the clock property from rng node
>    (<https://lore.kernel.org/all/20220901171041.32056-1-afd@ti.com/>)
>
> Changelog v1 -> v2:
> - change the TI_SCI flag from shared to exclusive as OP-TEE uses MCU
>    domain SA2UL instance and not the main domain instance
> - remove the 'dma-coherent' property (Binding changes are merged)
> - add the rng node which can be used as well for hwrng along with
>    optee-rng
>
> v2 patch: https://lore.kernel.org/all/20221031135416.350010-1-j-choudhary@ti.com/
>
> Testing log: https://gist.github.com/Jayesh2000/26acf0e63f7edcd4b267122e4c73b9a8
>
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index d1ec26110376..2e0ba2262e77 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -72,6 +72,25 @@ main_pmx0: pinctrl@11c000 {
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
> +		};
> +	};
> +

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

>   	main_uart0: serial@2800000 {
>   		compatible = "ti,j721e-uart", "ti,am654-uart";
>   		reg = <0x00 0x02800000 0x00 0x200>;
