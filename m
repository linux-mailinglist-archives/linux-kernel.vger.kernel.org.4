Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38A062CD43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiKPV7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKPV7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:59:02 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805A429B3;
        Wed, 16 Nov 2022 13:59:01 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so11306868otl.3;
        Wed, 16 Nov 2022 13:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOyBj+NkPlmsU/hNNX2WAgkJS380RESQvA61GOSlNF4=;
        b=2WrMfIfLOk87G8RAnPs7jtcLmj+U8vgOowwvr5+qDVQ9dP11UjkGy0lKnpvdIlZBS6
         S5Ob0aojp6enygONOpjD6l53oYqtwJJfW5b9jllH1JYUdxzRwmrexuWAJJvlsWPkoyvJ
         jjo0y/PCBkHC8gX1iEzCfcZK5DlEjQcWGxBs+3UtSGZXIinyUi3dh9Vqykyjd9PnNc7c
         rkbmxDjMFiOQkkwHBWRt8EwsAbzBNKu8TG/kiRN5cam63UmCypqdWabxBH/LBjmFly6s
         LojWg4iD3vpN2gSUmVeNq+6iOcPZUrVfn6iOLNKHtYGqnScTd0qhjCkdrxz5wPQ9xupj
         dgXg==
X-Gm-Message-State: ANoB5plkmaCJTT+zXI4yGvLdmDL4dvS6/v3+rITjHiIccGsitnZcegKd
        JuNFm10NfUTrJ+fijIM4BzMNcM/uQQ==
X-Google-Smtp-Source: AA0mqf70VCZhS3LeAtqQzNn5wuvSkgEMQ5q1d2p1FrjAZE/P1Wmr9559HMbXtHF/NBO9sbuGlfhEdg==
X-Received: by 2002:a05:6830:2a8d:b0:66c:5bf1:9f8c with SMTP id s13-20020a0568302a8d00b0066c5bf19f8cmr59727otu.163.1668635940513;
        Wed, 16 Nov 2022 13:59:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s35-20020a0568302aa300b0066db09fb1b5sm1818812otu.66.2022.11.16.13.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:58:59 -0800 (PST)
Received: (nullmailer pid 1042119 invoked by uid 1000);
        Wed, 16 Nov 2022 21:59:02 -0000
Date:   Wed, 16 Nov 2022 15:59:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] dt-bindings: phy: qcom,qmp-usb3-dp: fix
 sc8280xp binding
Message-ID: <20221116215902.GA1038313-robh@kernel.org>
References: <20221115144005.2478-1-johan+linaro@kernel.org>
 <20221115144005.2478-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115144005.2478-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 03:39:52PM +0100, Johan Hovold wrote:
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
> Note that the binding uses a PHY index to access either the USB3 or DP
> part of the PHY and that this can later be used also for the USB4 part
> if needed.
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
>  .../phy/qcom,sc7180-qmp-usb3-dp-phy.yaml      | 12 ---
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 99 +++++++++++++++++++
>  include/dt-bindings/phy/phy-qcom-qmp.h        | 20 ++++
>  3 files changed, 119 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>  create mode 100644 include/dt-bindings/phy/phy-qcom-qmp.h
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
> index 8afc5e815ae8..d9d0ab90edb1 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
> @@ -23,7 +23,6 @@ properties:
>        - qcom,sc7180-qmp-usb3-dp-phy
>        - qcom,sc7280-qmp-usb3-dp-phy
>        - qcom,sc8180x-qmp-usb3-dp-phy
> -      - qcom,sc8280xp-qmp-usb43dp-phy
>        - qcom,sdm845-qmp-usb3-dp-phy
>        - qcom,sm8250-qmp-usb3-dp-phy
>    reg:
> @@ -169,17 +168,6 @@ required:
>  
>  additionalProperties: false
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
>  examples:
>    - |
>      #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> new file mode 100644
> index 000000000000..6f31693d9868
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> @@ -0,0 +1,99 @@
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
> +    description:
> +      See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
> +
> +  "#phy-cells":
> +    const: 1
> +    description:
> +      See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
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
> +      #phy-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/phy/phy-qcom-qmp.h b/include/dt-bindings/phy/phy-qcom-qmp.h
> new file mode 100644
> index 000000000000..24a92e5809a0
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-qcom-qmp.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +/*
> + * Qualcomm QMP PHY constants
> + *
> + * Copyright (C) 2022 Linaro Limited
> + */
> +
> +#ifndef _DT_BINDINGS_PHY_QMP
> +#define _DT_BINDINGS_PHY_QMP
> +
> +/* QMP USB4-USB3-DP clocks */
> +#define QMP_USB43DP_USB3_PIPE_CLK	0
> +#define QMP_USB43DP_DP_LINK_CLK		1
> +#define QMP_USB43DP_DP_VCO_DIV_CLK	2
> +
> +/* QMP USB4-USB3-DP PHYs */
> +#define QMP_USB43DP_USB3_PHY		0
> +#define QMP_USB43DP_DP_PHY		1
> +
> +#endif /* _DT_BINDINGS_PHY_QMP */
> -- 
> 2.37.4
> 
> 
