Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3120762983F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiKOMMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKOMMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:12:50 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D57AE52
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:12:47 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h12so17235250ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMav8xKNkyJd8dYTuDrxcWCyxQ9njFDC0AA3Jeepq2U=;
        b=gDzxzSC6yVNoqY1zCu3xhGRLsbd8bfIpOQs4V6/Wn3OhFeIlkL5K+DR+1RyGwvvLvO
         ouUjHZpieshOzEo92gPkMWkMdhrktS3Hcc7Q7xDuQ0n/XXN5VAvpwSDQ9Z7bjiSNottj
         Wmd/SkewWKJrjwJdeg6/AvovqKFeF1S1VQaqYwFhmJRiRAmmXusj4+PdVn86gSabWIIX
         BqIOqVwrlYpIYAsimUifLhthNh0D0KxOTPS2qP9IUL36tlHbkc0/LV0ROO4jEn/Mptty
         IpvRAXca3xUV+LLaVMPI1OvZIjxgTO6SbRwLoS67m+o6Z0n3kzfGqO+Z7OZwxa2J7cAT
         XHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMav8xKNkyJd8dYTuDrxcWCyxQ9njFDC0AA3Jeepq2U=;
        b=brurAIGpvvYQ3zuSKYBwWIgvqM0456fXBuHWb74L3SUN+AFKZAYLVz2b8DJWLVi6dg
         lfnkTQMS98I5hICY1jACfBkAfSu8KygPj0Mjt0uSU5h+paAohGd6wxG2n3UV4EMbmVTW
         PDEoECn56pD/adoLZW/WqHUlhph4BWbKnmH3OoYbFfHAqUtnGMcJ6KrgX3VOLyNVaPxx
         BX8wFZ7QrXO5jQvySyqkuRbfwnyX9/sq4rJwCjzFO7dFse14D06CxVWQXJTPW9Frw6YH
         y3kt7hGxwPXm8lKETVeZ6JWAJK9v4lTn1EWVN6xe90rVC+PTsaPNbHMeeaMRPYUCsUB7
         iskA==
X-Gm-Message-State: ANoB5pn029vyMzqaDWcp/5ZnnP9O9CC38MeCvs7H9vYw/2RPhz3790X2
        J+GpRS4iIds0HYzKCEvFE0WUdw==
X-Google-Smtp-Source: AA0mqf7sx3nXu5rTD5mQ5GRhhLsHR9sDtPFQcjrqxTGQIL4llNiJnNagH/dDXzwbxLekddyKweds/A==
X-Received: by 2002:a2e:b621:0:b0:276:762b:3499 with SMTP id s1-20020a2eb621000000b00276762b3499mr5525270ljn.444.1668514366200;
        Tue, 15 Nov 2022 04:12:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g27-20020a2ea4bb000000b002771888fda1sm2473767ljm.84.2022.11.15.04.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 04:12:45 -0800 (PST)
Message-ID: <ca5f3b54-25bd-4dd5-799f-c7bda08cdef6@linaro.org>
Date:   Tue, 15 Nov 2022 13:12:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/23] dt-bindings: display: tegra: add bindings for
 Tegra20 VIP
Content-Language: en-US
To:     luca.ceresoli@bootlin.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
 <20221109141852.729246-2-luca.ceresoli@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109141852.729246-2-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 15:18, luca.ceresoli@bootlin.com wrote:
> From: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> VIP is the parallel video capture component within the video input
> subsystem of Tegra20 (and other Tegra chips, apparently).

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  .../display/tegra/nvidia,tegra20-vip.yaml     | 64 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
> new file mode 100644
> index 000000000000..934dabfd2307
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra20-vip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra VIP (parallel video capture) controller
> +
> +maintainers:
> +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
> +
> +properties:
> +  $nodename:
> +    const: vip

No need to enforce names in device schemas, especially that this does
not look like a generic name.

> +
> +  compatible:
> +    enum:
> +      - nvidia,tegra20-vip
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  channel@0:

Missing description.

> +    type: object

Do you expect it to grow to more channels?

> +
> +    properties:
> +      reg: true

const: 0

> +
> +      ports:
> +        $ref: /schemas/graph.yaml#/properties/ports
> +
> +        properties:
> +          port@0:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description:
> +              Port receiving the video stream from the sensor
> +
> +          port@1:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description:
> +              Port sending the video stream to the VI
> +
> +        required:
> +          - port@0
> +          - port@1
> +
> +    additionalProperties: false
> +
> +    required:
> +      - reg
> +      - ports
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - channel@0
> +
> +# see nvidia,tegra20-vi.yaml for an example

That file does not have this compatible. At least not on next-20221109.

Best regards,
Krzysztof

