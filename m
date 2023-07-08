Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D467174BDF6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGHO7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHO7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A47DE4D;
        Sat,  8 Jul 2023 07:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A061601D9;
        Sat,  8 Jul 2023 14:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27E4C433C8;
        Sat,  8 Jul 2023 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688828337;
        bh=zyiqPPttHrMHlfqAeF/jgSOrl93tlfuoWtOimapizvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pfsUDIg9r/ySf0zzLHRL9AD6n9iQl5DVGNJRrW4R6Rp5Uor9UMFlaF9upF0YpDpYr
         jQcy1Oilm/cgDpfkDLsdidk4JzXcsAm2slJuHKtlGKWViwhnGVTAtr3epbRrqKM8m3
         3PNo7IeCnvsyPXydNOMLx31Rb/HpVskw+hNpw61rBV7kAQ/HC3xU6GJCdkyhQmUdxQ
         Zfx96ZbAtO2LK/COeVMLXQdSBpQAhxk58fVZrAtMwguCDZRoHBhiFjjPk5min9J/vt
         knCxtU7vcjpcKoZpGUfxs2MqLVlBhY46YtTbXFQbGhwd+HHz+20JzyAzRzRtqn6eei
         V/rlQPcVtlZ5A==
Date:   Sat, 8 Jul 2023 15:58:44 +0100
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>, "Luca Weiss" <luca@z3ntu.xyz>,
        <linux-iio@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 01/11] iio: adc: Update bindings for ADC7 name used on
 QCOM PMICs
Message-ID: <20230708155844.31c55ca0@jic23-huawei>
In-Reply-To: <20230708072835.3035398-2-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
        <20230708072835.3035398-2-quic_jprakash@quicinc.com>
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

On Sat, 8 Jul 2023 12:58:25 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> The name used initially for this version of Qualcomm Technologies, Inc.
> PMIC ADC was ADC7, following the convention of calling the PMIC generation
> PMIC7. However, the names were later amended internally to ADC5 Gen2 and
> PMIC5 Gen2. In addition, the latest PMIC generation now is known as
> PMIC5 Gen3 with ADC5 Gen3 supported on it. With this addition, it makes more
> sense to correct the name for this version of ADCs to ADC5 Gen2 from ADC7.
> Since this affects ADC devices across some PMICs, update the names accordingly.
> 
> In order to avoid breaking the existing implementations of ADC7, add
> support for ADC5 Gen2 first now and remove the ADC7 support in a later
> patch.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Hi Jishnu.

Whilst I can appreciate why you've picked this particular approach to
deal with the renames I'm not sure it's the smoothest path - or the
easiest to review.

If doing a single patch for the complete rename was too much, perhaps
doing one header (or if it makes sense set of headers)
at a time would be easier to read?  With a final patch doing the compatible
addition.  Maybe let's see what other reviewers think though.

A few other comments inline,

Jonathan


> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 21 +++--
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 16 ++--
>  .../iio/qcom,spmi-adc5-gen2-pm8350.h          | 64 +++++++++++++
>  .../iio/qcom,spmi-adc5-gen2-pm8350b.h         | 89 +++++++++++++++++++
>  .../iio/qcom,spmi-adc5-gen2-pmk8350.h         | 47 ++++++++++
>  .../iio/qcom,spmi-adc5-gen2-pmr735a.h         | 29 ++++++
>  .../iio/qcom,spmi-adc5-gen2-pmr735b.h         | 28 ++++++
>  include/dt-bindings/iio/qcom,spmi-vadc.h      | 77 ++++++++++++++++
>  8 files changed, 354 insertions(+), 17 deletions(-)
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350b.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735b.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index ad7d6fc49de5..f886977de165 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -13,7 +13,7 @@ maintainers:
>  description: |
>    SPMI PMIC voltage ADC (VADC) provides interface to clients to read
>    voltage. The VADC is a 15-bit sigma-delta ADC.
> -  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
> +  SPMI PMIC5/PMIC5 Gen2 voltage ADC (ADC) provides interface to clients to read
>    voltage. The VADC is a 16-bit sigma-delta ADC.
>  
>  properties:
> @@ -27,6 +27,7 @@ properties:
>            - qcom,spmi-adc5
>            - qcom,spmi-adc-rev2
>            - qcom,spmi-adc7
> +          - qcom,spmi-adc5-gen2

Alphabetical order (roughly given currently list). So I'd stick 
this after qcom,spmi-adc5

>  
>    reg:
>      description: VADC base address in the SPMI PMIC register map
> @@ -71,7 +72,7 @@ patternProperties:
>          description: |
>            ADC channel number.
>            See include/dt-bindings/iio/qcom,spmi-vadc.h
> -          For PMIC7 ADC, the channel numbers are specified separately per PMIC
> +          For PMIC5 Gen2 ADC, the channel numbers are specified separately per PMIC
>            in the PMIC-specific files in include/dt-bindings/iio/.
>  
>        label:
> @@ -114,7 +115,7 @@ patternProperties:
>                channel calibration. If property is not found, channel will be
>                calibrated with 0.625V and 1.25V reference channels, also
>                known as absolute calibration.
> -            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc5-gen2" and
>                "qcom,spmi-adc-rev2", if this property is specified VADC will use
>                the VDD reference (1.875V) and GND for channel calibration. If
>                property is not found, channel will be calibrated with 0V and 1.25V
> @@ -213,7 +214,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: qcom,spmi-adc7
> +            enum :
> +                - qcom,spmi-adc7

There is a deprecated marking for dt-bindings. Might be good to use it here.

> +                - qcom,spmi-adc5-gen2
>  
>      then:
>        patternProperties:
> @@ -277,8 +280,8 @@ examples:
>      };
>U>;
> +                io-channels = <&pmk8350_vadc PMK8350_ADC5_GEN2_AMUX_THM1_100K_PU>;
>                  qcom,decimation = <340>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time-us = <200>;
> @@ -251,7 +251,7 @@ examples:
>  
>              conn-therm@1 {
>                  reg = <1>;
> -                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
> +                io-channels = <&pmk8350_vadc PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
>                  qcom,avg-samples = <2>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time-us = <200>;



