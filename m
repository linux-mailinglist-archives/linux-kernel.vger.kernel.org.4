Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122A2650E49
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiLSPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiLSPGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:06:45 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6566B3F;
        Mon, 19 Dec 2022 07:06:25 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id z20-20020a4a4914000000b004b026afa844so424994ooa.13;
        Mon, 19 Dec 2022 07:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3zMLD1exw0zwesV3mAax2+09Fr2KnxDbnRnnShUUeM=;
        b=v+4FPseEZOtKamxXzQn5R9DAXu9PVOLXVdGzO+eBwGcuZX+R57b5aYt2OhvduEqPeP
         yrxtuRLTJOLXY08R1/06/JKQ/pg03FqvhlkrSyYp/HX9+Valcblc9aaCxScWt83xjgbD
         SJF1BekF4WmlaRC30igHMBhluXwobprwNOI5w1P9nGPIHeqb7ZHk5cKUZWNqfpLcGnVo
         xqhfFB8HwwE64lZulc2EJIDtSCvP+wwkAgHvrDxD9W+EknkBUjv1RWoYEL2ZdZ1c6sQr
         H10LfjqHspTvJq77INF3x9bzYurGE2amfAUExm/VJOE1sO6N5WLZ2lBUjhx6hdzUJJ3u
         N6FQ==
X-Gm-Message-State: ANoB5pluP0BrvQQ667ixzzXdq5F6ISSgX39/niRC1+iYX3BMAIJ/mV1n
        CHrYgBLj+0yu4zYew4htPw==
X-Google-Smtp-Source: AA0mqf4ut9Jx+u8oJg6XTvW3bBltJjSFEzIjQ5plDvY74uhxCD2gb1FOTCWoCv2GwQYb1jbW4GDXuQ==
X-Received: by 2002:a4a:49d5:0:b0:4a3:7135:d6e6 with SMTP id z204-20020a4a49d5000000b004a37135d6e6mr17962718ooa.2.1671462385033;
        Mon, 19 Dec 2022 07:06:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020a4aa8c2000000b0049f098f4fb4sm4028582oom.24.2022.12.19.07.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:06:24 -0800 (PST)
Received: (nullmailer pid 1384489 invoked by uid 1000);
        Mon, 19 Dec 2022 15:06:23 -0000
Date:   Mon, 19 Dec 2022 09:06:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: clock: Add QDU1000 and QRU1000 GCC
 clocks
Message-ID: <20221219150623.GA1381881-robh@kernel.org>
References: <20221216230722.21404-1-quic_molvera@quicinc.com>
 <20221216230722.21404-2-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216230722.21404-2-quic_molvera@quicinc.com>
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

On Fri, Dec 16, 2022 at 03:07:21PM -0800, Melody Olvera wrote:
> Add device tree bindings for global clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,qdu1000-gcc.yaml      |  51 +++++
>  include/dt-bindings/clock/qcom,qdu1000-gcc.h  | 175 ++++++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,qdu1000-gcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
> new file mode 100644
> index 000000000000..fb51375b9be6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,qdu1000-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on QDU1000 and QRU1000
> +
> +  See also:: include/dt-bindings/clock/qcom,qdu1000-gcc.h
> +
> +properties:
> +  compatible:
> +    const: qcom,qdu1000-gcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Sleep clock source
> +      - description: PCIE 0 Pipe clock source
> +      - description: PCIE 0 Phy Auxiliary clock source
> +      - description: USB3 Phy wrapper pipe clock source
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +additionalProperties: false

This should be 'unevaluatedProperties' instead to fix the errors.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    clock-controller@100000 {
> +      compatible = "qcom,qdu1000-gcc";
> +      reg = <0x00100000 0x001f4200>;
> +      clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>,
> +               <&pcie_0_pipe_clk>, <&pcie_0_phy_aux_clk>,
> +               <&usb3_phy_wrapper_pipe_clk>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/qcom,qdu1000-gcc.h b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
> new file mode 100644
> index 000000000000..ddbc6b825e80
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
> @@ -0,0 +1,175 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_GCC_QDU1000_H
> +#define _DT_BINDINGS_CLK_QCOM_GCC_QDU1000_H
> +
> +/* GCC clocks */
> +#define GCC_GPLL0					0
> +#define GCC_GPLL0_OUT_EVEN				1
> +#define GCC_GPLL1					2
> +#define GCC_GPLL2					3
> +#define GCC_GPLL2_OUT_EVEN				4
> +#define GCC_GPLL3					5
> +#define GCC_GPLL4					6
> +#define GCC_GPLL5					7
> +#define GCC_GPLL5_OUT_EVEN				8
> +#define GCC_GPLL6					9
> +#define GCC_GPLL7					10
> +#define GCC_GPLL8					11
> +#define GCC_AGGRE_NOC_ECPRI_DMA_CLK			12
> +#define GCC_AGGRE_NOC_ECPRI_DMA_CLK_SRC			13
> +#define GCC_AGGRE_NOC_ECPRI_GSI_CLK_SRC			14
> +#define GCC_BOOT_ROM_AHB_CLK				15
> +#define GCC_CFG_NOC_ECPRI_CC_AHB_CLK			16
> +#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK			17
> +#define GCC_DDRSS_ECPRI_DMA_CLK				18
> +#define GCC_ECPRI_AHB_CLK				19
> +#define GCC_ECPRI_CC_GPLL0_CLK_SRC			20
> +#define GCC_ECPRI_CC_GPLL1_EVEN_CLK_SRC			21
> +#define GCC_ECPRI_CC_GPLL2_EVEN_CLK_SRC			22
> +#define GCC_ECPRI_CC_GPLL3_CLK_SRC			23
> +#define GCC_ECPRI_CC_GPLL4_CLK_SRC			24
> +#define GCC_ECPRI_CC_GPLL5_EVEN_CLK_SRC			25
> +#define GCC_ECPRI_XO_CLK				26
> +#define GCC_ETH_DBG_SNOC_AXI_CLK			27
> +#define GCC_GEMNOC_PCIE_QX_CLK				28
> +#define GCC_GP1_CLK					29
> +#define GCC_GP1_CLK_SRC					30
> +#define GCC_GP2_CLK					31
> +#define GCC_GP2_CLK_SRC					32
> +#define GCC_GP3_CLK					33
> +#define GCC_GP3_CLK_SRC					34
> +#define GCC_PCIE_0_AUX_CLK				35
> +#define GCC_PCIE_0_AUX_CLK_SRC				36
> +#define GCC_PCIE_0_CFG_AHB_CLK				37
> +#define GCC_PCIE_0_CLKREF_EN				38
> +#define GCC_PCIE_0_MSTR_AXI_CLK				39
> +#define GCC_PCIE_0_PHY_AUX_CLK				40
> +#define GCC_PCIE_0_PHY_RCHNG_CLK			41
> +#define GCC_PCIE_0_PHY_RCHNG_CLK_SRC			42
> +#define GCC_PCIE_0_PIPE_CLK				43
> +#define GCC_PCIE_0_SLV_AXI_CLK				44
> +#define GCC_PCIE_0_SLV_Q2A_AXI_CLK			45
> +#define GCC_PDM2_CLK					46
> +#define GCC_PDM2_CLK_SRC				47
> +#define GCC_PDM_AHB_CLK					48
> +#define GCC_PDM_XO4_CLK					49
> +#define GCC_QMIP_ANOC_PCIE_CLK				50
> +#define GCC_QMIP_ECPRI_DMA0_CLK				51
> +#define GCC_QMIP_ECPRI_DMA1_CLK				52
> +#define GCC_QMIP_ECPRI_GSI_CLK				53
> +#define GCC_QUPV3_WRAP0_CORE_2X_CLK			54
> +#define GCC_QUPV3_WRAP0_CORE_CLK			55
> +#define GCC_QUPV3_WRAP0_S0_CLK				56
> +#define GCC_QUPV3_WRAP0_S0_CLK_SRC			57
> +#define GCC_QUPV3_WRAP0_S1_CLK				58
> +#define GCC_QUPV3_WRAP0_S1_CLK_SRC			59
> +#define GCC_QUPV3_WRAP0_S2_CLK				60
> +#define GCC_QUPV3_WRAP0_S2_CLK_SRC			61
> +#define GCC_QUPV3_WRAP0_S3_CLK				62
> +#define GCC_QUPV3_WRAP0_S3_CLK_SRC			63
> +#define GCC_QUPV3_WRAP0_S4_CLK				64
> +#define GCC_QUPV3_WRAP0_S4_CLK_SRC			65
> +#define GCC_QUPV3_WRAP0_S5_CLK				66
> +#define GCC_QUPV3_WRAP0_S5_CLK_SRC			67
> +#define GCC_QUPV3_WRAP0_S6_CLK				68
> +#define GCC_QUPV3_WRAP0_S6_CLK_SRC			69
> +#define GCC_QUPV3_WRAP0_S7_CLK				70
> +#define GCC_QUPV3_WRAP0_S7_CLK_SRC			71
> +#define GCC_QUPV3_WRAP1_CORE_2X_CLK			72
> +#define GCC_QUPV3_WRAP1_CORE_CLK			73
> +#define GCC_QUPV3_WRAP1_S0_CLK				74
> +#define GCC_QUPV3_WRAP1_S0_CLK_SRC			75
> +#define GCC_QUPV3_WRAP1_S1_CLK				76
> +#define GCC_QUPV3_WRAP1_S1_CLK_SRC			77
> +#define GCC_QUPV3_WRAP1_S2_CLK				78
> +#define GCC_QUPV3_WRAP1_S2_CLK_SRC			79
> +#define GCC_QUPV3_WRAP1_S3_CLK				80
> +#define GCC_QUPV3_WRAP1_S3_CLK_SRC			81
> +#define GCC_QUPV3_WRAP1_S4_CLK				82
> +#define GCC_QUPV3_WRAP1_S4_CLK_SRC			83
> +#define GCC_QUPV3_WRAP1_S5_CLK				84
> +#define GCC_QUPV3_WRAP1_S5_CLK_SRC			85
> +#define GCC_QUPV3_WRAP1_S6_CLK				86
> +#define GCC_QUPV3_WRAP1_S6_CLK_SRC			87
> +#define GCC_QUPV3_WRAP1_S7_CLK				88
> +#define GCC_QUPV3_WRAP1_S7_CLK_SRC			89
> +#define GCC_QUPV3_WRAP_0_M_AHB_CLK			90
> +#define GCC_QUPV3_WRAP_0_S_AHB_CLK			91
> +#define GCC_QUPV3_WRAP_1_M_AHB_CLK			92
> +#define GCC_QUPV3_WRAP_1_S_AHB_CLK			93
> +#define GCC_SDCC5_AHB_CLK				94
> +#define GCC_SDCC5_APPS_CLK				95
> +#define GCC_SDCC5_APPS_CLK_SRC				96
> +#define GCC_SDCC5_ICE_CORE_CLK				97
> +#define GCC_SDCC5_ICE_CORE_CLK_SRC			98
> +#define GCC_SNOC_CNOC_GEMNOC_PCIE_QX_CLK		99
> +#define GCC_SNOC_CNOC_GEMNOC_PCIE_SOUTH_QX_CLK		100
> +#define GCC_SNOC_CNOC_PCIE_QX_CLK			101
> +#define GCC_SNOC_PCIE_SF_CENTER_QX_CLK			102
> +#define GCC_SNOC_PCIE_SF_SOUTH_QX_CLK			103
> +#define GCC_TSC_CFG_AHB_CLK				104
> +#define GCC_TSC_CLK_SRC					105
> +#define GCC_TSC_CNTR_CLK				106
> +#define GCC_TSC_ETU_CLK					107
> +#define GCC_USB2_CLKREF_EN				108
> +#define GCC_USB30_PRIM_MASTER_CLK			109
> +#define GCC_USB30_PRIM_MASTER_CLK_SRC			110
> +#define GCC_USB30_PRIM_MOCK_UTMI_CLK			111
> +#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC		112
> +#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC	113
> +#define GCC_USB30_PRIM_SLEEP_CLK			114
> +#define GCC_USB3_PRIM_PHY_AUX_CLK			115
> +#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC			116
> +#define GCC_USB3_PRIM_PHY_COM_AUX_CLK			117
> +#define GCC_USB3_PRIM_PHY_PIPE_CLK			118
> +#define GCC_SM_BUS_AHB_CLK				119
> +#define GCC_SM_BUS_XO_CLK				120
> +#define GCC_SM_BUS_XO_CLK_SRC				121
> +#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC			122
> +#define GCC_ETH_100G_C2C_HM_APB_CLK			123
> +#define GCC_ETH_100G_FH_HM_APB_0_CLK			124
> +#define GCC_ETH_100G_FH_HM_APB_1_CLK			125
> +#define GCC_ETH_100G_FH_HM_APB_2_CLK			126
> +#define GCC_ETH_DBG_C2C_HM_APB_CLK			127
> +#define GCC_AGGRE_NOC_ECPRI_GSI_CLK			128
> +#define GCC_PCIE_0_PIPE_CLK_SRC				129
> +#define GCC_PCIE_0_PHY_AUX_CLK_SRC			130
> +
> +/* GCC resets */
> +#define GCC_ECPRI_CC_BCR				0
> +#define GCC_ECPRI_SS_BCR				1
> +#define GCC_ETH_WRAPPER_BCR				2
> +#define GCC_PCIE_0_BCR					3
> +#define GCC_PCIE_0_LINK_DOWN_BCR			4
> +#define GCC_PCIE_0_NOCSR_COM_PHY_BCR			5
> +#define GCC_PCIE_0_PHY_BCR				6
> +#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR		7
> +#define GCC_PCIE_PHY_CFG_AHB_BCR			8
> +#define GCC_PCIE_PHY_COM_BCR				9
> +#define GCC_PDM_BCR					10
> +#define GCC_QUPV3_WRAPPER_0_BCR				11
> +#define GCC_QUPV3_WRAPPER_1_BCR				12
> +#define GCC_QUSB2PHY_PRIM_BCR				13
> +#define GCC_QUSB2PHY_SEC_BCR				14
> +#define GCC_SDCC5_BCR					15
> +#define GCC_TCSR_PCIE_BCR				16
> +#define GCC_TSC_BCR					17
> +#define GCC_USB30_PRIM_BCR				18
> +#define GCC_USB3_DP_PHY_PRIM_BCR			19
> +#define GCC_USB3_DP_PHY_SEC_BCR				20
> +#define GCC_USB3_PHY_PRIM_BCR				21
> +#define GCC_USB3_PHY_SEC_BCR				22
> +#define GCC_USB3PHY_PHY_PRIM_BCR			23
> +#define GCC_USB3PHY_PHY_SEC_BCR				24
> +#define GCC_USB_PHY_CFG_AHB2PHY_BCR			25
> +
> +/* GCC power domains */
> +#define PCIE_0_GDSC					0
> +#define PCIE_0_PHY_GDSC					1
> +#define USB30_PRIM_GDSC					2
> +
> +#endif
> -- 
> 2.38.1
> 
> 
