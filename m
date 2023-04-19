Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7086E80FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjDSSLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjDSSLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:11:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957D6A42
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:11:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso183831a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681927864; x=1684519864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2j1Pkr50g1mSceZHX8SMamWZIYT0Wo0+87cbSXw7e3o=;
        b=m+cMiZEoVpqxyT/om0k6XXK3bOf3Pnff/VflBJct4TbCkartXBbel29eKfpE9IWZvi
         S4ZUKSV6EXpHQ8zuORLbeV/u+ni6sq9BlxReFP0ECkw/+0dq7VRxqb3rIB1j5B0/oT25
         HObV51x2RuIfHa0WVmal7WRUebQo4Kp9KIDgtprIK/DwbA+Nz5es2pWXc5ulhoQbOrYX
         IHRxkGCj8TlYwdDI44bh8wW7iHPl6mHkK8LvOCKPqHKvVWzpjUD0b+WsjUzilILMFH42
         9UVXyk8Sn04HGtwNOPR0vij04blgLVO4iVo5jbP8BRClZ/LI99gJA/czjWEHSdLvt7DM
         xY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681927864; x=1684519864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2j1Pkr50g1mSceZHX8SMamWZIYT0Wo0+87cbSXw7e3o=;
        b=PaMCA8PoaGg7EVSxpe1hwcRiGLTMAbgA4ueXaWImdmQ4foMV74RrVtuwKv5Jihd1ie
         1nPkjsibJ6Mi3EKoQ2EI0/fXWkHj0qqluCdu7qyBpkdhIKKyIVLllZDbv/M5nr58EJRR
         zjc5pBL6sYR11rYjtN3cni8GXfDTFTGiT5CTeiFQBI8R+len0gJTOwnD7JQsdmsRMg6V
         dMJ+s0aqgDx/kX3HHxs2tjG0ZG1Pj73BMHk/OkQg9ZBIFF+t8xTLiTHCFwH9aK9BkRl0
         tFdcVmKgdfBTqUSM+Kx7L1HCAxv1P3safvlCitvfPlPQdIKfmSZm7GA0FaVsomXA4+Ec
         Vq2Q==
X-Gm-Message-State: AAQBX9f13bGGCoxMZ+tgyleM2XemgBRDOnZuE7J8UVNjHUX1+CWqbeWI
        PkbEDWsdUN93DT/KcYr2HzN4YA==
X-Google-Smtp-Source: AKy350a8Vdr07kQJG1rigtqy3d4/Y6OrVskqooISmVBchT4XXGJtlyrkQQiZkJt8od8HpD6LxrUw3w==
X-Received: by 2002:aa7:d6c2:0:b0:505:47a:7ae8 with SMTP id x2-20020aa7d6c2000000b00505047a7ae8mr6638521edr.4.1681927864360;
        Wed, 19 Apr 2023 11:11:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b7d8:d88b:1fac:c802? ([2a02:810d:15c0:828:b7d8:d88b:1fac:c802])
        by smtp.gmail.com with ESMTPSA id bo25-20020a0564020b3900b005067d129267sm7397824edb.39.2023.04.19.11.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 11:11:03 -0700 (PDT)
Message-ID: <3b7394e1-1be7-ec38-61bd-708a624070ac@linaro.org>
Date:   Wed, 19 Apr 2023 20:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] dt-bindings: clock: Add GCC bindings support for
 SDX75
Content-Language: en-US
To:     Taniya Das <quic_tdas@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     quic_skakitap@quicinc.com, Imran Shaik <quic_imrashai@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohiagar@quicinc.com, netdev@vger.kernel.org
References: <20230419133013.2563-1-quic_tdas@quicinc.com>
 <20230419133013.2563-3-quic_tdas@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419133013.2563-3-quic_tdas@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 15:30, Taniya Das wrote:
> From: Imran Shaik <quic_imrashai@quicinc.com>
> 

Thank you for your patch. There is something to discuss/improve.

> Add support for GCC bindings and update documentation for
> clock rpmh driver for SDX75.

Subject: drop second/last, redundant "bindings support for". The
"dt-bindings" prefix is already stating that these are bindings.
But missing vendor name (Qualcomm). Both in subject and commit msg.



> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-sdx75.yaml        |  69 +++++++
>  .../bindings/clock/qcom,rpmhcc.yaml           |   1 +
>  include/dt-bindings/clock/qcom,gcc-sdx75.h    | 193 ++++++++++++++++++
>  3 files changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdx75.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sdx75.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdx75.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdx75.yaml
> new file mode 100644
> index 000000000000..6489d857d5c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdx75.yaml

All new devices come as SoC-IP, so qcom,sdx75-gcc

> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-sdx75.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on SDX75
> +
> +maintainers:
> +  - Imran Shaik <quic_imrashai@quicinc.com>
> +  - Taniya Das <quic_tdas@quicinc.com>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on SDX75
> +
> +  See also:: include/dt-bindings/clock/qcom,gcc-sdx75.h

Also hee

> +
> +properties:
> +  compatible:
> +    const: qcom,gcc-sdx75

Also here

> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: PCIE20 phy aux clock source
> +      - description: PCIE_1 Pipe clock source
> +      - description: PCIE_2 Pipe clock source
> +      - description: PCIE Pipe clock source
> +      - description: Sleep clock source
> +      - description: USB3 phy wrapper pipe clock source
> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: pcie20_phy_aux_clk
> +      - const: pcie_1_pipe_clk
> +      - const: pcie_2_pipe_clk
> +      - const: pcie_pipe_clk
> +      - const: sleep_clk
> +      - const: usb3_phy_wrapper_gcc_usb30_pipe_clk

Drop clock names entirely.

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    clock-controller@80000 {
> +      compatible = "qcom,gcc-sdx75";
> +      reg = <0x80000 0x1f7400>;
> +      clocks = <&rpmhcc RPMH_CXO_CLK>, <&pcie20_phy_aux_clk>, <&pcie_1_pipe_clk>,
> +               <&pcie_2_pipe_clk>, <&pcie_pipe_clk>, <&sleep_clk>,
> +               <&usb3_phy_wrapper_gcc_usb30_pipe_clk>;
> +      clock-names = "bi_tcxo", "pcie20_phy_aux_clk", "pcie_1_pipe_clk",
> +                    "pcie_2_pipe_clk", "pcie_pipe_clk", "sleep_clk",
> +                    "usb3_phy_wrapper_gcc_usb30_pipe_clk";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> index d5a250b7c2af..267cf8c26823 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> @@ -27,6 +27,7 @@ properties:
>        - qcom,sdm845-rpmh-clk
>        - qcom,sdx55-rpmh-clk
>        - qcom,sdx65-rpmh-clk
> +      - qcom,sdx75-rpmh-clk

Separate patch.


>        - qcom,sm6350-rpmh-clk
>        - qcom,sm8150-rpmh-clk
>        - qcom,sm8250-rpmh-clk
> diff --git a/include/dt-bindings/clock/qcom,gcc-sdx75.h b/include/dt-bindings/clock/qcom,gcc-sdx75.h
> new file mode 100644
> index 000000000000..a470e8c4fd41
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,gcc-sdx75.h

qcom,sdx75-gcc

> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SDX75_H
> +#define _DT_BINDINGS_CLK_QCOM_GCC_SDX75_H
> +
> +/* GCC clocks */


Best regards,
Krzysztof

