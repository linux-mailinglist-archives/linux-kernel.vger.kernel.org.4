Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC3674EDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGKMNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGKMNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:13:32 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8310EF;
        Tue, 11 Jul 2023 05:13:29 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BC95Y2015254;
        Tue, 11 Jul 2023 14:13:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=sCuZ/9hR/lPRsTzfts991T5JQ1QG/1OJ5zsN85rXrt8=;
 b=34/UyTlDI65TARTZzRibNlZiylBgJKUUXOlXb01LX/4vCeFqRehsUbWUo7lgg1+DVZIj
 4syoI/l4sijMQ5lUD9ZbbLya+ZIhHYuWhK5ror8LQ8G91mB7xDtW2vXBeK77bs4Zb8lZ
 4GxAPX/Uzt8mj/Q4a+6UkexJjf2ageLZC/iSWC+0HSeU3E04eWGPeLZrrm7qX3WLcnRR
 lLZPXCnWQEIIDF/qtweWl8CJlBvRMB891ZmcTP55HUKKeeasV9qV+mWZdKfaesteX4nR
 g0gR6j+NiBWLjLLJpKdsYK2x4lGsY3pR6PPkzFEEid0nV2M8HbwSe1hHD4Ne6u61OM5V qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rs6u680t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:13:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D803C100067;
        Tue, 11 Jul 2023 14:13:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5DC94222CA3;
        Tue, 11 Jul 2023 14:13:09 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 11 Jul
 2023 14:13:09 +0200
Message-ID: <abff4a25-a178-7eb7-1576-a94b0a57a896@foss.st.com>
Date:   Tue, 11 Jul 2023 14:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] ARM: dts: stm32: support display on
 stm32f746-disco board
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     <michael@amarulasolutions.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230629083726.84910-1-dario.binacchi@amarulasolutions.com>
 <20230629083726.84910-4-dario.binacchi@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230629083726.84910-4-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario

On 6/29/23 10:37, Dario Binacchi wrote:
> Add support to Rocktech RK043FN48H display on stm32f746-disco board.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v5:
> I am confident that framebuffer sizing is a real requirement for STM32 boards,
> but I need some time to understand if and how to introduce this functionality.
> Therefore, I drop the following patches to allow the series to be fully merged:
>   - [4/6] dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
>   - [5/6] ARM: dts: stm32: set framebuffer bit depth on stm32f746-disco
>   - [6/6] drm/stm: set framebuffer bit depth through DTS property
> 
> Changes in v4:
> - Use DTS property instead of module parameter to set the framebuffer bit depth.
> 
> Changes in v3:
> - drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
>    Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
>    https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
> - drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
>    Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
>    https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc
> 
>   arch/arm/boot/dts/stm32f746-disco.dts | 51 +++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
> index c11616ed5fc6..cda423b6a874 100644
> --- a/arch/arm/boot/dts/stm32f746-disco.dts
> +++ b/arch/arm/boot/dts/stm32f746-disco.dts
> @@ -60,10 +60,41 @@ memory@c0000000 {
>   		reg = <0xC0000000 0x800000>;
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			no-map;
> +			size = <0x80000>;
> +			linux,dma-default;
> +		};
> +	};
> +
>   	aliases {
>   		serial0 = &usart1;
>   	};
>   
> +	backlight: backlight {
> +		compatible = "gpio-backlight";
> +		gpios = <&gpiok 3 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +
> +	panel_rgb: panel-rgb {
> +		compatible = "rocktech,rk043fn48h";
> +		backlight = <&backlight>;
> +		enable-gpios = <&gpioi 12 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +		port {
> +			panel_in_rgb: endpoint {
> +				remote-endpoint = <&ltdc_out_rgb>;
> +			};
> +		};
> +	};
> +
>   	usbotg_hs_phy: usb-phy {
>   		#phy-cells = <0>;
>   		compatible = "usb-nop-xceiv";
> @@ -99,6 +130,26 @@ &i2c1 {
>   	status = "okay";
>   };
>   
> +&dma1 {
> +	status = "okay";
> +};
> +
> +&dma2 {
> +	status = "okay";
> 
Why do you enable DMAs ? It seems not used by LTDC.

> +&ltdc {
> +	pinctrl-0 = <&ltdc_pins_a>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	port {
> +		ltdc_out_rgb: endpoint {
> +			remote-endpoint = <&panel_in_rgb>;
> +		};
> +	};
> +};
> +
>   &sdio1 {
>   	status = "okay";
>   	vmmc-supply = <&mmc_vcard>;

