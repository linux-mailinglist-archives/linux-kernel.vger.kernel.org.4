Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540126FC420
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjEIKmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjEIKmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:42:13 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7541C59F1;
        Tue,  9 May 2023 03:42:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349Ag39D088292;
        Tue, 9 May 2023 05:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683628923;
        bh=Nomgq3t+4HfebnevX3WGB/j8KKfQAwmWlrWI5nUU5Fw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lTS3/k7owXlrwGfPC4vLNdyekhJ75RPL0xWc+6gn7jRhNelAJrXQbuZiaXWhGcZYq
         0LxOcYW1pXJR43rB9chc47MpPee/E8+mOOkwvqieo5B9sHuHi86ZcodL8dp9OGFdtQ
         kq2bhF5ZcTkhXsnYB374KXAbmGjyEFM+3+FKmF+8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349Ag3fA017716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 05:42:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 05:42:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 05:42:03 -0500
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349Afxh8077375;
        Tue, 9 May 2023 05:42:00 -0500
Message-ID: <feddcd03-1848-b667-6a38-ae7c0f6ff160@ti.com>
Date:   Tue, 9 May 2023 16:11:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: k3-j7200-mcu-wakeup: Update fss
 node and hbmc_mux
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20230505115858.7391-1-vaishnav.a@ti.com>
 <20230505115858.7391-4-vaishnav.a@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230505115858.7391-4-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/23 17:28, Vaishnav Achath wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> fss node claims to be a syscon node, while it actually is a simple bus

FSS

> where ospi, hbmc peripherals are located and a mux for path select

OSPI, HBMC

> between OSPI and Hyperbus which can be modelled as a reg-mux. So model
> it accordingly and use reg-mux to describe the hbmc-mux. Also update
> the region size to the correct values as per the TRM.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> V1->V2:
>  * Address feedback from Udit to limit the FSS register region size as
>  per TRM.
>  * Use reg-mux changes to simplify the hbmc-mux modelling.
>  * Update commit message to reflect changes.
> 
> Depends on:
>  https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index b58a31371bf3..333564ca9c91 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -338,22 +338,23 @@
>  		status = "disabled";
>  	};
>  
> -	fss: syscon@47000000 {
> -		compatible = "syscon", "simple-mfd";
> -		reg = <0x00 0x47000000 0x00 0x100>;
> +	fss: bus@47000000 {
> +		compatible = "simple-bus";
> +		reg = <0x00 0x47000000 0x0 0x7c>;

                                       ^^^^ 0x00

I know the registers only go up to 0x7c, but its convention to map
entire region that is reserved for the IP irrespective of how many
registers are actually valid (I see this across arm64 SoC Vendors).
Eg as per TRM,  Table 203 MCU Domain map:

MCU_FSS0_CFG 0x0047000000 - 0x00470000FF (256B)




>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges;
>  
> -		hbmc_mux: hbmc-mux {
> -			compatible = "mmio-mux";
> +		hbmc_mux: mux-controller@47000004 {
> +			compatible = "reg-mux";
> +			reg = <0x00 0x47000004 0x00 0x2>;
>  			#mux-control-cells = <1>;
>  			mux-reg-masks = <0x4 0x2>; /* HBMC select */
>  		};
>  
>  		hbmc: hyperbus@47034000 {
>  			compatible = "ti,am654-hbmc";
> -			reg = <0x00 0x47034000 0x00 0x100>,
> +			reg = <0x00 0x47034000 0x00 0x0c>,

Hmm, doesn't look correct? I see register addresses up to 0x47034048h in
TRM?

I prefer to map entire region reserved in the SoC memory map:
MCU_FSS0_HPB_CTRL 0x0047034000 - 0x00470340FF (256B)


>  				<0x05 0x00000000 0x01 0x0000000>;
>  			power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
>  			clocks = <&k3_clks 102 0>;

-- 
Regards
Vignesh
