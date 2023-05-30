Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547A1716B93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjE3RvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjE3RvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:51:01 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814ABA3;
        Tue, 30 May 2023 10:50:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UHone2006637;
        Tue, 30 May 2023 12:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685469050;
        bh=EeURbpGqVcxBuyv5DijQKXjocdeNk4oLnlwGWm0D+9s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=zDH7qfSArEfl8AtR5v6WXwA1pWT5TS6JGO+gibYnUTgOCOzCWAbRkOVtjn187pbOw
         /heL5lQin/SVPr24WdCIuCooyD7nb2SPHs6LOR6U0fISWyGs/SqZ1czTOhdrARAPdS
         EL1017YRdbdNoZV5KLkwsg6vuGTCKEdA4biPMYts=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UHonPv074569
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 12:50:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 12:50:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 12:50:49 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UHoniL019431;
        Tue, 30 May 2023 12:50:49 -0500
Date:   Tue, 30 May 2023 12:50:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62x-sk-common: Add main_uart1
 and wkup_uart nodes
Message-ID: <20230530175049.yjcc6nnuipbkafhx@cryptic>
References: <20230510123216.3440019-1-n-yadav@ti.com>
 <20230510123216.3440019-2-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230510123216.3440019-2-n-yadav@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:02-20230510, Nitin Yadav wrote:
> wkup_uart and main_uart1 on this platform is used by TIFS and DM
> firmwares. Describe pinmux and add aliases for completeness.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 976f8303c84f..e29ea8ae2177 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -12,7 +12,9 @@
>  
>  / {
>  	aliases {
> +		serial0 = &wkup_uart0;
>  		serial2 = &main_uart0;
> +		serial3 = &main_uart1;
>  		mmc0 = &sdhci0;
>  		mmc1 = &sdhci1;
>  		mmc2 = &sdhci2;
> @@ -127,6 +129,15 @@ AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
>  		>;
>  	};
>  
> +	main_uart1_pins_default: main-uart1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19) MCASP0_AXR3.UART1_CTSn */
> +			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19) MCASP0_AXR2.UART1_RTSn */
> +			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
> +			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCAS/mP0_ACLKR.UART1_TXD */
In all places for sk-common.dtsi,

Could you fix the documentation in line with rest of the code?

/* First pad number is ALW package and second is AMC package */

[..]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
