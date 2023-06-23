Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E073B2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjFWIWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjFWIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:22:30 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA610DC;
        Fri, 23 Jun 2023 01:22:25 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id BBA3E5FDB5;
        Fri, 23 Jun 2023 11:22:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687508542;
        bh=eYRXuph28hO53cOyWayN9gnjJltJBlK1sbJmX9HywUE=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=sRjdo2k/90AhOMjkhr6vGMWhqDr50acqCUZOd2R0Cc7TpJogdli0ZiwbWlzea8AsU
         pCNH7AJYcKZlYvBu3+iGnScJAxKzNc+hcE4Jv2jssDWDUYnKyj3+4RZfkjbKqzRo6E
         DTBboPpgDaaIqufRyRJk/Q17SbtQmNbWh6Y75HiAIdGlBvmZdskpWdcLzyZOpe3ck7
         ezUn4Z6jA4ot19g+OYmM6JI1V7/9MqdrsEzljUMUlIeTqkOs6o3p9z3WhWhXAmGNMo
         CqkRqoM37dx+IeqTuuxav+ghsJKrAFlF+AOKxqYz2unvi+JuCO9iX2jPFg9AmtnC8U
         MHnq2B6px79Sw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 23 Jun 2023 11:22:05 +0300 (MSK)
Date:   Fri, 23 Jun 2023 11:22:01 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor+dt@kernel.org>
CC:     <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 0/6] arm64: dts: meson: a1: introduce several
 peripheral IPs
Message-ID: <20230623082201.7tfnpjvwi22omleq@CAB-WSD-L081021>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/23 05:01:00 #21560607
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil, Krzysztof, Jerome, Martin, Rob and Conor,

Would you please review this patch? The latest modifications enable CLK,
EFUSE, USB, SDIO (WiFi), and UART (BT) functionality on A1 boards.

On Wed, Jun 07, 2023 at 11:16:35PM +0300, Dmitry Rokosov wrote:
> This patch series introduces device tree declarations for various
> peripheral IPs of the A1 SoC family, including clock controllers, EFUSE,
> USB, SPI Flash Controller, SDIO, and UART_AO:
>     - CLK: A1 SoC has four types on the board, namely PLL, Peripherals,
>       CPU, and Audio, but only Amlogic A1 PLL and Peripherals clock
>       controllers are currently supported.
>     - EFUSE: consists of a 4k bit One Time Programmable (OTP) memory
>       divided into 32 128-bit blocks, and data is accessed using the APB
>       bus through software or the Key-ladder integrated with the EFUSE
>       block.
>     - USB: only one USB 2.0 high-speed port is available in the A1 SoC,
>       supporting both HOST and DEVICE modes for OTG.
>     - SPI Flash Controller: 4-bit QPI/SPI NOR Flash or NAND FLASH
>       controller.
>     - SDIO: for WiFi/IEEE802.11 connection.
>     - UART_AO: for Bluetooth connection.
> 
> Alexey Romanov (1):
>   arm64: dts: meson: a1: enable efuse controller and setup its clk
> 
> Dmitry Rokosov (2):
>   arm64: dts: meson: a1: introduce PLL and Peripherals clk controllers
>   arm64: dts: meson: a1: support USB controller in OTG mode
> 
> Jan Dakinevich (1):
>   arm64: dts: meson: a1: add eMMC controller and its pins
> 
> Martin Kurbanov (1):
>   arm64: dts: meson: a1: introduce SPI Flash Controller
> 
> Oleg Lyovin (1):
>   arm64: dts: meson: a1: introduce UART_AO mux definitions
> 
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 164 ++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> -- 
> 2.36.0
> 

-- 
Thank you,
Dmitry
