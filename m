Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8697872E4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbjFMN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbjFMN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:56:56 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF1CA;
        Tue, 13 Jun 2023 06:56:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35DDucch028956;
        Tue, 13 Jun 2023 08:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686664598;
        bh=AisEUQFN6qXK+ZgbfXrx9CrTIJoeUeeHyqEZJKH9pKM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PsJvvz5XS41tAsGYDTqgIlugg1p3do7L3bGivru8HYzOGi4LLcdSbaNU3oi5jDpTl
         L+pNu0JZn7Ov2KQDK+OWZ3MYDiXiUfQKkCaLLdN/cJfVNkea3afwdYmEh8koGE6bvJ
         ExP7htS3QjYq3ilWqDiysNwxkF7t9tSvwmQLECsw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35DDucY1033792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jun 2023 08:56:38 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Jun 2023 08:56:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Jun 2023 08:56:38 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35DDuZbr051552;
        Tue, 13 Jun 2023 08:56:35 -0500
Message-ID: <22b67e80-1f5f-d8e0-3c85-c69d97ea0d39@ti.com>
Date:   Tue, 13 Jun 2023 19:26:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6/9] arm64: dts: ti: k3-j721e-beagleboneai64: Add
 wakeup_uart pinmux
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Neha Malcom Francis <n-francis@ti.com>
References: <20230601183151.1000157-1-nm@ti.com>
 <20230601183151.1000157-7-nm@ti.com>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230601183151.1000157-7-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 6/2/2023 12:01 AM, Nishanth Menon wrote:
> Define the wakeup uart pin-mux for completeness. This allows the
> device tree usage in bootloader and firmwares that can configure the
> same appropriately.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> index c13246a9ed8f..bc53ca566a68 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> @@ -531,6 +531,13 @@ J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
>   		>;
>   	};
>   
> +	wkup_uart0_pins_default: wkup-uart0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
> +			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
> +		>;
> +	};
> +
>   	mcu_usbss1_pins_default: mcu-usbss1-pins-default {
>   		pinctrl-single,pins = <
>   			J721E_WKUP_IOPAD(0x3c, PIN_OUTPUT_PULLUP, 5) /* (A23) MCU_OSPI1_LBCLKO.WKUP_GPIO0_30 */
> @@ -541,6 +548,8 @@ J721E_WKUP_IOPAD(0x3c, PIN_OUTPUT_PULLUP, 5) /* (A23) MCU_OSPI1_LBCLKO.WKUP_GPIO
>   &wkup_uart0 {
>   	/* Wakeup UART is used by TIFS firmware. */
>   	status = "reserved";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_uart0_pins_default>;
>   };


If you like to consider alias for wkup_uart0 for this board ,

Just to align with other boards for this SOC family.  I understand 
wkup_uart0 is not being used.


>   
>   &main_uart0 {
