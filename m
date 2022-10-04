Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07395F4607
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJDO4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJDO4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:56:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AB6642C2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:56:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp15so8033972lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hSBDHnFG8axASJ0YmwxpylUiE0wfRyjeK7fpM+KbKBU=;
        b=m2OqE+QCgx8wp2HDVaSCfP02gyput5UXdsoF4NRp92smtE+gg37l7/IZ5r8t27g+Yb
         qn9Gyi4ni9+zEgS80AIBDqrA2hNJ6WHtpXLadeAtFH3wbvXOk2AA+wci1GrOvddtq7wX
         /i5ghqQyLNnNu3dy2u7ba6aW9m0Rd0jLMJDr6cgsgEfAT1tlmmKkiZftWrjahJXmaM6h
         iFzHFCxZ2Uvc7knfrdi754vw32KebsFoMLny7RDgK6Px2NbOWPRWuMlN2K2+p7398amt
         bqyhUJhMlDQnoPD7mPbNrbeVj37ZUnBo9C1MvlSxdjJQ89JAZGBjVefsAsZL2FNUAfLQ
         oG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hSBDHnFG8axASJ0YmwxpylUiE0wfRyjeK7fpM+KbKBU=;
        b=tv8ioOCXj19xTpCJysOILob90bq3jbB3QjdcscThyNyUemtsfOAQPvv1OAtOUzP+7d
         EAVrvhhY+efueW6WI/IWcMFQFsQhTlpm9GhACG0mt0N4FgVCnXlpckTOn7Qs+iv/syoG
         9vNzEEwstKuuVZARz4iE0vWrtkraNe3EaXa7HZAqFSgBLiH9lpAkYiRajaSjQYsoScUW
         AfomY9fhgh4I1HaNSxxNa9fp9O6Med0QI5nfTh0tTeQElPxlayKzZATNC997CvujNDkF
         ju98BjKNVoUgtelmJQJSiSP64vujD5Zf3QOtFX5SYl2iMFPsoovvDfrjnp1icbKwj1W9
         Ln2g==
X-Gm-Message-State: ACrzQf2s7ZW9z7iQLg/LHXS7qoHLtbi9TLQdVfTLfpZ2j0vRsiFy6+S5
        +YLcjMzBM0RF4EPv2mMgfIkkWA==
X-Google-Smtp-Source: AMsMyM6hEOdwMh6Rly6ZZwQiF0Y4Q2QP/NbqR+8PXh/xCFmx/bUwWWfImvA58mqjM6N9yRScX4GWsg==
X-Received: by 2002:ac2:5cd1:0:b0:4a2:291a:9460 with SMTP id f17-20020ac25cd1000000b004a2291a9460mr4818850lfq.203.1664895370389;
        Tue, 04 Oct 2022 07:56:10 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id cf38-20020a056512282600b00498f32ae907sm1946293lfb.95.2022.10.04.07.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:56:09 -0700 (PDT)
Message-ID: <e9d1d3b7-77d7-2c5d-8ea8-f5f6796457fd@linaro.org>
Date:   Tue, 4 Oct 2022 16:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 1/2] dt-bindings:iio:adc: add documentation for TI
 LMP92064 controller
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221004134238.3144326-1-l.goehrs@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221004134238.3144326-1-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 15:42, Leonard Göhrs wrote:
> Add binding documentation for the TI LMP92064 dual channel SPI ADC.

Subject: missing spaces after ':'. Also drop "documentation" - kind of
redundant.


> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>  .../bindings/iio/adc/ti,lmp92064.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml b/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
> new file mode 100644
> index 0000000000000..b7b5761baa108
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,lmp92064.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments LMP92064 Precision Current and Voltage Sensor.
> +
> +maintainers:
> +  - Leonard Göhrs <l.goehrs@pengutronix.de>
> +
> +description: |
> +  The LMP92064 is a two channel ADC intended for combined voltage and current
> +  measurements.
> +
> +  The device contains two ADCs to allow simultaneous sampling of voltage and
> +  current and thus of instantanious power consumption.

Not sure if my spell-check misses a word or you meant "instantaneous"?

> +

Missing allOf:$ref to spi-peripheral-props.yaml

> +properties:
> +  compatible:
> +    enum:
> +      - ti,lmp92064
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  shunt-resistor:

This is not a valid property name.
git grep shunt-resistor


> +    description: |
> +      Value of the shunt resistor (in µΩ) connected between INCP and INCN,
> +      across which current is measured. Used to provide correct scaling of the
> +      raw adc measurement.

s/adc/ADC/

> +
> +  reset-gpios:
> +    maxItems: 1
> +

Best regards,
Krzysztof

