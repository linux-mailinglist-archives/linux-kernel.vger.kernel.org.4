Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14574FEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGLFcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGLFc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:32:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4718A1716
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:32:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e5d9e20ecso3239600a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689139947; x=1691731947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cm9lqU5pPuyE1DC++4NWH2zRUzX6wSqTAdFnrSF5Rww=;
        b=VNigY0kXhCTUccMmpH3lWTI7nxi83g7n5A1t1tz1XYVlSBCWD9Kg6QLd7Ops/wOXIW
         JgrqUmfdDm7UX7cnWLkVBMz95ScQmC5AjulXn8LK3+WDjp1VALtpm2QZaqJhnA0NcZQn
         74vY8XFWcy9hvefzgIeiXi9CVfmzZhB2dDky+W8StXKW5ohrK75wLI7kmcv4t0q4chrj
         G15AqQCc3VxVHvxHXXFbpi3bbtG1xGhSpn8HQ1X0Dv9tcPXm50LjdF8YHfucYTp52V5Q
         UkXEV8WZD76Tsp55o0hKxcAGY9S3gKTMPf53nhiPGnKPdRbRepfjLIHJYHqzEESRp/fk
         5cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689139947; x=1691731947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cm9lqU5pPuyE1DC++4NWH2zRUzX6wSqTAdFnrSF5Rww=;
        b=BLgd5qK3vr0FkGFUn2P8GTyqvkN0nKJYGulcD08yzNkT+pticpvtf1O5bjNU0KB4da
         h8zvHlsiRaEqPAeOmHoDp8rz5y30OnMJJ/nguTRmE6/JKvadK0kpEjTKkKWBlMQ/mhPu
         QiUZ2KOUjxim+8AVN22scpYBl+hrCj7VT4ACRqAQ8+OaN1819SPvGANCDBNFqsBK/Qwh
         baLHqOoItR4qeCtCKHunY49gDAvwbxo/imCvYEjDihZtL2OpaG87a4+rhVzAHOcgGOUS
         eNXG4wsNOhbVuJvbkQmKAstNtHzNkuthGaxwfJz8ExQ/jsqcEtbPV+CdXVPAoW0aaYMM
         zCLQ==
X-Gm-Message-State: ABy/qLZ0ZvqMdASJKNXyXsXU1GlhknFO2lc+1erZzlT9FqKCMb3MXotd
        MHKWUUmOtU7Zbs1kP36CqGr1oA==
X-Google-Smtp-Source: APBJJlG4YRdWN+SCSbzyfd58UWeDDH8s4zkWWVj4TV7KjDSCdVdE1A1W2FG3adOSrHXkUmi0u3mGVA==
X-Received: by 2002:a17:906:33d0:b0:992:b3a3:81f9 with SMTP id w16-20020a17090633d000b00992b3a381f9mr15779053eja.71.1689139946740;
        Tue, 11 Jul 2023 22:32:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906394b00b00982b204678fsm1976336eje.207.2023.07.11.22.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 22:32:26 -0700 (PDT)
Message-ID: <14bed951-22ae-4aa8-5fcb-b2cd92ebdbef@linaro.org>
Date:   Wed, 12 Jul 2023 07:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: add startek
 kd070fhfid015 support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230711-startek_display-v1-0-163917bed385@baylibre.com>
 <20230711-startek_display-v1-1-163917bed385@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230711-startek_display-v1-1-163917bed385@baylibre.com>
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

On 11/07/2023 17:36, Alexandre Mergnat wrote:
> The Startek KD070FHFID015 is a 7-inch TFT LCD display with a resolution
> of 1024 x 600 pixels.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../display/panel/startek,kd070fhfid015.yaml       | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
> new file mode 100644
> index 000000000000..857658e002fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/startek,kd070fhfid015.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Startek Electronic Technology Co. kd070fhfid015 7 inch TFT LCD panel
> +
> +maintainers:
> +  - Alexandre Mergnat <amergnat@baylibre.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: startek,kd070fhfid015
> +
> +  dcdc-gpios: true

From where does this come? Which schema defines it?

> +
> +  height-mm:
> +    const: 151
> +
> +  iovcc-supply:
> +    description: Reference to the regulator powering the panel IO pins.
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  reset-gpios: true
> +
> +  port: true
> +
> +  power-supply: true
> +
> +  width-mm:
> +    const: 95
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - dcdc-gpios
> +  - iovcc-supply
> +  - reg
> +  - reset-gpios
> +  - port
> +  - power-supply

Missing example.

Best regards,
Krzysztof

