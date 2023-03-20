Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2A16C14E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjCTOhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjCTOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:37:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F224729;
        Mon, 20 Mar 2023 07:37:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KEauwu099838;
        Mon, 20 Mar 2023 09:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679323016;
        bh=LmKfiqOB9lLaiKr+Uw2VYK639kxj+XeEJN2M8SFWSfk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=l2DBSGa+CbgIUe1ieMhINKpKNWGK4nqeAa6lWSh/EVvLI2VQI0s9VvwGDbVfJ2Xrk
         OlmAT3Xocz2t/JOFL4fADi8Xt7jM6S9RhdZIiRyV2zOY0Btd8lAR8vvmO2yiS+JRXE
         kIZqRS34edGCA2fuOsNO0/iIHh2v2ezLc1XaW1jA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KEaue3017624
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 09:36:56 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 09:36:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 09:36:56 -0500
Received: from [10.249.132.105] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KEaqkI041627;
        Mon, 20 Mar 2023 09:36:53 -0500
Message-ID: <70bf6237-1762-98f4-393d-42dd3ade3fe4@ti.com>
Date:   Mon, 20 Mar 2023 20:06:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 1/2] arm64: dts: ti: k3-am62-wakeup: Introduce RTC node
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20230315170706.1598977-1-nm@ti.com>
 <20230315170706.1598977-2-nm@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230315170706.1598977-2-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/03/23 22:37, Nishanth Menon wrote:
> Introduce digital RTC node in wakeup domain. Even though this has
> no specific battery backup supply, this on-chip RTC is used in
> cost-optimized board designs as a wakeup source.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>
> No changes since V1
> V1: https://lore.kernel.org/all/20230311105850.21811-2-nm@ti.com/
>
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index 38dced6b4fef..fec81546fbbd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -40,4 +40,14 @@ wkup_i2c0: i2c@2b200000 {
>  		clock-names = "fck";
>  		status = "disabled";
>  	};
> +
> +	wkup_rtc0: rtc@2b1f0000 {
> +		compatible = "ti,am62-rtc";
> +		reg = <0x00 0x2b1f0000 0x00 0x100>;
> +		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 117 6> , <&k3_clks 117 0>;
> +		clock-names = "vbus", "osc32k";
> +		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
> +		wakeup-source;
> +	};
>  };

LGTM!

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

