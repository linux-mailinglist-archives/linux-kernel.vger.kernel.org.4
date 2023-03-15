Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C086BB518
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjCONsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjCONsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:48:07 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F22227993;
        Wed, 15 Mar 2023 06:47:37 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32FDkv2j120549;
        Wed, 15 Mar 2023 08:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678888017;
        bh=EtqTPcSnfVc0LoUbtO5WMNgw5dncuifjT+kor26LEik=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vJFbImRcVQJe1Vbv/GRPA1opyPaCc9Kd1v8v1hpjb6qbddm4TN4Lq9Tals9h3IQzK
         xtRBycAegRvNbAKbZwEKvwSAi/URSfUr5Ls5UhGoPGhC39YIwdKAn+amI+Po/EBvaF
         QZQvhYrB+QtixL5KzywvMU8ev1lQFmCxPQcjD7M4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32FDkvRu025008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 08:46:57 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 08:46:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 08:46:56 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32FDkusv001488;
        Wed, 15 Mar 2023 08:46:56 -0500
Date:   Wed, 15 Mar 2023 08:46:56 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Update IO EXP
 GPIO lines for Rev E2
Message-ID: <20230315134656.bt3mczw73h3z2j57@privacy>
References: <20230315120934.16954-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230315120934.16954-1-sinthu.raja@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:39-20230315, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> Rev E2 of the AM68 SK baseboard has updated the GPIO IO expander pins
> functionality. To match the Rev E2 schematics, update existing IO expander
> GPIO line names and the corresponding node which uses the expansion(exp1)
> node.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> Schematics Ref: https://www.ti.com/lit/zip/sprr463

Looking at https://www.ti.com/tool/SK-AM68 looks like E1 never hit
production, is that correct?

Does this need a "Fixes" tag?

> 
>  arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index 2091cd2431fb..27a43a8ecffd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -60,7 +60,7 @@ vdd_mmc1: regulator-sd {
>  		regulator-boot-on;
>  		enable-active-high;
>  		vin-supply = <&vsys_3v3>;
> -		gpio = <&exp1 10 GPIO_ACTIVE_HIGH>;
> +		gpio = <&exp1 8 GPIO_ACTIVE_HIGH>;
>  	};
>  
>  	vdd_sd_dv: regulator-tlv71033 {
> @@ -264,12 +264,10 @@ exp1: gpio@21 {
>  		reg = <0x21>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -		gpio-line-names = "CSI_VIO_SEL", "CSI_SEL_FPC_EXPn", "HDMI_PDn",
> -					"HDMI_LS_OE", "DP0_3V3 _EN", "BOARDID_EEPROM_WP",
> -					"CAN_STB", " ", "GPIO_uSD_PWR_EN", "eDP_ENABLE",
> -					"IO_EXP_PCIe1_M.2_RTSz", "IO_EXP_MCU_RGMII_RSTz",
> -					"IO_EXP_CSI2_EXP_RSTz", " ", "CSI0_B_GPIO1",
> -					"CSI1_B_GPIO1";
> +		gpio-line-names = " ", " ", " ", " ", " ",
> +				  "BOARDID_EEPROM_WP", "CAN_STB", " ",
> +				  "GPIO_uSD_PWR_EN", " ", "IO_EXP_PCIe1_M.2_RTSz",
> +				  "IO_EXP_MCU_RGMII_RST#", " ", " ", " ", " ";
>  	};
>  };
>  
> -- 
> 2.36.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
