Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CEB63FA5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiLAWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiLAWM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:12:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B13C462A;
        Thu,  1 Dec 2022 14:12:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD5362163;
        Thu,  1 Dec 2022 22:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4D7C433C1;
        Thu,  1 Dec 2022 22:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669932743;
        bh=6L29YbZfP45KfSEKeCJ4KJ1OrLqAXiCErdwDskNl5Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BItB6QRZJ6pvebRb6hRT1PxYp6WMMEpxBscCUHUW7Q819f+34QTROwOVQKHtcmIXC
         AWZkVtgm0p/uWiWQz3IG7cfs15NL3WEprU380IRjfv3zgTJ2e/eyv+wf2l6R2Fjs10
         M4xqmbk39g+LooqnZ7Reht1AmpwsP+cZO9bs/lWU2uPGjwGEZsIXR7DiPQhbvfFFYV
         TfkPlVYyDkzzcFkykeX81F9XpltkQ/Tdxiw6e6rmUCO0kwvNkIc8gVGSIegvSJdyvd
         mrEmzXPHPhGrdjmQV8ivQZGO+LHC2BdJGnilIa5wiwpswTmFfuB/0CsT+M7BJoZgAA
         AWR3XOjWeXmow==
Date:   Thu, 1 Dec 2022 16:12:20 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/9] dt-bindings: clock: Add SM8550 TCSR CC clocks
Message-ID: <20221201221220.7kdbndug3m3om62p@builder.lan>
References: <20221130112852.2977816-1-abel.vesa@linaro.org>
 <20221130112852.2977816-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130112852.2977816-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:28:45PM +0200, Abel Vesa wrote:
> Add bindings documentation for clock TCSR driver on SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/qcom,sm8550-tcsrcc.yaml    | 45 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,sm8550-tcsrcc.h    | 18 ++++++++
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
> new file mode 100644
> index 000000000000..b2de251328e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8550-tcsrcc.yaml#
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
> +  See also:: include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8550-tcsrcc

The block described is the TCSR block, the clock controller represents
one of the functions provided. I think it would be more appropriate if
the compatible represented the generic nature of the block, even though
you currently only care about exposing these clocks.

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

Your clocks are fed by cxo. While there might be reasons for not wire
the parent up in the clocks, I think you should represent it in the
binding.

Regards,
Bjorn

> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@1fc0000 {
> +      compatible = "qcom,sm8550-tcsrcc";
> +      reg = <0x1fc0000 0x30000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h b/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> new file mode 100644
> index 000000000000..091cb76f953a
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
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
