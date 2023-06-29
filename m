Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E1742A89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF2QWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjF2QWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:22:11 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A6B2D71;
        Thu, 29 Jun 2023 09:22:10 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-78625caa702so36251339f.1;
        Thu, 29 Jun 2023 09:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055729; x=1690647729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XJIPc5D/nWMfHtdu7S7li9GBwwNXgclF2o+QzBIkc4=;
        b=h1p8UOYDhvekLDtouXyxYzVLqYPXQES0d5trf7gGfzrqCG3sxpTEi2eUjt5fcnJytL
         oBz3u6FvXO38u/hZMsKOWxw4EBBVwcXgsejzc7JCGHP0q6eV14DWxZ4Q13ElLkkVsLo8
         k7cqMyVCdSRYtFyn//wM/aUWU6RIyKjVXdHuhF/sOZ3X8i9uTJSlWRxG2jjVpCWAo4Ma
         8N4qdxtILC5pq+LSwgd04YuQwLgvag9hRFbXFBfwCNyluO32cFdn9a4BF03R90YEh5/3
         P6MiPhj7ghF0hMIiN5Dy70lzeLbUIN+Sl7tcnthFEI+YGn9SfnWypFo+xwbWPmqyFENG
         liMQ==
X-Gm-Message-State: AC+VfDxCQNTaIqS0jrT1+H6hGeHcPaa6HlATJmIiG2Yi7z/KQF+ndult
        FCIQMU8EN4ARR63y5ZtTwQ==
X-Google-Smtp-Source: ACHHUZ6zGJ7m4puXX8RHcH3RvWagEBtmRonrdSYks1C5rYbMaDbnTtvDB2aOGrA7t0/2f2jzbMXmHw==
X-Received: by 2002:a05:6602:200c:b0:786:2d04:7b14 with SMTP id y12-20020a056602200c00b007862d047b14mr19684iod.16.1688055729525;
        Thu, 29 Jun 2023 09:22:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b2-20020a05663801a200b0042aeaba5413sm1498979jaq.117.2023.06.29.09.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:22:08 -0700 (PDT)
Received: (nullmailer pid 3141062 invoked by uid 1000);
        Thu, 29 Jun 2023 16:22:06 -0000
Date:   Thu, 29 Jun 2023 10:22:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/4] dt-bindings: regulator: Describe Qualcomm REFGEN
 regulator
Message-ID: <20230629162206.GA3137232-robh@kernel.org>
References: <20230628-topic-refgen-v1-0-126e59573eeb@linaro.org>
 <20230628-topic-refgen-v1-1-126e59573eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628-topic-refgen-v1-1-126e59573eeb@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:29:45PM +0200, Konrad Dybcio wrote:
> Modern Qualcomm SoCs have a REFGEN (reference voltage generator)
> regulator, providing reference voltage to on-chip IP, like PHYs.
> It's controlled through MMIO and we can toggle it or read its state back.
> 
> Describe it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../regulator/qcom,sdm845-refgen-regulator.yaml    | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
> new file mode 100644
> index 000000000000..19d3eb9db98f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/qcom,sdm845-refgen-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. REFGEN Regulator
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +
> +description: |

Don't need '|'.

> +    The REFGEN (reference voltage renegator) regulator provides reference

renegator?

> +    voltage for on-chip IPs (like PHYs) on some Qualcomm SoCs.
> +
> +allOf:
> +  - $ref: regulator.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,sc7180-refgen-regulator
> +              - qcom,sc8180x-refgen-regulator
> +              - qcom,sm8150-refgen-regulator
> +          - const: qcom,sdm845-refgen-regulator
> +
> +      - items:
> +          - enum:
> +              - qcom,sc7280-refgen-regulator
> +              - qcom,sc8280xp-refgen-regulator
> +              - qcom,sm6350-refgen-regulator
> +              - qcom,sm6375-refgen-regulator
> +              - qcom,sm8350-refgen-regulator
> +          - const: qcom,sm8250-refgen-regulator
> +
> +      - enum:
> +          - qcom,sdm845-refgen-regulator
> +          - qcom,sm8250-refgen-regulator
> +
> +  reg: true

Need to define how many.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    regulator@162f000 {
> +      compatible = "qcom,sm8250-refgen-regulator";
> +      reg = <0 0x0162f000 0 0x84>;

Default cell size is 1.

> +    };
> +...
> 
> -- 
> 2.41.0
> 
