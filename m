Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA62B74FEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGLF0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGLF0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:26:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F4E74
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:25:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so100654311fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689139558; x=1691731558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AK4eb7KoL8ndmCPLluj+EXz7PDkhjxyHzXKMz5A/aGE=;
        b=LNTsca7LfYc7UmuC05LHt7V+LYFMGnX7TjiIjqBrGFlds42YrhoVki5mAffAjYjga+
         mjnwnc5Uwuf2zAtW/7Las4tscJg6LZSDxa49UnP5UUeQ7eNq8gPlC2TWiGD0sZCcPNoo
         E0eo1+bF97Qf8uGYolSBxZVPSV97+9KGPEboAlFQ/9tc2aGCaGj9IgYqmhQphJGox23c
         5V2d0Q270czKJpZhg1UEbWsO84+8gRLAoQKB+cU0aEIonhrqEJJC33fbK5LbkPhc9Q3i
         Lg+mPl2eirurAYV9cs6fErGzsuFz89sL5p5S2BoP5KlzIWMEUaAwjnjxUFgyznRK/Gj5
         5Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689139558; x=1691731558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK4eb7KoL8ndmCPLluj+EXz7PDkhjxyHzXKMz5A/aGE=;
        b=iXiv5SyIiitAd1LbUf/tBGngIGMJliSPPIGmXIuhHbEGJYLYC3d494TIgynsiJuXkn
         uVwurmP6SkvjpzEJJMWCS+Vo1SZpyAYvYspXPmNjKs92hS0FwVIQxUkDtSbJSRSR7FRB
         +b58l3rc2Muy+UWuf3T93cKhAQl3CjVA4JYXuqMR0FdPaInFBcYAWQhigy9VI0zGL+sF
         t0RIn/77o7UqqMCNIG1tbZuaFy40OQ3/Fgph3Ip4fJvUp1xtmGsYXL3IfYduB7K89XtQ
         XPhWG6xgDeOzF1JaKTEm0V84w02svWiC2R1+PHhvReRy8qlOgcznVLUVBtz+8Wzu97rV
         Tetw==
X-Gm-Message-State: ABy/qLYjm6JQL4p1oJHi4d3DgbbKi3UesZqoKWrbA6PXT+0U4gFC82GM
        +VsgQxYv9eIF+gALrvRbxUuDdg==
X-Google-Smtp-Source: APBJJlHtrGyx7YwUFhU7r6vqVS9mppAzhhjskmPXgB60TsCyGLrwu57v+FF1PLGFyf4SFUkcfG2jjg==
X-Received: by 2002:a05:651c:112:b0:2b7:3b73:2589 with SMTP id a18-20020a05651c011200b002b73b732589mr400249ljb.32.1689139557117;
        Tue, 11 Jul 2023 22:25:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u17-20020a170906069100b00985bdb7dd5fsm1986826ejb.201.2023.07.11.22.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 22:25:56 -0700 (PDT)
Message-ID: <a7761c1e-9327-38f7-8e7b-0b3c3007668e@linaro.org>
Date:   Wed, 12 Jul 2023 07:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] ASoC: dt-bindings: Add tas2505 audio amplifier
To:     Kevin Lu <luminlong@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tiwai@suse.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230712044006.48456-1-luminlong@139.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712044006.48456-1-luminlong@139.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 06:40, Kevin Lu wrote:
> Create tas2505.yaml for tas2505.
> 
> Signed-off-by: Kevin Lu <luminlong@139.com>
> ---
>  .../devicetree/bindings/sound/tas2505.yaml    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2505.yaml

Filename like compatible.

> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2505.yaml b/Documentation/devicetree/bindings/sound/tas2505.yaml
> new file mode 100644
> index 0000000..6cc3fe4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas2505.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2019 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/tas2505.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes

> +
> +title: Texas Instruments TAS2505 Mono Audio Amplifier
> +
> +maintainers:
> +  - Kevin Lu <kevin-lu@ti.com>
> +
> +description: |
> +  The TAS2505 is a mono Class-D speaker amp that supports both Digital
> +  and Analog inputs. The device is ideal for automotive instrument cluster,
> +  emergency call (eCall), and telematics applications. Direct I2S input
> +  removes the need for an external DAC in the audio signal path.
> +  An on-chip PLL provides the high speed clock needed by the DSP.
> +  The volume level is register controlled.
> +
> +  Specifications about the audio amplifier can be found at:
> +    https://www.ti.com/lit/gpn/tas2505
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2505

Why are you adding duplicated binding?

> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +       I2C address of the device can be set to 0x18.> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO used to reset the device.

Drop description, it's obvious.

> +
> +  clock-source:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Sets TDM clock sourse.

source, but anyway that is not the way to set clocks. Use "clocks"
property for your future bindings.

> +    enum:
> +      - 0 # Select MLCK
> +      - 1 # Select BLCK
> +
> +  '#sound-dai-cells':
> +    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
> +    # compatibility but is deprecated.

This is the first submission so there is no "deprecated" or "backwards
compatibility".


Best regards,
Krzysztof

