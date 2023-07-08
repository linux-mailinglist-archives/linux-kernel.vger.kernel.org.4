Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93D474BE0F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGHPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C057E7;
        Sat,  8 Jul 2023 08:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A72E660D56;
        Sat,  8 Jul 2023 15:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7978AC433C8;
        Sat,  8 Jul 2023 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688829191;
        bh=bnr0VSTI8p7KQC4KA1GiSG5P6kLWoXPgfRmEgwYrnq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a6LvhJhYlrfrMo4dUFeQgu7vHe2b1LRbO0LI50bLpjEzigEqZyff7HznRLRQHOCQJ
         xevnZ/RdLrqwjr92eg+H7Q9Wj1T0DiZHNxmre9Ut8aion1KSS4F50soaoopNoYKhw5
         oRIga+LXuwNx+k2fIvn9Bb/RquypRc34xqWpZmBVjMx7/7GxzmIq2ZV18wDtyxMU86
         YKDHknzrLjriBg03nALJnKMo3zdjSxejyvZSfzZl5yRdndk6VeEOHjiWMY0oqK/Tll
         HvMWMSFNsQLAyynNAfSmGXaGUu0iYu5iZW1j5Fr/3USYVIy75AitUao1BxbnvFL+m+
         VXpnNRqB8pdcw==
Date:   Sat, 8 Jul 2023 16:12:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Luca Weiss" <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Message-ID: <20230708161259.7af17fa9@jic23-huawei>
In-Reply-To: <20230708072835.3035398-7-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
        <20230708072835.3035398-7-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 12:58:30 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

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
>  
>    reg:
>      description: VADC base address in the SPMI PMIC register map
> -    maxItems: 1
> +    minItems: 1

?

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

Defined only for the new gen3?  If so make make it false for the other devices.

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
> +            Defined for compatible property "qcom,spmi-adc5-gen3".
> +        type: boolean

Enforce that in the binding, not via a comment. Once the binding
performs that check (set it to false for non matching compatibles) then
there is no need to also mention it in text.

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

Side note - it's fine to have a single element enum, so you could
use that option to reduce churn in this set...

>  
>      then:
>        patternProperties:
> @@ -299,7 +315,7 @@ examples:
>                  label = "xo_therm";
>              };
>  
> -            channel@47 {
> +            channel@147 {

?  If that's a valid change, then it looks like a separate fix.

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
> +        reg = <0x9000>;
> +        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #io-channel-cells = <1>;
> +        #thermal-sensor-cells = <1>;
> +
> +        /* PMK8550 Channel nodes */
> +        channel@3 {
> +          reg = <PMK8550_ADC5_GEN3_DIE_TEMP>;
> +          label = "pmk8550_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +
> +        channel@44 {
> +          reg = <PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU>;
> +          label = "pmk8550_xo_therm";
> +          qcom,pre-scaling = <1 1>;
> +          qcom,ratiometric;
> +          qcom,hw-settle-time = <200>;
> +          qcom,adc-tm-type;
> +        };
> +
> +        /* PM8550 Channel nodes */
> +        channel@103 {
> +          reg = <PM8550_ADC5_GEN3_DIE_TEMP>;
> +          label = "pm8550_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +
> +        channel@18e {
> +          reg = <PM8550_ADC5_GEN3_VPH_PWR>;
> +          label = "pm8550_vph_pwr";
> +          qcom,pre-scaling = <1 3>;
> +        };
> +
> +        /* PM8550B Channel nodes */
> +        channel@703 {
> +          reg = <PM8550B_ADC5_GEN3_DIE_TEMP>;
> +          label = "pm8550b_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +
> +        channel@78e {
> +          reg = <PM8550B_ADC5_GEN3_VPH_PWR>;
> +          label = "pm8550b_vph_pwr";
> +          qcom,pre-scaling = <1 3>;
> +        };
> +
> +        channel@78f {
> +          reg = <PM8550B_ADC5_GEN3_VBAT_SNS_QBG>;
> +          label = "pm8550b_vbat_sns_qbg";
> +          qcom,pre-scaling = <1 3>;
> +        };
> +
> +        /* PM8550VS_C Channel nodes */
> +        channel@203 {
> +          reg = <PM8550VS_ADC5_GEN3_DIE_TEMP(2)>;
> +          label = "pm8550vs_c_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +      };
> +    };
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
> new file mode 100644
> index 000000000000..74e6e2f6f9ed
> --- /dev/null
> +++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
> +
> +#ifndef PM8550_SID
> +#define PM8550_SID		1
> +#endif
> +
> +/* ADC channels for PM8550_ADC for PMIC5 Gen3 */
> +#define PM8550_ADC5_GEN3_OFFSET_REF			(PM8550_SID << 8 | 0x00)

can we do the naming for the 0x00 as per Dmitry's set? That is get them from
qcom,spmi-vadc.h

https://patchwork.kernel.org/project/linux-iio/patch/20230707123027.1510723-2-dmitry.baryshkov@linaro.org/

> +#define PM8550_ADC5_GEN3_1P25VREF			(PM8550_SID << 8 | 0x01)
> +#define PM8550_ADC5_GEN3_VREF_VADC			(PM8550_SID << 8 | 0x02)
> +#define PM8550_ADC5_GEN3_DIE_TEMP			(PM8550_SID << 8 | 0x03)
> +


> diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
> index b1413c62ad27..ca5a0a947b3b 100644
> --- a/include/dt-bindings/iio/qcom,spmi-vadc.h
> +++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
> @@ -298,4 +298,82 @@
>  #define ADC5_GEN2_SBUx				0x94
>  #define ADC5_GEN2_VBAT_2S_MID			0x96
>  
> +/* ADC channels for PMIC5 Gen3 */
> +
> +#define ADC5_GEN3_OFFSET_REF			0x00
> +#define ADC5_GEN3_1P25VREF			0x01
> +#define ADC5_GEN3_VREF_VADC			0x02
> +#define ADC5_GEN3_DIE_TEMP			0x03


