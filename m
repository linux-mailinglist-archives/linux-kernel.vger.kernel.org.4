Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE570F740
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjEXNFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXNFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:05:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF629E;
        Wed, 24 May 2023 06:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684933544; x=1716469544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TPn0OnXhyX1k/fGqFhNKe0zxo+eTujVX+0nj3TYsWmY=;
  b=Sn0XSthDgjWVHwOKcBbcN5GLByPlIeZtizxOi11AXsc4lkslmBDCeDZn
   iSpb6s2tMxZ+E3NDrqk55XNomAewqUGQmPWAUSPRKshoQN2hRAarPG+fy
   kohgOr3PEy4Q9OaZ0figsVxI125RkPjv8h2rfH6eO4llQHrCRupLDACGj
   knTwybfIHB0zmF0ECqXbzwEi8AjbZLiYNQQlR+TWd6FFz4Sh4032Bjq20
   LdCwSdupAGf+s9hIe+OHnhlmLxezSpKKgARE4uhUqHMEKCtA0LWUQSlU1
   rot7wKxdMRyKaO6vCmIo4EsLYI33HX2lO2NamBdeLv8jvon0JynN3Ndqj
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="217055754"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 06:05:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 06:05:40 -0700
Received: from [10.12.67.12] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 24 May 2023 06:05:38 -0700
Message-ID: <f05fca51-8c45-0167-9b60-2314bbc3626e@microchip.com>
Date:   Wed, 24 May 2023 15:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] dt-bindings: power: reset: at91: convert to YAML
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230524123528.439082-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 at 14:35, Claudiu Beznea wrote:
> Hi,
> 
> Series convert AT91 shutdown controllers documentation to YAML.
> Along with it device trees were updated and also entries to
> MAINTAINERS with documentation files.
> 
> Thank you,
> Claudiu
> 
> Changes in v2:
> - use minimum, maximum on uint32 enums instead of all possible values
> - change commit description for patch 3/4 to explain why there is a
>    syscon along with microchip,sama7g5-shdwc
> - remove | near description entries
> 
> Claudiu Beznea (4):
>    ARM: dts: at91: use generic name for shutdown controller
>    dt-bindings: power: reset: atmel,at91sam9260-shdwc: convert to yaml
>    dt-bindings: power: reset: atmel,sama5d2-shdwc: convert to yaml
>    MAINTAINERS: add documentation file for Microchip SAMA5D2 shutdown
>      controller

For the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> 
>   .../devicetree/bindings/arm/atmel-sysregs.txt |  94 --------------
>   .../power/reset/atmel,at91sam9260-shdwc.yaml  |  82 +++++++++++++
>   .../power/reset/atmel,sama5d2-shdwc.yaml      | 115 ++++++++++++++++++
>   MAINTAINERS                                   |   1 +
>   arch/arm/boot/dts/at91-qil_a9260.dts          |   2 +-
>   arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   |   2 +-
>   arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     |   2 +-
>   arch/arm/boot/dts/at91-sama5d2_xplained.dts   |   2 +-
>   arch/arm/boot/dts/at91sam9260.dtsi            |   2 +-
>   arch/arm/boot/dts/at91sam9260ek.dts           |   2 +-
>   arch/arm/boot/dts/at91sam9261.dtsi            |   2 +-
>   arch/arm/boot/dts/at91sam9263.dtsi            |   2 +-
>   arch/arm/boot/dts/at91sam9g20ek_common.dtsi   |   2 +-
>   arch/arm/boot/dts/at91sam9g45.dtsi            |   2 +-
>   arch/arm/boot/dts/at91sam9n12.dtsi            |   2 +-
>   arch/arm/boot/dts/at91sam9rl.dtsi             |   2 +-
>   arch/arm/boot/dts/at91sam9x5.dtsi             |   2 +-
>   arch/arm/boot/dts/sam9x60.dtsi                |   2 +-
>   arch/arm/boot/dts/sama5d2.dtsi                |   2 +-
>   arch/arm/boot/dts/sama5d3.dtsi                |   2 +-
>   arch/arm/boot/dts/sama5d4.dtsi                |   2 +-
>   arch/arm/boot/dts/sama7g5.dtsi                |   2 +-
>   arch/arm/boot/dts/usb_a9260.dts               |   2 +-
>   arch/arm/boot/dts/usb_a9263.dts               |   2 +-
>   24 files changed, 218 insertions(+), 114 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shdwc.yaml
>   create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
> 

-- 
Nicolas Ferre

