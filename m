Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6EE72ABA7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjFJNQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjFJNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:16:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316626AD;
        Sat, 10 Jun 2023 06:16:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-654f8b56807so2862379b3a.1;
        Sat, 10 Jun 2023 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686402988; x=1688994988;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6ecJGJDuuEEHRoPE7ipHiRhKubpIsd+Z4uIhEGj22E=;
        b=EnHaoUtnWBfp61G7idmJ+243jNQ9zoixKb8v5lFB83ObX93cho2hWFPH51MMLpB0An
         GYw/rKGnK0kSZaFKhZSEv7AGhgEjI5JIryR0vASUy+0p+ukAsi40101y4BbbOhOC1aEp
         c8aqikHiCad0YwmMsnGzCpU+9Y5mqBT5qn2aAP9p/dWCTc3e4O30BYd38iA15NaXUzSY
         D0zCQZVQoLK8pay3X4gsYlNMptn8BQqeOc9es8KG17cFXBIa9/w44YaLIZcStf8tGa6J
         aWcVu4jYQOlrE08EiW6ScZP/6tgvepPp1s3+jX8Hm3PbwEzNvHvPH1wqIVCP5RAS7cPZ
         mmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686402988; x=1688994988;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6ecJGJDuuEEHRoPE7ipHiRhKubpIsd+Z4uIhEGj22E=;
        b=GMX8T9Hh8uXfYFq2Pi1EDf0V4r95HscKWHGtlxMVkLdDQUSdP5T2AVl3IsmxNgSiKz
         ypkkyxQzRGB/m1tss0TeT56UhAtLKsQNUI6OvAZRNAUfMTp5HhCPdqR5BctEeLYdoTLu
         G4Nl3pj4SwUmRgwhhTTD55M0qkhRfcaEOH5hfJP4cei8hbG8Zo2f0TyC00hppQF4Xjvr
         mK3eZW++L6QoWAD30R8vhn4pWjPLscG43mLocHxb033ZIYoCMEyKIZuVzia0BqRDOvt7
         2+oCj/NY0oAZko3XADK+9A2oqKwoxNZ3PMJJqviqiVITPj7ryv71wlUs2+kn/wBNRWvE
         Iplw==
X-Gm-Message-State: AC+VfDwTHMhd1jfiX2xqhv1trO/IuGbuSXVlcWuo0AtoODj/IlPUZlot
        iJJ5K+GsagJe22MnkQzy/RI=
X-Google-Smtp-Source: ACHHUZ64/c2TGyOHXIs+2seDSd6fkb6u7cXrIE+DgseUC/1VzddEpRZeI7jJXQywUmd8QqKIGsvBEQ==
X-Received: by 2002:a05:6a00:1705:b0:662:5c39:48e4 with SMTP id h5-20020a056a00170500b006625c3948e4mr4664245pfc.9.1686402988206;
        Sat, 10 Jun 2023 06:16:28 -0700 (PDT)
Received: from [172.30.1.8] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e14-20020aa78c4e000000b006439df7ed5fsm4180336pfd.6.2023.06.10.06.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 06:16:27 -0700 (PDT)
Message-ID: <77b25ee9-34a6-d651-3476-05b1c5590521@gmail.com>
Date:   Sat, 10 Jun 2023 22:16:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: extcon: wlf,arizona: drop unneeded quotes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        - <patches@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230609140740.64990-1-krzysztof.kozlowski@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <20230609140740.64990-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 6. 9. 23:07, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/extcon/wlf,arizona.yaml    | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml b/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
> index efdf59abb2e1..351b202d0e10 100644
> --- a/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
> +++ b/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
> @@ -23,7 +23,7 @@ properties:
>        headphone detect mode to HPDETL, ARIZONA_ACCDET_MODE_HPR/2 sets it
>        to HPDETR.  If this node is not included or if the value is unknown,
>        then headphone detection mode is set to HPDETL.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 1
>      maximum: 2
>  
> @@ -51,7 +51,7 @@ properties:
>      description:
>        Additional software microphone detection debounce specified in
>        milliseconds.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>  
>    wlf,micd-pol-gpio:
>      description:
> @@ -63,7 +63,7 @@ properties:
>      description:
>        Time allowed for MICBIAS to startup prior to performing microphone
>        detection, specified as per the ARIZONA_MICD_TIME_XXX defines.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 12
>  
> @@ -71,7 +71,7 @@ properties:
>      description:
>        Delay between successive microphone detection measurements, specified
>        as per the ARIZONA_MICD_TIME_XXX defines.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 12
>  
> @@ -79,7 +79,7 @@ properties:
>      description:
>        Microphone detection hardware debounces specified as the number of
>        measurements to take.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [2, 4]
>  
>    wlf,micd-timeout-ms:
> @@ -97,7 +97,7 @@ properties:
>        CTIA / OMTP headsets), the field can be of variable length but
>        should always be a multiple of 3 cells long, each three cell group
>        represents one polarity configuration.
> -    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>      items:
>        items:
>          - description:
> @@ -119,7 +119,7 @@ properties:
>      description:
>        Settings for the general purpose switch, set as one of the
>        ARIZONA_GPSW_XXX defines.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 3
>  

Applied it.Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

