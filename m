Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A06BA046
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCNUBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCNUBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:01:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97BD1BAD5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:01:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x13so19493682edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678824072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJw25BbAU1Xa3o/c+4guYsxEw6qrcE3VPRRjP1gJhAQ=;
        b=bS2G0tHr7Ce5LOz4PWs+gsazmMCT6tA1r4i3XQSrdkLbiki0qcg2fuK+RadoackR7T
         PWsz72EpZSIpsrYT5beWMKqIneqeaA2/K4cWUp8KOIQYvGXpjiSuW+hVGENxkJ98bqAA
         oX2dU+L5lh1ovIGRnbETGdScsv0wikOzA1VqOscL57E+y1fxrpyUPzMdDjfVvyBqARS7
         xN1FQM4AlRE6UrHWmRTAVx700CacYtMWm6z7IITerQi8mh/1pJySAQiN6dyDMsm9pB/h
         /8c7quyKWecnux7syOhL78/4WQC28HDZyP65CKgWZpoLRhCehI693NgQavap9wkRkVIV
         b2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJw25BbAU1Xa3o/c+4guYsxEw6qrcE3VPRRjP1gJhAQ=;
        b=oMV6b4gNFNctQ62SN66uciCnkKD6u2TfdDVhXE+5EyL0/cqBXY7tJYT0y0sI1GfNmZ
         semAqbHnKW31fnuIpnVWm/XBubR2cxsrzWJCoYzr0Ir9Z7k1QfmUI1Us/hTRVhW13EU5
         YcupHpkRn0ExuogttBIyxGwQDPSl54eLZKVqsuP4lW3bjdBSwYpk29gyU8/2LaTb4+Fx
         gSu204R8MfE2BZa0Htpfk6OKwDSX/gUqCRK4hK9dKU6P0G21PUqvp5hPbqs5pS6X5Rc5
         ZCpABW0z7qWh/E3H10X4yyJWf3glwlV2yTgBbXavr5z/JizRAGbYLvlta0eh+KFoAeK4
         GzgA==
X-Gm-Message-State: AO0yUKXRHPs9QjpSxfN2SMbi912GiO1eYhL3iF2/CWZ+BhWaD2fRehuI
        NXe3CLJ0dejtIADMSnIc8DvMbQ==
X-Google-Smtp-Source: AK7set/mR3Z2E6wCtQ4/zwg+h1KGCXo/5y3h7lavCBCvkg00L7cXdg2M+jG3+T6bl4ReDVOupOachw==
X-Received: by 2002:aa7:d0d8:0:b0:4fd:2675:3783 with SMTP id u24-20020aa7d0d8000000b004fd26753783mr390885edo.1.1678824072153;
        Tue, 14 Mar 2023 13:01:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:642b:87c2:1efc:c8af? ([2a02:810d:15c0:828:642b:87c2:1efc:c8af])
        by smtp.gmail.com with ESMTPSA id b21-20020a0564021f1500b004fbdfbb5acesm1474588edb.89.2023.03.14.13.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 13:01:11 -0700 (PDT)
Message-ID: <680053bc-66fb-729f-ecdc-2f5fe511cecd@linaro.org>
Date:   Tue, 14 Mar 2023 21:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553
 variants
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230314151201.2317134-1-msp@baylibre.com>
 <20230314151201.2317134-2-msp@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314151201.2317134-2-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 16:11, Markus Schneider-Pargmann wrote:
> These two new chips do not have state or wake pins.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  .../devicetree/bindings/net/can/tcan4x5x.txt          | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> index e3501bfa22e9..38a2b5369b44 100644
> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -4,7 +4,10 @@ Texas Instruments TCAN4x5x CAN Controller
>  This file provides device node information for the TCAN4x5x interface contains.
>  
>  Required properties:
> -	- compatible: "ti,tcan4x5x"
> +	- compatible:
> +		"ti,tcan4x5x" or
> +		"ti,tcan4552" or
> +		"ti,tcan4553"

Awesome, they nicely fit into wildcard... Would be useful to deprecate
the wildcard at some point and switch to proper compatibles in such
case, because now they became confusing.

Anyway:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

