Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4AC6EE118
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjDYLcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjDYLcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FD63C04;
        Tue, 25 Apr 2023 04:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E899616F8;
        Tue, 25 Apr 2023 11:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8808C433D2;
        Tue, 25 Apr 2023 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682422330;
        bh=UuXKbyhIaXCYiDs1culAYOsXSM30LX3eDmpf6+fnnpI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OZd8/xP6EvyFmFDAF0T28LMchJc5xeN2PJZfvG5pRjDomj1xU0oslTXnfr8KiB+so
         g+5cizRaGYcPpmpn8/pzuztM3UNO7f3eo4bKNbtOIz4eAEfX+3q6aCh6IDk2RSOgOn
         sL827/P93ASLZ/2FyhbGK/McEw26lR98C6DrLgaNRib8vzfWogNOwLcm4PED9D1Qcp
         IaSZMWywVNWPaZ7lZGcMh7jIZ1vJ8jG3ScHXWNErkDHvZdpZ0JgjsyipFz8PbOPxsJ
         Kw1/yLaPzunRaoe33O9uWRc57i/wOkY56E9dW39dG0d6+ZvTylfwJXdqffkPfescmA
         LESkDPRkcInLw==
Message-ID: <2b74bc3f-85c7-1d2f-d597-968a914c4e6e@kernel.org>
Date:   Tue, 25 Apr 2023 14:32:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v14 3/8] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support
 of OSPI
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, afd@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-vadapalli@ti.com,
        vaishnav.a@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230331090028.8373-1-r-gunasekaran@ti.com>
 <20230331090028.8373-4-r-gunasekaran@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230331090028.8373-4-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/03/2023 12:00, Ravi Gunasekaran wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Add support for two instance of OSPI in J721S2 SoC.
> 
> Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
> Changes from v13:
> * No changes. Only rebased on top of linux-next
> 
> Changes from v12:
> * Disabled only nodes that need additional info
> 
> Changes from v11:
> * Cleaned up comments
> 
> Changes from v10:
> * Documented the reason for disabling the nodes by default.
> * Removed Link tag from commmit message
> 
> Changes from v9:
> * Disabled fss, ospi nodes by default in common DT file
> 
> Changes from v8:
> * Updated "ranges" property to fix dtbs warnings
> 
> Changes from v7:
> * Removed "reg" property from syscon node
> * Renamed the "syscon" node to "bus" to after change in
>   compatible property
> 
> Changes from v6:
> * Fixed the syscon node's compatible property
> 
> Changes from v5:
> * Updated the syscon node's compatible property
> * Removed Cc tags from commit message
> 
> Changes from v4:
> * No change
> 
> Changes from v3:
> * No change
> 
> Changes from v2:
> * No change
> 
> Changes from v1:
> * No change
> 
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index a353705a7463..6e981fe4727e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -379,4 +379,48 @@
>  			compatible = "ti,am3359-adc";
>  		};
>  	};
> +
> +	fss: bus@47000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
> +			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
> +			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
> +
> +		ospi0: spi@47040000 {
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
> +			reg = <0x00 0x47040000 0x00 0x100>,
> +			      <0x05 0x00000000 0x01 0x00000000>;
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
> +
> +			status = "disabled"; /* Needs pinmux */
> +		};
> +
> +		ospi1: spi@47050000 {
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
> +			reg = <0x00 0x47050000 0x00 0x100>,
> +			      <0x07 0x00000000 0x01 0x00000000>;
> +			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 110 5>;

What about clock parent and clock rate assignment like it was done for osip0?

> +			power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disabled"; /* Needs pinmux */
> +		};
> +	};
>  };

cheers,
-roger
