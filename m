Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC973C7CD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjFXH4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFXH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:56:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB22733
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:56:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98d8c38549dso189337466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593372; x=1690185372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSt2AtZZh3GZpsNl8QTQCKxlNBUmkNMW7h6B51q0Fvg=;
        b=tp25xMDkznV75JI3vdiNAJWl65hzOtE1vIYxwwqhJlEy8/uxyjJc8gmF/4BpROZwMT
         So8ags5GA1qeqt4Tvv428U9zTD3AyFOt9eJl17rkpG9KAF+5CO4JrNvHK7RXC/XAuRr+
         JcopiYDZa1WusC6EfjHKdyFc3XbT1M/q56rklAdlCGENZH4tkQV/QG/JZVau6sqLBXB0
         2dRHekqT/OoGYzPBegRHXQEZ3vSChxxWz73Vul9JkPlhE3sg97lUxnYzd8hlJPIBh9re
         Ua5gz1poF3bWk4vsdRhFLrh3EuQLyNSezyG9xckHLFn7241Ta+EO82c3g+jtHwkNHVWO
         bPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593372; x=1690185372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSt2AtZZh3GZpsNl8QTQCKxlNBUmkNMW7h6B51q0Fvg=;
        b=ba1jMwd7TtVyO/6JxLmgj6U0WYi9dhr5lZlgDuUXgvIvKvqVCwskO/QOlIOnGwZUCM
         ykheLlmHSU85E9TTv12rYt9nHRwXxbN2UoF2p1Cy86vOUp9Y592nLtqdN5BHqkcJ1S8Z
         v97z0XSskWK+sLXsZI5vhI4KBAmdX4PnNq1BXYa4pjhNh90y5tZpjIzMM2zQAvTOZcRQ
         SN3qzQvqAPm+t0ww17knl7AfbXsM17ut13rtf6Le4QiWmkh9VV7oaUEH6B6ZBCdYfHBO
         58prmUpY1KisIBaWVOsG8tleeRVcwm3wPbCzitdqIdEOuw6rLZlrYAunFwneh5Trj44h
         DdeQ==
X-Gm-Message-State: AC+VfDxk+5/qO3ryDlebZYnnXNheOl3eMRJtk3vLTtttNpcu2ShbQjEC
        /zdpaAgcvyLvaaJ2eAC/cTykfQ==
X-Google-Smtp-Source: ACHHUZ6NF60BoiHF1787mu6pGM6EiBURQ9TKeKNqM6q3ihuvMLTZrjMfALGAKYzmSFnyF+q8mSD8Pw==
X-Received: by 2002:a17:907:970e:b0:98d:470d:6c7e with SMTP id jg14-20020a170907970e00b0098d470d6c7emr5868847ejc.16.1687593371873;
        Sat, 24 Jun 2023 00:56:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id fy23-20020a170906b7d700b0098d4ac60c20sm577426ejb.190.2023.06.24.00.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:56:11 -0700 (PDT)
Message-ID: <f2f8cabf-ca4d-c6f3-5561-b24334be89d1@linaro.org>
Date:   Sat, 24 Jun 2023 09:56:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 00/45] Add support for sam9x7 SoC family
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-1-varshini.rajendran@microchip.com>
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
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added

Your CC list is enormous and causes multiple bounces/rejections.

Organize your patchset properly to avoid this.

Best regards,
Krzysztof

