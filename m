Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B82964E9A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiLPKlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiLPKlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:41:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12D0442C7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:41:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so2832931lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKWFv4+1LvBdg0mr235r5AhUkZyQqNGBCErVEiGMmEg=;
        b=R7vAAqzgGShnocas6YZpTgDxaoNtnMm4wXRoNvlsBNw/NdoisDd+xIdHMd354q2ynx
         17qlRfXH1JuGiWpSphIrlIVRpL1pQPtrC8M4ViDxvnnktKflFfYENjNQafoYhz2gHb8Z
         4r2hCJmto8v201veR7/DZW5xtjgviSJyTgX1Uhj7psKfTM2gWcsevue5ORk66mq8jDOc
         bHUnR7vGJE07tQriPNU5+ty6xBMJB8AHNKuNJjprobIFOqvb9DG5Mv+1IudQ7V8kXE0P
         CJDapD2XerUx326jheWOzBncXPkzC5kygn7U6hZyFiOVNOrIlBqbTzMuhqEMNKmOBqtb
         ZmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKWFv4+1LvBdg0mr235r5AhUkZyQqNGBCErVEiGMmEg=;
        b=0E/DhZkH6BZlXaz/YlUqoIotsjsyOesSSvtDb8DMkYcZcIzDP3OmfhpQf4RGtBfOho
         op69gpYaLhRaWr2sDTrIYWuFfPI6zdJ+fWbinDRFqvOm7E4hSLqJ0UNiGOP2Y4ioAKzW
         W6Ql/yJ/FlNHa205Va1xzRdiH5VAYLghK8fve8BdXkV8+2fMnDpms1YnxoaRU6yaRiXw
         guzPoSLY667q0D37m5lMZNKXJccc1pairUZRdYV08+wtlHCfi8p14Dwm3EKGDUf9o6Kj
         tkP79VINv5MbCZDKXxdn/SNSN7aILmlB6PxdX1z36i2NEcxYzNxaER+810AMMwDCjPf1
         hBBw==
X-Gm-Message-State: ANoB5pll+IFV7DGFIXx+O0h266YMqnqoRxFslbYU68f1DMfMUpjB+OfG
        YKFNVokFFbAwKiyOQU1kU9doqA==
X-Google-Smtp-Source: AA0mqf5+6cqyJyuRix6TrVBYKCydgdKKG+rfrjT7ZB2TWH+1nm5rapmQtuPaFGLtr72Thnbg8KH7eQ==
X-Received: by 2002:a05:6512:3691:b0:4b6:fddc:1fcd with SMTP id d17-20020a056512369100b004b6fddc1fcdmr3929040lfs.23.1671187292163;
        Fri, 16 Dec 2022 02:41:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q1-20020ac25281000000b0049478cc4eb9sm184253lfm.230.2022.12.16.02.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 02:41:31 -0800 (PST)
Message-ID: <0f3e755f-954a-9722-6898-181170deb2c3@linaro.org>
Date:   Fri, 16 Dec 2022 11:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/2] dt-bindings: display: imx: Describe drm binding
 for fsl,imx-lcdc
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221214115921.1845994-1-u.kleine-koenig@pengutronix.de>
 <20221214115921.1845994-2-u.kleine-koenig@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214115921.1845994-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 12:59, Uwe Kleine-König wrote:
> Modify the existing (fb-like) binding to support the drm-like binding in
> parallel.

Aren't you now adding two compatibles to the same hardware, just for two
Linux drivers? One hardware should have one compatible, regardless of
Linux display implementation.

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  .../bindings/display/imx/fsl,imx-lcdc.yaml    | 45 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
> index 35a8fff036ca..2a8225b10890 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
> @@ -21,6 +21,9 @@ properties:
>                - fsl,imx25-fb
>                - fsl,imx27-fb
>            - const: fsl,imx21-fb
> +      - items:
> +          - const: fsl,imx25-lcdc
> +          - const: fsl,imx21-lcdc
>  
>    clocks:
>      maxItems: 3
> @@ -31,6 +34,9 @@ properties:
>        - const: ahb
>        - const: per
>  
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +
>    display:
>      $ref: /schemas/types.yaml#/definitions/phandle
>  
> @@ -59,17 +65,54 @@ properties:
>      description:
>        LCDC Sharp Configuration Register value.
>  
> +if:

Put it under allOf. It grows pretty often so this would avoid future
re-indents.

> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - fsl,imx1-lcdc
> +          - fsl,imx21-lcdc
> +then:
> +  properties:
> +    display: false
> +    fsl,dmacr: false
> +    fsl,lpccr: false
> +    fsl,lscr1: false
> +
> +  required:
> +    - port
> +
> +else:
> +  properties:
> +    port: false
> +
> +  required:
> +    - display
> +
>  required:
>    - compatible
>    - clocks
>    - clock-names
> -  - display
>    - interrupts
>    - reg
>  
>  additionalProperties: false
>  
>  examples:
> +  - |
> +    lcdc@53fbc000 {
> +        compatible = "fsl,imx25-lcdc", "fsl,imx21-lcdc";
> +        reg = <0x53fbc000 0x4000>;
> +        interrupts = <39>;
> +        clocks = <&clks 103>, <&clks 66>, <&clks 49>;
> +        clock-names = "ipg", "ahb", "per";
> +
> +        port {
> +            parallel_out: endpoint {
> +              remote-endpoint = <&panel_in>;
> +            };
> +        };
> +    };
>    - |
>      imxfb: fb@10021000 {
>          compatible = "fsl,imx21-fb";

Best regards,
Krzysztof

