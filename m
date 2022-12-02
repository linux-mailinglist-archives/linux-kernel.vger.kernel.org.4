Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D88B640E50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiLBTTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiLBTTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:19:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC0CE01
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:19:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id fc4so6765599ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J943yYpuo0jFR9PCG/F9JS9VvWtOyHZ6S8cQEy5PX9s=;
        b=zIMn7QfCJdbk4wTH0N8lemUAvDDcSZo/Z+gBiKFz8ilbUjpEIe4S3P4uvqDDd+H+AM
         5gg1OTe8VLzeMxXf7HC69s4F9H4ZSyW3R7jEzr7aF4yQKHXHdU/lehSD3gNzfp8rU39A
         Vqlg2vFP9WXVXctmx3ERTPpjFSf6OMwn9RV+Byk6C16lfFBg4FaDKOD2udXMBBbmBXJI
         arkM87qCeV3zTeBHIWUXH3wxhO/NL6FUao54jNTnlB1v7krtXvEviNPYKYZsHJCMN2Vg
         Nbbz0g91IPi1Nm65INfGgyfvaED0KbuKOFkLLGhK7D6/JP/XyNkf4FJH/R/pV+p/7vGx
         1Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J943yYpuo0jFR9PCG/F9JS9VvWtOyHZ6S8cQEy5PX9s=;
        b=gX1YXWATtZ9Ntne8T/zw7AMwRSaWcg55EeiMDYENPEaWziR9rc3Fxs3l6ysJ8DCnc0
         qmAi2sUo9OzgQbt3sghMeryEH2Z3Xp+z++ZKVfwhkejb5ZbgnJhVeNXLHlAnupU1g3J5
         nNd2PtLCuNHfAq/DhZ3NH4EvHa6hQfKwnPrf1ZybfxIzQw9M0aHlacRvgdQoIo9XKRny
         O1nl4e32FRGZJ/So/ZVCANkxJNe94BbCJLLaQfzr6mz+ffHvv4U3Elf8bNAvqQ9aYvo0
         qHyNgziKIcprjw+VF9HZhoDd2vmquObfA2Oaau5lbvCxe36Cub+PNJTvVHEqyPRz2GAJ
         86Jg==
X-Gm-Message-State: ANoB5plYe2nBdusc5ntnqCW7B3Wu2ZmiGbDFE+lhRiXypMg6gmHRk9Gu
        X1gVyGK0rcSAVx3qpXrbG7R8vBIebMwLWlJ3
X-Google-Smtp-Source: AA0mqf7ogr9/tON+JEkHrEd1+Lltn3rha/i65c/OtJZfitNnrjQd44HPiL5kZj9Rj48yTucY21oj+w==
X-Received: by 2002:a17:906:94c8:b0:7c0:a321:8df2 with SMTP id d8-20020a17090694c800b007c0a3218df2mr10838829ejy.308.1670008746540;
        Fri, 02 Dec 2022 11:19:06 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090694cd00b007c0b28b85c5sm2145585ejy.138.2022.12.02.11.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:19:05 -0800 (PST)
Date:   Fri, 2 Dec 2022 21:19:04 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
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
Message-ID: <Y4pPqAbKLI5L/u0G@linaro.org>
References: <20221130112852.2977816-1-abel.vesa@linaro.org>
 <20221130112852.2977816-3-abel.vesa@linaro.org>
 <20221201221220.7kdbndug3m3om62p@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201221220.7kdbndug3m3om62p@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-01 16:12:20, Bjorn Andersson wrote:
> On Wed, Nov 30, 2022 at 01:28:45PM +0200, Abel Vesa wrote:
> > Add bindings documentation for clock TCSR driver on SM8550.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/clock/qcom,sm8550-tcsrcc.yaml    | 45 +++++++++++++++++++
> >  .../dt-bindings/clock/qcom,sm8550-tcsrcc.h    | 18 ++++++++
> >  2 files changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
> >  create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
> > new file mode 100644
> > index 000000000000..b2de251328e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,sm8550-tcsrcc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm TCSR Clock Controller on SM8550
> > +
> > +maintainers:
> > +  - Bjorn Andersson <andersson@kernel.org>
> > +
> > +description: |
> > +  Qualcomm TCSR clock control module provides the clocks, resets and
> > +  power domains on SM8550
> > +
> > +  See also:: include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,sm8550-tcsrcc
> 
> The block described is the TCSR block, the clock controller represents
> one of the functions provided. I think it would be more appropriate if
> the compatible represented the generic nature of the block, even though
> you currently only care about exposing these clocks.

I think there is a rule that says the compatible string to be the same as
the schema filename.

Should I then also rename the schema file and also the binding IDs header?
Like qcom,sm8550-tcsr.yaml and qcom,sm8550-tcsr.h ?

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  '#reset-cells':
> > +    const: 1
> > +
> 
> Your clocks are fed by cxo. While there might be reasons for not wire
> the parent up in the clocks, I think you should represent it in the
> binding.

Right, will document the clocks property as well and describe the clock
as xo-board.

> 
> Regards,
> Bjorn
> 
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    clock-controller@1fc0000 {
> > +      compatible = "qcom,sm8550-tcsrcc";
> > +      reg = <0x1fc0000 0x30000>;
> > +      #clock-cells = <1>;
> > +      #reset-cells = <1>;
> > +    };
> > +
> > +...
> > diff --git a/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h b/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> > new file mode 100644
> > index 000000000000..091cb76f953a
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2022, Linaro Limited
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
> > +#define _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
> > +
> > +/* TCSR CC clocks */
> > +#define TCSR_PCIE_0_CLKREF_EN					0
> > +#define TCSR_PCIE_1_CLKREF_EN					1
> > +#define TCSR_UFS_CLKREF_EN					2
> > +#define TCSR_UFS_PAD_CLKREF_EN					3
> > +#define TCSR_USB2_CLKREF_EN					4
> > +#define TCSR_USB3_CLKREF_EN					5
> > +
> > +#endif
> > -- 
> > 2.34.1
> > 
