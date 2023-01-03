Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3765BE80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbjACK55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjACK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:57:55 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B2FAE2;
        Tue,  3 Jan 2023 02:57:53 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 303AvZSb090263;
        Tue, 3 Jan 2023 04:57:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672743455;
        bh=vMEBQ4PD6kGg0suLTL9EmbRebRqL5OH/ooXSm7+/JOE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QguY1QiqVYuQ0klszRFz5Nqz9XHjpza7VN8ihtP49CSZ5J8tIOTTpUGd7F/qUmL7g
         3cv8t22ohQNpfYDiwwBq0b1X8wd28ePdVRyajzA+NABZfaFVEasFyi2V5SIDAjYrPb
         i9H+Duec0CmKTdu8OQ+vegVF4+xB5RKzGf2K4H2c=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 303AvZkV017961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jan 2023 04:57:35 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 3
 Jan 2023 04:57:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 3 Jan 2023 04:57:34 -0600
Received: from [10.24.69.26] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 303AvUfO118033;
        Tue, 3 Jan 2023 04:57:31 -0600
Message-ID: <68f09cf2-e40f-cc06-b3ef-f7373ee64367@ti.com>
Date:   Tue, 3 Jan 2023 16:27:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] arm64: dts: ti: k3-am62a7-sk: Enable USB1 node
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bb@ti.com>
References: <20230103042110.1092122-1-vigneshr@ti.com>
 <20230103042110.1092122-5-vigneshr@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230103042110.1092122-5-vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/23 09:51, Vignesh Raghavendra wrote:
> Enable USB1 host port on AM62A7 SK.
> 
> Co-developed-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---

For the series,

Acked-by: Dhruva Gole <d-gole@ti.com>

>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index bdc363fcbb4b..5c9012141ee2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -160,6 +160,12 @@ AM62AX_IOPAD(0x244, PIN_OUTPUT, 7) /* (D18) MMC1_SDWP.GPIO1_49 */
>   		>;
>   	};
>   
> +	main_usb1_pins_default: main-usb1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
> +		>;
> +	};
> +
>   	main_mdio1_pins_default: main-mdio1-pins-default {
>   		pinctrl-single,pins = <
>   			AM62AX_IOPAD(0x160, PIN_OUTPUT, 0) /* (V12) MDIO0_MDC */
> @@ -247,6 +253,16 @@ &main_uart0 {
>   	pinctrl-0 = <&main_uart0_pins_default>;
>   };
>   
> +&usbss1 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_usb1_pins_default>;
> +};
> +
>   &cpsw3g {
>   	status = "okay";
>   	pinctrl-names = "default";

-- 
Thanks and Regards,
Dhruva Gole
