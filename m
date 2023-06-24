Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913D773C89A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 10:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjFXIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjFXIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 04:04:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D0F2D7B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 01:04:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51a2de3385fso1739370a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593835; x=1690185835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jxU1m/bl74A0iGu9LghKPO8HvECi5G5jZ9eqVP2K3E=;
        b=SQ0F0qO5g/dUpqxHfRkqAYysEzXvOCArdnrhQsHQTlUpG7NayIMU6j1M2rIyjBDVya
         x5px8eudLBvKa84lRJJJox+1RP1u6RG7I1xJ9FenVAaTLFcvXxgX7X5ih71vApTZLSbv
         jPst2ohqwiY8Dhs65PTypQT3PU1VOdXW3gc/LGGAmf2aKmiwxKxPmvg/XQ3LmeShtkHn
         TVnw0tPg8J0iFuIZ2T8pexQvID1xGMf6y37Y2M+HtoGRe+TKcwVt3TXz2RyCw4u5aGsC
         ExNyGnCkujtDC5OUwFx3xqyNXKIGBCRZBf8fZD4pMy0kbJDPIdlgOlzISH7nDoHMFTw1
         MrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593835; x=1690185835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jxU1m/bl74A0iGu9LghKPO8HvECi5G5jZ9eqVP2K3E=;
        b=IGCLNyirqYzMma6oj9K9Q/AuUo+cIxhZ5+La48NLE1CLwFLTHHH8/i12N+12l+moHM
         FK2cqACCwNgnDb5Q8rxUv5K7LlcCWu5TYEjf6C/SSAA/O5rNHOnK1pBYJVv5KWTYZRp5
         yQWUzF6xIIH+2JIpwCcKoIqytaIhessLJYDUyj86nzASmw33lFWcuqL/7/fTvVFY4bAw
         WgkPgxLHcV92RAl1aXQgvsUzrwj/GexxzACkzf+9zbDEtkR112L6cpm1VVTZhdI/Gafd
         HQ91445NrIqM+fLNeGcWXD+U0mqCWhBTMxrpMQIrqJUp921KVOL0ZGreJeGfqGZnu119
         yPhQ==
X-Gm-Message-State: AC+VfDyCFBiqYqipFY1kmwTfN52qNQ+C9m40VAM799KDcwuBzLkxmfpa
        vbzh8PSkg+GDVKrJsi1pj2aFjA==
X-Google-Smtp-Source: ACHHUZ7SxDDSVPtNN64oZsP8HBukovPFIpinv/C1GfUthOVpQroM4LCwYJgVu5igdC2NaJUOIO0FXQ==
X-Received: by 2002:aa7:dbd9:0:b0:518:7ad9:64bb with SMTP id v25-20020aa7dbd9000000b005187ad964bbmr15293063edt.19.1687593835490;
        Sat, 24 Jun 2023 01:03:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c4-20020aa7d604000000b0051a4a1abdbbsm411437edr.49.2023.06.24.01.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:03:54 -0700 (PDT)
Message-ID: <7ad81b90-0463-c660-d290-34ccfc1c2e5e@linaro.org>
Date:   Sat, 24 Jun 2023 10:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 44/45] dt-bindings: arm: add sam9x75 curiosity board
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
 <20230623203056.689705-45-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-45-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add documentation for SAM9X75 Curiosity board.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++

Did you receive here tags?

Best regards,
Krzysztof

