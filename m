Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215477244F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbjFFNxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbjFFNxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:53:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53A183;
        Tue,  6 Jun 2023 06:53:01 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356CAu3G070791;
        Tue, 6 Jun 2023 07:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686053456;
        bh=2vdLTd9jB9uLP9Eo374O+cBAshyPuNPO8VuZO8gC4no=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eKknT4Ub2xPBgY6EYd9C10IJq77dLoHlXtujFQesWK33/754IAsN3IMFBcb1Y9QAt
         lI/Lg0fBJasyDOsRMpBFtSSg989CGXa9dYaQdvonyGU2QSKOQhINEetzT9RRwCi1hw
         eXXnmUduze4bfdV04umWZ+jdtK7UpHY0GEgGEf14=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356CAuOq006708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 07:10:56 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 07:10:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 07:10:56 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356CAtv9002537;
        Tue, 6 Jun 2023 07:10:55 -0500
Date:   Tue, 6 Jun 2023 07:10:55 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Udit Kumar <u-kumar1@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH v3 3/5] arm64: dts: ti: k3-j7200-common-proc-board: Add
 uart pin mux in main_pmx0
Message-ID: <20230606121055.gii7tl6ccu4dlpxp@sanctity>
References: <20230604045525.1889083-1-u-kumar1@ti.com>
 <20230604045525.1889083-4-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230604045525.1889083-4-u-kumar1@ti.com>
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
> Add main uart0 pin mux into common board file and it's
> reference to main_uart0 node.
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)

We could squash this with patch #5 for uart pinmuxes - there are a few more missing

> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 0cc0e1dc40c5..02d2e4b36b18 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -113,6 +113,15 @@ J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
>  		>;
>  	};
>  
> +	main_uart0_pins_default: main_uart0_pins_default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
> +			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
> +			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
> +			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
> +		>;
> +	};
> +
>  	main_i2c1_pins_default: main-i2c1-pins-default {
>  		pinctrl-single,pins = <
>  			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
> @@ -162,6 +171,8 @@ &main_uart0 {
>  	status = "okay";
>  	/* Shared with ATF on this platform */
>  	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
>  };
>  
>  &main_uart1 {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
