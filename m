Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C0C6434C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiLETwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiLETwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:52:14 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF422C67E;
        Mon,  5 Dec 2022 11:49:35 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1443a16b71cso11211286fac.13;
        Mon, 05 Dec 2022 11:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF6ng5m2itRiuJ7lnIkeTvq8cFNvXklppaaRKX7UGTg=;
        b=ZvqL+N1cFzc9fjhCaxfp4Q/g2QU+Wd6saT1/EaE8dufuk92Ae4Ie7jiwZqrLQpdYOJ
         Ae+zJ7+jykw0e1TmaZQECsXkMk5f4p9qzv3y9uMwENnQ5zdYgkF/KePikTDMjwv0HC9f
         GKxWA6mo4CXqcJIHaH8FKWn4w3DdUwJi5lcs77vnxpLzFEpJzyzHdzjUrH5aYYg7GVhL
         vfmHINIuUI8944+NNtr2D8Wx2YhxY1WXUWOthuD3HJ8g8cggy131LYvxGjp9qmJnSDpH
         YyE044/VACQvfmRF4gDJkVDKL43IaKhDVxHu0TrKW6foxLCSp/j8+m1Gvm9dnp4pdBU8
         cQgQ==
X-Gm-Message-State: ANoB5pm3VzDVwRgDYw5wKPexXHuGZMVEaBlXQhetHz3oCjcAp26BjgAg
        5EeV+LaBVzQC2zf28uHlUDpBJDmcRg==
X-Google-Smtp-Source: AA0mqf6SKObACkoAq/BTaSQXXX27hSFzMgOd8GS/+JY7J6S6nZqiBO+ur0213ZcibiO+Qf8KBRwWBA==
X-Received: by 2002:a05:6871:430a:b0:142:397c:ae63 with SMTP id lu10-20020a056871430a00b00142397cae63mr47891313oab.269.1670269775164;
        Mon, 05 Dec 2022 11:49:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j125-20020acab983000000b0035b451d80afsm7358427oif.58.2022.12.05.11.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:49:34 -0800 (PST)
Received: (nullmailer pid 2481339 invoked by uid 1000);
        Mon, 05 Dec 2022 19:49:34 -0000
Date:   Mon, 5 Dec 2022 13:49:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/15] dt-bindings: remoteproc: qcom,sm8150-pas: split
 into separate file
Message-ID: <20221205194934.GA2476927-robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-9-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 07:43:26PM +0100, Krzysztof Kozlowski wrote:
> Split SM8150 and SM8250 remote processor Peripheral Authentication
> Service bindings into their own file to reduce complexity and make
> maintenance easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Drop if:then: for the clock and put it directly under properties.
> 2. Merge two if:then: clauses for setting interrupts.
> 
> Changes since v1:
> 1. Add qcom,qmp (not part of qcom,pas-common.yaml# anymore).
> 2. Add firmware-name to example.
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        |  27 ---
>  .../bindings/remoteproc/qcom,sm8150-pas.yaml  | 166 ++++++++++++++++++
>  2 files changed, 166 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> index 67941e79a4a0..e8d66eefd522 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> @@ -40,13 +40,6 @@ properties:
>        - qcom,sm6350-adsp-pas
>        - qcom,sm6350-cdsp-pas
>        - qcom,sm6350-mpss-pas
> -      - qcom,sm8150-adsp-pas
> -      - qcom,sm8150-cdsp-pas
> -      - qcom,sm8150-mpss-pas
> -      - qcom,sm8150-slpi-pas
> -      - qcom,sm8250-adsp-pas
> -      - qcom,sm8250-cdsp-pas
> -      - qcom,sm8250-slpi-pas
>  
>    reg:
>      maxItems: 1
> @@ -94,13 +87,6 @@ allOf:
>                - qcom,sm6350-adsp-pas
>                - qcom,sm6350-cdsp-pas
>                - qcom,sm6350-mpss-pas
> -              - qcom,sm8150-adsp-pas
> -              - qcom,sm8150-cdsp-pas
> -              - qcom,sm8150-mpss-pas
> -              - qcom,sm8150-slpi-pas
> -              - qcom,sm8250-adsp-pas
> -              - qcom,sm8250-cdsp-pas
> -              - qcom,sm8250-slpi-pas
>      then:
>        properties:
>          clocks:
> @@ -150,12 +136,6 @@ allOf:
>                - qcom,sdm845-cdsp-pas
>                - qcom,sm6350-adsp-pas
>                - qcom,sm6350-cdsp-pas
> -              - qcom,sm8150-adsp-pas
> -              - qcom,sm8150-cdsp-pas
> -              - qcom,sm8150-slpi-pas
> -              - qcom,sm8250-adsp-pas
> -              - qcom,sm8250-cdsp-pas
> -              - qcom,sm8250-slpi-pas
>      then:
>        properties:
>          interrupts:
> @@ -173,7 +153,6 @@ allOf:
>                - qcom,sc8180x-mpss-pas
>                - qcom,sdx55-mpss-pas
>                - qcom,sm6350-mpss-pas
> -              - qcom,sm8150-mpss-pas
>      then:
>        properties:
>          interrupts:
> @@ -199,8 +178,6 @@ allOf:
>                - qcom,msm8226-adsp-pil
>                - qcom,msm8996-adsp-pil
>                - qcom,msm8998-adsp-pas
> -              - qcom,sm8150-adsp-pas
> -              - qcom,sm8150-cdsp-pas
>      then:
>        properties:
>          power-domains:
> @@ -272,7 +249,6 @@ allOf:
>                - qcom,sc7280-mpss-pas
>                - qcom,sdx55-mpss-pas
>                - qcom,sm6350-mpss-pas
> -              - qcom,sm8150-mpss-pas
>      then:
>        properties:
>          power-domains:
> @@ -293,9 +269,6 @@ allOf:
>                - qcom,sc8180x-cdsp-pas
>                - qcom,sc8280xp-adsp-pas
>                - qcom,sm6350-adsp-pas
> -              - qcom,sm8150-slpi-pas
> -              - qcom,sm8250-adsp-pas
> -              - qcom,sm8250-slpi-pas
>      then:
>        properties:
>          power-domains:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> new file mode 100644
> index 000000000000..b934252cf02b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,sm8150-pas.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM8150/SM8250 Peripheral Authentication Service
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description:
> +  Qualcomm SM8150/SM8250 SoC Peripheral Authentication Service loads and boots
> +  firmware on the Qualcomm DSP Hexagon cores.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm8150-adsp-pas
> +      - qcom,sm8150-cdsp-pas
> +      - qcom,sm8150-mpss-pas
> +      - qcom,sm8150-slpi-pas
> +      - qcom,sm8250-adsp-pas
> +      - qcom,sm8250-cdsp-pas
> +      - qcom,sm8250-slpi-pas
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XO clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +
> +  qcom,qmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the AOSS side-channel message RAM.

Not ideal that we are defining the type here multiple times.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
