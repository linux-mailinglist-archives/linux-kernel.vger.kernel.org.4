Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF70A61393F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiJaOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiJaOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:46:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA110FD9;
        Mon, 31 Oct 2022 07:46:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VEju3U117604;
        Mon, 31 Oct 2022 09:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667227556;
        bh=9wzXyXbrH4vUZm+CwB9gxE4UcpSRgmXNDK9nYapXWis=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=r1zV8lvhT8i+t7DxrtIwouwLQy7hFSWErn1wI9vd5Eh5R7nDyn82ThAZzjmz9vOpa
         VSGXokCiJbmQVbCU3Z/94fVFj6187FLs5evpy8e8cwdo2jaU/X/Fayd7rslAn/w79C
         R0R/EEEMByGH6ailnRUah53Z7giHXUyKA/e83KdE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VEju1H129231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 09:45:56 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 09:45:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 09:45:55 -0500
Received: from ubuntu (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with SMTP id 29VEjjUk027016;
        Mon, 31 Oct 2022 09:45:48 -0500
Date:   Mon, 31 Oct 2022 07:45:44 -0700
From:   Matt Ranostay <mranostay@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <afd@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721s2-main: Enable crypto
 accelerator
Message-ID: <Y1/fmMRlsRkCS0z3@ubuntu>
References: <20221031135416.350010-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221031135416.350010-1-j-choudhary@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 07:24:16PM +0530, Jayesh Choudhary wrote:
> Add the node for SA2UL for supporting hardware crypto algorithms,
> including SHA1, SHA256, SHA512, AES, 3DES and AEAD suites.
> Add rng node for hardware random number generator.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

Acked-by: Matt Ranostay <mranostay@ti.com>

> ---
> 
> Changes have been tested on local j721s2-evm board. Tcrypt tests
> and crypto self-tests were passing.
> 
> Changelog v1 -> v2:
> - change the TI_SCI flag from shared to exclusive as OP-TEE uses MCU
>   domain SA2UL instance and not the main domain instance
> - remove the 'dma-coherent' property (Binding changes are merged)
> - add the rng node which can be used as well for hwrng along with
>   optee-rng
>   
> v1 patch: https://lore.kernel.org/all/20220628054518.350717-1-j-choudhary@ti.com/
> 
> Testing log: https://gist.github.com/Jayesh2000/26acf0e63f7edcd4b267122e4c73b9a8
> 
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index d1ec26110376..7b828afc9280 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -72,6 +72,26 @@ main_pmx0: pinctrl@11c000 {
>  		pinctrl-single,function-mask = <0xffffffff>;
>  	};
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
> +		};
> +	};
> +
>  	main_uart0: serial@2800000 {
>  		compatible = "ti,j721e-uart", "ti,am654-uart";
>  		reg = <0x00 0x02800000 0x00 0x200>;
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
