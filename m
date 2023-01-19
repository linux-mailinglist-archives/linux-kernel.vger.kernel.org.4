Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BE0673613
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjASKv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjASKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:51:25 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774BA4ABEB;
        Thu, 19 Jan 2023 02:51:19 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30JAp7ps099459;
        Thu, 19 Jan 2023 04:51:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674125467;
        bh=1qaOrmcJcnr6XGxNyPCLgbyiPdz5QVG556zvtisy1zQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QR88l0RwRDpDepaJX/Et2sU+gCkXP23GS/8xZYsxP1IHl4DNJ37wdfti2747VpXnn
         ofdp2BAJThGs0CYKZuXHUc1/pyA5eMFu09ni6tJBJLMUS9wEyB6rzhJ6thk+nUShs0
         n/ZGd9vORKwVsspfFcj8f381a3M62nfZWNAt+hzU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30JAp70T007191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 04:51:07 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 04:51:06 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 04:51:06 -0600
Received: from [172.24.145.215] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30JAp2LM047415;
        Thu, 19 Jan 2023 04:51:03 -0600
Message-ID: <331c1a38-9483-f485-3787-3e0cf1e68985@ti.com>
Date:   Thu, 19 Jan 2023 16:21:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix wakeup pinmux range
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, <vigneshr@ti.com>,
        <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <j-keerthy@ti.com>
References: <20230119042622.22310-1-vaishnav.a@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230119042622.22310-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/01/23 09:56, Vaishnav Achath wrote:
> The WKUP_PADCONFIG register region in J7200 has multiple non-addressable
> regions, split the existing wkup_pmx region as follows to avoid the
> non-addressable regions and include all valid WKUP_PADCONFIG registers.
> Also update references to old nodes with new ones.
> 
> wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
> wkup_pmx1 -> 2 pins (WKUP_PADCONFIG 14 - 15)
> wkup_pmx2 -> 59 pins (WKUP_PADCONFIG 26 - 84)
> wkup_pmx3 -> 8 pins (WKUP_PADCONFIG 93 - 100)
> 
> J7200 Datasheet (Table 6-106, Section 6.4 Pin Multiplexing) :
> 	https://www.ti.com/lit/ds/symlink/dra821u.pdf
> 
> Fixes: d361ed88455f ("arm64: dts: ti: Add support for J7200 SoC")
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

> ---
>   .../dts/ti/k3-j7200-common-proc-board.dts     |  2 +-
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 29 ++++++++++++++++++-
>   2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 6240856e4863..0d39d6b8cc0c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -80,7 +80,7 @@
>   	};
>   };
>   
> -&wkup_pmx0 {
> +&wkup_pmx2 {
>   	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
>   		pinctrl-single,pins = <
>   			J721E_WKUP_IOPAD(0x0068, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index fe669deba489..de56a0165bd0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -56,7 +56,34 @@
>   	wkup_pmx0: pinctrl@4301c000 {
>   		compatible = "pinctrl-single";
>   		/* Proxy 0 addressing */
> -		reg = <0x00 0x4301c000 0x00 0x178>;
> +		reg = <0x00 0x4301c000 0x00 0x34>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +
> +	wkup_pmx1: pinctrl@0x4301c038 {
> +		compatible = "pinctrl-single";
> +		/* Proxy 0 addressing */
> +		reg = <0x00 0x4301c038 0x00 0x8>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +
> +	wkup_pmx2: pinctrl@0x4301c068 {
> +		compatible = "pinctrl-single";
> +		/* Proxy 0 addressing */
> +		reg = <0x00 0x4301c068 0x00 0xec>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +
> +	wkup_pmx3: pinctrl@0x4301c174 {
> +		compatible = "pinctrl-single";
> +		/* Proxy 0 addressing */
> +		reg = <0x00 0x4301c174 0x00 0x20>;
>   		#pinctrl-cells = <1>;
>   		pinctrl-single,register-width = <32>;
>   		pinctrl-single,function-mask = <0xffffffff>;
