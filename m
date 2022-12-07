Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B7B645723
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLGKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLGKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:07:44 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3B2A8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:07:42 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id l8so20283614ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lgyDc2BPaf6a7xLJztu7FglI3cnhZOU9b/y2TvNFgc=;
        b=vRsLv/GaSy9EPmAQq+63dZ6M4t6p4/CzDF2JAjaJSIcxWJOx9uVeZqJVNVq3dmnpPb
         lBbab6edWfxx7MxVCDMbL855Z5mWItwy5YdIfEfZyiS/JHuT2O+8bt92/90S+I4d4l8V
         iFrpKD1UpAiPDqcnWIxRmPay3c38uIZ7FH1b8s6ecILw68jJqX4NunJSc1velN82iOav
         NUhsUSK7gdRRkiBhDUH99oazExjAQxTUARi1CHM2K0dmmwiheHUfoas2SOLG3QpcGJTO
         QqFBw3rMuSN7y7RbUu8bMOcFQHvG/oSb+scJ7gW2JFLzjvH+VqXs+Kj8KfPIvB7wpqr+
         Fkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lgyDc2BPaf6a7xLJztu7FglI3cnhZOU9b/y2TvNFgc=;
        b=H4jxQ0OHYeRPfqc+OKelp3skK08rknX6ROyYQSzVb0UXiO2q25dkmRWPUZgfajF93Y
         okhHD9zcHMoVrClGW06HXSlKyAInAGOQ+VmziycOGDkdWg1+0UD6Nk+DCw5Avx5lNhom
         TaRgOVdZaXMIWrKbeCElsDG5+Qz8UxUUdsw9gtF2XphJ4vPKCwdaW6GmFc/YyXvWWB1f
         Y1U6iVF5uSwgjSqy8Vnk8DW6hYU8jv3jDVAtfmD2ADDJSHWCP6WhlRlZcbnII6+11r4q
         orr7jv+/ogkpMy2ez1O2AWju6DDySj4xcGrr1lpMTV1p1d2E2H3MDTYwCPJZ0ClvOdTH
         VaAA==
X-Gm-Message-State: ANoB5plrbphTsEb9qeqJJMXMRTqAsSKYEskFk8H2InadkLqV/ZNeT62h
        Mg2mMFEyyZnj0F4W65R+RRcshQ==
X-Google-Smtp-Source: AA0mqf7rtzVO4OcdPniGSM3lTHYW3jU+eQ+5NKwi22IsC1vflmvtS1Aibm/8Ce1hrOnOkE5hsrF3pw==
X-Received: by 2002:a2e:9e11:0:b0:26e:3292:12ad with SMTP id e17-20020a2e9e11000000b0026e329212admr24627754ljk.271.1670407660835;
        Wed, 07 Dec 2022 02:07:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020ac25927000000b004ab4ebb5d92sm2807906lfi.5.2022.12.07.02.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 02:07:40 -0800 (PST)
Message-ID: <7deb14ee-aae1-b521-c75e-6e33cd052c44@linaro.org>
Date:   Wed, 7 Dec 2022 11:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/5] staging: dt-bindings: regulator: adi,max77541.yaml
 Add MAX77541 Regulator bindings
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>, outreachy@lists.linux.dev
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20221207090906.5896-1-okan.sahin@analog.com>
 <20221207090906.5896-5-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207090906.5896-5-okan.sahin@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 10:08, Okan Sahin wrote:
> This patch adds document the bindings for MAX77541 and MAX77540
> regulator drivers.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../bindings/regulator/adi,max77541.yaml      | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77541.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/adi,max77541.yaml b/Documentation/devicetree/bindings/regulator/adi,max77541.yaml
> new file mode 100644
> index 000000000000..1f828895ab3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/adi,max77541.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/adi,max77541.yaml#

Filename matching compatible, so adi,max77541-regulator.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Buck Converter driver for MAX77540/MAX77541

Drop "driver" and any other references to Linux drivers.

> +
> +maintainers:
> +  - Okan Sahin <okan.sahin@analog.com>
> +
> +description: |
> +  This is a part of device tree bindings for ADI MAX77540/MAX77541
> +
> +  The buck convertere is represented as a sub-node of the PMIC node on the device tree.

Typo, converter

> +
> +  The device has two buck regulators.
> +  See also Documentation/devicetree/bindings/mfd/adi,max77541.yaml for
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max77540-regulator
> +      - adi,max77541-regulator
> +
> +patternProperties:
> +  "^BUCK[12]$":

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +    type: object
> +    $ref: regulator.yaml#
> +    additionalProperties: false
> +    description: |
> +      Buck regulator.
> +
> +    properties:
> +      regulator-name: true
> +      regulator-always-on: true
> +      regulator-boot-on: true
> +      regulator-min-microvolt:
> +        minimum: 300000
> +      regulator-max-microvolt:
> +        maximum: 5200000
> +
> +additionalProperties: false
> \ No newline at end of file

Check your patches before sending...

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5704ed5afce3..8e5572b28a8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12502,6 +12502,7 @@ M:	Okan Sahin <okan.sahin@analog.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> +F:	Documentation/devicetree/bindings/regulator/adi,max77541.yaml
>  F:	drivers/mfd/max77541.c
>  F:	drivers/regulator/max77541-regulator.c
>  F:	include/linux/mfd/max77541.h

Best regards,
Krzysztof

