Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85A629863
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKOMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiKOMPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:15:38 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD62140FE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:15:36 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id k19so17264623lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spp9dkHGZgQDodLByXAhVTEFyPemlJZRHAN1Y7nBNVg=;
        b=ymUYv/Oi6G8aiGdWofIyBdj8GVJ2K/0VU+eb7/Nqt7gB5gZciBnHZJLMeNa0ZtjHZP
         T59m1RJ6vl8+hyKQ9wwaXLL9HibIjD6mEmV9q261LPfLveDJsDx8lEVUfrkLh6UX9o5M
         feMh1R9AuXDxBLrDCNyyv34iJqtw75cIyYkRCJ0zDt+yqVRhBwFhoZd+pjzUH1hXn7kh
         XTQJdi/7HPP8h1zQ4I8+sy6PWW4psEuetF5BuW3omjXJjBgjD0YHb+yUfwXO1YOBC0ax
         w/BPIaYC6+CHBD6fyGpCw9IbLelOusgSzPQl5zEurdmP+PgzJ3YT1h86UKw1pz5HJRwv
         edFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spp9dkHGZgQDodLByXAhVTEFyPemlJZRHAN1Y7nBNVg=;
        b=lwWiLpii2/QTHaXSCgTA0TtyhQKWrh15h/nAEz8mGGjX31GR7o9YYcj7Kq3zEROJiW
         qgaFn7koiugFXFKisZxSLSPXkHs/B7yNUZhtVFqBMF1DI2B9rt0Jg8d1U0QTp5RelhUy
         +wQKZ/iWc5BywOtPIfrEH4L/j1HLkXucq9jCb4r8/rjH2TFffMdt4rodM82VBF6Nr79f
         HAU2zvFdcuWrNQLJjMEmFWg7TiuwbxPTDPsfNZyhJPtoIv6USPe/jj9LAb3E40e4OTGF
         OJ7VEo+MZmUNi5G1iGsZVT49HiB83KtjFAy1Z/T/hS+C0F/EEYnXFkZcqoofOGCc1FKr
         zsBA==
X-Gm-Message-State: ANoB5pmU048XHRxDgg7+pymZ4gwLRM8nvsYhEPiXQsBrpwR/j0DjkZir
        YSFzFpGaLBc2/ID11QYcY497LA==
X-Google-Smtp-Source: AA0mqf5kyq1KoTRqo1s4x36SAW+o4nEZ0jyMBBgN4JjqAOehEVO/C2NjL3odDI1zFExO9EeV2XWumA==
X-Received: by 2002:a2e:978c:0:b0:278:f59a:c7cf with SMTP id y12-20020a2e978c000000b00278f59ac7cfmr4559051lji.72.1668514534738;
        Tue, 15 Nov 2022 04:15:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f14-20020a056512360e00b004a45edc1de2sm2173307lfs.239.2022.11.15.04.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 04:15:34 -0800 (PST)
Message-ID: <eae67ed0-fb60-a825-2ac5-a18a37acd7d3@linaro.org>
Date:   Tue, 15 Nov 2022 13:15:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/23] dt-bindings: display: tegra: vi: add 'vip' property
 and example
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
 <20221109141852.729246-3-luca.ceresoli@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109141852.729246-3-luca.ceresoli@bootlin.com>
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
> The Tegra20 VI peripheral can receive parallel input from the VIP parallel
> input module. Add it to the allowed properties and augment the existing
> nvidia,tegra20-vi example to show a 'vip' property.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  .../display/tegra/nvidia,tegra20-vi.yaml      | 68 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> index 782a4b10150a..aab795241dd6 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> @@ -74,6 +74,22 @@ properties:
>    avdd-dsi-csi-supply:
>      description: DSI/CSI power supply. Must supply 1.2 V.
>  
> +  vip:
> +    $ref: /schemas/display/tegra/nvidia,tegra20-vip.yaml
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input from the VIP (parallel input capture) module
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +
>  patternProperties:
>    "^csi@[0-9a-f]+$":
>      type: object
> @@ -109,6 +125,22 @@ examples:
>      #include <dt-bindings/clock/tegra20-car.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> +    i2c3 {

Just "i2c"

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

