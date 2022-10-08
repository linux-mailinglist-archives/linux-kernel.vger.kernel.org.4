Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED925F829D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJHC6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 22:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJHC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 22:58:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336685F991;
        Fri,  7 Oct 2022 19:58:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ot12so14894304ejb.1;
        Fri, 07 Oct 2022 19:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ajMDfq9ox0mU2sX/ueFv0xaV5X0UEUZFKaNpdeAj+T8=;
        b=WQe/X+SvTNp/8WqHmhmGQWHM75qZNgoD+YWKgIwzfMFKe0iB6OiIi5Veg/KWZraj5+
         v9TyA/C0Q/tir4IsW4+Jf2lkIM2Dp56OmYFp0eqpaKqraNypL/UAJtsIZpB5wQPltYir
         0tnT5GQ8ApmWeFf04mj/clQ6Y7fRsk+omxChV7MptymxVTUjplqFxap180KFTiX7irzJ
         VwV67kDtxjoUIiLBJ+fXgYkLuWXbIaNye9h4oNO7gEL26Fpx2icUMCTeRUUI7Gvt6cSi
         svX/9gIDbjhj/e5ZsdHHVFpvUrQsmrU0hwVy2Oz2Wwooyo1cD7YfqvsQS0ACYYOTQaVz
         B1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajMDfq9ox0mU2sX/ueFv0xaV5X0UEUZFKaNpdeAj+T8=;
        b=xbhmsuYipNSxgIdqUn5LbDX68s//iaPa4iZutltE4kNsPQG3wCZ7Yy3TYUMUtyklUn
         htt9k7DBAhPFdIKCIFpXcFTcS3xtBH+PEX24IaTjDTnO1Cj5WS+yU4Bdco42yYHjPf0p
         RAmuJNHAwCXaezZjeP3R8uHFaCnmt8gD3ih+xFulJO6vpp1Swl08jrOjS2skdIiU5fH7
         5jiEX2Zh6oslzHGOXFS7AU1zR2EMAeO/UTiQ+l9hZbk108KqZSmEj+3OFn+200qvdKkf
         aQ1Kw1Pzp8VbDwOJtvRxbxTzLx0hXliIdz6gt2MvsfoEV+M6WI7bJxXGjw88C/jCZQcH
         LZNA==
X-Gm-Message-State: ACrzQf3qlX9p/ySL3yScsGkv2IYRKPAJ1QLEHi9HkEwKpZvxwNK0n6o5
        w203ogXZuxRX877gtm7MvNtSKkP5cDq75Bzdcdlo++r69eY=
X-Google-Smtp-Source: AMsMyM4gVGrEmWFLMnMMldsV0FjyqGtDZKHHoLhezKAMdGOnHaIInFDeNevoM2F2Z2wjD8/sUPiZWdheLTAI8/bHJpk=
X-Received: by 2002:a17:907:7dab:b0:782:fe13:6102 with SMTP id
 oz43-20020a1709077dab00b00782fe136102mr6296796ejc.617.1665197892671; Fri, 07
 Oct 2022 19:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220930082405.1761-1-zhang.lyra@gmail.com> <20220930082405.1761-3-zhang.lyra@gmail.com>
 <727a540d-0ca9-ade3-894d-f1774d10a681@linaro.org>
In-Reply-To: <727a540d-0ca9-ade3-894d-f1774d10a681@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Sat, 8 Oct 2022 10:57:35 +0800
Message-ID: <CAAfSe-u4y84kjjksv-Y7=zyosV=34M-=_wrDQC9884znvx9V4Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] dt-bindings: gpio: Convert Unisoc EIC controller
 binding to yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sept 2022 at 19:09, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/09/2022 10:24, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Convert the Unisoc EIC controller binding to DT schema format.
> > Update the maxItems of 'reg' property, since the current gpio-eic-sprd
> > driver supports 3 reg items. Also remove three redundant examples.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../bindings/gpio/gpio-eic-sprd.txt           |  97 --------------
> >  .../bindings/gpio/sprd,gpio-eic.yaml          | 119 ++++++++++++++++++
> >  2 files changed, 119 insertions(+), 97 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> >  create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml

[snip]

> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        eic_debounce: gpio@40210000 {
> > +            compatible = "sprd,sc9860-eic-debounce";
> > +            reg = <0 0x40210000 0 0x80>;
> > +            gpio-controller;
> > +            #gpio-cells = <2>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <2>;
> > +            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +    };
> > +
> > +    sc2730_pmic {
>
> If you insisted to keep it, at least should be correct, so just pmic.
>
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        pmic_eic: gpio@300 {
>
> It's exactly the same example as above - all same properties. Drop it or
> bring some differences.

The differences are on #address-cells and #size-cells.

Thanks for the review,
Chunyan
