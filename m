Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570D273C890
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjFXIE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 04:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjFXIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 04:04:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F0E2972
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 01:03:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51a3e6a952aso1507340a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593802; x=1690185802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LafiNXSw+zwzkCcD61tNVkSDk1UzsnZGQNFOHQIckUc=;
        b=E0MlV0GQvGr61TLHUeLUX7K4RKJbbZT+46+KOPXItxfa1kGrSeRn9gXbUtlckJpnM/
         o3h1VNL1amgLqrC/vh909Fc+Le0/1qVQUczndSlbEc3xMr+6MTs4kw5POYSuAFIaWdjB
         KrrlrOhDRofruYCZeeLquI/1Fd9m+fahMOpm/HOuyaOP2ematY8blA6Yno/Qx3OKWFh8
         y/6ktg4Znn4suJdbr1P5vrImzzc1WqhxUY8e+zJ1gasuY2VORMrZmbllh+XGqcpWlj5N
         VP4AzDVW6JgOoAvkfjnNl9bztm0gXUKz8UOQbBiLxtfCVaY9D/QbpumZtHXeNEYd4u7c
         LEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593802; x=1690185802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LafiNXSw+zwzkCcD61tNVkSDk1UzsnZGQNFOHQIckUc=;
        b=TsCIj3FwxqIwHrmWcSSCodxdM4lNinba2nTfAifgQCd3pguhJRaRGellQNRdCqlIPz
         zNaFDRR5XN0x+mIsqepERAMTpNcWUf/RwFd76oJnAaWx1UGRNcSs4xiAAOLHM34CeekP
         6LXA2D/CKWjbzK61KEf+ec//+4PO+TfWyxrR6naBKal6gBEoQnieAFVYTm/KoVB13tMa
         TVEXkXZ0IiQj+q4VZ9wbH0b8WxM38kknn6kl1FOidpmLoojBSjIa8cbG9oXgv4YxwC4i
         xphELyRPzPznpM07Xa15SXs/Tv24wmIlUeb6iJwQRQ8351gyrQBlMLzaxT/8t/ROMx3q
         Sktg==
X-Gm-Message-State: AC+VfDwE9v9G5p4KFFwwcnkNR0OKYSywKOtq3G7gZuIvfm+Rca+l5UUO
        va1n0YHbssj+UtKhhY1fR7LBXQ==
X-Google-Smtp-Source: ACHHUZ6C0rvzl2GKbsYXoP7Ohg1Api903AvKgo4IuRCGX/jGRLZS6P8DTOGf+2z7abGrmlBbMBqn+g==
X-Received: by 2002:a17:907:2d28:b0:98d:81c7:f01c with SMTP id gs40-20020a1709072d2800b0098d81c7f01cmr3338161ejc.38.1687593802608;
        Sat, 24 Jun 2023 01:03:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u12-20020a05640207cc00b0051bf998b25fsm407586edy.44.2023.06.24.01.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:03:22 -0700 (PDT)
Message-ID: <f158149a-bc40-b828-9631-ff6ca677504c@linaro.org>
Date:   Sat, 24 Jun 2023 10:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 34/45] dt-bindings: watchdog: sama5d4-wdt: add
 compatible for sam9x7-wdt
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, sre@kernel.org, jerry.ray@microchip.com,
        horatiu.vultur@microchip.com, durai.manickamkr@microchip.com,
        andrew@lunn.ch, alain.volmat@foss.st.com,
        neil.armstrong@linaro.org, mihai.sain@microchip.com,
        eugen.hristev@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-35-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-35-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add compatible microchip,sam9x7-wdt to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> index 816f85ee2c77..216e64dfddb2 100644
> --- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - atmel,sama5d4-wdt
>        - microchip,sam9x60-wdt
> +      - microchip,sam9x7-wdt
>        - microchip,sama7g5-wdt

Same as in other cases, so just to avoid applying by maintainer: looks
not tested and not working.

Best regards,
Krzysztof

