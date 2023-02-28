Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99E6A5436
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjB1IPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjB1IPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:15:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0026029E1D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:15:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l25so8777597wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677572114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azxM/SMAWi+5Y+8kP4W8b45r/c639Rvk9h64PbJkv1E=;
        b=EzHU25BuMEUwIZo0ZM03zEoP1TDcjArIY7QjyqP7DDk64d455X7mVS7BLjjjX7RRZJ
         D6tRQdZ24N4rWhI037MwGUvOVAysjBvfRlnRfU3Sz0M6xUhowA2MDKy3QTMDiVOyDchi
         /uM/7RFfR5r+z300QeyaYfIcJnnLImMqnsxQVa7WISDrzMMAbCSaP95ZFx7TurlpMSaJ
         Bx+0Ysds+l6+RiqqTy5iXl2E+rvSl2AXxmffRQAkooFZ70VZkbSh5bohvxxjk9M0fLrk
         duguOisYvwhECBnF+hhJL1nXHkfkTLt0vJ0pNm5WqQs+cRj+LeeeqT8ZI3UgxFpsbciH
         1BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677572114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azxM/SMAWi+5Y+8kP4W8b45r/c639Rvk9h64PbJkv1E=;
        b=Rzq1iu+gu+ifCIdaV2/AiEc37mYHa+dDk6vUDzCm+4IBAlRkQQ5LupQllxGcSrdts5
         RFO1WGPphMAasyQj32j6mdlmQRqnS/xGWohiyWjMnp2bIrvindTQxKDKv4V4Wf+6PCXb
         GMKoCLKXU5lbC8fc6cjtvvQvo2XRfSE1wBGhYy8ZJecUGKdroJvjb4R4ufLo5ZbPnmAm
         qwhWPkcRBEyXmmCffgnNdxz9pxt9WJgEF2sbZXjNGct3ryiXhxdtJhpSVByr/MMkiANR
         eRJd9aO2SYB/GtG3KZJ2xMNfFoWqDieWb23xO6Ni3WXhkY9uBKlUefA9PByAAiDtu6g9
         Rgqw==
X-Gm-Message-State: AO0yUKW/XQm02VodJ3YyOF8rtpHRF4iIjavpyhFRrPiIWP310cEUV1B/
        7e/nKd/OLKs1lzg6G0rJ4/H+zA==
X-Google-Smtp-Source: AK7set9Am2h32Fsn/6toLjOljad6mPQ8tBB42OOqm1NJP0uXtXTRRGqgQTSUfJQyXOdmgvWImFuqIw==
X-Received: by 2002:adf:f204:0:b0:2c7:76a:31ff with SMTP id p4-20020adff204000000b002c7076a31ffmr1700105wro.18.1677572114389;
        Tue, 28 Feb 2023 00:15:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x6-20020adff646000000b002c56046a3b5sm8891695wrp.53.2023.02.28.00.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 00:15:13 -0800 (PST)
Message-ID: <43fb6355-9a94-fabe-156e-8706ece97f9f@linaro.org>
Date:   Tue, 28 Feb 2023 09:15:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 03/10] dt-bindings: sound: nvidia,tegra-audio: add
 RT5631 CODEC
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-4-clamor95@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221183211.21964-4-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 19:32, Svyatoslav Ryhel wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Add dt-binding for RT5631 CODEC.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../sound/nvidia,tegra-audio-rt5631.yaml      | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml
> new file mode 100644
> index 000000000000..b347f34c47f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-rt5631.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra audio complex with RT5631 CODEC
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +allOf:
> +  - $ref: nvidia,tegra-audio-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - pattern: '^[a-z0-9]+,tegra-audio-rt5631(-[a-z0-9]+)+$'
> +      - const: nvidia,tegra-audio-rt5631
> +
> +  nvidia,audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      A list of the connections between audio components.
> +      Each entry is a pair of strings, the first being the connection's sink,
> +      the second being the connection's source. Valid names for sources and
> +      sinks are the pins (documented in the binding document),
> +      and the jacks on the board.
> +    minItems: 2
> +    items:
> +      enum:
> +        # Board Connectors
> +        - "Int Spk"
> +        - "Headphone Jack"
> +        - "Mic Jack"
> +        - "Int Mic"
> +
> +        # CODEC Pins
> +        - MIC1
> +        - MIC2
> +        - AXIL
> +        - AXIR
> +        - MONOIN_RXN
> +        - MONOIN_RXP
> +        - DMIC
> +        - MIC Bias1
> +        - MIC Bias2
> +        - MONO_IN
> +        - AUXO1
> +        - AUXO2
> +        - SPOL
> +        - SPOR
> +        - HPOL
> +        - HPOR
> +        - MONO
> +
> +required:
> +  - nvidia,i2s-controller

By convention we always require compatible (and your common schema does
not require it, I think). The same for your other patches.

Best regards,
Krzysztof

