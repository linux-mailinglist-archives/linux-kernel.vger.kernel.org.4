Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB8688B58
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjBCAEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjBCAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:04:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9F7274B8;
        Thu,  2 Feb 2023 16:04:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E384B828B4;
        Fri,  3 Feb 2023 00:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA5C433D2;
        Fri,  3 Feb 2023 00:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675382641;
        bh=v41qSYIy/grCOThf3ACyEpdoLoURRh6v9d1NSGGMMAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eOZV/fDct4rRtv9bQaMW4umgD+AOvIpMblCUEP85r43uPDDQKv144K/8aZ+5V28py
         63pKSOBjr+BK0oi8qZpVIqHK7risLLO0QTLzwIj/ctRYW0Ca4ujcbUMD9GZJ3jaq7Y
         TGs+tbkFUxMAdRNlXFiEhXU7k10q0SlkWOVCwA2yAAHBY7FwHoXR6HzSoTjsmIXAVS
         t/zTSTRVr4doDYjPbbfYg7HCgKGPfFfGlQmyvaYhQbK0yHJQSLrCWum1sRs/o2XgpP
         UHh5AZRBCDJfEkRcUdegaMvuXDM3ALjmdtXZH7NngWDTzn1NUOpFJ0r2LuTHq9y/px
         BLoALDeujwiXA==
Received: by mail-vs1-f45.google.com with SMTP id y8so3763874vsq.0;
        Thu, 02 Feb 2023 16:04:01 -0800 (PST)
X-Gm-Message-State: AO0yUKWBDaJLZzJoowTdl1+IMXR77LsS6YwogltEh7t4fnWZf1xa5CwF
        W6FfDbvU/lxiCY49LXwc+2IocOjPS/sImHGibw==
X-Google-Smtp-Source: AK7set/24UNuKAbNg26YwkAYHwGWM1WDU4yUDp715QSlA/l1JUIHc1XW1R/V5PFCprjAZo402uMoCPx62hFjf+H6MV8=
X-Received: by 2002:a05:6102:338a:b0:3f3:5ce0:85ab with SMTP id
 i10-20020a056102338a00b003f35ce085abmr1615861vsh.26.1675382640194; Thu, 02
 Feb 2023 16:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-3-krzysztof.kozlowski@linaro.org> <20230203000130.GA2934311-robh@kernel.org>
In-Reply-To: <20230203000130.GA2934311-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Feb 2023 18:03:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKnsDJVD-PJNg39=Awdw2XNeUV5b3VgZt3zKCsHzp74bw@mail.gmail.com>
Message-ID: <CAL_JsqKnsDJVD-PJNg39=Awdw2XNeUV5b3VgZt3zKCsHzp74bw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: pinctrl: qcom,msm8909: correct GPIO
 name pattern and example
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Iskren Chernev <me@iskren.info>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 6:01 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 02, 2023 at 11:44:44AM +0100, Krzysztof Kozlowski wrote:
> > The MSM8909 TLMM pin controller has GPIOs 0-112, so narrow the pattern
> > and gpio-ranges in the example.
> >
> > Fixes: c249ec7ba1b1 ("dt-bindings: pinctrl: Add DT schema for qcom,msm8909-tlmm")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  .../devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml        | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> > index 449e6e34be61..85082adc1811 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> > @@ -63,7 +63,7 @@ $defs:
> >            subnode.
> >          items:
> >            oneOf:
> > -            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-7])$"
> > +            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-2])$"
> >              - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd,
> >                        sdc2_data, qdsd_clk, qdsd_cmd, qdsd_data0, qdsd_data1,
> >                        qdsd_data2, qdsd_data3 ]
> > @@ -127,7 +127,7 @@ examples:
> >          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> >          gpio-controller;
> >          #gpio-cells = <2>;
> > -        gpio-ranges = <&tlmm 0 0 117>;
> > +        gpio-ranges = <&tlmm 0 0 113>;
>
> I thought 112 was the max?

That's the count, duh.

Acked-by: Rob Herring <robh@kernel.org>
