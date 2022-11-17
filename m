Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4362D73E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiKQJlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbiKQJk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:40:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB400627F0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:40:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j15so2272495wrq.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iWJKbHUSlRi/JJGQvc0uCcs9jVteUyxx6gBbiNtDa0=;
        b=y+FijfafquQ+ImGqRdfm7MhSuhNwosXpBr6y7dZi1oJ1h8M4cWD1f/qgOXvZ7EKlbQ
         gZZzrrQFE1Sqv8inHHHLc0VWIX7VsaAufMfIe9EHqbAVqIHXv4nLLioBrrE1CrDD5VIj
         VVkyZq1yMamQTkbvoYCG+hYemCWcOONcj6jurAN3QSE3YhHsBJuNRkZ77LXQZQtoE70x
         6dqHnJVL3gvc5vhqH5P/hk1bwRT58hovUyudmGPMPesdzaVNzBzlBfVKIuus7DXnKPnL
         ddBuC58t0h/phrlWPGndGCkla7b9Om9ZrSlA6JD2lZjAceod8R3gtJQo7xH5IpXMD5xF
         cAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iWJKbHUSlRi/JJGQvc0uCcs9jVteUyxx6gBbiNtDa0=;
        b=sHuHQeFHUOuvIUCs62RsxnQUoSZSmQ+hC899LvNqRreAV1qQvDs4AsABtqM3b9E3n9
         ua1mwkyJzSzWmjimeP1W7TdRHkuvSgKVRKYxDFXoKl9GrQ59VTgLXtjOYrsfXe+NrBJn
         2qbEPD9RalfZre8AAG/j4pfZZO6NuH+h1zgQO0ZK9nbKqequE2VOeALqxpMucMYW4VdT
         e4zxtB2w4FuMAszpMaDmyHbJrKMwIH6p6+mX9HRzcg8sqWqAG+GAUA31cRSjIoFLvqsO
         UP88SHjbVe/7xQzmCWBVCihygOxN+PFef4f4TOU/0VIlJT5aFmJ1UtbLzAM5WhltGXbi
         vUtw==
X-Gm-Message-State: ANoB5pkn7iOD5SyJ+Ntq9W9kSvUbn1sv/x1ZUCW/yB7XwcebYLl1J/Rx
        fDJgMbDLJUn355AH8CoW8p91Mg==
X-Google-Smtp-Source: AA0mqf4oZgPJEHiLUo80n1Gbd2WhfHze0jEPhP11zLbAi7sL/nuxvNg8NsG6qm+y1ZWT4vmSi3oS8A==
X-Received: by 2002:a5d:5915:0:b0:236:6dd1:eb68 with SMTP id v21-20020a5d5915000000b002366dd1eb68mr912860wrd.261.1668678055435;
        Thu, 17 Nov 2022 01:40:55 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d6885000000b002366b17ca8bsm488082wru.108.2022.11.17.01.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 01:40:55 -0800 (PST)
Date:   Thu, 17 Nov 2022 11:40:53 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: clock: Add SM8550 GCC clock bindings
Message-ID: <Y3YBpXIjDELtit0k@linaro.org>
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
 <20221116104716.2583320-2-abel.vesa@linaro.org>
 <c298fd71-22e9-98c5-14c6-88b078687b3d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c298fd71-22e9-98c5-14c6-88b078687b3d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-17 10:08:05, Krzysztof Kozlowski wrote:
> On 16/11/2022 11:47, Abel Vesa wrote:
> > Add device tree bindings for global clock controller on SM8550 SoCs.
> 
> Subject: drop second, redundant "bindings".

Sure thing, will drop.

> 
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  .../bindings/clock/qcom,gcc-sm8550.yaml       |  88 +++++++
> >  include/dt-bindings/clock/qcom,gcc-sm8550.h   | 231 ++++++++++++++++++
> >  2 files changed, 319 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml
> >  create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8550.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml
> > new file mode 100644
> > index 000000000000..a2468167c8ab
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml
> > @@ -0,0 +1,88 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,gcc-sm8550.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Global Clock & Reset Controller Binding for SM8550
> 
> You need to base on recent bindings. See commit ece3c3198182a1.
> 

Yep, will do.

> > +
> > +maintainers:
> > +  - Bjorn Andersson <andersson@kernel.org>
> > +
> > +description: |
> > +  Qualcomm global clock control module which supports the clocks, resets and
> > +  power domains on SM8550
> 
> Ditto
> 
> > +
> > +  See also:
> > +  - dt-bindings/clock/qcom,gcc-sm8550.h
> 
> Ditto
> 
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,sm8550-gcc
> > +
> > +  clocks:
> > +    items:
> > +      - description: Board XO source
> > +      - description: Sleep clock source
> > +      - description: PCIE 0 Pipe clock source (Optional clock)
> 
> Drop "(Optional clock)"

Sure, will drop. I based this on SM8450, but maybe that also needs an
update.

> 
> > +      - description: PCIE 1 Pipe clock source (Optional clock)
> > +      - description: PCIE 1 Phy Auxiliary clock source (Optional clock)
> > +      - description: UFS Phy Rx symbol 0 clock source (Optional clock)
> > +      - description: UFS Phy Rx symbol 1 clock source (Optional clock)
> > +      - description: UFS Phy Tx symbol 0 clock source (Optional clock)
> > +      - description: USB3 Phy wrapper pipe clock source (Optional clock)
> > +    minItems: 2
> 
> This does not look correct. Why clocks of GCC are inputs clocks to GCC?

Well, it is not a GCC clock. It is a fixed-clock fed into GCC.
The name is taken from downstream, but I'm pretty sure the HW clock is
named so. So I think we should keep it as is.

> 
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bi_tcxo
> > +      - const: sleep_clk
> > +      - const: pcie_0_pipe_clk # Optional clock
> > +      - const: pcie_1_pipe_clk # Optional clock
> > +      - const: pcie_1_phy_aux_clk # Optional clock
> > +      - const: ufs_phy_rx_symbol_0_clk # Optional clock
> > +      - const: ufs_phy_rx_symbol_1_clk # Optional clock
> > +      - const: ufs_phy_tx_symbol_0_clk # Optional clock
> > +      - const: usb3_phy_wrapper_gcc_usb30_pipe_clk # Optional clock
> > +    minItems: 2
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  '#reset-cells':
> > +    const: 1
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +  reg:
> > +    maxItems: 1
> 
> Drop all duplicated properties and use qcom,gcc.yaml. See commit
> 842b4ca1cb8cf54
> 

Will do.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - '#clock-cells'
> > +  - '#reset-cells'
> > +  - '#power-domain-cells'
> 
> Drop redundant entries.

Will do.

> 
> > +
> > +allOf:
> > +  - $ref: qcom,gcc.yaml#
> > +
> 

Thanks,
Abel

> Best regards,
> Krzysztof
> 
