Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD446D7BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbjDELvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbjDELvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:51:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E658D4699
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:51:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-93283bd90dbso35463666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680695464;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PEJZogkw2jx65ZdRCOLlWmLoNVIfXowhGDmP2BgB5ww=;
        b=ICrSx230GHXpweLTGQkQV4pOzvP51d7Az7pKzc5Mhi/NY5kFuWC9TCngRnvgP8NqJ2
         y1k7uFlV8NiCU+4Lu210gji1TRlScgNzhxkGZIhJv8YLNIOPlX732Z0wMtlNEQ7q8mwz
         l7dcbqGWdwaZrrQhS1LjIhvOfphvOs7UXmW+SM/JTK0G72c06M3XDDqLbwnVHZKTWBQI
         I/zBcf3XJuO8tUOgw8xjeTbFy/Xz0BgdhjqKfhQiPKTvadMCUmltkGj2FQ0O16wKMYMj
         mGRHZ1W4hmCA1pzpvgSs8C6kzsM377rMC5NTKOmE6uDrATFxjaUiqmeuU4GY4e/8HLxy
         t9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680695464;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEJZogkw2jx65ZdRCOLlWmLoNVIfXowhGDmP2BgB5ww=;
        b=Rb6l/gWYvaZjhTIBfI24Tb/8SZukBeDmI/QUHyP/IitA6NbrvzqD1VpDh8bNcgrXVc
         g/lszVxkjGnc3K5ajDq7n+N9fXw+cmEQ9/AiFwEs+kj65esFYR9y7K0dvdSDW8S9vJpf
         PQbyNV3eM5HswO3yNJmuH6v0+2i9776sJiToac4nNp/dXrRGsnsHoeLw/vCgEitPZaQP
         YCX/KKDEEIHi7TdmPoFo0O+XiFOnlzSlIqwkpKF9V9O8QTK+fEPAv0yO0q0gMo9M+RqX
         0h5nY9wZqQfHR97foYxx8dqqsRax8cUbsFcdlH+nY690QGN7/cI5GsXcwb+RSLuHR3/7
         GMDQ==
X-Gm-Message-State: AAQBX9eLkOrBhthcT3cYE6R8L1Q+wmPjDSh0Q6teT+TyrRLxDeBCqikN
        54+1JN/7gJB5mG1+9aM9fIfkkg==
X-Google-Smtp-Source: AKy350bVqHYHaZ9yu1s8YRFR/WPFDOaNrZpD3EVzfo7T8Exbhyd2Z73xyhhF6i/zERdbvo7R04rCyA==
X-Received: by 2002:a05:6402:216:b0:4fb:ec6a:2357 with SMTP id t22-20020a056402021600b004fbec6a2357mr1607480edv.34.1680695464452;
        Wed, 05 Apr 2023 04:51:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id a9-20020a509e89000000b005024e725aefsm7189622edf.33.2023.04.05.04.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 04:51:04 -0700 (PDT)
Message-ID: <5398cbe0-c681-5dd7-0b3e-3a586cc4915f@linaro.org>
Date:   Wed, 5 Apr 2023 13:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
Content-Language: en-US
To:     Johannes Zink <j.zink@pengutronix.de>, vkoul@kernel.org,
        kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jun.li@nxp.com, haibo.chen@nxp.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
 <20230405112118.1256151-2-j.zink@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405112118.1256151-2-j.zink@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 13:21, Johannes Zink wrote:
> Add optional properties for tuning of usb phy.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  .../bindings/phy/fsl,imx8mq-usb-phy.yaml      | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> index e6f9f5540cc3..f452a41b4f32 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> @@ -35,6 +35,46 @@ properties:
>      description:
>        A phandle to the regulator for USB VBUS.
>  
> +  fsl,phy-tx-vref-tune:
> +    description:
> +      HS DC Voltage level adjustment

"Level" in what units?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
> +
> +  fsl,phy-tx-rise-tune:
> +    description:
> +      HS Transmitter Rise/Fall Time Adjustment
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  fsl,phy-tx-preemp-amp-tune:
> +    description:
> +      HS Transmitter Pre-Emphasis Current Control

If this is current then use standard unit suffixes.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  fsl,phy-tx-vboost-level:
> +    description:
> +      TX Voltage Boost Level
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 2, 3]
> +
> +  fsl,phy-comp-dis-tune:
> +    description:
> +      Disconnect Threshold Adjustment
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +
> +  fsl,phy-pcs-tx-deemph-3p5db:
> +    description:
> +      TX De-Emphasis at 3.5 dB
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  fsl,phy-pcs-tx-swing-full:
> +    description:
> +      TX Amplitude

I have feeling you just pasted here short titles from datasheet. They
are not that helpful.



Best regards,
Krzysztof

