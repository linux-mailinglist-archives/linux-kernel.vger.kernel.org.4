Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4AE5BDEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiITH7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiITH73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:59:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DE61112;
        Tue, 20 Sep 2022 00:59:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w8so2378914lft.12;
        Tue, 20 Sep 2022 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xi4J48eyVp3XBTnULXOJWqnXSkoDp8ND1IDB0SNIHaE=;
        b=gf8qkEuX/8rcMT+OVpDYVHbtPPXG48oysNuDVSfNrus2fDKGlifxfMDPP0BxX4rzm/
         mvNgpi5wttjVEZp5SiM05XiZNMSlBRS5WmWUbKspSqf8mQgeGcFdZKG//0mfGAzvrrfY
         uCVFyKvXsKzVXN+OMjC7SFbhl/wQ9RL8UFq45yM2jfP9pO/y74/T40GTxdF4xKE55XHW
         SSPlzMRs2oCPg+k7GVT1bhs56PNIbSSoxV2kgXC+6ohq2nXWh3VXAp42AxFNzeODG2wZ
         wDvY3zC9r3xAPFgPocPJp/pY7Jve1rd+YgdT0gKK8zgQyEWrzTkKDnZA1Jbs0b/lZrab
         h5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xi4J48eyVp3XBTnULXOJWqnXSkoDp8ND1IDB0SNIHaE=;
        b=gkSDciCCQNnpQcx6JNiut+RmUoEW55h+yCuq36ZzDwCcvSwMy7m4g+8WaEwMkUtTM5
         TGhhZsCKT5GhMbK9Iy4WJ7iGlj4NL/DzIIxJdvukjtvqUeBcr6dCnziNJVat9l4nC78k
         n14koDy40jjoO9uwihRL4XGUjUnDnE6zzJg5DSJ1RJ8/wTiOs9HyaGCdREUcLcdJBx5v
         UEUFILZhNI0EwCvrqj+ZAsdIvgPrY9+amcfLeRYy/fRcaY6xA+eteD5HYdpcfltzMUUF
         ipx+zac6lvAWEN5r5nyfacUfhJACQqwhB9GwELH7sl/cpfysg1o19B+3O5fB4NaWuAyO
         ljzQ==
X-Gm-Message-State: ACrzQf34d1Z+yAfVN0xLEWcm6zKkfWLE3iif1sUDOq7iwMpqy/fcmhd7
        HU3FRtRNLnmY0pz3Qjl1vrK6uoBcV8F2Q360vi2f1a3Ddec=
X-Google-Smtp-Source: AMsMyM6jwmAgf6JVkGoyng4BC6Sn/3ffWQfWLkLl/CA+/fv09157gUqekt913KGzQ9CVd9Wp4vN3fy5b8MjFnrwMzGg=
X-Received: by 2002:a05:6512:694:b0:498:ff40:24e with SMTP id
 t20-20020a056512069400b00498ff40024emr7016041lfe.265.1663660764492; Tue, 20
 Sep 2022 00:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220714122322.63663-1-tmaimon77@gmail.com> <20220714122322.63663-2-tmaimon77@gmail.com>
 <20220718211046.GA3547663-robh@kernel.org> <CAP6Zq1hQ5m2kkQOKaYsKhPQhCW+vdsdyPRxxb_yRGMB=gJCPdw@mail.gmail.com>
 <3981e6e8-d4bb-b13d-7aaa-7aea83ffaad9@linaro.org> <CAP6Zq1gp1ph1wixgb6nL+2R8We2YJ2HQM2iC05itq_XWd2Cwig@mail.gmail.com>
 <bfca0379-7346-13e7-a18f-66740c5871b3@linaro.org>
In-Reply-To: <bfca0379-7346-13e7-a18f-66740c5871b3@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 20 Sep 2022 10:59:12 +0300
Message-ID: <CAP6Zq1gyDW8ZwwAZ1jyfNEZa09WN-biZZJY8tBmW_gzMzpj3ZA@mail.gmail.com>
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

On Mon, 19 Sept 2022 at 19:06, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/09/2022 16:31, Tomer Maimon wrote:
> >>>>> +examples:
> >>>>> +  - |
> >>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>>>> +    #include <dt-bindings/gpio/gpio.h>
> >>>>> +
> >>>>> +    soc {
> >>>>> +      #address-cells = <2>;
> >>>>> +      #size-cells = <2>;
> >>>>> +
> >>>>> +      pinctrl: pinctrl@f0800000 {
> >>>>> +        compatible = "nuvoton,npcm845-pinctrl";
> >>>>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> >>>>> +        #address-cells = <1>;
> >>>>> +        #size-cells = <1>;
> >>>>> +        nuvoton,sysgcr = <&gcr>;
> >>>>> +
> >>>>> +        gpio0: gpio@f0010000 {
> >>>>
> >>>> gpio@0
> >>>>
> >>>> Is this really a child block of the pinctrl? Doesn't really look like it
> >>>> based on addressess. Where are the pinctrl registers? In the sysgcr? If
> >>>> so, then pinctrl should be a child of it. But that doesn't really work
> >>>> too well with gpio child nodes...
> >>> the pin controller mux is handled by sysgcr this is why the sysgcr in
> >>> the mother node,
> >>> and the pin configuration are handled by the GPIO registers.  each
> >>> GPIO bank (child) contains 32 GPIO.
> >>> this is why the GPIO is the child node.
> >>
> >> Then maybe pinctrl should be the sysgcr and expose regmap for other devices?
> > The pin controller using the sysgcr to handle the pinmux, this is why
> > the sysgcr is in the mother node, is it problematic?
>
> You said pin-controller mux registers are in sysgcr, so it should not be
> used via syscon.
Sorry but maybe I missed something.
the sysgcr is used for miscellaneous features and not only for the pin
controller mux, this is why it used syscon and defined in the dtsi:
                gcr: system-controller@f0800000 {
                        compatible = "nuvoton,npcm845-gcr", "syscon";
                        reg = <0x0 0xf0800000 0x0 0x1000>;
                };
>
> Please provide address map description to convince us that this is
> correct HW representation.
GCR (sysgcr) registers 0xf0800000-0xf0801000 - used for miscellaneous
features, not only pin mux.
GPIO0 0xf0010000-0xf0011000
GPIO1 0xf0011000-0xf0012000
...
GPIO7 0xf0017000-0xf0018000
>
> Best regards,
> Krzysztof

Best regards,

Tomer
