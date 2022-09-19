Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEB85BCEED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiISOcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiISOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:32:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CBF32EDB;
        Mon, 19 Sep 2022 07:32:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z25so47296258lfr.2;
        Mon, 19 Sep 2022 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fbOtVx32xD0An1BP4gF5wsbpUuDHf0RuAIKgzeGlyw8=;
        b=oCY3SQQ06GI1T0nc3vcegfw92SJwkc8GhNmDuFea6YzJroQA1iJ/C0VGdrJSgUz9jx
         mApqMR+9XBUm/uurHE2l+5JQHn2ITXWeQV9bcFU0CNL9s/AsShY84T7chTNmXJLWe4wu
         WCP+4EKr9Nr34D7du1LtLHoiWh7Br/ERUuvDz1gBnykah2JOscL2r/aUjHsOHwb9ltbJ
         la5S4xmdhcWePibJaIj099rNjvZPOikrYSFMzzIMFFgI8RfwnlpHlXHB52MRUmJUBjs+
         SdqxwySj5lN9Am7atnFcJv1SQm1DdpFDiYichNtnI6qxbj8CBO8UxKyxH1InjVj1eEj4
         8Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fbOtVx32xD0An1BP4gF5wsbpUuDHf0RuAIKgzeGlyw8=;
        b=Lt1D4qLYnzvhgfZDUFcwtSDGcX4eTXghxl/bK7NF3aAsvIBA0fd/Flr76bm+Us3/dh
         F2uoFk6aw6BjNPdStZL5UXzzstS8/eKWAYPC+XxTLLukIPCImAlMwr/v4XNVoAJBT8mF
         Y4OZhg8WscoiWaCHx1kt0lZHv9WFnb+ZQFqXGPIN03meJTy/SdaM34YNyXD2AHckHKxX
         r3j79qIJL7yphWMhzOQqLekwDuutH0uLsZXaY706e3xn8tTB6OYbsv0jlP1yiDgzdN6G
         3ADC1Q+agPsjLjWi2v1bP4jzoPBuyZCVAhDpoB6tjQOe1zq3J8vajArI2Z8BP6cGd8Qg
         VxfQ==
X-Gm-Message-State: ACrzQf1CI2oYgSVCzHkXDk6+n7xSleC06/HaGhfmJ1Y769SRwLq6tdTB
        0IBaQcDMV91qkmV1LG9gF50x5vo2tzAhdtFrQNg=
X-Google-Smtp-Source: AMsMyM4TvhQ+C6HD/ZV0YS/n8Apo8lVG6faXAtccFQUMj9KOsAXpl4UCFWGvBlxtGV9MQYWcekd+O4B2UpHaNWuzNlw=
X-Received: by 2002:a05:6512:eaa:b0:497:a1ed:6fa5 with SMTP id
 bi42-20020a0565120eaa00b00497a1ed6fa5mr6073634lfb.108.1663597928023; Mon, 19
 Sep 2022 07:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220714122322.63663-1-tmaimon77@gmail.com> <20220714122322.63663-2-tmaimon77@gmail.com>
 <20220718211046.GA3547663-robh@kernel.org> <CAP6Zq1hQ5m2kkQOKaYsKhPQhCW+vdsdyPRxxb_yRGMB=gJCPdw@mail.gmail.com>
 <3981e6e8-d4bb-b13d-7aaa-7aea83ffaad9@linaro.org>
In-Reply-To: <3981e6e8-d4bb-b13d-7aaa-7aea83ffaad9@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 19 Sep 2022 17:31:56 +0300
Message-ID: <CAP6Zq1gp1ph1wixgb6nL+2R8We2YJ2HQM2iC05itq_XWd2Cwig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Sorry but I didn't understand,

On Mon, 19 Sept 2022 at 09:56, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/09/2022 20:28, Tomer Maimon wrote:
> > Hi Rob,
> >
> > Thanks for your comment and sorry for the late reply.
>
> Two months... we are out of the context and this will not help your
> patchset.
>
> >
> > On Tue, 19 Jul 2022 at 00:10, Rob Herring <robh@kernel.org> wrote:
> >>
>
> (...)
>
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>> +    #include <dt-bindings/gpio/gpio.h>
> >>> +
> >>> +    soc {
> >>> +      #address-cells = <2>;
> >>> +      #size-cells = <2>;
> >>> +
> >>> +      pinctrl: pinctrl@f0800000 {
> >>> +        compatible = "nuvoton,npcm845-pinctrl";
> >>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <1>;
> >>> +        nuvoton,sysgcr = <&gcr>;
> >>> +
> >>> +        gpio0: gpio@f0010000 {
> >>
> >> gpio@0
> >>
> >> Is this really a child block of the pinctrl? Doesn't really look like it
> >> based on addressess. Where are the pinctrl registers? In the sysgcr? If
> >> so, then pinctrl should be a child of it. But that doesn't really work
> >> too well with gpio child nodes...
> > the pin controller mux is handled by sysgcr this is why the sysgcr in
> > the mother node,
> > and the pin configuration are handled by the GPIO registers.  each
> > GPIO bank (child) contains 32 GPIO.
> > this is why the GPIO is the child node.
>
> Then maybe pinctrl should be the sysgcr and expose regmap for other devices?
The pin controller using the sysgcr to handle the pinmux, this is why
the sysgcr is in the mother node, is it problematic?

>
>
> Best regards,
> Krzysztof

Best regards,

Tomer
