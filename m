Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5170B06F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjEUU6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 16:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUU6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 16:58:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D0E3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 13:57:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso1137362e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684702677; x=1687294677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8VgRiwl/tsNhAm0CEALdxN74kfHKIFrIlet29wp6ag=;
        b=bJ1SiCO5hhg/s+RqhzEQ/OtlfMMGNW+oEli/37gQlFgxaCcso3DVr3j6tnXu1JL+sW
         auo2g8Vf5xccd7QiidhFV2dQDGFmJ0CxwTQs+RvAenXRDiJDgfSYXGX2hS7sTX251DJg
         Sjohh6lrZYr7kaIRZiek1yMVeMIAtEpzX07E3FYJLwkjNaukAOpI/CWCZO/Qh76uNUGB
         cYbcFrdQwUf/XqXsLolR9W326JfTeYTgu7W/TctwUZEu28udj2uGqj8nxCvGEYM4oO//
         QjfEMAD0MtGAmk+ff4qElud7DzwLAtMYeL19MLN2EjsuIzdX7WlMDwg+OM5JvlWrxOjT
         PmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684702677; x=1687294677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8VgRiwl/tsNhAm0CEALdxN74kfHKIFrIlet29wp6ag=;
        b=k3bUErloVcFzhc48XsCGwftBkS/UM11PHX/Cilzj51c/i7t8sFvktVCyR13oKc0J/R
         bOFhKHCmD/lPRMpyxXeo8iL2HUEXWBWxqVgYheXfRvrXmFhv3ve62D02TJjcWfIAD+NE
         7WWd3x0+wypTy3uA9k7wQcW6YAcAhTJeuZOuU45JC255ptHCD2QHlDW2Np6khVb3t846
         Y33mdGrEGcRwixd7GJ24PmXZWaJNqf+I4wrRZxC9B/pyQVgemiay7yE59zN4jcs3kCKS
         CeWx+vjKBXV/7MrbKotbJF5rZ9anuXJDHXjG2rQ1SLKhYsNneJodA84w/oVqM+poi0qd
         2ggA==
X-Gm-Message-State: AC+VfDw9qkdkRbj1CjPTIf1jPFFa6tnPSSWp8PAynAP26O9h453CaxS5
        M/Q8Rn4LuFw28CJ0FBwAVsTl3Q==
X-Google-Smtp-Source: ACHHUZ5t6z6Z/Pzc3RXPwIkR8BYJtuzC364yOjRapibj1hxvGc9LTzDSTBdOYaBYejxngr7JmrhU2A==
X-Received: by 2002:a19:ee15:0:b0:4f3:ac64:84d9 with SMTP id g21-20020a19ee15000000b004f3ac6484d9mr2232089lfb.20.1684702676948;
        Sun, 21 May 2023 13:57:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q6-20020ac25146000000b004f391369ccbsm733232lfd.55.2023.05.21.13.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 13:57:56 -0700 (PDT)
Message-ID: <874a328c-bbfb-00cb-4b2e-69132605cb2d@linaro.org>
Date:   Sun, 21 May 2023 23:57:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 1/2] dt-bindings: phy: qcom,qmp-pcie: Add ipq9574
 bindings
Content-Language: en-GB
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
References: <20230519085723.15601-1-quic_devipriy@quicinc.com>
 <20230519085723.15601-2-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230519085723.15601-2-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 11:57, Devi Priya wrote:
> Add bindings for the PCIe QMP PHYs found on IPQ9574.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   Changes in V2:
> 	- Picked up the R-b tag
> 	- Did not convert the clock IDs to numerical values as the clock
> 	  header (dependent patch) is merged in latest rc1.
> 
>   .../phy/qcom,ipq9574-qmp-pcie-phy.yaml        | 90 +++++++++++++++++++
>   1 file changed, 90 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml
> new file mode 100644
> index 000000000000..7c8012647051
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,ipq9574-qmp-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QMP PHY controller (PCIe, IPQ9574)
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description:
> +  The QMP PHY controller supports physical layer functionality for a number of
> +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq9574-qmp-gen3x1-pcie-phy
> +      - qcom,ipq9574-qmp-gen3x2-pcie-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 5
> +
> +  clock-names:
> +    items:
> +      - const: aux
> +      - const: cfg_ahb
> +      - const: anoc_lane
> +      - const: snoc_lane
> +      - const: pipe

Could you please reorder the clocks in the following way:
- aux
- cfg_ahb
- pipe
- .. the rest

This will allow us to use this schema for other IPQ QMP PCIe PHYs.

> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +      - const: common
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - "#clock-cells"
> +  - clock-output-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +    #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +
> +    pcie0_phy: phy@84000 {
> +      compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +      reg = <0x00084000 0x1000>;
> +
> +      clocks = <&gcc GCC_PCIE0_AUX_CLK>,
> +               <&gcc GCC_PCIE0_AHB_CLK>,
> +               <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
> +               <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>,
> +               <&gcc GCC_PCIE0_PIPE_CLK>;
> +      clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
> +
> +      resets = <&gcc GCC_PCIE0_PHY_BCR>,
> +               <&gcc GCC_PCIE0PHY_PHY_BCR>;
> +      reset-names = "phy", "common";
> +
> +      #clock-cells = <0>;
> +      clock-output-names = "gcc_pcie0_pipe_clk_src";
> +
> +      #phy-cells = <0>;
> +    };

-- 
With best wishes
Dmitry

