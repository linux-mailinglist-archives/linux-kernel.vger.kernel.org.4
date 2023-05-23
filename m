Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AF370D933
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjEWJfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjEWJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:35:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8919A12B;
        Tue, 23 May 2023 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684834513; x=1716370513;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Iw8Yy2Z1tvGZYFerS0IcUyhSccmNuan8NjhlAC1ECBY=;
  b=j8T88rrUp1OBj4AslXbS5hdPjXJ6e2W9Lhrg9F7oExwpsVes0fTiVzO+
   HSCaI/5Apc3lYUF5AYlrJRYIsT7omULTMYVvOcAuH0zzw8ZmfbZBs2f1K
   W2jkTDYky6hDfFcqFZIp2bwg0/5CCYDH8MDwMhdD6l6tiJWLutECLWesB
   oZkjBjteiOpqPQ4chSiQ+app5bLhP4khdbeCWo1PnyDvafevRAsxwz2n2
   zYWPDweeDHhqKOqqDeJtC5Uzuu0O74hrPOkQ2MdCOWsYEfaooakbRC4av
   2EQcDYIdivYwdc5n3SlB+y7XGEIHY7ewSv4a64NcaZO95AANCAUefoygX
   A==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="216818395"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2023 02:35:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 23 May 2023 02:35:11 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 23 May 2023 02:35:09 -0700
Message-ID: <124faf73-af03-4688-427c-fa247fde40b4@microchip.com>
Date:   Tue, 23 May 2023 11:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ARM: dts: at91: sama7g5ek: fix debounce delay property
 for shdwc
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230523052750.184223-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230523052750.184223-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 at 07:27, Claudiu Beznea wrote:
> There is no atmel,shdwc-debouncer property for SHDWC. The right DT property
> is debounce-delay-us. Use it.
> 
> Fixes: 16b161bcf5d4 ("ARM: dts: at91: sama7g5: add shdwc node")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu. Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama7g5ek.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
> index aa5cc0e98bba..217e9b96c61e 100644
> --- a/arch/arm/boot/dts/at91-sama7g5ek.dts
> +++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
> @@ -792,7 +792,7 @@ &sdmmc2 {
>   };
>   
>   &shdwc {
> -	atmel,shdwc-debouncer = <976>;
> +	debounce-delay-us = <976>;
>   	status = "okay";
>   
>   	input@0 {

-- 
Nicolas Ferre

