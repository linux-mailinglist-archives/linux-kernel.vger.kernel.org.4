Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A0761898F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKCU2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiKCU2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:28:12 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E66E20BE7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:28:11 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id l9so1917138qkk.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcNbeoDhTOJYnxfmvZJ6fTW07kY5UqbYZAVgmWdeb3Q=;
        b=i7U6xqSbsC9vblyjtpagm37NoEb/aCx9jUklqlAmYOmaSiIJXxjysx+18PP3eNIPlS
         iViyd4LOKYGjBIn1wEukKUYIJQLktyULEawai+L+7GpH2h4TtpiSy26ZqcS8zFZTDD65
         3h9aD6IhUTvZ5NjLrQuyJM0Aan7bYZ4QU89C7na+K19cJIueabsk+hs8gh8GDvyhjB2c
         Oi+x3zVLDX6EryfyvLdRcWygjQLuijtz/dFzD1m8ZfkfXytrHSwzPLm5fz1h9p1o1lQe
         lfUpetJCtqeH6WlOsNuNnvTBsSW0YNacZn3NVXgvLXHt5cS/0usoGKHmPtqX/b5i8ysQ
         2L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcNbeoDhTOJYnxfmvZJ6fTW07kY5UqbYZAVgmWdeb3Q=;
        b=NGlIYV9RGLLb05QGrXIS8Fmld5NKUsyWje5pnDyY7Wl32kaoJfmqSAwql8XbDbVgwp
         20QcoiiiMq3PaE5qS1vGhi+pCpxDdQL9jPIxGf7p1X3iwDo1JalIc5jQM5dBtAx1mXGz
         zzXB4+eQIeLP7818aTsYF9U76hDML7UymHipiGDsmRbs7y5bWPSh93pQKO/VUnwOTuUj
         nLRxutOeV5aVRguOciqvku+FCZTDIs/8NLlihXdCYRvRIxYIxslpsz4TMZNnQpeAsfK8
         +vuIP8x/ONiM/TD6HEBi9ZPPVaHW1YxysxgGBBZTuN7b2zpLqI62m4P4wR/m90dFVSjU
         Z/1A==
X-Gm-Message-State: ACrzQf1pMPTFMfwC0+yNEV9E6e6OG9+xRh+rh27D10G+jxqgFJ2PZbop
        YBvwdE6Gq9rVTaPZTB7WB/mtXQ==
X-Google-Smtp-Source: AMsMyM7Livkejr1uQzyxumkSbQP3fN+cKv5rMoQwT3f64PF14L+c+/UGJNiLiLXVHZ5SqJL7LiMA9g==
X-Received: by 2002:a05:620a:388:b0:6fa:60fb:b325 with SMTP id q8-20020a05620a038800b006fa60fbb325mr7908832qkm.646.1667507290567;
        Thu, 03 Nov 2022 13:28:10 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id y12-20020a37f60c000000b006cfaee39ccesm1334936qkj.114.2022.11.03.13.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 13:28:08 -0700 (PDT)
Message-ID: <ef719b46-18af-f567-2665-f563c953fb34@linaro.org>
Date:   Thu, 3 Nov 2022 16:28:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221103202548.1921397-1-Naresh.Solanki@9elements.com>
 <20221103202548.1921397-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103202548.1921397-2-Naresh.Solanki@9elements.com>
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

On 03/11/2022 16:25, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../bindings/mfd/maxim,max5970.yaml           | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> new file mode 100644
> index 000000000000..bf3db2484723
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator for MAX5970 smart switch from Maxim Integrated.
> +
> +maintainers:
> +  - Patrick Rudolph <patrick.rudolph@9elements.com>
> +
> +description: |
> +  The smart switch provides no output regulation, but independent fault protection
> +  and voltage and current sensing.
> +  Programming is done through I2C bus.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> +    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max5970
> +      - maxim,max5978
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  leds:
> +    type: object
> +    description:
> +      Properties for single channel.
> +
> +    patternProperties:
> +      "^led@[0-3]$":
> +        $ref: /schemas/leds/common.yaml#
> +        type: object
> +
> +    additionalProperties: true
> +
> +  vss1-supply:
> +    description: Supply of the first channel.
> +
> +  vss2-supply:
> +    description: Supply of the first channel.
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  regulators:
> +    type: object
> +    description:
> +      Properties for single channel.
> +
> +    patternProperties:
> +      "^(sw[0-1])$":
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +
> +      shunt-resistor-micro-ohms:
> +        description: |
> +          The value of curent sense resistor in microohms.
> +          Must be specified for each channel.
> +
> +    additionalProperties: true

We did not finish discussion and you already sent v7... It's waste of
your effort. Don't send patches too often and do not send new version
while still discussing.

Best regards,
Krzysztof

