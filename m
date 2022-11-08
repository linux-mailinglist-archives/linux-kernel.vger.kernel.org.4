Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E89621282
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiKHNiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiKHNiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:38:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA3F42F44;
        Tue,  8 Nov 2022 05:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667914698; x=1699450698;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=cXYGbsvnzEJ7aWBlV3PzyHHAXqr9UjDIQ0Dd7uq71bA=;
  b=Uyz6iHNDN3U+A56dpFS3IIcIrJ1cNEe+7SJuBBtEUiRmW4xPlzplGQbH
   K7ZnKD30CRYpgROtbz/8/FEGB+RNlPzbHH8YltcilN+qmONxu+LxfIf/4
   vZ5kJFDH/JCFnNXKvnLIpxhaAkxFyc/7YXsqBMXX2gmdQfZCyPQ9sAcCO
   9KYNf2Dq5Q/ijMDUccOcxEhnOxPsnU85tHYM2x7cKodHomnOvvQxsXI0R
   mPqIGoDhYNzG5zvHrtoC4ZM4ZWAe1CwpJUoIw9mYQaNKLrmRlgVX6H2UR
   EIApmeUldLYdQGwjLuSwPRdJdQu0GhzAQz7oU+uMg6Sa2Q0sz/mhCM9BJ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="182470119"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2022 06:38:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 8 Nov 2022 06:38:11 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 8 Nov 2022 06:38:08 -0700
Message-ID: <ae1744a5-c042-7549-10ad-6185c0d007ec@microchip.com>
Date:   Tue, 8 Nov 2022 14:37:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHv1 3/8] ARM: dts: at91: sam9x60: Add flexcom definitions
Content-Language: en-US
To:     Durai Manickam KR <durai.manickamkr@microchip.com>,
        <cristian.birsan@microchip.com>, <claudiu.beznea@microchip.com>,
        <Hari.PrasathGE@microchip.com>, <davem@davemloft.net>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <manikandan.m@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <horatiu.vultur@microchip.com>
References: <20221031033653.43269-1-durai.manickamkr@microchip.com>
 <20221031033653.43269-4-durai.manickamkr@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221031033653.43269-4-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 at 04:36, Durai Manickam KR wrote:
> Add the flexcom definitions to the SoC specifc DTSI file.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
> Signed-off-by: Manikandan M <manikandan.m@microchip.com>
> ---
>   arch/arm/boot/dts/sam9x60.dtsi | 52 ++++++++++++++++++++++++++++++++--
>   1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
> index ef07d281a3db..fd4f5d43f7bb 100644
> --- a/arch/arm/boot/dts/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/sam9x60.dtsi

[..]

> @@ -180,6 +190,26 @@ flx5: flexcom@f0004000 {
>   				#size-cells = <1>;
>   				ranges = <0x0 0xf0004000 0x800>;
>   				status = "disabled";
> +
> +				uart5: serial@200 {
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(10))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(11))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;

Isn't "atmel,fifo-size = <16>;" missing in this added definition?

> +					status = "disabled";
> +				};
>   			};
>   
>   			dma0: dma-controller@f0008000 {

[..]

Regards,
   Nicolas

-- 
Nicolas Ferre

