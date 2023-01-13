Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8A669879
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbjAMN1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbjAMN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:27:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3935D5CF9C;
        Fri, 13 Jan 2023 05:18:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ay40so15261989wmb.2;
        Fri, 13 Jan 2023 05:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YgIF86xFlVafZ9POD/Q6wH2nOUXlLRZBzccN46/gwyI=;
        b=aZvWv2v3QWsETkYdecEWQ0sinCRBmmqTcYg2AxF5SGnEJdz3BT2VVQE4FmsNMZcYZo
         y7FBVB9PomPLrGum4K+tgt3TW9Oo0OsZ3J41z+gw6W6KKiAFr8LftysIIxdhZ63MOzhJ
         WpxW4SW6Cs6Yf2Q4nytMAuzd4jdbtgDASmvgS+lTbcVD8ZtYquBEZbgWBtY9+0jZRMYc
         Vm1IDGn/0K/o7Nla8jr97mOCf0PFCd/1dwToSqYc8yjNNYKAhSXoZ5UGrMRmbW5lK9Dp
         EUdfSPdTDjHg7rKJP3Gnkl6MUc/TFNWmxMSVLwhu41YpRVqdC+m7FS+HMH+P/Ps88Mug
         r3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgIF86xFlVafZ9POD/Q6wH2nOUXlLRZBzccN46/gwyI=;
        b=35tbslBt8IZEyOHm569y24v+eVc0i9SAsg8PrkhyxhAr0Qj+OC18I3wMi8jeCggFKW
         we6a0BWmZpAc5qPJLNgR5Qbt5EsMOVPi+uCZkJav0E0L/16Rs4gVvDibw0z178Ri8XDD
         Mcom7rvUCm7dX/bsJyrLTCtIWl/ffLfa+6N+kAH07c+EynlkFiBCiB3bnb5vVmj7G0gh
         fhwaKVt/ASn4f8ngoFE4xQ64vuP8S58lNbRXQnWweFWBiPpySc493aTi7uQrvGlRRBA7
         Ct+Y7WXJIP5RUNqzeIbIPPQCsXFHSB8lWLHXCFtcfvR92Qj48qnePBo4Ia88loH02EFd
         3pJA==
X-Gm-Message-State: AFqh2kpdl2+AeUuMBj+cCVTT0tyY0odVxAMbQZcbLPrYa4dkyIqGDp8u
        3D++ylBMoHeL9AiTjPu51Kg=
X-Google-Smtp-Source: AMrXdXt5dXeyjA4xq4soWwa1BPKHI/UVZQ7Z2QmybFI6KSU/hzx4ltymAgon77A/gX4Ush5hVGEwmQ==
X-Received: by 2002:a05:600c:5399:b0:3d9:c6f5:c63d with SMTP id hg25-20020a05600c539900b003d9c6f5c63dmr26889582wmb.28.1673615932941;
        Fri, 13 Jan 2023 05:18:52 -0800 (PST)
Received: from Ansuel-xps. (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003c701c12a17sm27788319wmp.12.2023.01.13.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:18:52 -0800 (PST)
Message-ID: <63c15a3c.050a0220.5f7c6.1db3@mx.google.com>
X-Google-Original-Message-ID: <Y8FaO230vYJUCfjX@Ansuel-xps.>
Date:   Fri, 13 Jan 2023 14:18:51 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 2/6] dt-bindings: arm: msm: Convert and split kpss-acc
 driver Documentation to yaml
References: <20230110183259.19142-1-ansuelsmth@gmail.com>
 <20230110183259.19142-3-ansuelsmth@gmail.com>
 <f851bca5-d0e1-fe40-9b06-e6f2af37cce0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f851bca5-d0e1-fe40-9b06-e6f2af37cce0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 06:00:10AM +0200, Dmitry Baryshkov wrote:
> On 10/01/2023 20:32, Christian Marangi wrote:
> > Convert kpss-acc driver Documentation to yaml.
> > The original Documentation was wrong all along. Fix it while we are
> > converting it.
> > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > don't have any driver that expose additional clocks. The kpss-acc driver
> > is only specific to v1. For this exact reason, split the Documentation
> > to 2 different schema, v1 as clock-controller and v2 for
> > power-controller as per msm-3.10 specification, the exposed regs handle
> > power domains.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 -------------
> >   .../bindings/clock/qcom,kpss-acc-v1.yaml      | 72 +++++++++++++++++++
> >   .../bindings/power/qcom,kpss-acc-v2.yaml      | 47 ++++++++++++
> >   3 files changed, 119 insertions(+), 49 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> >   create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
> >   create mode 100644 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> > deleted file mode 100644
> > index 7f696362a4a1..000000000000
> > --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> > +++ /dev/null
> > @@ -1,49 +0,0 @@
> > -Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> > -
> > -The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> > -There is one ACC register region per CPU within the KPSS remapped region as
> > -well as an alias register region that remaps accesses to the ACC associated
> > -with the CPU accessing the region.
> > -
> > -PROPERTIES
> > -
> > -- compatible:
> > -	Usage: required
> > -	Value type: <string>
> > -	Definition: should be one of:
> > -			"qcom,kpss-acc-v1"
> > -			"qcom,kpss-acc-v2"
> > -
> > -- reg:
> > -	Usage: required
> > -	Value type: <prop-encoded-array>
> > -	Definition: the first element specifies the base address and size of
> > -		    the register region. An optional second element specifies
> > -		    the base address and size of the alias register region.
> > -
> > -- clocks:
> > -        Usage: required
> > -        Value type: <prop-encoded-array>
> > -        Definition: reference to the pll parents.
> > -
> > -- clock-names:
> > -        Usage: required
> > -        Value type: <stringlist>
> > -        Definition: must be "pll8_vote", "pxo".
> > -
> > -- clock-output-names:
> > -	Usage: optional
> > -	Value type: <string>
> > -	Definition: Name of the output clock. Typically acpuX_aux where X is a
> > -		    CPU number starting at 0.
> > -
> > -Example:
> > -
> > -	clock-controller@2088000 {
> > -		compatible = "qcom,kpss-acc-v2";
> > -		reg = <0x02088000 0x1000>,
> > -		      <0x02008000 0x1000>;
> > -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> > -		clock-names = "pll8_vote", "pxo";
> > -		clock-output-names = "acpu0_aux";
> > -	};
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml b/Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
> > new file mode 100644
> > index 000000000000..a466e4e8aacd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,kpss-acc-v1.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC) v1
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description:
> > +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> > +  There is one ACC register region per CPU within the KPSS remapped region as
> > +  well as an alias register region that remaps accesses to the ACC associated
> > +  with the CPU accessing the region. ACC v1 is currently used as a
> > +  clock-controller for enabling the cpu and hanling the aux clocks.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,kpss-acc-v1
> > +
> > +  reg:
> > +    items:
> > +      - description: Base address and size of the register region
> > +      - description: Optional base address and size of the alias register region
> > +    minItems: 1
> > +
> > +  clocks:
> > +    minItems: 2
> > +    maxItems: 2
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
> > +  - clocks
> > +  - clock-names
> > +  - clock-output-names
> > +  - '#clock-cells'
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
> > +...
> > diff --git a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> > new file mode 100644
> > index 000000000000..91af95569ae6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/qcom,kpss-acc-v2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC) v2
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description:
> > +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> > +  There is one ACC register region per CPU within the KPSS remapped region as
> > +  well as an alias register region that remaps accesses to the ACC associated
> > +  with the CPU accessing the region. ACC v2 is currently used as a
> > +  power-controller for enabling the cpu.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,kpss-acc-v2
> > +
> > +  reg:
> > +    items:
> > +      - description: Base address and size of the register region
> > +      - description: Optional base address and size of the alias register region
> > +    minItems: 1
> > +
> > +  '#power-domain-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#power-domain-cells'
> 
> This dictates that if at some point we implement the kps-acc-v2 driver, it
> will return a single power domain. I can not confirm that this would be the
> case. I see that you want to migrate from the clock-controller as the acc-v2
> doesn't provide clocks. I'd suggest instead using the neutral
> `power-manager@...` node name. It doesn't demand anything, so we can drop
> the (unused and unsupported) #power-domain-cells property.
>

Thanks for the review of the series and thanks for the suggestion. Will
do the change and send v7 hoping it's the final revision.

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    power-controller@f9088000 {
> > +      compatible = "qcom,kpss-acc-v2";
> > +      reg = <0xf9088000 0x1000>,
> > +            <0xf9008000 0x1000>;
> > +      #power-domain-cells = <0>;
> > +    };
> > +...
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
	Ansuel
