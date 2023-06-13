Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0541972EBAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjFMTK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjFMTK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:10:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9048E199A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:10:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso7421855e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686683454; x=1689275454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bsthYoTMoxKvhCTREZdV1Kid7Fcy+tC3T2OnmSeiNw=;
        b=GD+dsWXhc4Jx4h5q1rLFVbaICNav2yheoYx+hViDBrl+DYy6sh22S+/NJAGlO862nj
         ra1TFSwxC9DtpUR/p37d2Xr45DWefo+F5OlEq05Esb8K/f0K2uT00il8AC87oD4IfgEM
         +mtCFS5e6/pM9m+nt7QSVyM9a5jTQKjtkeD5m38D5OLuefXBHwAxcnIrCI66C/Uyg4ii
         K/Ql5mHMk9H2KQTmCpL4zLsaXkL1emJZfChO+GveeBYvH7Dvjzz1+3tknlbyWqB3PQIp
         yjZCkBQoxYoA9q6L8Lf0RPuTWePxStd3mjVAlHSsqIhd3Pss00hiiNIx8A+AdzhMOJNY
         gEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683454; x=1689275454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bsthYoTMoxKvhCTREZdV1Kid7Fcy+tC3T2OnmSeiNw=;
        b=VMzOa6pnL6MGdqW2tuYjrYRnvrFLDe87F7+GQW6AQQtnVITGvyBNbEq4tORvRQD++H
         eKiaTnkD/2qLbSTYgQJv1BblNugTQx5ZOtpUAO46JX5whvRIqsPWy4n7Das4rzSxDVlY
         dgRw+PwPz5tFYebXqvfypeRLkx1GjT0C/fr2SivqFt+gELxgEXsd1Mm0di8jfQBFUSpU
         D+qD7knZLesrLtHn01WGB/kigq7e/5MeqXsc5IsY6YJZRwLYHkHrkZoeK8+fwZ7Q1bPQ
         l9Bhv5tTKAxMSTnrCYnyiopVX/BZoecEqE52/7V+cbeoF/cbhs8g1e3ppsBYLIf8STeD
         zBCA==
X-Gm-Message-State: AC+VfDw4wok2nHtcbCR2syI1/xBffX+lxpUfkSl7pCs/ern0gnAfXyza
        JjkTgVYRhjfyVlXDLCHfcZeIPw==
X-Google-Smtp-Source: ACHHUZ5OMU9IQGCMZ6AHR8ezt2PQkmNVD/i8Q4phlBfYM0zoCZUE85NqI4RSCWrszKbuQ+cbdZbc4A==
X-Received: by 2002:ac2:5f87:0:b0:4f6:4d92:9ffb with SMTP id r7-20020ac25f87000000b004f64d929ffbmr6606096lfe.21.1686683453771;
        Tue, 13 Jun 2023 12:10:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7cd08000000b005187af2dbe3sm588947edw.6.2023.06.13.12.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 12:10:53 -0700 (PDT)
Message-ID: <208d06d1-58e3-748e-de28-075dc0cd28de@linaro.org>
Date:   Tue, 13 Jun 2023 21:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 7/8] dt-bindings: rtc: isl12022: add #clock-cells
 property
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-8-linux@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613130011.305589-8-linux@rasmusvillemoes.dk>
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

On 13/06/2023 15:00, Rasmus Villemoes wrote:
> The isl12022 has a dual-purpose irq/f_out pin, which can either be
> used as an interrupt or clock output.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../devicetree/bindings/rtc/intersil,isl12022.yaml     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> index d5d3a687a34d..a9ef68b5fdcd 100644
> --- a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> +++ b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> @@ -11,6 +11,13 @@ maintainers:
>  
>  allOf:
>    - $ref: rtc.yaml#
> +  # If #clock-cells is present, interrupts must not be present
> +  - if:
> +      required:
> +        - '#clock-cells'
> +    then:
> +      properties:
> +        interrupts: false

Entire allOf block should be like in example-schema, so before
unevaluatedProperties. Please put it in correct place in your first
patch so here it does not have to be moved.

Best regards,
Krzysztof

