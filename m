Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58370644E23
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLFVmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLFVmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:42:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA99C1C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 13:42:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id d14so17358270edj.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 13:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6SKBfsG69v/G59R3JpQZMBAr09gp1lj2RaDqDluJ9o=;
        b=JyTN2+0YDPQGraLJ+F5D+m8j5jfPg/5DtRG6jPGwxOH/h98JaeKHfCjEGkq+e5qSSW
         yxCqrFO1msTKmVZL78/TPWTLnsFh7fN7E6HYQL0XfVyTX1XFOuVrVuEvuxBHtKTa1lj4
         4Up/L8kThSSiUUQe3EwK9xXj7AmwUa50k6X54ISqiYj7dN0SoFEVQ/i38SAb+A8IHp07
         egPuYEJ92qkRZyWisQUgP3SBKVWOZ9Vh+bdBbPIf+Bv1pyEMQs2naOGffqDQdff7OiZg
         +Km+hZX2Q5PSwPw1X+eHXh9Xm1NYVpqNTkV/XpNj72X/2Y0AZpi3Zdrpvc4sBrXLCu7R
         Ntzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6SKBfsG69v/G59R3JpQZMBAr09gp1lj2RaDqDluJ9o=;
        b=eEOgtnhfB/dIvQGgo85ry8cGTXyUnXGEk3lmXcTyc+jGFRubWCl5drvqZo573yUaia
         m7ZR75H1un/Ke4Lk5kz5kw4EaJ5Tms4Gzdz+4cipz1NF0hdnhH8srZZuOwmm94nVfNy+
         5oNhRVOjd3PTyH5rk+mkwGQpldryWM3a1VBODQvhD+vQt5cS/vTgApa3+iQyF3nxpmd9
         SY6xE2aUlPJ2d6D4hcLAdv7nOCAOdHk2XrPspd12mCugM3+cCZ0wd3CTlEQiNfPxryjD
         Ur7xk/V+Pc4uLFpkpCXC2FZiVuW5JaO79w/FSYLfFkbxDE5MEoRqZMtWOEScs/k5h3Mz
         DkfQ==
X-Gm-Message-State: ANoB5plqVhrbgaN5LmcKbKxeOjoVl/4ANYATm52OLm/UTltCvPaKckK5
        wGMTI/SWmo2DQB1WrPSB9qV66g==
X-Google-Smtp-Source: AA0mqf5Ge71m/n5V0SR0lNuLf7XobkHDw98VWR3Sf/cV71e4GhWsAZSpCUcf+Tp4wkzIUcG2GUi+Mg==
X-Received: by 2002:aa7:dd4b:0:b0:467:65a2:f635 with SMTP id o11-20020aa7dd4b000000b0046765a2f635mr66802120edw.106.1670362951972;
        Tue, 06 Dec 2022 13:42:31 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id kx4-20020a170907774400b0079e11b8e891sm7744392ejc.125.2022.12.06.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:42:31 -0800 (PST)
Date:   Tue, 6 Dec 2022 23:42:30 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
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
Message-ID: <Y4+3RnfYzCtiUkny@linaro.org>
References: <20221206125635.952114-1-abel.vesa@linaro.org>
 <20221206125635.952114-2-abel.vesa@linaro.org>
 <20221206182332.oi7mxxryv2kvd3wu@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206182332.oi7mxxryv2kvd3wu@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-06 12:23:32, Bjorn Andersson wrote:
> On Tue, Dec 06, 2022 at 02:56:31PM +0200, Abel Vesa wrote:
> > Add bindings documentation for clock TCSR driver on SM8550.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/clock/qcom,sm8550-tcsr.yaml      | 53 +++++++++++++++++++
> >  include/dt-bindings/clock/qcom,sm8550-tcsr.h  | 18 +++++++
> >  2 files changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
> >  create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsr.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
> > new file mode 100644
> > index 000000000000..15176b0457d1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,sm8550-tcsr.yaml#
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
> > +  See also:: include/dt-bindings/clock/qcom,sm8550-tcsr.h
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,sm8550-tcsr
> > +
> > +  clocks:
> > +    items:
> > +      - description: Board XO source
> 
> This sounds like the crystal feeding the PMIC, but the clock here should
> be the signal that arrives at the CXO pin of the SoC.

Oh, I guess this should be:
          - description: TCXO pad clock

Will send a new version.

> 
> Other than that, this looks good now.
> 
> Thanks,
> Bjorn
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
> > +required:
> > +  - compatible
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,rpmh.h>
> > +
> > +    clock-controller@1fc0000 {
> > +      compatible = "qcom,sm8550-tcsr";
> > +      reg = <0x1fc0000 0x30000>;
> > +      clocks = <&rpmhcc RPMH_CXO_PAD_CLK>;
> > +      #clock-cells = <1>;
> > +      #reset-cells = <1>;
> > +    };
> > +
> > +...
> > diff --git a/include/dt-bindings/clock/qcom,sm8550-tcsr.h b/include/dt-bindings/clock/qcom,sm8550-tcsr.h
> > new file mode 100644
> > index 000000000000..091cb76f953a
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/qcom,sm8550-tcsr.h
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
