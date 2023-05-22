Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D92C70B787
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjEVIWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjEVIVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45B1BE;
        Mon, 22 May 2023 01:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEA6461046;
        Mon, 22 May 2023 08:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45803C433EF;
        Mon, 22 May 2023 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684743691;
        bh=X1dl0BdIV9APH8eAgp4Q3DNkcGW1XH11ZR81ccznbGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qi6QYJmUtdl311CXBvCYBhAX6Gt2KOBgSmhAIwhpBu28dfLGNsjdhY4XzIDFPtUkj
         JeueI05C5MnqwyI3+EMN7WaonLKB/5/2KLSvQ5e9PfcC/RKy4Vne7i7YXM33Ogrqde
         hW/21Id5jGKWnFmNqZ2kaMQpIsj57QpiWLD7WeZ+MFLtvphdNnrjaJhFrDubGRmkGx
         /B9PDQAfFS2GrEnWRQ10jweqQtk2p2fque+FGV52sFrFF46qiz13ZVZIbDLisbuHVg
         cG5arHe4w4EaEseBvPbVhht+mBIWH0CwRMwBGUiqyBbD1LaOVkaBsZMMEBxLPCa1W+
         Wf2wg2pArOjwg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q10nK-0004MP-Ve; Mon, 22 May 2023 10:21:31 +0200
Date:   Mon, 22 May 2023 10:21:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add YAML schemas for LPASSCC and
 reset on SC8280XP
Message-ID: <ZGsmCmEdoWIkcVDd@hovoldconsulting.com>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
 <20230518113800.339158-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518113800.339158-2-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:37:56PM +0100, Srinivas Kandagatla wrote:
> The LPASS(Low Power Audio Subsystem) clock provider provides reset

Missing space after LPASS acronym.

s/provider/controller/?

> controller support when is driven by the Q6DSP.

s/controller//?

"when is driven by": sounds like there are some words missing here.

> This patch adds support for those resets and adds IDs for clients

There is never any need to say "this patch" in a commit message. Just say

	Add support for...

> to request the reset.
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
> index 000000000000..7c30614a0af9
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
> +  reset and power domains on SC8280XP.

"power domains"? copy-paste error?

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
> +  '#reset-cells':
> +    const: 1
> +
> +  '#clock-cells':
> +    const: 1

Move above #reset-cells for some sorting of related attributes. Same
below (in two places).

> +
> +  qcom,adsp-pil-mode:
> +    description:
> +      Indicates if the LPASS would be brought out of reset using
> +      peripheral loader.
> +    type: boolean

Move above the provider cells properties?

> +
> +required:
> +  - compatible
> +  - reg
> +  - qcom,adsp-pil-mode

If this boolean property is always needed, shouldn't that simply be
handled by the driver based on the compatible?

> +  - '#reset-cells'
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
> +    lpasscc: clock-controller@3900000 {
> +      compatible = "qcom,sc8280xp-lpasscc";

binding examples use 4-space indentation.

> +      reg = <0x033e0000 0x12000>;

Does not match the node unit address.

> +      #reset-cells = <1>;
> +      #clock-cells = <1>;
> +      qcom,adsp-pil-mode;
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
