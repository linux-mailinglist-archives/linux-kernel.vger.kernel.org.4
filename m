Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71407241BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbjFFMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbjFFMKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:10:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844DD10D3;
        Tue,  6 Jun 2023 05:10:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356CA0Ho089369;
        Tue, 6 Jun 2023 07:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686053400;
        bh=S4YNGDBdV23hnWy0uTndF8WiempTRHZpHbLE2gBg+W4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=x98FWjLPJXTsPF5c5rggFAypgw+IPyNOEwsrjMtm7mYF/MBkiXMKJivWtoSRYx34l
         k+K84IwjnwApflxxqOkMN8qcFN9ZFrHMJN2GLKvVX5gJer040THsDa0hWjkBnANR9P
         tW5zk3jXxQgjuhKSESMhRwKvBXYJ8KtQql3oHSCQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356CA0Xi058293
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 07:10:00 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 07:09:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 07:09:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356C9xHu001052;
        Tue, 6 Jun 2023 07:09:59 -0500
Date:   Tue, 6 Jun 2023 07:09:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Udit Kumar <u-kumar1@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-j7200-common-proc-board: Add
 uart pin mux in wkup_pmx0
Message-ID: <20230606120959.r4pnxuigknl7qkjr@outpour>
References: <20230604045525.1889083-1-u-kumar1@ti.com>
 <20230604045525.1889083-6-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230604045525.1889083-6-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:25-20230604, Udit Kumar wrote:
> Add uart pin mux of wkup domain into common board file.
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index e12d93f56c51..809d1c910015 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -79,6 +79,24 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
>  	};
>  };
>  
> +&wkup_pmx0 {
> +	mcu_uart0_pins_default: mcu_uart0_pins_default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
> +			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
> +			J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
> +			J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
> +		>;
> +	};
> +
> +	wkup_uart0_pins_default: wkup_uart0_pins_default {

Could you add the pins to wkup_uart0 node as well?

> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
> +			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
> +		>;
> +	};
> +};

We are also missing pinmux for main_uart1 and main_uart2

> +
>  &wkup_pmx2 {
>  	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
>  		pinctrl-single,pins = <
> @@ -157,7 +175,9 @@ &wkup_uart0 {
>  
>  &mcu_uart0 {
>  	status = "okay";
> -	/* Default pinmux */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_uart0_pins_default>;
> +	clock-frequency = <96000000>;
>  };
>  
>  &main_uart0 {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
