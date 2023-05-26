Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDAF712638
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEZME5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbjEZMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206EB1B0;
        Fri, 26 May 2023 05:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4680560F08;
        Fri, 26 May 2023 12:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8B4C433EF;
        Fri, 26 May 2023 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685102686;
        bh=nJljWBKgOyOWAPBWpCK5MiNtzZILMZl1Ym7li47LYmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4lOLFYUf8/7vJ8VGhMsLinv6egM0R2/BXrrqrBWX2YoIWCdAWcezMIjvjfg+qgHi
         Emw+svE4rmU8qViXroYfJk/P4FHRQtkvBSl+qa/xZ6QTHZbmdAA2GmMvdtTHw/4NRT
         FaUcvnYfunLj8SJBe0HoHfWB2w/FnYfdJFRtkCYuVolHnpjTQJddIxCvWbRGfu3XyI
         XsrVWVMdsKbxsVWIzBct9XX+OYuTg0WJ0DMrWba+ysGz0M+CZJn3zb/8XzN6UV43OM
         W8i4B9aCiKtu+oJYQg2/A2+L4/qZm5lOBpjnXKfBSwM7QaTg/QQOgwjOXrJAdkpsyR
         aQZl/ipiEtXrw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q2WBm-00070Y-4r; Fri, 26 May 2023 14:04:58 +0200
Date:   Fri, 26 May 2023 14:04:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: Add YAML schemas for LPASSCC
 and reset on SC8280XP
Message-ID: <ZHCgap_Ve75uWclL@hovoldconsulting.com>
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525122930.17141-2-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 01:29:25PM +0100, Srinivas Kandagatla wrote:
> The LPASS (Low Power Audio Subsystem) clock controller provides reset
> support when it is under the control of Q6DSP.
> 
> Add support for those resets and adds IDs for clients to request the reset.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/clock/qcom,sc8280xp-lpasscc.yaml | 57 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,lpasscc-sc8280xp.h | 12 ++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> new file mode 100644
> index 000000000000..08a9ae60a365
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sc8280xp-lpasscc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm LPASS Core & Audio Clock Controller on SC8280XP
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  Qualcomm LPASS core and audio clock control module provides the clocks,
> +  and reset on SC8280XP.
> +
> +  See also::
> +    include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> +
> +properties:
> +  reg: true
> +
> +  compatible:
> +    enum:
> +      - qcom,sc8280xp-lpasscc
> +
> +  qcom,adsp-pil-mode:
> +    description:
> +      Indicates if the LPASS would be brought out of reset using
> +      peripheral loader.
> +    type: boolean
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - qcom,adsp-pil-mode
> +  - '#reset-cells'
> +  - '#clock-cells'

Nit: #clock before #reset

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
> +    lpasscc: clock-controller@33e0000 {
> +        compatible = "qcom,sc8280xp-lpasscc";
> +        reg = <0x033e0000 0x12000>;
> +        qcom,adsp-pil-mode;
> +        #reset-cells = <1>;
> +        #clock-cells = <1>;

Nit: #clock before #reset

> +    };
> +...
> diff --git a/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> new file mode 100644
> index 000000000000..df800ea2741c
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, Linaro Ltd.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
> +#define _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
> +
> +/* LPASS TCSR */
> +#define LPASS_AUDIO_SWR_TX_CGCR				0
> +
> +#endif

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
