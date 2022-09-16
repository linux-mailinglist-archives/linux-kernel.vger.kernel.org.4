Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A290E5BB2F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiIPTnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:42:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAECB14E8;
        Fri, 16 Sep 2022 12:42:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k9so37670851wri.0;
        Fri, 16 Sep 2022 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=ajlJknxebsBqz0RiDgCRdoNQyFjTdK4PeIJmLu5MBYs=;
        b=WeQcAt48QOvcANIJLF6Ebq8OhVWqIe+rGtVil/UbrUbWt3RzSz7sTI4nKSNkazlIVQ
         J/boaO1cODFVGFXGA3lCergR6jER4TyX1BkCf/nD0e1+JEqWfiqB5+9dUkNkfiynctQb
         O+4ecxJgu0gY81tq4ZpvNVFvtuhnJpvZhKLESmjZDdbh3SWlGenxl27qRYaiOARKMRnf
         zrYz+M9ZSN8wth63wZZkeUGn57u5gBAdpbFHrRWSUwM8Monr8RnL9CLud4mqjT6R5onw
         5jntUe1zLtpQUKgRrI0sW45cjxE/Z+VGvDYU6qj7Kfsh6cdSa4H9+K0VMlSPSNvFR0fN
         4EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ajlJknxebsBqz0RiDgCRdoNQyFjTdK4PeIJmLu5MBYs=;
        b=gqyThttqCcTKgMhofRV0JOuU80R9TD2gCC+xA7KiinaEQGCBhd1msA4J2Y0sAOY3oH
         XdmfaOcSWXkJuNn451dTvmUW21ccbWHuSJWNDi5HFZBOdFc6acT8QTLfj/FJ90b9TqFu
         4pmSBq9TuyGuF3BkVWHHK1Q43OpES4oTfvAQasDTlkXljll7SGIABoExxg6NOO8walZV
         3sYQeSyOxCAVTE5/uPFqdzUNKLbE/4+Ht8kQDxfdUVfbip8rEssFJpnA8clzFVDxwauC
         NBkmz+xMrn44zMGLwMILBb11xB7fFILRv4dFKKf09UscuXUPusBWwLvkg1YEzVOI+1sH
         PBFg==
X-Gm-Message-State: ACrzQf0rFI2QU9bhZpJ2lT2tpbnNdO8hT7jr/8y4CecyZN/tINYQR35V
        oPBa9GrVFUh4SAHGAikjkcg=
X-Google-Smtp-Source: AMsMyM5a5cZhG9eAzWCHyQJeeFo+4QRS/e+W/n1bkny4dmc2vyR4PsQXhZgMGZEf65tlCNT27dG2cw==
X-Received: by 2002:adf:d08d:0:b0:22a:4560:9c29 with SMTP id y13-20020adfd08d000000b0022a45609c29mr3785962wrh.579.1663357375310;
        Fri, 16 Sep 2022 12:42:55 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c204a00b003a5fa79007fsm3033507wmg.7.2022.09.16.12.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:42:54 -0700 (PDT)
Message-ID: <6324d1be.050a0220.9d842.7b47@mx.google.com>
X-Google-Original-Message-ID: <YyTRvO5yYCFlgj7S@Ansuel-xps.>
Date:   Fri, 16 Sep 2022 21:42:52 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 2/5] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
 <20220914142256.28775-3-ansuelsmth@gmail.com>
 <20220916191715.GA1079300-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916191715.GA1079300-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:17:15PM -0500, Rob Herring wrote:
> On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian Marangi wrote:
> > Convert kpss-acc driver Documentation to yaml.
> > The original Documentation was wrong all along. Fix it while we are
> > converting it.
> > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > don't have any driver that expose additional clocks. The kpss-acc driver
> > is only specific to v1. For this exact reason, limit all the additional
> > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > v1 and also flag that these bindings should NOT be used for v2.
> 
> Odd that a clock controller has no clocks, but okay.
>

As said in the commit v2 is only used for regs. v2 it's only used in
arch/arm/mach-qcom/platsmp.c to setup stuff cpu hotplug and bringup.

Should we split the 2 driver? To me the acc naming seems to be just
recycled for v2 and it's not really a clk controller.

So keeping v2 in arm/msm/qcom,kpss-acc-v2.yaml and v1 moved to clock?

> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
> >  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 93 +++++++++++++++++++
> 
> As this is a clock controller, please move to bindings/clock/
> 
> >  2 files changed, 93 insertions(+), 49 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> 
> > diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> > new file mode 100644
> > index 000000000000..5e16121d9f0d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-acc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description: |
> 
> Don't need '|' if no formatting to preserve.
> 
> > +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> > +  There is one ACC register region per CPU within the KPSS remapped region as
> > +  well as an alias register region that remaps accesses to the ACC associated
> > +  with the CPU accessing the region.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,kpss-acc-v1
> > +      - qcom,kpss-acc-v2
> > +
> > +  reg:
> > +    items:
> > +      - description: Base address and size of the register region
> > +      - description: Optional base address and size of the alias register region
> > +
> > +  clocks:
> > +    items:
> > +      - description: phandle to pll8_vote
> 
> Always a phandle (and arg), so that's redundant. Really, if there's not 
> more to add that what clock-names says, then just 'maxItems: 2' is fine.
> 
> > +      - description: phandle to pxo_board
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pll8_vote
> > +      - const: pxo
> > +
> > +  clock-output-names:
> > +    description: Name of the aux clock. Krait can have at most 4 cpu.
> > +    enum:
> > +      - acpu0_aux
> > +      - acpu1_aux
> > +      - acpu2_aux
> > +      - acpu3_aux
> > +
> > +  '#clock-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: qcom,kpss-acc-v1
> > +then:
> > +  required:
> > +    - clocks
> > +    - clock-names
> > +    - clock-output-names
> > +    - '#clock-cells'
> > +else:
> > +  properties:
> > +    clocks: false
> > +    clock-names: false
> > +    clock-output-names: false
> > +    '#clock-cells': false
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> > +
> > +    clock-controller@2088000 {
> > +      compatible = "qcom,kpss-acc-v1";
> > +      reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> > +      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> > +      clock-names = "pll8_vote", "pxo";
> > +      clock-output-names = "acpu0_aux";
> > +      #clock-cells = <0>;
> > +    };
> > +
> > +  - |
> > +    clock-controller@f9088000 {
> > +      compatible = "qcom,kpss-acc-v2";
> > +      reg = <0xf9088000 0x1000>,
> > +            <0xf9008000 0x1000>;
> > +    };
> > +...
> > -- 
> > 2.37.2
> > 
> > 

-- 
	Ansuel
