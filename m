Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785CF66D103
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjAPVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjAPVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:39:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C702BEEC;
        Mon, 16 Jan 2023 13:39:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so3401956wmb.0;
        Mon, 16 Jan 2023 13:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rkg1oIP8WuA99Y+At5DVt6BS5y4c96Q2/i6EP+4qLLc=;
        b=LaHBV3YL70302UUs5UN8YE9tUeY+C2r/uoRIIfYk1yDKJK4bMBZ7TYgTlGxDo8eL4C
         7Z5KWarcnb2anvZCcEEgi2FRmYgRYxU3JfVf0rluzESlWM4preBvHB2vwcaKVCzW7imc
         kg+XcQ+o+kRLFxVQprd9Wxdxp7h6I7fV7jjdhArkUkfh16eIGFTS8NZ25aKVctBt6/xO
         p6tWoEnYSBXo2zuXBRGw86uJeKnjObTpAyMyfEFidr2mWeYvkaKQ6WWKPwShnB9RwyiF
         dj7umqUymR2GjOxzpio3C5jfRtgKppmfJcQUlKcFQpGUDbkjiIEV+gPWnQFbXHwJ7FK5
         8adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rkg1oIP8WuA99Y+At5DVt6BS5y4c96Q2/i6EP+4qLLc=;
        b=NDAsmol3/1hrf4opVw7hVyzcXfoHTQ+HiK3zCC9stbVzQcUz7egx8VQOsN2aBVdWlv
         8msisq/C8qoRW2JinbxkJYTlAyRnRpPHuqR0kjNI8Obe5PKlsSrsKgUS4crXzchNkZbF
         4ovyM8AXc8C7yxf4BON5mqJS2KFMtQug2i7860Wotn13IIzbfQlNiQ6wdJePgzM9/X0C
         CcTezUjEKGr6aLHHOs9AoTlHq8Tda6hFYRp/1Lj4512Fi/RXGZLuNsw4oUNFVWLPB9+5
         WhUOL9RuO5e7cs0+LWwQFBEdjVa8t2igoxX1MpoitRVlVpTGIt0bK7BOZhD+C73H4ZhB
         dtKQ==
X-Gm-Message-State: AFqh2kpc91RTgZvCx9pwWnyaR/9k/Ag7mji7oSX8SCb4pHzj5F4qjqr5
        6cUbiqs2gjLHgQY2sLjcy2o=
X-Google-Smtp-Source: AMrXdXv7NhZA30363yn0C7MOKM+/EXoByLhqvO5BoJTnjNob+1HWtbJ/kPjab+6yEv+Av0HQNQQcfw==
X-Received: by 2002:a05:600c:1f14:b0:3da:f97b:2a95 with SMTP id bd20-20020a05600c1f1400b003daf97b2a95mr803614wmb.36.1673905164278;
        Mon, 16 Jan 2023 13:39:24 -0800 (PST)
Received: from Ansuel-xps. (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm33652345wmq.9.2023.01.16.13.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 13:39:23 -0800 (PST)
Message-ID: <63c5c40b.050a0220.be3d1.dd0c@mx.google.com>
X-Google-Original-Message-ID: <Y8XEChcOkh5vl8Gg@Ansuel-xps.>
Date:   Mon, 16 Jan 2023 22:39:22 +0100
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
        linux-clk@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/7] dt-bindings: clock: Convert qcom,krait-cc to yaml
References: <20230116204751.23045-1-ansuelsmth@gmail.com>
 <20230116204751.23045-2-ansuelsmth@gmail.com>
 <CAA8EJppdYqwM6n+6BdKtjO+TTerqeodLO7CEpBVNW45yduFV0g@mail.gmail.com>
 <63c5bf92.050a0220.bca9b.5439@mx.google.com>
 <E690C301-63D8-4563-8A82-43D2EB996D10@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E690C301-63D8-4563-8A82-43D2EB996D10@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:29:04PM +0200, Dmitry Baryshkov wrote:
> 16 января 2023 г. 23:20:17 GMT+02:00, Christian Marangi <ansuelsmth@gmail.com> пишет:
> >On Mon, Jan 16, 2023 at 11:14:10PM +0200, Dmitry Baryshkov wrote:
> >> On Mon, 16 Jan 2023 at 22:48, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >> >
> >> > Convert qcom,krait-cc to yaml Documentation.
> >> >
> >> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> > Acked-by: Rob Herring <robh@kernel.org>
> >> 
> >> I know this has been reviewed already. I checked again my apq8064
> >> branch and noticed that the bindings are not compatible with the
> >> apq8064. The SoC in question is a 4-core device, so this is what I had
> >> in mind:
> >> 
> >>        kraitcc: clock-controller {
> >>                compatible = "qcom,krait-cc-v1";
> >>                clocks = <&gcc PLL9>, /* hfpll0 */
> >>                         <&gcc PLL10>, /* hfpll1 */
> >>                         <&gcc PLL16>, /* hfpll2 */
> >>                         <&gcc PLL17>, /* hfpll3 */
> >>                         <&gcc PLL12>, /* hfpll_l2 */
> >>                         <&acc0>,
> >>                         <&acc1>,
> >>                         <&acc2>,
> >>                         <&acc3>,
> >>                         <&l2cc>;
> >>                clock-names = "hfpll0",
> >>                              "hfpll1",
> >>                              "hfpll2",
> >>                              "hfpll3",
> >>                              "hfpll_l2",
> >>                              "acpu0_aux",
> >>                              "acpu1_aux",
> >>                              "acpu2_aux",
> >>                              "acpu3_aux",
> >>                              "acpu_l2_aux";
> >>                #clock-cells = <1>;
> >>        };
> >> 
> >
> >Oh wow... Wasn't aware, but I wonder if a good idea would be to patch
> >the yaml if and when this series is merged? This is a direct conversion
> >of the krait-cc txt...
> >
> >If we really want I can send a v8 with adding these extra stuff to the
> >just converted yaml in a different commit? (afaik conversion should not
> >add more info if the documentation is not broken enough and can be
> >converted)
> 
> I think we can ask Bjorn to pick the rest of the patches (if they are acked/reviewed, they look good to me) and work on this one. It might make sense to add per-SoC compatibles. Also note, the qsb clock. Which block generates it on ipq8064?
>

The krait-cc driver is really very generic and modular so IMHO it
doesn't require different compatibiles... But now that I think about
it... It may be problematic to differentiate them for the clock
configuration...

Btw the qsb clk from krait-cc driver is still a fixed clock set to 1.
In hw side it's the bus clk and it's driven by rpm... (this link is
totally lacking from krait-cc and I think nobody was aware of this
(except old qcom)... To find out this I had to resurrect a pre-DT
migration driver that use the cxo clk to perform hw measurement of the
clk and I discovered that. (cpu and l2 clk can be measured and by
setting the mux to sourcing out of qsb you can notice that the freq will
always match the bus frequency)

But I got sidetracked by too much discoveries... ipq806x simply don't
have a krait-cc driver currently so the qsb doesn't apply...

My idea is to push kriat-cc node + opp node.

> >
> >> > ---
> >> >  .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
> >> >  .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
> >> >  2 files changed, 59 insertions(+), 34 deletions(-)
> >> >  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> >> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> >> > deleted file mode 100644
> >> > index 030ba60dab08..000000000000
> >> > --- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> >> > +++ /dev/null
> >> > @@ -1,34 +0,0 @@
> >> > -Krait Clock Controller
> >> > -
> >> > -PROPERTIES
> >> > -
> >> > -- compatible:
> >> > -       Usage: required
> >> > -       Value type: <string>
> >> > -       Definition: must be one of:
> >> > -                       "qcom,krait-cc-v1"
> >> > -                       "qcom,krait-cc-v2"
> >> > -
> >> > -- #clock-cells:
> >> > -       Usage: required
> >> > -       Value type: <u32>
> >> > -       Definition: must be 1
> >> > -
> >> > -- clocks:
> >> > -       Usage: required
> >> > -       Value type: <prop-encoded-array>
> >> > -       Definition: reference to the clock parents of hfpll, secondary muxes.
> >> > -
> >> > -- clock-names:
> >> > -       Usage: required
> >> > -       Value type: <stringlist>
> >> > -       Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
> >> > -
> >> > -Example:
> >> > -
> >> > -       kraitcc: clock-controller {
> >> > -               compatible = "qcom,krait-cc-v1";
> >> > -               clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
> >> > -               clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
> >> > -               #clock-cells = <1>;
> >> > -       };
> >> > diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> >> > new file mode 100644
> >> > index 000000000000..8caa5a677394
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> >> > @@ -0,0 +1,59 @@
> >> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> > +%YAML 1.2
> >> > +---
> >> > +$id: http://devicetree.org/schemas/clock/qcom,krait-cc.yaml#
> >> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> > +
> >> > +title: Qualcomm Krait Clock Controller
> >> > +
> >> > +maintainers:
> >> > +  - Christian Marangi <ansuelsmth@gmail.com>
> >> > +
> >> > +description: |
> >> > +  Qualcomm Krait Clock Controller used to correctly scale the CPU and the L2
> >> > +  rates.
> >> > +
> >> > +properties:
> >> > +  compatible:
> >> > +    enum:
> >> > +      - qcom,krait-cc-v1
> >> > +      - qcom,krait-cc-v2
> >> > +
> >> > +  clocks:
> >> > +    items:
> >> > +      - description: phandle to hfpll for CPU0 mux
> >> > +      - description: phandle to hfpll for CPU1 mux
> >> > +      - description: phandle to CPU0 aux clock
> >> > +      - description: phandle to CPU1 aux clock
> >> > +      - description: phandle to QSB fixed clk
> >> > +
> >> > +  clock-names:
> >> > +    items:
> >> > +      - const: hfpll0
> >> > +      - const: hfpll1
> >> > +      - const: acpu0_aux
> >> > +      - const: acpu1_aux
> >> > +      - const: qsb
> >> > +
> >> > +  '#clock-cells':
> >> > +    const: 1
> >> > +
> >> > +required:
> >> > +  - compatible
> >> > +  - clocks
> >> > +  - clock-names
> >> > +  - '#clock-cells'
> >> > +
> >> > +additionalProperties: false
> >> > +
> >> > +examples:
> >> > +  - |
> >> > +    clock-controller {
> >> > +      compatible = "qcom,krait-cc-v1";
> >> > +      clocks = <&hfpll0>, <&hfpll1>,
> >> > +               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
> >> > +      clock-names = "hfpll0", "hfpll1",
> >> > +                    "acpu0_aux", "acpu1_aux", "qsb";
> >> > +      #clock-cells = <1>;
> >> > +    };
> >> > +...
> >> > --
> >> > 2.37.2
> >> >
> >> 
> >> 
> >> -- 
> >> With best wishes
> >> Dmitry
> >
> 

-- 
	Ansuel
