Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED82870B8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjEVJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEVJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:18:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C478B9;
        Mon, 22 May 2023 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684747138; x=1716283138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fDtexVohjVYX6dRilxkmMbucr9mn93hRsD+jI1yt23g=;
  b=vFINzo5mHbImGxXRs9ObpcFpXD7+ZR6m2mkObQH7n+sx9peYE5CMeL/J
   fImvwlQ6ZK/hWDEgnhY4cnF1Zg6fb/UQggMUdpQPfM/PRndkc4cAjFJcu
   3jiW/UcQ6jp406BYQVaWUEshkTY8Sxcy6l1uSbpglQU5Fu4bsbetrxnfq
   bQIgEdkqKcN3F8OIFaDtJC3VGCCXUyWVXWQph2n5UmmC3NDTAI87B1H6t
   pEt/iVdB4Z9Y2sOG4TbpVoKvNJwqVPbI7EsF8SjqNSpzftpXbnvRKRpjv
   xM5nXrTfNhSw2sL1+Sj+1V35eelwUMNb5DIe3okT/U8znshr9QFiIpTnc
   g==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="216609345"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 02:18:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 02:18:55 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 02:18:53 -0700
Message-ID: <928e87a9-2335-1af3-d4be-8d7eda98ddba@microchip.com>
Date:   Mon, 22 May 2023 11:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: at91-pio4: Add push-pull
 support
Content-Language: en-US
To:     <Ryan.Wanner@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linus.walleij@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
 <048a41d1dcb3da0e845986a73eaac61a54c69269.1684313910.git.Ryan.Wanner@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <048a41d1dcb3da0e845986a73eaac61a54c69269.1684313910.git.Ryan.Wanner@microchip.com>
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

On 17/05/2023 at 13:54, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add generic push-pull support for pio4 driver.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   .../devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt    | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
> index e2b861ce16d8..774c3c269c40 100644
> --- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
> @@ -37,7 +37,8 @@ right representation of the pin.
>   Optional properties:
>   - GENERIC_PINCONFIG: generic pinconfig options to use:
>   	- bias-disable, bias-pull-down, bias-pull-up, drive-open-drain,
> -	  input-schmitt-enable, input-debounce, output-low, output-high.
> +	 drive-push-pull input-schmitt-enable, input-debounce, output-low,
> +	 output-high.
>   	- for microchip,sama7g5-pinctrl only:
>   		- slew-rate: 0 - disabled, 1 - enabled (default)
>   - atmel,drive-strength: 0 or 1 for low drive, 2 for medium drive and 3 for

-- 
Nicolas Ferre

