Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9049B5BE1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiITJ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiITJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:27:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F536B160;
        Tue, 20 Sep 2022 02:27:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u18so2746807lfo.8;
        Tue, 20 Sep 2022 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pbBbo0wS9RefiKHJAHea5Z+uUoKrx1Fu0kwL/SMeV7A=;
        b=dbQD2A90p/pP5WBHjfMv0TH9z9lfoSt8o998wRryLQ//wjxln1WnlY2wsOldM0mqoV
         Jyv0ntKQKJKv7ASQtHmJcrpdj+VMjDHbJVe0pu0DBWoZ47b0GzUimsdDwStoWScTm+oJ
         1h4KXWswd31nsQvElNONF2ft8gf9PHmAHp1+2p8utzLECIFqYsmfT5BxDrx/BkY9pGJD
         rmUZ02vWWN1ceRA6Y1a04QrTk03JLD5TZYga5wdsgpROTIZk2esKRtM8GHEAR6Nw2mPl
         mOyOVbeLXHjjs8jSjR16d6NYYXk6dNQlrj/a4mDFSy3IUUDm4G1Z9vUZMriPL/cXSXgS
         KHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pbBbo0wS9RefiKHJAHea5Z+uUoKrx1Fu0kwL/SMeV7A=;
        b=WCsDrfuSTa5NlEY16s/UMc60rAR81HLsLLPpDCX1XcuxeZbEPIUzHV82i8VCB0RMUL
         Z52lzXHOZp05k0uUAXiIuuxguFVnAB2SITqYTmaBi3RWIfTgYnodNKxtVWUKRBfFXGjr
         MC/KvLe71Fbwrh0/448epW7+/1LkcGOpE+CieVa7TuTcCdGnlkyddOCAmRv5fvumnNGp
         2KB3Nst0HmUKSyEeOV7sEBUAvRBvQtcAI6fttUmNlXCLehyWG01Gv8GFm08s2U7LjXVa
         cjaZU9MLHC0QjhyyrS9OeNZBHKKoFb18La3qiX9jI9u66n/ULW5F2WeYhIgDr+SKRhBS
         y5JQ==
X-Gm-Message-State: ACrzQf3kDy9wMTnlukDq9qeC4EUAMRcJw4xRYJciBBCxg/5Wc5VqIroN
        zeaPbckk/Y2o6zeNcUnxcyTB5RLAVKZ2uPkSgcI=
X-Google-Smtp-Source: AMsMyM70HRwyDNrlVbW7+24P1AAAdcmQVe1pXn7jxUKJU8FIZ1qCXCRkPEcX29c+JjYMwTHerlG/q4VaiNhf4j5TjAE=
X-Received: by 2002:a05:6512:2592:b0:49c:53de:7eb8 with SMTP id
 bf18-20020a056512259200b0049c53de7eb8mr7346350lfb.401.1663666058396; Tue, 20
 Sep 2022 02:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220714122322.63663-1-tmaimon77@gmail.com> <20220714122322.63663-2-tmaimon77@gmail.com>
 <20220718211046.GA3547663-robh@kernel.org> <CAP6Zq1hQ5m2kkQOKaYsKhPQhCW+vdsdyPRxxb_yRGMB=gJCPdw@mail.gmail.com>
 <3981e6e8-d4bb-b13d-7aaa-7aea83ffaad9@linaro.org> <CAP6Zq1gp1ph1wixgb6nL+2R8We2YJ2HQM2iC05itq_XWd2Cwig@mail.gmail.com>
 <bfca0379-7346-13e7-a18f-66740c5871b3@linaro.org> <CAP6Zq1gyDW8ZwwAZ1jyfNEZa09WN-biZZJY8tBmW_gzMzpj3ZA@mail.gmail.com>
 <2b0e6e33-ef76-4bd4-8894-53f9a3fe68b4@linaro.org> <CAP6Zq1iwW6HvvfM684VLG0ZT-0OLKT0udW4bHxsZsTMEypo2sg@mail.gmail.com>
 <6f1ad082-74e4-e4e7-9304-5cdd95cc9f66@linaro.org>
In-Reply-To: <6f1ad082-74e4-e4e7-9304-5cdd95cc9f66@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 20 Sep 2022 12:27:26 +0300
Message-ID: <CAP6Zq1hTS7mVWvYWfTwWvrZibKMpW5r7=wE6W9uETb=aS6MTuA@mail.gmail.com>
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

On Tue, 20 Sept 2022 at 11:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/09/2022 10:32, Tomer Maimon wrote:
> > On Tue, 20 Sept 2022 at 11:21, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 20/09/2022 09:59, Tomer Maimon wrote:
> >>>>>>>>> +      pinctrl: pinctrl@f0800000 {
> >>>>>>>>> +        compatible = "nuvoton,npcm845-pinctrl";
> >>>>>>>>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> >>>>>>>>> +        #address-cells = <1>;
> >>>>>>>>> +        #size-cells = <1>;
> >>>>>>>>> +        nuvoton,sysgcr = <&gcr>;
> >>>>>>>>> +
> >>>>>>>>> +        gpio0: gpio@f0010000 {
> >>>>>>>>
> >>>>>>>> gpio@0
> >>>>>>>>
> >>>>>>>> Is this really a child block of the pinctrl? Doesn't really look like it
> >>>>>>>> based on addressess. Where are the pinctrl registers? In the sysgcr? If
> >>>>>>>> so, then pinctrl should be a child of it. But that doesn't really work
> >>>>>>>> too well with gpio child nodes...
> >>>>>>> the pin controller mux is handled by sysgcr this is why the sysgcr in
> >>>>>>> the mother node,
> >>>>>>> and the pin configuration are handled by the GPIO registers.  each
> >>>>>>> GPIO bank (child) contains 32 GPIO.
> >>>>>>> this is why the GPIO is the child node.
> >>>>>>
> >>>>>> Then maybe pinctrl should be the sysgcr and expose regmap for other devices?
> >>>>> The pin controller using the sysgcr to handle the pinmux, this is why
> >>>>> the sysgcr is in the mother node, is it problematic?
> >>>>
> >>>> You said pin-controller mux registers are in sysgcr, so it should not be
> >>>> used via syscon.
> >>> Sorry but maybe I missed something.
> >>> the sysgcr is used for miscellaneous features and not only for the pin
> >>> controller mux, this is why it used syscon and defined in the dtsi:
> >>>                 gcr: system-controller@f0800000 {
> >>>                         compatible = "nuvoton,npcm845-gcr", "syscon";
> >>>                         reg = <0x0 0xf0800000 0x0 0x1000>;
> >>>                 };
> >>>>
> >>>> Please provide address map description to convince us that this is
> >>>> correct HW representation.
> >>> GCR (sysgcr) registers 0xf0800000-0xf0801000 - used for miscellaneous
> >>> features, not only pin mux.
> >>> GPIO0 0xf0010000-0xf0011000
> >>> GPIO1 0xf0011000-0xf0012000
> >>> ...
> >>> GPIO7 0xf0017000-0xf0018000
> >>>>
> >>
> >> Then why your pinctrl is in sysgcr IO range? (pinctrl@f0800000)
> > you suggest using pinctrl@0 or pinctrl@f0010000 and not
> > pinctrl@f0800000 because 0xf0800000 is the GCR address that serve
> > miscellaneous features and not only pinmux controller ?
>
> If you have a map like you pasted, then DTS like this:
>
> syscon@f0800000 {}
> pinctrl@f0800000 {
>   gpio@f0010000 {}
> }
>
> Is quite weird, don't you think? You have two devices on the same unit
> address which is not allowed. You have child of pinctrl with entirely
O.K.
> different unit address, so how is it its child?
The pinctrl node name will modify the pinctrl@f0010000 the same as the
range property and the start of the child registers,is it fine?
> Best regards,
> Krzysztof

Best regards,

Tomer
