Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B276197A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiKDNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiKDNVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:21:55 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B962D1EE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:21:07 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id x13so3152270qvn.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sztW4RSToXkurDuSapi6NMntxpjCEEL0G1Ytm3cmVqA=;
        b=h+5UlCL+wTH31MzVcOig5ad3N63ShH3N7pT8fbJ69UlCBlj1b9h/sswJL+NYMR7yQo
         RGEzueFlYVdQWM/qoHunbPzyHNem37kw30uCUgof4WNhZIRHtdiT2UOMePW1FsrY/bFv
         FoEb64VGNPc4oLCvirxI7kkP5fq+z60VXPQ+w3tvj+Cuot++MNxn7GinoXq2Kl5WQQDb
         tGI8cFyVq8M4OJwPdR9HdBfaEaQpLdAFCNFMlg8aDMsjYPwr+piX6U7tT+ynFRBykmor
         S6wX/7emXd0iHpJ5+w53bZD3vMJZq+fkhYmCbeJVxj99UddLDG+V7g/+UWmmGREKdL88
         R0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sztW4RSToXkurDuSapi6NMntxpjCEEL0G1Ytm3cmVqA=;
        b=WvY/dQlKM23ZyZhD/fGyuu3yBpSebwkunlk5cJc73oNfrfE4OWRl/VyHA94VTrQmpJ
         TIvMgVY86PNBxRMNZxkC8T12vzE/ckrxaWc+/rVRB5mu9bXUwi8YksepnpbBxFE73rLl
         BQN1pDrzAYERkC67vE746tFMT12NsYh70G6O4xW2wo6F2YQE9V4+/PriCYnKI7JN8o/O
         igfUg5C60UqBhcizDQqj+oTxGH5nJwpkg0whBKJeo5RkYVYcScf6IWBxhZxdYZMYmWCS
         SufuNt+5tZC1/z1xpfH2WfgtRxbNASioKjFVldzF2Lfs5fFFI3+QGR8MChRKiWpXtpy4
         g+jg==
X-Gm-Message-State: ACrzQf1vQUgFcWuKEpOLFQzaOqv1qWRh5BBiyPCPgRh9wuUx4/8fsaaw
        gq2jLXpi69rssv2fHHabRJmFGg==
X-Google-Smtp-Source: AMsMyM6A+j8PxwplXv/5IymiQPnPdIz0jADWTE3BkGYJWlfceHvrH9qXmuRc7nYNaiXXFi1+bNvZIw==
X-Received: by 2002:a05:6214:2a8f:b0:4bb:6c0d:f2e4 with SMTP id jr15-20020a0562142a8f00b004bb6c0df2e4mr31195831qvb.18.1667568066209;
        Fri, 04 Nov 2022 06:21:06 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id j6-20020ac85f86000000b00397e97baa96sm2538630qta.0.2022.11.04.06.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:21:05 -0700 (PDT)
Message-ID: <f551f177-8163-283d-cf1e-23b09ff35489@linaro.org>
Date:   Fri, 4 Nov 2022 09:21:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] dt-bindings: iio: frequency: add adf4377 doc
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
 <20221104092802.90725-2-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104092802.90725-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 05:27, Antoniu Miclaus wrote:
> Add device tree bindings for the ADF4377 driver.

Subject: drop "doc"

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf4377.yaml   | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> new file mode 100644
> index 000000000000..3f5c83e03bb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adf4377.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADF4377 Microwave Wideband Synthesizer with Integrated VCO
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +
> +description: |
> +   The ADF4377 is a high performance, ultralow jitter, dual output integer-N
> +   phased locked loop (PLL) with integrated voltage controlled oscillator (VCO)
> +   ideally suited for data converter and mixed signal front end (MxFE) clock
> +   applications.
> +
> +   https://www.analog.com/en/products/adf4377.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf4377
> +      - adi,adf4378
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 10000000
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description:
> +      External clock that provides reference input frequency.
> +    items:
> +      - const: ref_in
> +
> +  ce-en-gpios:

chip-enable-gpios

> +    description:
> +      Gpio that controls the Chip Enable Pin.

s/Gpio/GPIO/
(other places as well)

> +    maxItems: 1
> +
> +  enclk1-gpios:

clk1-enable-gpios

> +    description:
> +      Gpio that controls the Enable Clock 1 Output Buffer Pin.
> +    maxItems: 1
> +
> +  enclk2-gpios:

clk2-enable-gpios


> +    description:
> +      Gpio that controls the Enable Clock 2 Output Buffer Pin.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +

allOf with reference to spi-peripheral-props.yaml

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        frequency@0 {
> +            compatible = "adi,adf4377";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            clocks = <&adf4377_ref_in>;
> +            clock-names = "ref_in";
> +        };
> +    };
> +...

Best regards,
Krzysztof

