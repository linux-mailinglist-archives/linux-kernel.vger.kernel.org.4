Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2D600B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiJQJmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJQJmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:42:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB7F64;
        Mon, 17 Oct 2022 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665999771; x=1697535771;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=WsXUdjOn3js3nYe4RKd94I9UT2XiDhLyOPhGqc7Y3Iw=;
  b=vhQL+DQvaqlPB/eyhQXFugPo88v4SLHyqkMBOYFpVgTAqs+GWw5hv3kL
   eCOSXVxP6reoHTPBG02afLcILpbIGRmeMWwZz0ei1rKaRClyrd/Z5Y629
   Rmjxh8PQklkfr15Bk8BXPiCHz5bRDEHJ83Qrmmv+3VOMz95U7ddy5oI2T
   hNQI80TqTeR25Hwxb5oYv7XhSHR//VVvC/YPhX0TRm6bdxUzzHTcyHRaS
   Uy4THvnA2LWliMzrO4ZcYvGltnD8Jc6Okbt6zXfenO+l99o/J7LPWUB80
   /pIO6X/2CHrgv4dApNM0p6+t1L/Wo0F06a0qN5Lx/wM6Pesch997lxlmc
   g==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="185026782"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Oct 2022 02:42:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 17 Oct 2022 02:42:49 -0700
Received: from [10.159.205.135] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 17 Oct 2022 02:42:48 -0700
Message-ID: <a30e0ff4-c73e-514e-bb35-18b1b6d49b21@microchip.com>
Date:   Mon, 17 Oct 2022 11:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: fix signal name of pin PB2
Content-Language: en-US
To:     Mihai Sain <mihai.sain@microchip.com>, <robh+dt@kernel.org>,
        <eugen.hristev@microchip.com>, <claudiu.beznea@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221017083119.1643-1-mihai.sain@microchip.com>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221017083119.1643-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 at 10:31, Mihai Sain wrote:
> The signal name of pin PB2 with function F is FLEXCOM11_IO1
> as it is defined in the datasheet.
> 
> Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks Mihai, best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/sama7g5-pinfunc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama7g5-pinfunc.h b/arch/arm/boot/dts/sama7g5-pinfunc.h
> index 4eb30445d205..6e87f0d4b8fc 100644
> --- a/arch/arm/boot/dts/sama7g5-pinfunc.h
> +++ b/arch/arm/boot/dts/sama7g5-pinfunc.h
> @@ -261,7 +261,7 @@
>   #define PIN_PB2__FLEXCOM6_IO0		PINMUX_PIN(PIN_PB2, 2, 1)
>   #define PIN_PB2__ADTRG			PINMUX_PIN(PIN_PB2, 3, 1)
>   #define PIN_PB2__A20			PINMUX_PIN(PIN_PB2, 4, 1)
> -#define PIN_PB2__FLEXCOM11_IO0		PINMUX_PIN(PIN_PB2, 6, 3)
> +#define PIN_PB2__FLEXCOM11_IO1		PINMUX_PIN(PIN_PB2, 6, 3)
>   #define PIN_PB3				35
>   #define PIN_PB3__GPIO			PINMUX_PIN(PIN_PB3, 0, 0)
>   #define PIN_PB3__RF1			PINMUX_PIN(PIN_PB3, 1, 1)


-- 
Nicolas Ferre
