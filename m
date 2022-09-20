Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4CF5BE02B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiITIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiITIcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:32:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55F92DCB;
        Tue, 20 Sep 2022 01:32:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o2so2517343lfc.10;
        Tue, 20 Sep 2022 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+/OUZiYO0SDMAPBkbc+dxN7K0Ghz3UX1HgPLq26TwY8=;
        b=NBYAJFzZKAUXo9Iojo5wexxgw0TKAuBYfXYzNcSiw7qZqMR+0vZNwnQpIsfUXZjrpW
         R87x/rjzcv+MrXy/YZQSXk9h3ESJLYWmIwyDGYyCPVV57J30cPmwy4l4W9Nf3BfK2dxJ
         XSNZZOvsWvjpmiDXXJ74IfxzHW76bT0M9MuibSzsRQUphmGkWWIC0VbhDXArlBg45Jc0
         f7a5xZyHziAUJL3o5t67zam2yoLhVnsbRyQAq61EJXEbM4AkKBBvjo//j4WSvqsJaKpY
         Yj+sV0/ClglPqQ2FqLj9fMJr0OTpZzw9U9FGYsuZRnxgyC6zs3PPtj2iXht0e55zz9jQ
         8tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+/OUZiYO0SDMAPBkbc+dxN7K0Ghz3UX1HgPLq26TwY8=;
        b=aJqLzubEALBVSkw2xrOQHeKRlNUI3GV9MxjDcU1btJqF1DvKg2B2Bu5IeVGOcfxDoa
         VomK37jlMbwi2Epn6bqNP6m+VdBxVEWRnQCAQ37Rkhs4cvFPi3gVW+SyH1w1tl85QqDv
         yTEinJ9bik+8KhsFK6o+kZlMs5KeRbHyW+rAydBxjrdAynHbRwPAwe5gDksSHOaiTRFt
         UKGbLQ6Evgu6YmMwHSoblEoTpCFfx6DzVU/6c1LbO0iIdfTKfJB4uHucTMCNaMGZ0Ube
         2xPd/J8DK36JiLD4JIZEq8jBdpFrJe7F9DVfkI03QIE6ZUHR3iuR3PPARZK8ERqsb1SH
         5Wfw==
X-Gm-Message-State: ACrzQf2dR/wEPgs7lasr2yDq6cVblNg18wExjgfi9NkS/b2BE3pzkzu3
        wLVze25NGGGYDdshZTPJxS+V2sN7bKUHyGdjfUI=
X-Google-Smtp-Source: AMsMyM6R/zVvN7o1HLVOVBoRNZstsmoJ+m6sB78Wu1iewEJzZKmtLmXBalE8SjQYaEgEiTk+pdNoySHCq/kbebX1bFU=
X-Received: by 2002:a05:6512:b1d:b0:49f:59da:c706 with SMTP id
 w29-20020a0565120b1d00b0049f59dac706mr6078557lfu.668.1663662737989; Tue, 20
 Sep 2022 01:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220714122322.63663-1-tmaimon77@gmail.com> <20220714122322.63663-2-tmaimon77@gmail.com>
 <20220718211046.GA3547663-robh@kernel.org> <CAP6Zq1hQ5m2kkQOKaYsKhPQhCW+vdsdyPRxxb_yRGMB=gJCPdw@mail.gmail.com>
 <3981e6e8-d4bb-b13d-7aaa-7aea83ffaad9@linaro.org> <CAP6Zq1gp1ph1wixgb6nL+2R8We2YJ2HQM2iC05itq_XWd2Cwig@mail.gmail.com>
 <bfca0379-7346-13e7-a18f-66740c5871b3@linaro.org> <CAP6Zq1gyDW8ZwwAZ1jyfNEZa09WN-biZZJY8tBmW_gzMzpj3ZA@mail.gmail.com>
 <2b0e6e33-ef76-4bd4-8894-53f9a3fe68b4@linaro.org>
In-Reply-To: <2b0e6e33-ef76-4bd4-8894-53f9a3fe68b4@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 20 Sep 2022 11:32:06 +0300
Message-ID: <CAP6Zq1iwW6HvvfM684VLG0ZT-0OLKT0udW4bHxsZsTMEypo2sg@mail.gmail.com>
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

On Tue, 20 Sept 2022 at 11:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/09/2022 09:59, Tomer Maimon wrote:
> >>>>>>> +      pinctrl: pinctrl@f0800000 {
> >>>>>>> +        compatible = "nuvoton,npcm845-pinctrl";
> >>>>>>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> >>>>>>> +        #address-cells = <1>;
> >>>>>>> +        #size-cells = <1>;
> >>>>>>> +        nuvoton,sysgcr = <&gcr>;
> >>>>>>> +
> >>>>>>> +        gpio0: gpio@f0010000 {
> >>>>>>
> >>>>>> gpio@0
> >>>>>>
> >>>>>> Is this really a child block of the pinctrl? Doesn't really look like it
> >>>>>> based on addressess. Where are the pinctrl registers? In the sysgcr? If
> >>>>>> so, then pinctrl should be a child of it. But that doesn't really work
> >>>>>> too well with gpio child nodes...
> >>>>> the pin controller mux is handled by sysgcr this is why the sysgcr in
> >>>>> the mother node,
> >>>>> and the pin configuration are handled by the GPIO registers.  each
> >>>>> GPIO bank (child) contains 32 GPIO.
> >>>>> this is why the GPIO is the child node.
> >>>>
> >>>> Then maybe pinctrl should be the sysgcr and expose regmap for other devices?
> >>> The pin controller using the sysgcr to handle the pinmux, this is why
> >>> the sysgcr is in the mother node, is it problematic?
> >>
> >> You said pin-controller mux registers are in sysgcr, so it should not be
> >> used via syscon.
> > Sorry but maybe I missed something.
> > the sysgcr is used for miscellaneous features and not only for the pin
> > controller mux, this is why it used syscon and defined in the dtsi:
> >                 gcr: system-controller@f0800000 {
> >                         compatible = "nuvoton,npcm845-gcr", "syscon";
> >                         reg = <0x0 0xf0800000 0x0 0x1000>;
> >                 };
> >>
> >> Please provide address map description to convince us that this is
> >> correct HW representation.
> > GCR (sysgcr) registers 0xf0800000-0xf0801000 - used for miscellaneous
> > features, not only pin mux.
> > GPIO0 0xf0010000-0xf0011000
> > GPIO1 0xf0011000-0xf0012000
> > ...
> > GPIO7 0xf0017000-0xf0018000
> >>
>
> Then why your pinctrl is in sysgcr IO range? (pinctrl@f0800000)
you suggest using pinctrl@0 or pinctrl@f0010000 and not
pinctrl@f0800000 because 0xf0800000 is the GCR address that serve
miscellaneous features and not only pinmux controller ?
>
> Your map looks quite different from what you described in example.
>
> Best regards,
> Krzysztof

Best regards,

Tomer
