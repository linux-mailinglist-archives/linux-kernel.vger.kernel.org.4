Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB03B66D0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjAPVUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjAPVUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:20:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE52794;
        Mon, 16 Jan 2023 13:20:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so3376367wmb.0;
        Mon, 16 Jan 2023 13:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wx6dFpBiKRF+lOp7tVSvWrSb/+7pTNhNIK42JetspUc=;
        b=DUu/lyLhWrxqyxq6o1rBYVNColZC4w3ZfDC4z+kYDQZfcz0rcpMtIDFd8OdacWa0zx
         aRxHpDXTh3DSvZsFC6UMowq8dM2ljk6so70O5QO5ZvkRQwe9H2j/nCJOFazlsrEt1xTR
         H5Aa3h4ivCis+KGgBsBF4EGk4hlxt+U149GenS6C7PEdTII93zrcZen8wbcLjiZy8EW1
         TusiVSMhG7j76mQPpLYLu2qRTD62OQvM6iPolDBWpLp6FQXYN/0V/i0rc0dhXO2y1yu2
         xYLsc/3PWxbzPEYNgpg5754nfSr4Pc2mB2aHpVh5qNoJbEy5MQiLsm40klwQ4QatlkBk
         0Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx6dFpBiKRF+lOp7tVSvWrSb/+7pTNhNIK42JetspUc=;
        b=THE0CVy3OQoXW1r0BF9R1rwddMnGG7Ua/lCXpB98Y/gx+3n7dFW5I2xFeRotozX51v
         rVHrliYR8Xnr1e0HTpu2XZ5Kxp+sWJ2d+2pzLB1msC61jxjmmcaz1ZKGMEqsqizg1hWz
         sEFod4bdfrMx9RSN+vg1sTMy/h0iNp4Pr7F7/bc6VBLzlIczp/143Pw2VVvO23mxv04K
         BC1ONx82RAAZ4wQ1eXjksnSBac48gaSi7UhjOPF2dKlWCxukzTIfP/3VwDq4jW+3d0vY
         7HYnKPRUi6T0+bMurDLCEPZwk+3E0uqmW2GgCr0FEf/U6/Da9Hc969+4k3Wnvv6QleEY
         dW9g==
X-Gm-Message-State: AFqh2koBBG/87W4Dp4/Mg9UY4GruJpeuLQUzqcs0BgZ4nEvhgBupvzZw
        vKTblYdmYnSyX2YX6toAATI=
X-Google-Smtp-Source: AMrXdXs67C5IV65UlljRSfTVXQGMuK4uLXUEVOX7qzhxlrdEahu7BgQ49aO5FK8+AA2WDoRFE9QqsQ==
X-Received: by 2002:a05:600c:13c8:b0:3db:3e8:feca with SMTP id e8-20020a05600c13c800b003db03e8fecamr1314881wmg.15.1673904018984;
        Mon, 16 Jan 2023 13:20:18 -0800 (PST)
Received: from Ansuel-xps. (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c502500b003db03be9420sm1207370wmr.13.2023.01.16.13.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 13:20:18 -0800 (PST)
Message-ID: <63c5bf92.050a0220.bca9b.5439@mx.google.com>
X-Google-Original-Message-ID: <Y8W/kTrBS6fJbV9e@Ansuel-xps.>
Date:   Mon, 16 Jan 2023 22:20:17 +0100
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppdYqwM6n+6BdKtjO+TTerqeodLO7CEpBVNW45yduFV0g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:14:10PM +0200, Dmitry Baryshkov wrote:
> On Mon, 16 Jan 2023 at 22:48, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Convert qcom,krait-cc to yaml Documentation.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> I know this has been reviewed already. I checked again my apq8064
> branch and noticed that the bindings are not compatible with the
> apq8064. The SoC in question is a 4-core device, so this is what I had
> in mind:
> 
>        kraitcc: clock-controller {
>                compatible = "qcom,krait-cc-v1";
>                clocks = <&gcc PLL9>, /* hfpll0 */
>                         <&gcc PLL10>, /* hfpll1 */
>                         <&gcc PLL16>, /* hfpll2 */
>                         <&gcc PLL17>, /* hfpll3 */
>                         <&gcc PLL12>, /* hfpll_l2 */
>                         <&acc0>,
>                         <&acc1>,
>                         <&acc2>,
>                         <&acc3>,
>                         <&l2cc>;
>                clock-names = "hfpll0",
>                              "hfpll1",
>                              "hfpll2",
>                              "hfpll3",
>                              "hfpll_l2",
>                              "acpu0_aux",
>                              "acpu1_aux",
>                              "acpu2_aux",
>                              "acpu3_aux",
>                              "acpu_l2_aux";
>                #clock-cells = <1>;
>        };
> 

Oh wow... Wasn't aware, but I wonder if a good idea would be to patch
the yaml if and when this series is merged? This is a direct conversion
of the krait-cc txt...

If we really want I can send a v8 with adding these extra stuff to the
just converted yaml in a different commit? (afaik conversion should not
add more info if the documentation is not broken enough and can be
converted)

> > ---
> >  .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
> >  .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
> >  2 files changed, 59 insertions(+), 34 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> > deleted file mode 100644
> > index 030ba60dab08..000000000000
> > --- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> > +++ /dev/null
> > @@ -1,34 +0,0 @@
> > -Krait Clock Controller
> > -
> > -PROPERTIES
> > -
> > -- compatible:
> > -       Usage: required
> > -       Value type: <string>
> > -       Definition: must be one of:
> > -                       "qcom,krait-cc-v1"
> > -                       "qcom,krait-cc-v2"
> > -
> > -- #clock-cells:
> > -       Usage: required
> > -       Value type: <u32>
> > -       Definition: must be 1
> > -
> > -- clocks:
> > -       Usage: required
> > -       Value type: <prop-encoded-array>
> > -       Definition: reference to the clock parents of hfpll, secondary muxes.
> > -
> > -- clock-names:
> > -       Usage: required
> > -       Value type: <stringlist>
> > -       Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
> > -
> > -Example:
> > -
> > -       kraitcc: clock-controller {
> > -               compatible = "qcom,krait-cc-v1";
> > -               clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
> > -               clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
> > -               #clock-cells = <1>;
> > -       };
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> > new file mode 100644
> > index 000000000000..8caa5a677394
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,krait-cc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Krait Clock Controller
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  Qualcomm Krait Clock Controller used to correctly scale the CPU and the L2
> > +  rates.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,krait-cc-v1
> > +      - qcom,krait-cc-v2
> > +
> > +  clocks:
> > +    items:
> > +      - description: phandle to hfpll for CPU0 mux
> > +      - description: phandle to hfpll for CPU1 mux
> > +      - description: phandle to CPU0 aux clock
> > +      - description: phandle to CPU1 aux clock
> > +      - description: phandle to QSB fixed clk
> > +
> > +  clock-names:
> > +    items:
> > +      - const: hfpll0
> > +      - const: hfpll1
> > +      - const: acpu0_aux
> > +      - const: acpu1_aux
> > +      - const: qsb
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - clocks
> > +  - clock-names
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    clock-controller {
> > +      compatible = "qcom,krait-cc-v1";
> > +      clocks = <&hfpll0>, <&hfpll1>,
> > +               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
> > +      clock-names = "hfpll0", "hfpll1",
> > +                    "acpu0_aux", "acpu1_aux", "qsb";
> > +      #clock-cells = <1>;
> > +    };
> > +...
> > --
> > 2.37.2
> >
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
