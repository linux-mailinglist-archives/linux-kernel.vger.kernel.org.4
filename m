Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040A2626941
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiKLLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiKLLnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:43:08 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2872408A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:43:06 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id k19so7263580lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjxvJKCOUGF0uKsEtLv1V3yxQcKhAe5TR96SwIkJJTY=;
        b=nfeOBtCJONFbTODvWG5iKu/jDAoeyfaANc9ZVQVrYJGeYfhbMNDmc468Rqy+Pb5MpF
         tdg99QC4TdKTbhwWozEjYd0M0MNStY7ap1XAYm2Ysvic0op2zbX0wlzRVAU48sRRxivJ
         tOMcZ/q2+Pf232JWyQGH8uo38eHW11M3aW3gD85K5ra1JJhEwwPWNedha0t3mDBayI++
         sfGUHJt2wr0Lq/0E6OYQ0pOjzoFeulmaTFTRvn0+hb8kJGyk7D1m2Ojw5Q3Cytsr0fOG
         KxrvQx5Hj9QXypV9nA3COGKfn67kWeDYFfzbtoyJPq1x61H+hSKvJSCy7pQdJtdwItHo
         ZdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjxvJKCOUGF0uKsEtLv1V3yxQcKhAe5TR96SwIkJJTY=;
        b=h9m7zVA6LTEVyCcrw0OCBfMabk4bclZ5pcChttVBN+LHUKUDKVKTt7+pFRXaMZQlqP
         OsRqna1CtTUcEQqEqV8qW78i1ORi7P6s1BtnSlnUZHv/Z5hCBPY37JiLgXRxq8+w2tpX
         JgvqHFgOAiwybhdivqsZohrELCwRWUZDSfRqPKGhLB5fIXjnGSNnsVkuuLKjNDEhfwkk
         jG+x99mV/GTpiescA7VVZpqzuawo0NZE2gDXA65Z3hjsK0l4BgeYIMu5nubKx/8xAIEB
         V93d2ZIc0QZt33y8FbL5GmLVX7jNeLThLFyMAAcGDr0pr0VwtSFwWCl34p18iAVUj0je
         oHNQ==
X-Gm-Message-State: ANoB5pniXp8v+AHy8ZoxoFn2dq1Su9vH87yP53nOCsMAvX3l7M5KS03M
        RhUomszavL0buDs1CG6nz8mEYg==
X-Google-Smtp-Source: AA0mqf6vb15YAkHYZT9+DGZTKJanu/FLhhs+qQU5XcTdKudZwaaud6smmFGQA7jSxndaaz71lR9ACg==
X-Received: by 2002:a2e:a590:0:b0:277:3ca2:dac6 with SMTP id m16-20020a2ea590000000b002773ca2dac6mr1703439ljp.143.1668253384342;
        Sat, 12 Nov 2022 03:43:04 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651234c200b00492e3a8366esm841852lfr.9.2022.11.12.03.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 03:43:04 -0800 (PST)
Message-ID: <ace91d8b-9a14-5569-7c59-344e9751fa96@linaro.org>
Date:   Sat, 12 Nov 2022 14:43:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111092457.10546-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/11/2022 12:24, Johan Hovold wrote:
> The current QMP USB3-DP PHY bindings are based on the original MSM8996
> binding which provided multiple PHYs per IP block and these in turn were
> described by child nodes.
> 
> The QMP USB3-DP PHY block provides a single multi-protocol PHY and even
> if some resources are only used by either the USB or DP part of the
> device there is no real benefit in describing these resources in child
> nodes.
> 
> The original MSM8996 binding also ended up describing the individual
> register blocks as belonging to either the wrapper node or the PHY child
> nodes.
> 
> This is an unnecessary level of detail which has lead to problems when
> later IP blocks using different register layouts have been forced to fit
> the original mould rather than updating the binding. The bindings are
> arguable also incomplete as they only the describe register blocks used
> by the current Linux drivers (e.g. does not include the PCS LANE
> registers).
> 
> This is specifically true for later USB4-USB3-DP QMP PHYs where the TX
> registers are used by both the USB3 and DP parts of the PHY (and where
> the USB4 part of the PHY was not covered by the binding at all). Notably
> there are also no DP "RX" (sic) registers as described by the current
> bindings and the DP "PCS" region is really a set of DP_PHY registers.
> 
> Add a new binding for the USB4-USB3-DP QMP PHYs found on SC8280XP which
> further bindings can be based on.
> 
> Note that the binding uses a PHY type index to access either the USB3 or
> DP part of the PHY and that this can later be used also for the USB4
> part if needed.
> 
> Similarly, the clock inputs and outputs can later be extended to support
> USB4.
> 
> Also note that the current binding is simply removed instead of being
> deprecated as it was only recently merged and would not allow for
> supporting DP mode.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   .../phy/qcom,sc7180-qmp-usb3-dp-phy.yaml      |  12 --
>   .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 111 ++++++++++++++++++
>   2 files changed, 111 insertions(+), 12 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
> index 50b1fce530d5..2f4a419197a8 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
> @@ -23,7 +23,6 @@ properties:
>         - qcom,sc7180-qmp-usb3-dp-phy
>         - qcom,sc7280-qmp-usb3-dp-phy
>         - qcom,sc8180x-qmp-usb3-dp-phy
> -      - qcom,sc8280xp-qmp-usb43dp-phy
>         - qcom,sdm845-qmp-usb3-dp-phy
>         - qcom,sm8250-qmp-usb3-dp-phy
>     reg:
> @@ -169,17 +168,6 @@ required:
>   
>   additionalProperties: false
>   
> -allOf:
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - qcom,sc8280xp-qmp-usb43dp-phy
> -    then:
> -      required:
> -        - power-domains
> -
>   examples:
>     - |
>       #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> new file mode 100644
> index 000000000000..bd04150acee4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QMP USB4-USB3-DP PHY controller (SC8280XP)
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description:
> +  The QMP PHY controller supports physical layer functionality for a number of
> +  controllers on Qualcomm chipsets, such as, PCIe, UFS and USB.
> +
> +  See also:
> +    - include/dt-bindings/dt-bindings/phy/phy.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc8280xp-qmp-usb43dp-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: aux
> +      - const: ref
> +      - const: com_aux
> +      - const: usb3_pipe
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +      - const: common
> +
> +  vdda-phy-supply: true
> +
> +  vdda-pll-supply: true
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clock-output-names:
> +    items:
> +      - const: usb3_pipe
> +      - const: dp_link
> +      - const: dp_vco_div
> +
> +  "#phy-cells":
> +    const: 1
> +    description: |
> +      PHY index
> +        - PHY_TYPE_USB3
> +        - PHY_TYPE_DP

I'm stepping on Rob's and Krzysztof's ground here, but it might be more 
logical and future proof to use indices instead of phy types.

Just for my understanding, would USB4 support add another qserdes+tx/rx 
construct or would it be the same USB3 register space?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - vdda-phy-supply
> +  - vdda-pll-supply
> +  - "#clock-cells"
> +  - clock-output-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
> +
> +    phy@88eb000 {
> +      compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
> +      reg = <0x088eb000 0x4000>;
> +
> +      clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +               <&gcc GCC_USB4_EUD_CLKREF_CLK>,
> +               <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +               <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +      clock-names = "aux", "ref", "com_aux", "usb3_pipe";
> +
> +      power-domains = <&gcc USB30_PRIM_GDSC>;
> +
> +      resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> +               <&gcc GCC_USB4_DP_PHY_PRIM_BCR>;
> +      reset-names = "phy", "common";
> +
> +      vdda-phy-supply = <&vreg_l9d>;
> +      vdda-pll-supply = <&vreg_l4d>;
> +
> +      #clock-cells = <1>;
> +      clock-output-names = "usb3_pipe", "dp_link", "dp_vco_div";
> +
> +      #phy-cells = <1>;
> +    };

-- 
With best wishes
Dmitry

