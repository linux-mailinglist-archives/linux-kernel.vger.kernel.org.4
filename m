Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF029644BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLFS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiLFS3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:29:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B774E4B99B;
        Tue,  6 Dec 2022 10:24:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AFC9DCE1AF9;
        Tue,  6 Dec 2022 18:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE95C433D6;
        Tue,  6 Dec 2022 18:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670351014;
        bh=M8WKNBU3VnzY0vAPfX8+hUUgSFuMbkBjP5zVOGHhQz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqazpemNzOVMBIdamfGyH89ClbVP/HRxlj/qWxetTDkooWyvpjj5J0WEI4d62HuIk
         ayJFpl1vnPALluPk0xVlrvoVnGblfboEaTBMIL5v+ebNHbLy+H5Pk85oy/tjJdokz4
         eRms3g+wwr0djaX31g1lyh+RUwePzQMry88QyB4bTV6MLEOH5bqlSULQy8SzeXcZFk
         Op7hv3aDHD7J0lScdeqdyUStNSgNh9OUCr+wyvHoxM4r6EBkOdfZKBLYvEbJDYHBGU
         jQhU7d6F92Jes/X8zndi86PFMA/fnlDPVnoNuARXDN2j13oXUlFyjhj49d18nr2XIz
         r61vHslNYOSpA==
Date:   Tue, 6 Dec 2022 12:23:32 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: clock: Add SM8550 TCSR CC clocks
Message-ID: <20221206182332.oi7mxxryv2kvd3wu@builder.lan>
References: <20221206125635.952114-1-abel.vesa@linaro.org>
 <20221206125635.952114-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206125635.952114-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 02:56:31PM +0200, Abel Vesa wrote:
> Add bindings documentation for clock TCSR driver on SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/qcom,sm8550-tcsr.yaml      | 53 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm8550-tcsr.h  | 18 +++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsr.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
> new file mode 100644
> index 000000000000..15176b0457d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8550-tcsr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm TCSR Clock Controller on SM8550
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description: |
> +  Qualcomm TCSR clock control module provides the clocks, resets and
> +  power domains on SM8550
> +
> +  See also:: include/dt-bindings/clock/qcom,sm8550-tcsr.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8550-tcsr
> +
> +  clocks:
> +    items:
> +      - description: Board XO source

This sounds like the crystal feeding the PMIC, but the clock here should
be the signal that arrives at the CXO pin of the SoC.

Other than that, this looks good now.

Thanks,
Bjorn

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +
> +    clock-controller@1fc0000 {
> +      compatible = "qcom,sm8550-tcsr";
> +      reg = <0x1fc0000 0x30000>;
> +      clocks = <&rpmhcc RPMH_CXO_PAD_CLK>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/qcom,sm8550-tcsr.h b/include/dt-bindings/clock/qcom,sm8550-tcsr.h
> new file mode 100644
> index 000000000000..091cb76f953a
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm8550-tcsr.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
> +#define _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
> +
> +/* TCSR CC clocks */
> +#define TCSR_PCIE_0_CLKREF_EN					0
> +#define TCSR_PCIE_1_CLKREF_EN					1
> +#define TCSR_UFS_CLKREF_EN					2
> +#define TCSR_UFS_PAD_CLKREF_EN					3
> +#define TCSR_USB2_CLKREF_EN					4
> +#define TCSR_USB3_CLKREF_EN					5
> +
> +#endif
> -- 
> 2.34.1
> 
