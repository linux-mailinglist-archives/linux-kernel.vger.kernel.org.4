Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6E372EAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjFMSR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjFMSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:17:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90923E57
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:17:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f62b552751so7258704e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686680237; x=1689272237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eLJxUkGwEhV3L4pfZK45Zz/NqrL+/LdhPQYtZgAc5Y=;
        b=d445rOahKAWBdoKCCt6Ljhdoc8txuIdE8gFQ0Zim1iUxv4xckznCmZjcH0td68mCaZ
         LLRhRnMcjm0xYCkSsyIokE9MTyJ4hLNeJ5EU8M7nTTGsa3Z3RxSDUe2g7OdkaIrx2Nx2
         xX80IwONVu9RlLhsLOuJfmF6v60UTDNuydmlRm1FaET153qsfPdYGc/g6VLLEmQZXSQW
         gnAPexJRiE9PAGheUW6d3SVYYvcoew+OeAzqm4RjuGQVQ3NTKvuVgVpprfSdobcStisz
         b0DzBLjr0JNg4yBg2m0vwCOqnpQUALPuzRoKgBTWPpH9Oy82hDITcvbGk6TGV3KiE+38
         StJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680237; x=1689272237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eLJxUkGwEhV3L4pfZK45Zz/NqrL+/LdhPQYtZgAc5Y=;
        b=W01mC7246BwghRM4ndlZIdf1MUp6b6dHmr+fJ4/jmYUy4TxgiRKgoZ1/crprFHe17O
         3MaMhJGximX2kHZprRpB0v2V+Nwdr8wsAzTjImpX4JDKMeMCt+LE8rvvI7i/adxPV0Z3
         3iwD4tF4c8PisuziOJn/YhuMPS5+kfW+qmA+Pa1bF58+qjLDd20nWJqz2ufVB38SOJb4
         RUHlEi/uWasd2OSCvt8nDLSQPXGXsFFNJ25yJLrRJSpbHz7C3P5jV0949dMaOJElTF98
         leWqMmo6hRYNzRTjmMI8WYeOAzbUZjE/xFJlVpE0wUhpCc5Yykvi00XKSIjoHq/+kc2f
         clEQ==
X-Gm-Message-State: AC+VfDz55UnKf0vwpCT2EjDmI1y8r8mnfAbiOaKqIebw7KnKzktDfQtN
        uiK8RDPw6VCSRa/d8LjvsjoGJg==
X-Google-Smtp-Source: ACHHUZ4AuHUoFogcm9YXsuPvppxWikUukfl4gp7Sr64iT0Fiq1NCuxkfSUj2TSBJdR6Tn6k4xBuWDQ==
X-Received: by 2002:a19:5e12:0:b0:4f4:b28d:73eb with SMTP id s18-20020a195e12000000b004f4b28d73ebmr6122291lfb.12.1686680236841;
        Tue, 13 Jun 2023 11:17:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c9d0000000b0050d83a39e6fsm6786653edt.4.2023.06.13.11.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:17:16 -0700 (PDT)
Message-ID: <a0b059d1-df4d-10ce-fb7c-7acea0a20793@linaro.org>
Date:   Tue, 13 Jun 2023 20:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/9] dt-bindings: mfd: Add bindings for SAM9X7 LCD
 controller
Content-Language: en-US
To:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, sam@ravnborg.org,
        bbrezillon@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-2-manikandan.m@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613070426.467389-2-manikandan.m@microchip.com>
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

On 13/06/2023 09:04, Manikandan Muralidharan wrote:
> Add new compatible string for the XLCD controller on SAM9X7 SoC.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> index 5f8880cc757e..7c77b6bf4adb 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> @@ -8,6 +8,7 @@ Required properties:
>     "atmel,sama5d3-hlcdc"
>     "atmel,sama5d4-hlcdc"
>     "microchip,sam9x60-hlcdc"
> +   "microchip,sam9x7-xlcdc"

Google says sam9x7 is a series, not a SoC. Please add compatibles for
specific SoCs, not for series.

Best regards,
Krzysztof

