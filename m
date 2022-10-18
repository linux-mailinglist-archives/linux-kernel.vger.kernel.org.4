Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4F60288B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJRJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJRJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:41:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CE17B79F;
        Tue, 18 Oct 2022 02:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 666BAB81E12;
        Tue, 18 Oct 2022 09:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066FCC433D6;
        Tue, 18 Oct 2022 09:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666086060;
        bh=dBRtFaZHv2zChbhx1tx9d4AuEegiV59h3N2IOeis6QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPUgbmbZ2JFJ+7nVnGWJQezOogS6KNbQYKEDjLuKwrhLPRd7kaP0oFsm7ACcjXszp
         ycxTxqeG1YETgQFXGb0JWXqNU1b0GSV8JQOkS8+JELZFkP3scnLJX2F5zRC/PUXD5V
         o+esx1NuDw4+kDsprDr+arFMUcRDJBvV3m64tGMA7da3TACb8x7mXGpvTJZlC2SULQ
         UClLbELT7gTSu6aeo8kQJSClbC5+UaiRFKw776Yw+XCWpfjQ5BF49F+oEMo+c9gPhy
         G/D4MkuffCugJatLS80nDjiIba0G3fcAaOxYiUYWoADNBr1aQllTBX2GEpalhiXXpu
         6rX+gBOlTKU6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1okj5b-00025V-Ea; Tue, 18 Oct 2022 11:40:48 +0200
Date:   Tue, 18 Oct 2022 11:40:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] dt-bindings: phy: qcom,qmp-pcie: add sc8280xp
 bindings
Message-ID: <Y050nxCaFXIgczrA@hovoldconsulting.com>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-11-johan+linaro@kernel.org>
 <d6642028-3fb9-4e39-a349-666625dabb9d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6642028-3fb9-4e39-a349-666625dabb9d@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:20:49PM -0400, Krzysztof Kozlowski wrote:
> On 17/10/2022 10:53, Johan Hovold wrote:
> > Add bindings for the PCIe QMP PHYs found on SC8280XP.
> > 
> > The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
> > 4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
> > PCIe2A and PCIe2B).
> > 
> > The configuration for a specific system can be read from a TCSR register.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 163 ++++++++++++++++++
> >  1 file changed, 163 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> > new file mode 100644
> > index 000000000000..82da95eaa9d6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> 
> Filename based on compatible, so for example:
> 
> qcom,sc8280xp-qmp-pcie-phy.yaml

Ok, but as I mentioned in my reply to the previous patch, this file is
the one that is expected to be extended with new bindings.

I can't seem to find where this naming scheme is documented now even if
I'm quite sure I've seen it before. Do you have a pointer?

And does this imply that the file name should also include the gen infix
of one of the original compatibles (e.g.
"qcom,sc8280xp-qmp-gen3x4-pcie-phy.yaml")?

> > @@ -0,0 +1,163 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/qcom,qmp-pcie-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm QMP PHY controller (PCIe)
> > +
> > +maintainers:
> > +  - Vinod Koul <vkoul@kernel.org>
> > +
> > +description:
> > +  QMP PHY controller supports physical layer functionality for a number of
> > +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,sc8280xp-qmp-gen3x1-pcie-phy
> > +      - qcom,sc8280xp-qmp-gen3x2-pcie-phy
> > +      - qcom,sc8280xp-qmp-gen3x4-pcie-phy

> > +  qcom,4ln-config-sel:
> > +    description: 4-lane configuration as TCSR syscon phandle, register offset
> > +                 and bit number
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      maxItems: 3
> 
> You have only one phandle, so you need to describe the items and limit
> their number, like here:
> 
> https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42
> 
> This allows you to skip most of property description.

Ah, thanks, makes perfect sense. I based this one of the in-tree
bindings which had been reviewed by Rob and must have thought it was
some special phandle-array notation to express the same.

Johan
