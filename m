Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7F629333
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiKOIVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiKOIVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:21:20 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69620BEC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:21:17 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id s24so16516848ljs.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2oDeh8QPxwlUfystIUxy6bEGhHBIAnKFjrido9RSvwE=;
        b=c1HICuTpLc/CJJlN2iLUwWJYZutv4qlcQPvKUsicIFFtc2gVyTT9zwF59wROLbDdWt
         qldUP/isckTjSFFCLthOuDd0t9R5GV2RssusE4Vw1sKpHiJ+ZMcpUSyqwmgRnDlq6a5j
         SOHvgoEF4FarS0ajtd66emH1irmL8vSLm+Xr2ERJE1YHliHwDokscuFUt67ZyQUsMC3t
         oplgajD2alyXEfSpmMygPATluzDC6XYHCbg2J40ubRoKoiCPFIaHGiWnXXgrlWiOPkvy
         JuvLqMKz3GygXYhlZ9OatWezZusIGTU34tHQLg3Cxq64dbqmLIcPY+GxLKKc4BOtzsEq
         DhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oDeh8QPxwlUfystIUxy6bEGhHBIAnKFjrido9RSvwE=;
        b=NneYqPRHfNqfS2GF/i1mbbzIvKv4VknG3D6zLtZaO7VjN9zIOWAaiFRvX9Xb9vakr7
         63Mv1XX4ejVaYdNgdnICcuX5RJc10xkmP0f5DyHekhBfb4DwCB9rhyydKYE1AeCUalPv
         Ru4c9WQw98OON2DYNPxVR2BS/8vnDagB61/Y3LVtEywhkUmApk+E+hwV0Ivn96UTXlg2
         1D7lXmjQNLI2EDXoFX+pOP/oP6zdXD78OaJoAd5Ly4RWy96SKbm0jgpXWrPtDPfZ7027
         S2vHiP4hr9jc4Len8up+DFcdwcZP+KYvKDJCt+SvAYL0/BhUlfw/KGpqStt7Pi6EF7+B
         TzBg==
X-Gm-Message-State: ANoB5pkfOWpGC2/Da7XVWNqzzIjUx77scBaHGRtD0RXHHa4IzzqTjk/H
        T12cLjI4a7eVlhCVEnjBSsiu/g==
X-Google-Smtp-Source: AA0mqf5QslyE4xNjZT7wN5MLzXeAm1YVoAXp5J/x2SV75kjGSZBz4SBR9jnS8uSCGypyJ6Xe8Zzwrw==
X-Received: by 2002:a2e:2d09:0:b0:277:72a:41a5 with SMTP id t9-20020a2e2d09000000b00277072a41a5mr5953499ljt.352.1668500475698;
        Tue, 15 Nov 2022 00:21:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r5-20020a2e8e25000000b0026e059a3455sm2392490ljk.51.2022.11.15.00.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 00:21:15 -0800 (PST)
Message-ID: <acd7227f-102e-898b-beaa-b323285aa82d@linaro.org>
Date:   Tue, 15 Nov 2022 09:21:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add ti tmag5273
 documentation file
To:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
 <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
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

On 15/11/2022 08:37, Gerald Loacker wrote:
> Add bindings documentation file for TI TMAG5273.

Subject - drop "documentation file".

> 
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
> ---
>  .../iio/magnetometer/ti,tmag5273.yaml         | 72 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
> new file mode 100644
> index 000000000000..2f5b0a4d2f40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/ti,tmag5273.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor
> +
> +maintainers:
> +  - Gerald Loacker <gerald.loacker@wolfvision.net>
> +
> +description:
> +  The TI TMAG5273 is a low-power linear 3D Hall-effect sensor. This device
> +  integrates three independent Hall-effect sensors in the X, Y, and Z axes.
> +  The device has an integrated temperature sensor available. The TMAG5273
> +  can be configured through the I2C interface to enable any combination of
> +  magnetic axes and temperature measurements. An integrated angle calculation
> +  engine (CORDIC) provides full 360° angular position information for both
> +  on-axis and off-axis angle measurement topologies. The angle calculation is
> +  performed using two user-selected magnetic axes.
> +
> +properties:
> +  $nodename:
> +    pattern: '^magnetometer@[0-9a-f]+$'

Device schemas do not need to enforce the names.

> +
> +  compatible:
> +    const: ti,tmag5273
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  ti,angle-enable:

ti,angle-measurement

> +    description:
> +      Enables angle measurement in the selected plane.
> +      0 = OFF
> +      1 = X-Y (default)
> +      2 = Y-Z
> +      3 = X-Z

Why not strings which are easier for humans? off/x-y/y-z/x-z? How anyone
reading DTS can remember what is "3" in this and in thousands of other
devices?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3

default: 1

> +
> +  vcc-supply:
> +    description:
> +      A regulator providing 1.7 V to 3.6 V supply voltage on the VCC pin,
> +      typically 3.3 V.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c-0 {

Just: i2c


Best regards,
Krzysztof

