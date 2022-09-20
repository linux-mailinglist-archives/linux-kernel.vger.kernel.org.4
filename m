Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFA5BEB85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiITRAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:00:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DF34DB0D;
        Tue, 20 Sep 2022 10:00:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a14so3751088ljj.8;
        Tue, 20 Sep 2022 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a2XGN4ghAp94upVl0ROOioKKEQvmVvfjeJYYCE82DlI=;
        b=QkeDWMthgVYljQxi+VewLxdQDK4p7UImT48XBWnQsaE5KYDeQ3NZ5/rSC4DtcdgOB2
         xqRdYK3PqtXX2zjVOhPrExBptYAtmlvZjuNn/hRVhiePrbZlEBS/atJ62JWbMCPbGRPn
         thjqDaPfnwH2liOB4UYTD3OjceQxSRLWkcbzIxhCTTBxh8Zjx1YmVe0sLhlI1r0+DU9M
         Z828/mxxu1dd9vW9BBFcdtx7G6Yygx5oGujKUSwy5jXaBk/ElcjfXkG13Y2tPoKcdiT2
         Z7OV+ZPjlk2h97K6BDXJSuJFYNNeXcFOvRMJVc77O49K57wqfEtc/suxQZNw/X5TGGip
         vEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a2XGN4ghAp94upVl0ROOioKKEQvmVvfjeJYYCE82DlI=;
        b=G4RNEe8+07lC1QJhcdzVohjzQ5QpNLjPoNu9+D3dFtjJVSpke2qQFPvNyw1rbHNLa8
         Hlghrlfsyn/XFRpg+4keZgmcf5SeonAhoOZYqE2kfCKV10Mwl828XJto4jMHy55B9kKW
         y/tTSrerY1/2afxCrwbEKUscP48wiXdv861k7ENwtonXXDhZuQ8spjx4CPG7LrjnyKmF
         Sl6v5UfGNYbcnz8HyXSbBo1LsdMPaJc2KxTWtY59Qwd4kKqEoBHQ3nQuFfJ6GNZp93wA
         sjuzSu1MYq82VQGuYuRPdDnV0ZQvRjgMwDmj3Ia3XcbO+0w6z3FTLSyl7A9ttpa/vpPJ
         bidA==
X-Gm-Message-State: ACrzQf124o+O4omyAjmhZpF0WocesVZdjiZoq1HpB1FGtPoKu6T3I6aY
        1lkKqbsPZVjXvz5lUY2jlH/IjPEwOF5jIXqwKQw=
X-Google-Smtp-Source: AMsMyM4StdJy1Lqc4K8wWvp/gUGEklUXu1pRP3Pe1Ldrxj3ElxV6BcEyJP3XIniFnzxjBAPeA097tJPMUUZLPRWeSGg=
X-Received: by 2002:a2e:a587:0:b0:26c:510b:3cca with SMTP id
 m7-20020a2ea587000000b0026c510b3ccamr3457801ljp.452.1663693225927; Tue, 20
 Sep 2022 10:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220714122322.63663-1-tmaimon77@gmail.com> <20220714122322.63663-2-tmaimon77@gmail.com>
 <20220718211046.GA3547663-robh@kernel.org> <CAP6Zq1hQ5m2kkQOKaYsKhPQhCW+vdsdyPRxxb_yRGMB=gJCPdw@mail.gmail.com>
 <3981e6e8-d4bb-b13d-7aaa-7aea83ffaad9@linaro.org> <CAP6Zq1gp1ph1wixgb6nL+2R8We2YJ2HQM2iC05itq_XWd2Cwig@mail.gmail.com>
 <bfca0379-7346-13e7-a18f-66740c5871b3@linaro.org> <CAP6Zq1gyDW8ZwwAZ1jyfNEZa09WN-biZZJY8tBmW_gzMzpj3ZA@mail.gmail.com>
 <2b0e6e33-ef76-4bd4-8894-53f9a3fe68b4@linaro.org> <CAP6Zq1iwW6HvvfM684VLG0ZT-0OLKT0udW4bHxsZsTMEypo2sg@mail.gmail.com>
 <6f1ad082-74e4-e4e7-9304-5cdd95cc9f66@linaro.org> <CAP6Zq1hTS7mVWvYWfTwWvrZibKMpW5r7=wE6W9uETb=aS6MTuA@mail.gmail.com>
 <d8b7fce1-99fa-584b-55e0-f4c3cbe500e2@linaro.org>
In-Reply-To: <d8b7fce1-99fa-584b-55e0-f4c3cbe500e2@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 20 Sep 2022 20:00:14 +0300
Message-ID: <CAP6Zq1hEM67cZt-pcn95VpcPcOVnySb=3XV69irzdkuAuXgofw@mail.gmail.com>
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

On Tue, 20 Sept 2022 at 18:16, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/09/2022 11:27, Tomer Maimon wrote:
> > On Tue, 20 Sept 2022 at 11:47, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 20/09/2022 10:32, Tomer Maimon wrote:
> >>> On Tue, 20 Sept 2022 at 11:21, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 20/09/2022 09:59, Tomer Maimon wrote:
> >>>>>>>>>>> +      pinctrl: pinctrl@f0800000 {
> >>>>>>>>>>> +        compatible = "nuvoton,npcm845-pinctrl";
> >>>>>>>>>>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> >>>>>>>>>>> +        #address-cells = <1>;
> >>>>>>>>>>> +        #size-cells = <1>;
> >>>>>>>>>>> +        nuvoton,sysgcr = <&gcr>;
> >>>>>>>>>>> +
> >>>>>>>>>>> +        gpio0: gpio@f0010000 {
> >>>>>>>>>>
> >>>>>>>>>> gpio@0
> >>>>>>>>>>
> >>>>>>>>>> Is this really a child block of the pinctrl? Doesn't really look like it
> >>>>>>>>>> based on addressess. Where are the pinctrl registers? In the sysgcr? If
> >>>>>>>>>> so, then pinctrl should be a child of it. But that doesn't really work
> >>>>>>>>>> too well with gpio child nodes...
> >>>>>>>>> the pin controller mux is handled by sysgcr this is why the sysgcr in
> >>>>>>>>> the mother node,
> >>>>>>>>> and the pin configuration are handled by the GPIO registers.  each
> >>>>>>>>> GPIO bank (child) contains 32 GPIO.
> >>>>>>>>> this is why the GPIO is the child node.
> >>>>>>>>
> >>>>>>>> Then maybe pinctrl should be the sysgcr and expose regmap for other devices?
> >>>>>>> The pin controller using the sysgcr to handle the pinmux, this is why
> >>>>>>> the sysgcr is in the mother node, is it problematic?
> >>>>>>
> >>>>>> You said pin-controller mux registers are in sysgcr, so it should not be
> >>>>>> used via syscon.
> >>>>> Sorry but maybe I missed something.
> >>>>> the sysgcr is used for miscellaneous features and not only for the pin
> >>>>> controller mux, this is why it used syscon and defined in the dtsi:
> >>>>>                 gcr: system-controller@f0800000 {
> >>>>>                         compatible = "nuvoton,npcm845-gcr", "syscon";
> >>>>>                         reg = <0x0 0xf0800000 0x0 0x1000>;
> >>>>>                 };
> >>>>>>
> >>>>>> Please provide address map description to convince us that this is
> >>>>>> correct HW representation.
> >>>>> GCR (sysgcr) registers 0xf0800000-0xf0801000 - used for miscellaneous
> >>>>> features, not only pin mux.
> >>>>> GPIO0 0xf0010000-0xf0011000
> >>>>> GPIO1 0xf0011000-0xf0012000
> >>>>> ...
> >>>>> GPIO7 0xf0017000-0xf0018000
> >>>>>>
> >>>>
> >>>> Then why your pinctrl is in sysgcr IO range? (pinctrl@f0800000)
> >>> you suggest using pinctrl@0 or pinctrl@f0010000 and not
> >>> pinctrl@f0800000 because 0xf0800000 is the GCR address that serve
> >>> miscellaneous features and not only pinmux controller ?
> >>
> >> If you have a map like you pasted, then DTS like this:
> >>
> >> syscon@f0800000 {}
> >> pinctrl@f0800000 {
> >>   gpio@f0010000 {}
> >> }
> >>
> >> Is quite weird, don't you think? You have two devices on the same unit
> >> address which is not allowed. You have child of pinctrl with entirely
> > O.K.
> >> different unit address, so how is it its child?
> > The pinctrl node name will modify the pinctrl@f0010000 the same as the
> > range property and the start of the child registers,is it fine?
>
> We are all busy, so I don't have that much bandwidth to review each of
> your many solutions and instead poking me with every possible solution,
> I would prefer if you think a bit how this all should work and look.
>
> I don't know if it is fine. Why you should have two devices like this:
> pinctrl@f0010000 {
> gpio@f0010000 {}
> }
>
> ???
> Instead of one device? Answer such questions to yourself before asking
> me. Please come with reasonable DTS describing the hardware.
>
Will do, thanks.
> Best regards,
> Krzysztof

Best regards,

Tomer
