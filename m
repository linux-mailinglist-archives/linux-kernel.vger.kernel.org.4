Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129AF6C6965
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCWNXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWNXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:23:30 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A6421B;
        Thu, 23 Mar 2023 06:23:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32NDN7ls117175;
        Thu, 23 Mar 2023 08:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679577787;
        bh=MJVj6U+Sml+yBBT4L4TySKHSpgVK26/7pJRTNZYUNCI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=S2/F2rKxBFhnWLNDjszFPkYhGwKY3/8bcZfrFsMe1B+DVpJJqWZxaeWU2XZI2unpt
         j/yzIrlXHFGHTdqmY0NseuKhi+5TxVVZ6zTvnZhT9xDu9eIt/R5923lfYQ4gfe/+2y
         4vbJE+2hcji2AiOOW77vS9ZqWORxsifq4DNPL0OY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32NDN74Y094549
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Mar 2023 08:23:07 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Mar 2023 08:23:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Mar 2023 08:23:07 -0500
Received: from [172.24.145.199] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32NDN2DH029735;
        Thu, 23 Mar 2023 08:23:03 -0500
Message-ID: <2bfdd0ab-a73a-f1af-def1-0044cf8d4a01@ti.com>
Date:   Thu, 23 Mar 2023 18:53:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 5/6] arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3
 regulators
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
References: <20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com>
 <20230313-mcasp_upstream-v6-5-77685d7cbeb8@ti.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v6-5-77685d7cbeb8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai,

Thanks for the patch.

On 15/03/23 14:33, Jai Luthra wrote:
> VCC_3V3_MAIN is the output of LM5141-Q1, and it serves as an input to
> TPS22965DSGT which produces VCC_3V3_SYS.
I would suggest to put link to schematics too :
Design docs: Link: https://www.ti.com/lit/zip/sprr459
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
With that change,
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index 5c9012141ee2..063e69e45163 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -76,10 +76,10 @@ vcc_5v0: regulator-1 {
>  		regulator-boot-on;
>  	};
>  
> -	vcc_3v3_sys: regulator-2 {
> +	vcc_3v3_main: regulator-2 {
>  		/* output of LM5141-Q1 */
>  		compatible = "regulator-fixed";
> -		regulator-name = "vcc_3v3_sys";
> +		regulator-name = "vcc_3v3_main";
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		vin-supply = <&vmain_pd>;
> @@ -98,6 +98,17 @@ vdd_mmc1: regulator-3 {
>  		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
>  	};
>  
> +	vcc_3v3_sys: regulator-4 {
> +		/* output of TPS222965DSGT */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3_sys";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3_main>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		pinctrl-names = "default";
> 
