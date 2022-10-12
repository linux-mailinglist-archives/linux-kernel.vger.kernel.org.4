Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755235FC69E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJLNic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJLNiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:38:25 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2672BC1DB5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:38:22 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l28so4632735qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SidGkWFa9nPlFG+3QhCQlPl1KwD5+nWLJM4PPfubZi8=;
        b=yduzRp+hEe3uLj/tYh2WUUp5LNVSRTO5Ou6Hf2Aws8/SZ6563pC1LqWisK5xF7j+vW
         V6C7qRDWiVJo9+A8n2Zm3ki5hdDmFcHQfkcI7Ie3aJ6Y0fJcrtViu5tW0dmRG7bhB+lt
         9frA7NqruVeUgoTaGK+LZb0rrr3YLfPMyYUSM7NUCXh0NygZhFHvoDMrUDFl9kVx62Y4
         SfMezfHWTDv6B4IERJR7U+cr9ZaMAXuYzQSbOaiuRmLOvDGeuaT6suxMahHOSgbRIjjp
         ydArzJELLkjM/NxwQVgQx5+BaPzxWdtBWCMJOnzYjeO+bEWC+TZGxKnSi12gOX9gczKn
         Yrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SidGkWFa9nPlFG+3QhCQlPl1KwD5+nWLJM4PPfubZi8=;
        b=POqzMFgoht4Uof9dccOYjDARfzaobiaxsci/B42iN9LPtWcZYhWdKSSfr1PXFz1Sso
         WQGR9JbcND84Zz3gi9vQyxvdXrA+zkbtSxD0BTLw2T6bwpyJ5VzhL5GmnZd82WLAw5i5
         udtCv1ruYaC2aucxhKCUbHS2CUi8FSB4ikYBCEWSYsdhxwLhd9j1xjNKm6Gf3ODS4CCD
         FnA6Wpg2V5d6MGRuqiEAeLSHoqEozAb94WuIl9AePzfdoIC2D3mC/793+SJ/vQVAG4hG
         xg8NUxsRUUCi1KSfUE0lNflWLWuZVg9Cgpi1PiDMPxSp4HuOJIUXfjyGIj4z9heHoPZG
         qvZw==
X-Gm-Message-State: ACrzQf2yINnQtDcybbU/bpUpn5D9ik9rBnCt/W3O0kVj/hWyp/04/mtX
        qEWhAac8QE0SU5k7qlQRaMcI2A==
X-Google-Smtp-Source: AMsMyM4Rsj5oR1ATGM7658GzD3Q3lBbF+8Os3pqf/BLWi2fFG+xAXEPFzjZU6ldVhh3TOTZ5dZec8Q==
X-Received: by 2002:ac8:5e08:0:b0:399:e50e:f821 with SMTP id h8-20020ac85e08000000b00399e50ef821mr13129591qtx.5.1665581900935;
        Wed, 12 Oct 2022 06:38:20 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a430a00b006ce7cd81359sm15535290qko.110.2022.10.12.06.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:38:20 -0700 (PDT)
Message-ID: <06249fe9-97eb-1ab8-5e35-00b3c613d3a7@linaro.org>
Date:   Wed, 12 Oct 2022 09:36:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 05/11] dt-bindings: thermal: k3-j72xx: elaborate on
 binding descriptions
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
 <20221011231727.8090-6-bb@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011231727.8090-6-bb@ti.com>
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
> Elaborate on the function of this device node as well as some of the
> properties that this node uses.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  .../bindings/thermal/ti,j72xx-thermal.yaml    | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> index c74f124ebfc00..0b6a6fa07a532 100644
> --- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> @@ -9,6 +9,24 @@ title: Texas Instruments J72XX VTM (DTS) binding
>  maintainers:
>    - Keerthy <j-keerthy@ti.com>
>  
> +description: |
> +  The TI K3 family of SoCs typically have a Voltage & Thermal
> +  Management (VTM) device to control up to 8 temperature diode
> +  sensors to measure silicon junction temperatures from different
> +  hotspots of the chip as well as provide temperature, interrupt
> +  and alerting information.
> +
> +  The VTM device will periodically enable these temperature sensors
> +  to make a temperature measurement and store the reported data
> +  allowing the sensors to stay in a reset state when not in use
> +  to maximize the sensor's life.
> +
> +  This VTM driver will then use the following polynomial equation to

"VTM driver" is some physical/electronic element called driver? Or Linux
driver? If the latter, drop it and just describe the equation.

> +  calculate the temperature from the value stored in the VTM device.
> +
> +  Temp = (-9.2627e-12) * x^4 + (6.0373e-08) * x^3 + \
> +         (-1.7058e-04) * x^2 + (3.2512e-01) * x   + (-4.9003e+01)
> +
>  properties:
>    compatible:
>      enum:
> @@ -19,9 +37,16 @@ properties:
>      items:
>        - description: VTM cfg1 register space
>        - description: VTM cfg2 register space
> -      - description: VTM efuse register space
> +      - description: |
> +          A software trimming method must be applied to some Jacinto
> +          devices to function properly. This eFuse region provides
> +          the information needed for these SoCs to report
> +          temperatures accurately.
>  
>    power-domains:
> +    description: |
> +      Should contain the phandle to a power management (PM) domain
> +      node and the device-id of this device.

This is quite generic - why adding it?

>      maxItems: 1
>  
>    "#thermal-sensor-cells":

Best regards,
Krzysztof

