Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A666B1BC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjAOO53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjAOO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:57:27 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C508510406
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:57:24 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bk15so5156390ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5z9xvpyQwb/p3wmCjJHVAevXOfS6soyNwcx7EqDQqA=;
        b=oTHoYu/uuq+H4sxlXkVSLcqO31mFInw32z0ZpNSNm+SxwsM2Rj+l8Vureeu3CgmNjR
         mPtFQb4hlzo4wuI2aX9NqagTuK4gcUaGou5GLB04OtBsokaQ8SSN67Qrk2ofk75lliKz
         Oy88Qo1z1psk9x/HLFp3Mq8/iB2zU85Q5cQQEY12+qGvtRDqGAPUhWJtJeOxWQprgVh4
         z12LM82EjlU+S54uvfdba1Q9Lm5x7ZfbdoZN9eOFQqOV1rQvTEcrDwPj4jcME/Gj7h+M
         7WZNrAgpZ44Cj4oM0rDfJLXcqbKXNq7jklY80fA2qMHzQAiuiIE5JCZDg1RSXlsaBiJJ
         zc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5z9xvpyQwb/p3wmCjJHVAevXOfS6soyNwcx7EqDQqA=;
        b=cQzMmtq299q+RvFWCdOikx8lpVSFaz0dvbCnMOTcOJifpYKQFGFmtLbYytw0hqVM0+
         Vmj54WJUht8kQuf67a/10cc8OiNOH0UdQB6EqeW+WffYDXQugiigR6ienVbM3cggORhD
         gJP2cYoPW+5FtbpM13rygyuLNGUG90dnN9N1v/FBBUJGvG6wlgrqF7pXCNLQkEEYrZpo
         /upEp4jwOnjxbhKlT+C4iKAHts3WL7bxGVvaiVDPbfui3d/Gi+GJgO80GtiGO9tdjVzD
         1qTpHVOfNfbNoFs7CcuY+qJEG7h9gcRGgFW7xD9HegJUOn34fUW5PIpAQJzHhjXYrJkF
         O9xw==
X-Gm-Message-State: AFqh2kpiktQ3KQtmmWkQhY3MQWAEovQk9eG9ZIbauXp+2daOh/fWRI9p
        ja/oB+icGeCEDmQ/U/ZmJ43VauNfuF4vY5F+
X-Google-Smtp-Source: AMrXdXuLjqA27067ErXhBepaZR4Dis+ZqnVxCxeRaM2NcThdEVfQzmcIxYEWVBqdiwu9aFF4IeScGA==
X-Received: by 2002:a17:906:944a:b0:7c1:23f2:5b51 with SMTP id z10-20020a170906944a00b007c123f25b51mr8487730ejx.60.1673794643394;
        Sun, 15 Jan 2023 06:57:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906c30500b008552bc8399dsm6853290ejz.172.2023.01.15.06.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 06:57:22 -0800 (PST)
Message-ID: <dee8fbdc-5399-d5ce-8d01-2c48e85e2919@linaro.org>
Date:   Sun, 15 Jan 2023 15:57:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>, hvilleneuve@dimonoff.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230113194959.3276433-1-hugo@hugovil.com>
 <20230113194959.3276433-3-hugo@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113194959.3276433-3-hugo@hugovil.com>
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

On 13/01/2023 20:49, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add device tree bindings document for the Texas Instruments ADS7924
> ADC.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../bindings/iio/adc/ti,ads7924.yaml          | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> new file mode 100644
> index 000000000000..24bbf95383b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads7924.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS7924 4 channels 12 bits I2C analog to digital converter
> +
> +maintainers:
> +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> +
> +description: |
> +  Texas Instruments ADS7924 4 channels 12 bits I2C analog to digital converter
> +
> +  Specifications:
> +    https://www.ti.com/lit/gpn/ads7924
> +
> +properties:
> +  compatible:
> +    const: ti,ads7924
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      The regulator supply for the ADC reference voltage (AVDD)
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +patternProperties:
> +  "^channel@[0-3]+$":
> +    $ref: adc.yaml
> +
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 4 channels numbered from 0 to 3.
> +        items:
> +          - minimum: 0
> +            maximum: 3
> +
> +      label:
> +        description: |
> +          Unique name to identify the channel.

Drop description, it's coming from adc.yaml. Just "label: true"

> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false

You are not allowing anything else from adc.yaml. Is it on purpose?

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +  - "#address-cells"
> +  - "#size-cells"
> +

Best regards,
Krzysztof

