Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F686ED4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjDXS4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjDXSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:55:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1701965B7;
        Mon, 24 Apr 2023 11:55:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OItmDX014970;
        Mon, 24 Apr 2023 13:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682362548;
        bh=QCsbpNC2VDKR//72LdQesXrTAYp7X6UvJ49w9SVyVzI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=j1HeXphgTxf00rl7y2hW8/ouAk7Qxd/rO3qddsPCQ2AUQENQCruDooXYLsWP5OrQU
         WJwA/aOd8iv4qDE1T047hedeN2YsAMzW2sZ4cy8FduQlAPwpJ0sZRx9EkFldU/8Xb8
         U6/z+Tbu6sNi1s+JN+uLSFfACotM0tfPO56yqdwI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OItmBR121511
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 13:55:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 13:55:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 13:55:48 -0500
Received: from [10.250.35.77] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OItlV7115983;
        Mon, 24 Apr 2023 13:55:47 -0500
Message-ID: <f5861b8b-637a-e127-2945-8994a472015a@ti.com>
Date:   Mon, 24 Apr 2023 13:55:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j7200-mcu-wakeup: Split fss node
 up
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <vaishnav.a@ti.com>,
        <u-kumar1@ti.com>
References: <20230424173623.477577-1-nm@ti.com>
 <20230424173623.477577-4-nm@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230424173623.477577-4-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 12:36 PM, Nishanth Menon wrote:
> fss node claims to be entirely a syscon node, but it is really two
> parts of it - one a syscon that controls the hbmc mux and a simple bus
> where ospi, hbmc peripherals are located. So model it accordingly by
> splitting the node up and using ti,j721e-system-controller to describe
> the syscon
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 21 +++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index b58a31371bf3..7653cb191be1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -338,18 +338,27 @@ mcu_spi2: spi@40320000 {
>   		status = "disabled";
>   	};
>   
> -	fss: syscon@47000000 {
> -		compatible = "syscon", "simple-mfd";
> +	hbmc_syscon: syscon@47000000 {
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>   		reg = <0x00 0x47000000 0x00 0x100>;
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x47000000 0x100>;
>   
> -		hbmc_mux: hbmc-mux {
> +		hbmc_mux: mux-controller@4 {
>   			compatible = "mmio-mux";
> +			reg = <0x4 0x2>;
>   			#mux-control-cells = <1>;
>   			mux-reg-masks = <0x4 0x2>; /* HBMC select */
>   		};
> +	};
> +
> +	fss: bus@47030000 {
> +		compatible = "simple-bus";
> +		reg = <0x0 0x47030000 0x0 0x100>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
>   
>   		hbmc: hyperbus@47034000 {
>   			compatible = "ti,am654-hbmc";


I hope all the things you had to do here show you what I mean in my
comments on [0] :)

I've posted a first step patch that allows "reg-mux" node to work with
regular reg properties[1]. Which means this patch could have been just this:

--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -305,15 +305,16 @@ wkup_i2c0: i2c@42120000 {
                 status = "disabled";
         };
  
-       fss: syscon@47000000 {
-               compatible = "syscon", "simple-mfd";
+       fss: bus@47000000 {
+               compatible = "simple-bus";
                 reg = <0x00 0x47000000 0x00 0x100>;
                 #address-cells = <2>;
                 #size-cells = <2>;
                 ranges;
  
                 hbmc_mux: hbmc-mux {
-                       compatible = "mmio-mux";
+                       compatible = "reg-mux";
+                       reg = <0x00 0x47000004 0x00 0x2>;
                         #mux-control-cells = <1>;
                         mux-reg-masks = <0x4 0x2>; /* HBMC select */
                 };

Andrew

[0] https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/
[1] https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/
