Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDF664B88A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbiLMPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiLMPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:35:49 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCBF1F60D;
        Tue, 13 Dec 2022 07:35:48 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id q6-20020a4aa886000000b004a083f945a6so2420470oom.6;
        Tue, 13 Dec 2022 07:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OUQXNd8OYvFs7+8iUyrLASdaaAYcUXx/ROKukFE8BU=;
        b=fR4iD+ZyQoRTozC1N94PSo1ApNOo/XIFrFr56aDm/tfPpD2b7YFe7RPaFT6VJIpnxe
         IKLvpVNbh9PW1MnYIrvs8mqK39iQc4uG1Uk/hOLT5FEyMZi+6+6q5WoyRTsfmsL7sEgp
         C2BizP5WK1G+go9bfqQy9C20ozrM88GvqeRFJ69vsC7pQiWTe2kuo+b1nnTEU/dde/JM
         +or78GNMcISB+UZuJfrDpnDul8EwcCAAl/DLiWb+ukjfp3NarxYnjS0Rw7f2d+CxHZOQ
         BrrXlcgr1jWyjzUVA2P6mMn0K152x6OPyAeSZyQh5ZdDJQhhGSunSRL+6bbpRGssZXaV
         2erg==
X-Gm-Message-State: ANoB5pl4uWmFUzGOWaXr/cpmgGjD+AKKk6XpyjiDHksAVwt+Ox64UiDD
        FGV90eVfSA5N4b6iLaX92Q==
X-Google-Smtp-Source: AA0mqf5oAzMg6NWIlDVuwgZZKBVTdUgYITUUMi3HoVwRv5EqTUODYJy3Qq4DelBLPMUbE9q9SFlpeg==
X-Received: by 2002:a4a:49d5:0:b0:4a3:7135:d6e6 with SMTP id z204-20020a4a49d5000000b004a37135d6e6mr9443291ooa.2.1670945748025;
        Tue, 13 Dec 2022 07:35:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h18-20020a4a2812000000b00499527def25sm1220105ooa.47.2022.12.13.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:35:47 -0800 (PST)
Received: (nullmailer pid 1398415 invoked by uid 1000);
        Tue, 13 Dec 2022 15:35:46 -0000
Date:   Tue, 13 Dec 2022 09:35:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] dt-bindings: watchdog: qcom-wdt: allow interrupts
Message-ID: <20221213153546.GA1368120-robh@kernel.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 05:35:25PM +0100, Krzysztof Kozlowski wrote:
> Both of type of watchdogs described in the binding (the KPSS watchdog
> and APSS WDT timer) have interrupts.  Allow interrupts and describe them
> for KPSS watchdog to fix warnings like:
> 
>   watchdog@17c10000: Unevaluated properties are not allowed ('interrupts' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/watchdog/qcom-wdt.yaml           | 24 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 1828eaf70b3b..b7fc57f4800e 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -9,9 +9,6 @@ title: Qualcomm Krait Processor Sub-system (KPSS) Watchdog timer
>  maintainers:
>    - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>  
> -allOf:
> -  - $ref: watchdog.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -51,11 +48,31 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  interrupts:
> +    minItems: 1
> +    maxItems: 5

I only see 2 interrupts described at all.

> +
>  required:
>    - compatible
>    - reg
>    - clocks
>  
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,kpss-wdt
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          items:
> +            - description: Bark
> +            - description: Bite
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -66,5 +83,6 @@ examples:
>        compatible = "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
>        reg = <0x17c10000 0x1000>;
>        clocks = <&sleep_clk>;
> +      interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>        timeout-sec = <10>;
>      };
> -- 
> 2.34.1
> 
> 
