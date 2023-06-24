Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE09673C949
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjFXI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjFXI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 04:26:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A121A7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 01:24:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98746d7f35dso191157366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687595052; x=1690187052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUb+krGwN/aq//L4Czp4P4ZaV1gvYMjmNFcm0YMeIks=;
        b=wfHoDe9cIAIca7EsAKsAr3JGWE8sq2MW2O+c7PQLh1pSatj18V4ReY0Rhp2KxwHNns
         Letp+XNosErgy92slLif7EFMK4zFpG07AGnzgqdoHWkaQ2dvFjt9ZMLAHLH14aadkBUJ
         zvQhYhjZcOzMyaSsgMkcpK/mz0E63T4GUyZokGjoeuWaHmdGYgfuqIFLeE4aQxV9R6+F
         uF2UVV5jN53ep4E3ePyzKEJv8Mo1otzJGbDcYkI42zo0LL+d9muUOoF1uPktwzvGld9H
         s82lPYOy1p6iT3idKy7pXV7HlYI8iJ6PfRA1gCbNjDf9Vpx7IgvKlECzvdI7VLA6kWPR
         I4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687595052; x=1690187052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUb+krGwN/aq//L4Czp4P4ZaV1gvYMjmNFcm0YMeIks=;
        b=GqJeWuymlpDEM8JyiaiP+sdzpB27GBenzb2dsajaAH39xBjzMZbQUIdeGQpM2ZbLpc
         seUTvMBtF4nP2QhHvOfjLQpHfhJmEPjcs6RJZYvMusjDLHkcBxCEo2yF5Ck+xG9wtYut
         UkopSNymZGHFRz2Cl0cPrSV5cZqh8llEcDbKgYu9Op4Fhx5Ffihq4+H1v7uIeZycwmr0
         E0iDUNBDIN+YmFZuKbmv0GjhIAHTbTjO2Um0b36UHpLdMrrbrPiWzVkq874r64oTKfHp
         3YWlmesGRPOduaS7PrpOU5J0WsUHwrbJ2fTfhDOgZ6BvtzQda3zl3auAFBuAFSxPML/A
         RzZA==
X-Gm-Message-State: AC+VfDwDfcfr5Tw0HvHpxCAcZwvuQZTiUoLw4uieAUkOeELCYqvqKGMB
        IhwTT79bTkYrq/2YQVd1QcGT7A==
X-Google-Smtp-Source: ACHHUZ633G3vozqxhYSlb2/G6s1lR3tDI248WrtY+qSGpfA/pYjsCnzPQDLjOoJSYY1d4qs/oFcuJA==
X-Received: by 2002:a17:906:da84:b0:988:f307:aea7 with SMTP id xh4-20020a170906da8400b00988f307aea7mr14027159ejb.7.1687595052667;
        Sat, 24 Jun 2023 01:24:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906528f00b0098866a94f14sm610407ejm.125.2023.06.24.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:24:12 -0700 (PDT)
Message-ID: <8f231d42-1022-0595-2dc6-24817a7495b4@linaro.org>
Date:   Sat, 24 Jun 2023 10:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 22/45] dt-bindings: atmel-smc: add microchip,sam9x7-smc
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
 <20230623203056.689705-23-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-23-varshini.rajendran@microchip.com>
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
> Add microchip,sam9x7-smc to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-smc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-smc.txt b/Documentation/devicetree/bindings/mfd/atmel-smc.txt
> index 5696d9fcb5dc..1eb2606820a5 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-smc.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-smc.txt
> @@ -10,6 +10,7 @@ Required properties:
>  			"atmel,sama5d3-smc", "syscon"
>  			"atmel,sama5d2-smc", "syscon"
>  			"microchip,sam9x60-smc", "syscon"
> +			"microchip,sam9x7-smc", "syscon"

That's not what your DTS is saying. NAK.

Best regards,
Krzysztof

