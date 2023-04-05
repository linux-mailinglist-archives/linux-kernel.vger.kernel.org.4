Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625A16D83D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjDEQiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDEQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:38:07 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C116F30F3;
        Wed,  5 Apr 2023 09:38:05 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335Gbs1Y049305;
        Wed, 5 Apr 2023 11:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680712675;
        bh=RAzK/9/QguqNrFtBWr4bk5SJVoOVysSW9GzBLB9CjBM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=r69Sk4KfCLPW0Vz62ydNnCjnxaBiTYN2lWYn57zMlWeHjgEp/oh0wG01mCrZGtbjE
         5jZnRmer18kWDGLrXr1gj9THaGRGAc9lkCDd0LHYkxf0xFKNfUPH9a9w4U90z0r/iZ
         BhJHOXhTvmcZY9ObkpvT0jBzddtREAsA1aoxIthg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335GbsSP021417
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 11:37:54 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 11:37:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 11:37:54 -0500
Received: from [10.250.32.15] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 335Gbqxk089718;
        Wed, 5 Apr 2023 11:37:52 -0500
Message-ID: <e38ea0b2-5e51-05d6-50fc-c7ef3d4b8698@ti.com>
Date:   Wed, 5 Apr 2023 11:37:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/6] arm64: dts: ti: k3-j784s4-*: Add DSS node
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230405111412.151192-1-j-choudhary@ti.com>
 <20230405111412.151192-5-j-choudhary@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230405111412.151192-5-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 6:14 AM, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> Add DSS node for J784S4 SoC. DSS IP in J784S4
> is same as DSS IP in J721E, so same compatible is
> being used.
> Also add assigned clks for DSS
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 11 +++++


The changes to `k3-j784s4-evm.dts` in this patch and the next all
need moved to the last patch in this series. All these changes
needed to enable the display in the EVM work together and so
should be one atomic step.

Andrew

>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 55 ++++++++++++++++++++++
>   2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index b1445b7c2aa8..ccbfca76e9ae 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -305,3 +305,14 @@ &main_cpsw1_port1 {
>   &serdes_refclk {
>   	clock-frequency = <100000000>;
>   };
> +
> +&dss {
> +	assigned-clocks = <&k3_clks 218 2>,
> +			  <&k3_clks 218 5>,
> +			  <&k3_clks 218 14>,
> +			  <&k3_clks 218 18>;
> +	assigned-clock-parents = <&k3_clks 218 3>,
> +				 <&k3_clks 218 7>,
> +				 <&k3_clks 218 16>,
> +				 <&k3_clks 218 22>;
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 0cd692bc52e6..86ce6f6d4fc2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1373,4 +1373,59 @@ main_spi7: spi@2170000 {
>   		clocks = <&k3_clks 383 1>;
>   		status = "disabled";
>   	};
> +
> +	dss: dss@4a00000 {
> +		compatible = "ti,j721e-dss";
> +		reg =
> +			<0x00 0x04a00000 0x00 0x10000>,
> +			<0x00 0x04a10000 0x00 0x10000>,
> +			<0x00 0x04b00000 0x00 0x10000>,
> +			<0x00 0x04b10000 0x00 0x10000>,
> +
> +			<0x00 0x04a20000 0x00 0x10000>,
> +			<0x00 0x04a30000 0x00 0x10000>,
> +			<0x00 0x04a50000 0x00 0x10000>,
> +			<0x00 0x04a60000 0x00 0x10000>,
> +
> +			<0x00 0x04a70000 0x00 0x10000>,
> +			<0x00 0x04a90000 0x00 0x10000>,
> +			<0x00 0x04ab0000 0x00 0x10000>,
> +			<0x00 0x04ad0000 0x00 0x10000>,
> +
> +			<0x00 0x04a80000 0x00 0x10000>,
> +			<0x00 0x04aa0000 0x00 0x10000>,
> +			<0x00 0x04ac0000 0x00 0x10000>,
> +			<0x00 0x04ae0000 0x00 0x10000>,
> +			<0x00 0x04af0000 0x00 0x10000>;
> +
> +		reg-names = "common_m", "common_s0",
> +			"common_s1", "common_s2",
> +			"vidl1", "vidl2","vid1","vid2",
> +			"ovr1", "ovr2", "ovr3", "ovr4",
> +			"vp1", "vp2", "vp3", "vp4",
> +			"wb";
> +
> +		clocks =	<&k3_clks 218 0>,
> +				<&k3_clks 218 2>,
> +				<&k3_clks 218 5>,
> +				<&k3_clks 218 14>,
> +				<&k3_clks 218 18>;
> +		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
> +
> +		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
> +
> +		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "common_m",
> +				  "common_s0",
> +				  "common_s1",
> +				  "common_s2";
> +
> +		status = "disabled";
> +
> +		dss_ports: ports {
> +		};
> +	};
>   };
