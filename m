Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214695FC6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiJLNi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJLNia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:38:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D74AC1DB5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:38:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a5so5396209qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wP6wlJrJq0AXapDJFS1bYYPOvHfLJ0V91QFvJt3EmM4=;
        b=htS8wPekH6ZSTbgOxRhFhZzM4WaVmH3SLzrWzC/csQJEta5wzwnBq4VgX4HRuq/wlv
         2pM/l+kPsilF2MhKae2HPvsrPCttQ8QtTGGvoCJp+XsmAniI5lpVRLZbX7+WUo+oIhvz
         T4lSI+UCD0m5D01yBDCns7rW+Y+H1KoMIM/5r83mopTdmTL53iG/0DFKiHcWe1u0knZr
         2UqYxxTlO5VDXX4pa2JHwaop4luDOwSgM7UZu6KPk0p3L0R6jvuGur8oh+HVIZkylke2
         Vavk6GqRLhmSpHCnw39fQAiCuAZ9PBGPt7lfuEpyo9x8N4wOhOqcuL0Fl0uDSy16/B0K
         gzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP6wlJrJq0AXapDJFS1bYYPOvHfLJ0V91QFvJt3EmM4=;
        b=8J6oH86XYDLUvbKICKhD9DRuOJt/DhUwIkgixXcE+dzRjOsqShukG2fh1P8FNb467n
         UwL3ojx78jKTNrZHZGbJx+4jQRG6/lRtwXTcQXfQ9WYhElvGDdgz+UrnH32Jfc0GiEgm
         2pjmNuHNYdQLuH2DgBn/vJ54XYRa4YXDACo9FS9x3GLlx65CIy2QWY7vgIxDqfD8khr4
         uEDmAeGBdsLt56RF7e9uc80F4gf0MVHt6w03yO6e5Sju07Y84jfa1DjTYfQ7IHGTuDqu
         5M0NxPiOIZMb76vFNBMTxB+wOeqlb3AskTmTgM2NNgl3Me9Eo4jjTD8GSNzCIG1NkTfu
         x7OA==
X-Gm-Message-State: ACrzQf1/G4FPerDxmNFRX2TctFPPhzKTUCmOM9SMtQSjqcBtzMrOWlqI
        jq6uaQNuvBMlCXc+nfYUE4n27g==
X-Google-Smtp-Source: AMsMyM61O/+jzXk0HyMtHXDlasOurO4ukB3Oer0kNlfh77afIvaaO559V1ICYh8C+CvN9BGgABt9ZQ==
X-Received: by 2002:a05:620a:4594:b0:6ed:ee1f:3974 with SMTP id bp20-20020a05620a459400b006edee1f3974mr8299284qkb.688.1665581908203;
        Wed, 12 Oct 2022 06:38:28 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id bq8-20020a05620a468800b006ee0b144730sm6361377qkb.69.2022.10.12.06.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:38:27 -0700 (PDT)
Message-ID: <2eaae603-9726-290e-7c9d-67b89256140c@linaro.org>
Date:   Wed, 12 Oct 2022 09:38:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 06/11] dt-bindings: thermal: k3-j72xx: conditionally
 require efuse reg range
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20221011231727.8090-1-bb@ti.com>
 <20221011231727.8090-7-bb@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011231727.8090-7-bb@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 19:17, Bryan Brattlof wrote:
> Only some of TI's J721E SoCs will need a eFuse register range mapped to
> determine if they're affected by TI's i2128 erratum. All other SoC will
> not need this eFuse range to be mapped to function properly
> 
> Update the bindings for the k3_j72xx_bandgap thermal driver so other
> devices will only need to define two register ranges
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  .../bindings/thermal/ti,j72xx-thermal.yaml    | 34 +++++++++++++------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> index 0b6a6fa07a532..387628ab35959 100644
> --- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> @@ -33,16 +33,6 @@ properties:
>        - ti,j721e-vtm
>        - ti,j7200-vtm
>  
> -  reg:

No, keep entire part here.
with minItems:2


> -    items:
> -      - description: VTM cfg1 register space
> -      - description: VTM cfg2 register space
> -      - description: |
> -          A software trimming method must be applied to some Jacinto
> -          devices to function properly. This eFuse region provides
> -          the information needed for these SoCs to report
> -          temperatures accurately.
> -
>    power-domains:
>      description: |
>        Should contain the phandle to a power management (PM) domain
> @@ -52,6 +42,30 @@ properties:
>    "#thermal-sensor-cells":
>      const: 1
>  
> +if:

Put it under allOf.

> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ti,j721e-vtm
> +then:
> +  properties:
> +    reg:
> +      items:
> +        - description: VTM cfg1 register space
> +        - description: VTM cfg2 register space
> +        - description: |
> +            A software trimming method must be applied to some Jacinto
> +            devices to function properly. This eFuse region provides
> +            the information needed for these SoCs to report
> +            temperatures accurately.

Instead:
minItems: 3

> +else:
> +  properties:
> +    reg:
> +      items:
> +        - description: VTM cfg1 register space
> +        - description: VTM cfg2 register space

Instead:
maxItems: 2

> +
>  required:
>    - compatible
>    - reg

Best regards,
Krzysztof

