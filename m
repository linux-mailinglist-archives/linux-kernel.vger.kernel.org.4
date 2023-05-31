Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB237717ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjEaI62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjEaI6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:58:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0D3129
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:58:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so1458163a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685523494; x=1688115494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZOJX+i4TLfiEsCn8YaTCEUp1T6TkIMRzoXYTVTKTwE=;
        b=tf7l8uvbRO82F7iOCNa67n/0NsNgq9oitardSkfe9ypo0dEYwbGk6qReU9MsmccPeW
         oMll0Z6SZSR80HtgGrmcGw/EWNSQH1VTX+k2Q+zvAtBVJEdSoE0D4ngt60hD4aevLc86
         g+smoyRWh3KhyW6/PZ/owcmoF1f9DD7eIDVxg/XrlPlX0/KQyQUxXKp6idgE5bYCeB2+
         8LPSLUtShHbO82tI8L3gA3beGaN8Ts2AfwMhw5WPWKnedUWkXEP5/ggqfEGWAe+68WPM
         IvYNdPagIEAl2vpyAO7iIB0u2fuux4Pa6yHWyRuGzC44zPtNG/KXplTwG8mVFRkALeO3
         D4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523494; x=1688115494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZOJX+i4TLfiEsCn8YaTCEUp1T6TkIMRzoXYTVTKTwE=;
        b=MpN7oE5puwPknH7NJ42t0Qc5bh6VUhEEVycaKkOmbPXjTI62Va+Tc+OFW1PrhQrVXt
         Tr6GQtOdKNcHGl0Uop2Y0SejdDT7w3CDUaaBVKhAvRvKZsFFpKktmxxB2yDO2Ut1+oSk
         bFkbgl4C6bTroxz5B1incd9lwf0vzeFYV41no46/5e8E7etNrtxEELU0N09Emhu1Oh2u
         UcA1vf18p3Gf43VOXti3iUDVyDe0665conZDY5kRkiuUmSamkGt1BsZdCDRtYf4Tgd7r
         e4MoBftgVG0cEEwVXdwtAnh9C74AHfgVZhy3/PWKxvMOOv3265KLUlD58+VrlGN4/Yir
         InJg==
X-Gm-Message-State: AC+VfDxG3q6ls8DAc5w8Uc2vsWfnkZQ01U2g4vPKiI+6205KwTZz4tdq
        7GF0CfSYaDXzcAycqgg5pRkLxw==
X-Google-Smtp-Source: ACHHUZ7D0DFhOH7Mv7mobfMdQDueNhD3A5z1ZYhEtoZ+dyoJUJ4Wgbq7+pTLJlNSi5YJw7+le/Xpnw==
X-Received: by 2002:a17:906:ee88:b0:96f:aed9:2520 with SMTP id wt8-20020a170906ee8800b0096faed92520mr4250579ejb.21.1685523494145;
        Wed, 31 May 2023 01:58:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id br7-20020a170906d14700b00965b5540ad7sm8738335ejb.17.2023.05.31.01.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:58:13 -0700 (PDT)
Message-ID: <5908a6d6-e93f-d6b3-ee8e-d923663a80ed@linaro.org>
Date:   Wed, 31 May 2023 10:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] dt-bindings: timer: atmel,at91rm9200-st: convert
 to yaml
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
 <20230530090758.1652329-4-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530090758.1652329-4-claudiu.beznea@microchip.com>
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

On 30/05/2023 11:07, Claudiu Beznea wrote:
> Convert Microchip AT91 system timer to YAML.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> +properties:
> +  compatible:
> +    items:
> +      - const: atmel,at91rm9200-st
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Contain interrupt for the ST which is the IRQ line shared across all
> +      system controller members (memory controller, debug unit, system timer,
> +      real-time clock, power management controller).
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  watchdog:
> +    $ref: ../watchdog/atmel,at91rm9200-wdt.yaml

Full path, so /schemas/watchdog/atmel....

> +    description:
> +      Child node describing watchdog.
> +


Best regards,
Krzysztof

