Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD2715F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjE3Mah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjE3M3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:29:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842E11B5;
        Tue, 30 May 2023 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685449781; x=1716985781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rURsonAWbqRN3vUMqXSgbcSJQ8+RR/S84Z2YjMifaro=;
  b=m6G8tVd/sP7mpIS6jlPA9kelMUiGbru72hrZ7AdLqxNvNFtaGivMeApj
   btGRw69O0dqAstsk9LdlGPcs/YKB6vhRu3iUqKozj2rzEn4VxMLFi7Ozr
   EadN2JP/irPWnf9w/F0PdwrMXqfNFSI0MlFzELYcjm0x+gsKho1xTeq+O
   P6UED+CA8Xg6s60HcW+STlwaR1ep1MjRcLhKZNgPV+4dlei+ApuRfJzfK
   A3lL9YDjNqfx4LCIzJum+JvGlqLqoLV+AFEpYPmc9v1uV2UNqC4jN49pD
   Nbvth3ofzRKgVCxq8sXnJMo2Im+FpoNXacXDZN8yeIv1tMUmqKuJWNy7F
   A==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="217938016"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 05:29:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 05:29:17 -0700
Received: from [10.159.205.49] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 05:29:15 -0700
Message-ID: <83f32f3a-ed3e-e0d3-f7a0-d137a273c667@microchip.com>
Date:   Tue, 30 May 2023 14:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/3] dt-bindings: timer: Microchip AT91 convert to YAML
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
References: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 at 11:07, Claudiu Beznea wrote:
> Hi,
> 
> Series converts Microchip AT91 timers DT bindings to YAML. Along with it the
> atmel,at91rm9200-wdt has been converted and introduced in this series
> as it is referenced by atmel,at91rm9200-st.

For the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu and Conor.
Best regards,
   Nicolas

> Changes in v3:
> - removed patch 1/4 from v2
> - in patch 1/3 keep interrupt description only for PIT case (not for PIT64b)
>    and updated interrupt description to emphasize blocks part of the system
>    controller; note that system controller components may be different b/w
>    different Microchip AT91 SoCs;
> - in patch 3/3 updated interrupt description to emphasize blocks part of the
>    system controller; also, corrected Alexandre's email address
> - collected tags.
> 
> Changes in v2:
> - fixed compilation errors (sorry for that in v1)
> - moved DTS patch as the 1st patch in series
> - squash PIT and PIT64B into the same documentation file
> - use Microchip in titles, descriptions and commit message
> - in patch 4/4 remove oneOf from compatible section
> 
> Claudiu Beznea (3):
>    dt-bindings: timer: atmel,at91sam9260-pit: convert to yaml
>    dt-bindings: watchdog: atmel,at91rm9200-wdt: convert to yaml
>    dt-bindings: timer: atmel,at91rm9200-st: convert to yaml
> 
>   .../devicetree/bindings/arm/atmel-sysregs.txt | 21 ----
>   .../bindings/timer/atmel,at91rm9200-st.yaml   | 66 +++++++++++++
>   .../bindings/timer/atmel,at91sam9260-pit.yaml | 99 +++++++++++++++++++
>   .../watchdog/atmel,at91rm9200-wdt.yaml        | 29 ++++++
>   .../watchdog/atmel-at91rm9200-wdt.txt         |  9 --
>   5 files changed, 194 insertions(+), 30 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
>   create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
>   create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
>   delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> 

-- 
Nicolas Ferre

