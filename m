Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F17475CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGDP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGDP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:59:38 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 08:59:36 PDT
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0010C8;
        Tue,  4 Jul 2023 08:59:36 -0700 (PDT)
Date:   Tue, 4 Jul 2023 17:42:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
        t=1688485356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
         references:references; bh=+LYe7RcsSbB+80ZjVGbuUrixVTMyuk04HTuHnLRMmt4=;
        b=MQhMzt3/ctq7tCXcryTxP5CsHzfSwjQJbhVraY/7tK1bVNvaXSWHfbrnU2F17WesVnClLB
        sDZikeP/Zde7EKzB/er+9pD1xyhPIyms4BNoHRKglKh7IbtmzLWdcjbNwHjXA5VIcnqF0C
        e/UUI1cGZB0ygengW27JYAH6Myv+iDT+J/xSQOxRFIkGe96J9bFrwEFgtp5YtriqcoW5zi
        +bJF+CuKZoJ9hy7vnhgyUCsLXzFUHF4gcHyfjfs446MaTkdZuJzRsQtu4yYFb7m79Lwcd3
        uY9Cs3eF69ChWvDIYk6oiQs7MuZWo0ww0otznYPIuxJ0mlquWDvS9ipN9PzFLQ==
From:   Alexander Dahl <ada@thorsis.com>
To:     Durai Manickam KR <durai.manickamkr@microchip.com>
Cc:     Hari.PrasathGE@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, varshini.rajendran@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com, claudiu.beznea@microchip.com,
        cristian.birsan@microchip.com, nicolas.ferre@microchip.com,
        krzysztof.kozlowski@linaro.org, alexandre.belloni@bootlin.com,
        davem@davemloft.net, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        Horatiu.Vultur@microchip.com, robh+dt@kernel.org, andrew@lunn.ch,
        michael@walle.cc, jerry.ray@microchip.com
Subject: Re: [PATCH v5 6/8] ARM: dts: at91: sam9x60: Add missing flexcom
 definitions
Message-ID: <20230704-disposal-deferral-b457880eab90@ifak-system.com>
Mail-Followup-To: Durai Manickam KR <durai.manickamkr@microchip.com>,
        Hari.PrasathGE@microchip.com,
        balamanikandan.gunasundar@microchip.com, manikandan.m@microchip.com,
        varshini.rajendran@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com,
        claudiu.beznea@microchip.com, cristian.birsan@microchip.com,
        nicolas.ferre@microchip.com, krzysztof.kozlowski@linaro.org,
        alexandre.belloni@bootlin.com, davem@davemloft.net, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com, Horatiu.Vultur@microchip.com,
        robh+dt@kernel.org, andrew@lunn.ch, michael@walle.cc,
        jerry.ray@microchip.com
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
 <20230203034833.451461-7-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203034833.451461-7-durai.manickamkr@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Fri, Feb 03, 2023 at 09:18:31AM +0530 schrieb Durai Manickam KR:
> From: Manikandan Muralidharan <manikandan.m@microchip.com>
> 
> Added the missing flexcom functions for all the flexcom nodes.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> [durai.manickamkr@microchip.com: added missing UART compatibles]
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  arch/arm/boot/dts/sam9x60.dtsi | 545 +++++++++++++++++++++++++++++++++
>  1 file changed, 545 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
> index 8442971458e4..91225f0fb984 100644
> --- a/arch/arm/boot/dts/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/sam9x60.dtsi
> @@ -171,6 +171,27 @@ flx4: flexcom@f0000000 {
>  				ranges = <0x0 0xf0000000 0x800>;
>  				status = "disabled";
>  
> +				uart4: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";

All those added dbgu compatible strings break the soc detection.
Console / kernel log output on sam9x60-curiosity with kernel v6.4:

  AT91: Could not find matching SoC description

What was the rationale behind adding those compatibles anyways?
"microchip,sam9x60-dbgu" is not even used in any driver.

Greets
Alex

> +					reg = <0x200 0x200>;
> +					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(8))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(9))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
>  				spi4: spi@400 {
>  					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
>  					reg = <0x400 0x200>;
> @@ -189,6 +210,24 @@ AT91_XDMAC_DT_PER_IF(1) |
>  					atmel,fifo-size = <16>;
>  					status = "disabled";
>  				};
> +
> +				i2c4: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(8))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(9))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			flx5: flexcom@f0004000 {
> @@ -221,6 +260,43 @@ AT91_XDMAC_DT_PER_IF(1) |
>  					atmel,fifo-size = <16>;
>  					status = "disabled";
>  				};
> +
> +				spi5: spi@400 {
> +					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
> +					reg = <0x400 0x200>;
> +					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
> +					clock-names = "spi_clk";
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(10))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(11))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c5: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(10))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(11))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			dma0: dma-controller@f0008000 {
> @@ -292,6 +368,45 @@ flx11: flexcom@f0020000 {
>  				#size-cells = <1>;
>  				ranges = <0x0 0xf0020000 0x800>;
>  				status = "disabled";
> +
> +				uart11: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(22))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(23))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c11: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(22))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(23))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			flx12: flexcom@f0024000 {
> @@ -302,6 +417,45 @@ flx12: flexcom@f0024000 {
>  				#size-cells = <1>;
>  				ranges = <0x0 0xf0024000 0x800>;
>  				status = "disabled";
> +
> +				uart12: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(24))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(25))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c12: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(24))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(25))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			pit64b: timer@f0028000 {
> @@ -421,6 +575,27 @@ flx6: flexcom@f8010000 {
>  				ranges = <0x0 0xf8010000 0x800>;
>  				status = "disabled";
>  
> +				uart6: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(12))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(13))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
>  				i2c6: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
> @@ -448,6 +623,45 @@ flx7: flexcom@f8014000 {
>  				#size-cells = <1>;
>  				ranges = <0x0 0xf8014000 0x800>;
>  				status = "disabled";
> +
> +				uart7: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(14))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(15))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c7: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(14))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(15))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			flx8: flexcom@f8018000 {
> @@ -458,6 +672,45 @@ flx8: flexcom@f8018000 {
>  				#size-cells = <1>;
>  				ranges = <0x0 0xf8018000 0x800>;
>  				status = "disabled";
> +
> +				uart8: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(16))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(17))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c8: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(16))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(17))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			flx0: flexcom@f801c000 {
> @@ -469,6 +722,46 @@ flx0: flexcom@f801c000 {
>  				ranges = <0x0 0xf801c000 0x800>;
>  				status = "disabled";
>  
> +				uart0: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(0))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(1))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				spi0: spi@400 {
> +					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
> +					reg = <0x400 0x200>;
> +					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
> +					clock-names = "spi_clk";
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(0))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(1))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
>  				i2c0: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
> @@ -496,6 +789,64 @@ flx1: flexcom@f8020000 {
>  				#size-cells = <1>;
>  				ranges = <0x0 0xf8020000 0x800>;
>  				status = "disabled";
> +
> +				uart1: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(2))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(3))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				spi1: spi@400 {
> +					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
> +					reg = <0x400 0x200>;
> +					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
> +					clock-names = "spi_clk";
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(2))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(3))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c1: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(2))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(3))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			flx2: flexcom@f8024000 {
> @@ -506,6 +857,64 @@ flx2: flexcom@f8024000 {
>  				#size-cells = <1>;
>  				ranges = <0x0 0xf8024000 0x800>;
>  				status = "disabled";
> +
> +				uart2: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(4))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(5))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				spi2: spi@400 {
> +					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
> +					reg = <0x400 0x200>;
> +					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
> +					clock-names = "spi_clk";
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(4))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(5))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c2: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(4))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(5))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			flx3: flexcom@f8028000 {
> @@ -516,6 +925,64 @@ flx3: flexcom@f8028000 {
>  				#size-cells = <1>;
>  				ranges = <0x0 0xf8028000 0x800>;
>  				status = "disabled";
> +
> +				uart3: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(6))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(7))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				spi3: spi@400 {
> +					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
> +					reg = <0x400 0x200>;
> +					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
> +					clock-names = "spi_clk";
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(6))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(7))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c3: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(6))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(7))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			macb0: ethernet@f802c000 {
> @@ -581,6 +1048,45 @@ flx9: flexcom@f8040000 {
>  				#size-cells = <1>;
>  				ranges = <0x0 0xf8040000 0x800>;
>  				status = "disabled";
> +
> +				uart9: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(18))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(19))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c9: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(18))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(19))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			flx10: flexcom@f8044000 {
> @@ -591,6 +1097,45 @@ flx10: flexcom@f8044000 {
>  				#size-cells = <1>;
>  				ranges = <0x0 0xf8044000 0x800>;
>  				status = "disabled";
> +
> +				uart10: serial@200 {
> +					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					reg = <0x200 0x200>;
> +					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(20))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(21))>;
> +					dma-names = "tx", "rx";
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
> +					clock-names = "usart";
> +					atmel,use-dma-rx;
> +					atmel,use-dma-tx;
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
> +
> +				i2c10: i2c@600 {
> +					compatible = "microchip,sam9x60-i2c";
> +					reg = <0x600 0x200>;
> +					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
> +					dmas = <&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(20))>,
> +						<&dma0
> +						(AT91_XDMAC_DT_MEM_IF(0) |
> +						 AT91_XDMAC_DT_PER_IF(1) |
> +						 AT91_XDMAC_DT_PERID(21))>;
> +					dma-names = "tx", "rx";
> +					atmel,fifo-size = <16>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			isi: isi@f8048000 {
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
