Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A395E699093
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBPJ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBPJ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:57:37 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB88D37B6E;
        Thu, 16 Feb 2023 01:57:33 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(23454:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 16 Feb 2023 17:57:14 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 16 Feb
 2023 17:57:14 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 16 Feb 2023 17:57:14 +0800
Date:   Thu, 16 Feb 2023 17:57:14 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lgirdwood@gmail.com>,
        <u0084500@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5739
Message-ID: <20230216095714.GA14578@linuxcarl2.richtek.com>
References: <1676426457-1389-1-git-send-email-cy_huang@richtek.com>
 <1676426457-1389-2-git-send-email-cy_huang@richtek.com>
 <9c1f4d0e-83c9-014e-bdb1-38b4b0fb2bbf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9c1f4d0e-83c9-014e-bdb1-38b4b0fb2bbf@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:12:15AM +0100, Krzysztof Kozlowski wrote:
> On 15/02/2023 03:00, cy_huang@richtek.com wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > Add the binding document for Richtek RT5739.
> 
> Subject: drop second/last, redundant "bindings for". The "dt-bindings"
> prefix is already stating that these are bindings.
>
Then, refine it to "dt-bindings: regulator: Add Richtek RT5739 document" 
> > 
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../bindings/regulator/richtek,rt5739.yaml         | 80 ++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
> > new file mode 100644
> > index 00000000..7dc4f78
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/richtek,rt5739.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RT5739 2.4MHz 3.5A Step-Down Converter
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  The RT5739 is a step-down switching voltage regulator that delivers a
> > +  digitally programmable output from an input voltage supply of 2.5V to 5.5V.
> > +  The output voltage is programmed through an I2C interface capable of
> > +  operating up to 3.4MHz.
> > +
> > +  Using a proprietary architecture with synchronous rectification, the RT5739
> > +  is capable of delivering 3.5A continuously at over 80% efficiency,
> > +  maintaining that efficiency at load current as low as 10mA. The regulator
> > +  operates at a normal fixed frequency of 2.4MHz, which reduces the value of
> > +  the external components. 
> 
> Can we drop the marketing from kernel? Last part of sentence is not
> related to this submission at all. The internal frequency also looks
> unrelated to the topic...
>
Okay, too much marketing text. I'll shorten it and simply describe the function or
voltage range only. 
> > Additional output capacitance can be added to
> > +  improve regulation during load transients without affecting stability.
> > +
> > +allOf:
> > +  - $ref: regulator.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - richtek,rt5739
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    maxItems: 1
> > +
> > +  richtek,vsel-active-high:
> > +    description: |
> > +      If property is present, use the 'VSEL1' register group for buck control.
> > +      Else, use the 'VSEL0' register group. This depends on external hardware
> > +      'VSEL' pin connecton.
> > +    type: boolean
> > +
> > +  regulator-allowed-modes:
> > +    description: |
> > +      buck allowed operating mode
> > +        0: Auto PFM/PWM mode
> > +        1: Forced PWM mode
> > +    maxItems: 2
> > +    items:
> > +      enum: [0, 1]
> 
> So you always require two items? Thus I wonder what's the point of
> having it in DT? To skip the property entirely if none of the modes are
> allowed?
>
Not always need two. So does it mean no need to describe the 'maxItems' and 'Items'.
Keep the description of 'regulator-allowed-modes' to tell the user what the valid value is.
> 
> Best regards,
> Krzysztof
> 
