Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8474C6A3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGIRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjGIRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:23:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCCED7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:23:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992e22c09edso415690066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688923432; x=1691515432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXszYaQ2CLHCTB4bJrld8WlZZFAHDRACxKDlk8Go9KE=;
        b=OpMFWIFzs/n6J4yTTTHgvZwxJCwWZQIU1rvO1RcQNp6JgEJicsN8E1s9dEn4Ak/U5T
         H5YMNyGxzXL482ZgJlEP1ASV1EChwDOT26YOXllb5ymIMe9N4pIezE+NxjoYfjy9pbez
         8YHKbQY/g2pI7KzSDN0Swxr/3fBwNEDtzybzYLWlxXs8C+qRxb3MJDKZF9G/abuVa8Jb
         kB4gdfNJYG9zka1gESY5KMyEyUUkpGvmb6Hpl94JfjWGq0zmMNcnAB+OhcyZw5KnJVX5
         pvx2L7aWVe/v4EXhh+iAx3fI4GRoDzuxBwokbak88pRR6EcH/7CzDA19tvT0Hgx8lLvZ
         qfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923432; x=1691515432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXszYaQ2CLHCTB4bJrld8WlZZFAHDRACxKDlk8Go9KE=;
        b=CvQzm9hXq/Xyczi/SmmaFKSwcoyMVIuyKrxsI+8TU6H55g0FMc9jfSy4r5AgWNkItQ
         dfrvQ+7SoElrTE9ahSEATV7wB6xPNHXgDN0AR4L/vE0Ae3qcW/XkH/LKd2UJeQqkAfDo
         rX7eJDCWHcK+2MpWIPWqlibD5n4CTtH2+u5L8jyehkN3PRXqI7DkXZsY2YTk6rHt5X2E
         Bm0vsHqHM/ro+L9p6tIZ13CFkM8uLlwm6gnlsf2kUxIyNnkWd/nryTBhOyxpPJuF1mbt
         F9ZNRQpRY6X5tTM5woXkvI9AjjfUrp/2cBhp+jOFOdS8yDcj+JLrX8JwG1bNlO7wMWip
         HcJw==
X-Gm-Message-State: ABy/qLalVquVpPfFDK6B5SuacIWf5yLoeTq8XTQrBOnnUKqkhQle69mv
        66qIvJFVh3NlkFPETA/d2Ks1uuwa+flBHw880m6WguSX
X-Google-Smtp-Source: APBJJlGnzoJTLhBdGXuL1scQbuuQK51ub+hwLmkrEKuiNMRKT579F2NYfA8FhqZLYZJ7I5KTiM2/qQ==
X-Received: by 2002:a17:906:221a:b0:993:ff9d:2c2b with SMTP id s26-20020a170906221a00b00993ff9d2c2bmr2088208ejs.7.1688923432055;
        Sun, 09 Jul 2023 10:23:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090686ca00b0098e16f8c198sm5087461ejy.18.2023.07.09.10.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:23:51 -0700 (PDT)
Message-ID: <bb225c12-f017-fac3-45f1-c828a10553e2@linaro.org>
Date:   Sun, 9 Jul 2023 19:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, quic_jestar@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-7-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-7-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
> going through PBS firmware through a single register interface. This
> interface is implemented on an SDAM peripheral on the master PMIC PMK8550
> rather than a dedicated ADC peripheral.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 117 ++++++++++++++++--
>  .../iio/qcom,spmi-adc5-gen3-pm8550.h          |  48 +++++++
>  .../iio/qcom,spmi-adc5-gen3-pm8550b.h         |  97 +++++++++++++++
>  .../iio/qcom,spmi-adc5-gen3-pm8550vx.h        |  20 +++
>  .../iio/qcom,spmi-adc5-gen3-pmk8550.h         |  54 ++++++++
>  include/dt-bindings/iio/qcom,spmi-vadc.h      |  78 ++++++++++++
>  6 files changed, 402 insertions(+), 12 deletions(-)
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index eb7d16e385ad..090113e62d52 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -13,8 +13,8 @@ maintainers:
>  description: |
>    SPMI PMIC voltage ADC (VADC) provides interface to clients to read
>    voltage. The VADC is a 15-bit sigma-delta ADC.
> -  SPMI PMIC5/PMIC5 Gen2 voltage ADC (ADC) provides interface to clients to read
> -  voltage. The VADC is a 16-bit sigma-delta ADC.
> +  SPMI PMIC5/PMIC5 Gen2/PMIC5 Gen3 voltage ADC (ADC) provides interface to
> +  clients to read voltage. The VADC is a 16-bit sigma-delta ADC.
>  
>  properties:
>    compatible:
> @@ -27,10 +27,11 @@ properties:
>            - qcom,spmi-adc5
>            - qcom,spmi-adc-rev2
>            - qcom,spmi-adc5-gen2
> +          - qcom,spmi-adc5-gen3


This could be ordered...
>  
>    reg:
>      description: VADC base address in the SPMI PMIC register map
> -    maxItems: 1
> +    minItems: 1

Why? This does not make any sense. With previous patches it looks like
random set of changes.


>  
>    '#address-cells':
>      const: 1
> @@ -38,6 +39,12 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  "#thermal-sensor-cells":
> +    const: 1
> +    description:
> +      Number of cells required to uniquely identify the thermal sensors. Since
> +      we have multiple sensors this is set to 1.
> +
>    '#io-channel-cells':
>      const: 1
>  
> @@ -71,8 +78,8 @@ patternProperties:
>          description: |
>            ADC channel number.
>            See include/dt-bindings/iio/qcom,spmi-vadc.h
> -          For PMIC5 Gen2 ADC, the channel numbers are specified separately per PMIC
> -          in the PMIC-specific files in include/dt-bindings/iio/.
> +          For PMIC5 Gen2 and PMIC5 Gen3 ADC, the channel numbers are specified separately per
> +          PMIC in the PMIC-specific files in include/dt-bindings/iio/.
>  
>        label:
>          $ref: /schemas/types.yaml#/definitions/string
> @@ -114,11 +121,12 @@ patternProperties:
>                channel calibration. If property is not found, channel will be
>                calibrated with 0.625V and 1.25V reference channels, also
>                known as absolute calibration.
> -            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc5-gen2" and
> -              "qcom,spmi-adc-rev2", if this property is specified VADC will use
> -              the VDD reference (1.875V) and GND for channel calibration. If
> -              property is not found, channel will be calibrated with 0V and 1.25V
> -              reference channels, also known as absolute calibration.
> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc5-gen2",
> +              "qcom,spmi-adc-rev2" and "qcom,spmi-adc5-gen3", if this property
> +              is specified VADC will use the VDD reference (1.875V) and GND for
> +              channel calibration. If property is not found, channel will be
> +              calibrated with 0V and 1.25V reference channels, also known as
> +              absolute calibration.
>          type: boolean
>  
>        qcom,hw-settle-time:
> @@ -136,6 +144,12 @@ patternProperties:
>              from the ADC that is an average of multiple samples. The value
>              selected is 2^(value).
>  
> +      qcom,adc-tm-type:
> +        description: |
> +            Indicates if ADC_TM monitoring is done on this channel.

Description does not match property name.

> +            Defined for compatible property "qcom,spmi-adc5-gen3".

Then you need if:then:.

> +        type: boolean
> +
>      required:
>        - reg
>  
> @@ -213,7 +227,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: qcom,spmi-adc5-gen2
> +            enum:
> +              - qcom,spmi-adc5-gen2
> +              - qcom,spmi-adc5-gen3
>  
>      then:
>        patternProperties:
> @@ -299,7 +315,7 @@ examples:
>                  label = "xo_therm";
>              };
>  
> -            channel@47 {
> +            channel@147 {

Why?

>                  reg = <PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
> @@ -307,3 +323,80 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h>
> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h>
> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h>
> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h>
> +
> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      /* VADC node */
> +      pmk8550_vadc: vadc@9000 {
> +        compatible = "qcom,spmi-adc5-gen3";

Don't add new examples which differ only in compatible.


> diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
> new file mode 100644
> index 000000000000..74e6e2f6f9ed
> --- /dev/null
> +++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license.



Best regards,
Krzysztof

