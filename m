Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70421652886
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiLTVry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLTVrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:47:48 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418DB867
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:47:47 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id r204so6399032vkf.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VhZgaicca9LJo+DcaX0+4mdob/y6A/dlgKOdUG8hAQ8=;
        b=EDJt3mLQj1WwTJ31Q6XEL5N7U3t3sJCRSw5Gl+XLC+KJrTSm5kPmgNu1r+geG53I1w
         dZ4ZdF4Uq5McPr5gRJFnoSVpx2RwRF0hKtABLwjJ6UjO1q1aQ4nnGoNsFIUu948Hh6Ql
         TI6D7O7W9TOHkpwmeB5w+jD4UgEc2VmtX9ereM4H4PQdelRY/7S16ZHiOGqZ+FzzwMKU
         oYBiri4PKyBJW9oYimO1afyXI17pZowy4QySimCq0r3xgmMZczmQ9dQfNMnYzeKaIdrD
         2nma3SQy0teE60eQphOA3jMXOanP8r1SAWAtxQIPRYAAJfFloko2ZbgpH2lPRaV+M6n4
         nM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhZgaicca9LJo+DcaX0+4mdob/y6A/dlgKOdUG8hAQ8=;
        b=ERithkZ2uBRuiLqZFko0NE0YpFi7ipPS1owxoAqJqUf40q3gGbqLv7RlqW3IHABCHv
         alupW8D+UveaoTaXPLPVnTBP6E+VV/T9vlSkPsl9d5J7EV1/El0NK6Ai/xaQePZftWMa
         biTvnauupmQEDufsGf0Fv/cfiV5bqJRIDQT1YByJd7dh80kcK+KsWbnAdzoxP0upw3Up
         yQoP8ITZWZaoFoTfEiV4ZnGjAzHx8D7NYcwiGtsVYmCW8w9+9Hq0gpsM8wCR3rJQeces
         66vFR0tnD5OberHFhnfaLSPsPQLl2cH1mY5ucw4IIn+r0B1OO2Ubbw+viKYw0Velqa0J
         E+7g==
X-Gm-Message-State: AFqh2koHB5KWIFAzFRfCspA+r446Xm6+j764/ubmmdnHsSbq5es70Gos
        rDoqWOY55BYR7E7KEKNfRNLsOosVXvJu3sfh829I/w==
X-Google-Smtp-Source: AMrXdXt121kbSX/DN1gbxAGQs1zdX6/46XJEuREBUk/e9/77sXOnjAs85qH1gLyo4Ed2wpSZsPW8gyKMsUixPohw24Q=
X-Received: by 2002:a05:6122:2cd:b0:3c8:f99f:1934 with SMTP id
 k13-20020a05612202cd00b003c8f99f1934mr2557502vki.28.1671572866443; Tue, 20
 Dec 2022 13:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com> <20221220000457.1163446-2-jcormier@criticallink.com>
 <e0f620b4-5780-fbea-4446-fd68f281281a@linaro.org> <CADL8D3YUzgk+H70wEG1Qfq-kcn_csUdJyRg2rWfraVb3JsEa_g@mail.gmail.com>
 <20221220144656.GA3748047@roeck-us.net>
In-Reply-To: <20221220144656.GA3748047@roeck-us.net>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Tue, 20 Dec 2022 16:47:34 -0500
Message-ID: <CADL8D3bRFdj0FL41xNc+sdH515sEyxH5Uk-g+n5rpyKck_ES7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: hwmon: adi,ltc2945: Add binding
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay so for V3, I see only 2 changes. Please let me know if I've
overlooked something else.
- Remove "Also adds shunt-resistor-micro-ohms parameter" from commit description
- Remove extra newline from binding doc

Resending in plaintext...


On Tue, Dec 20, 2022 at 9:46 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Dec 20, 2022 at 09:35:38AM -0500, Jon Cormier wrote:
> > On Tue, Dec 20, 2022 at 5:15 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 20/12/2022 01:04, Cormier, Jonathan wrote:
> > > > Create initial binding for the LTC2945 I2C power monitor.
> > > > Also adds shunt-resistor-micro-ohms parameter
> > >
> > > The last sentence does not make sense. I propose to skip it.
> > Ok
> > >
> > > >
> > > > Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
> > > > ---
> > > >  .../bindings/hwmon/adi,ltc2945.yaml           | 50 +++++++++++++++++++
> > > >  1 file changed, 50 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> > > > new file mode 100644
> > > > index 000000000000..f90d40919ee6
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> > > > @@ -0,0 +1,50 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/hwmon/adi,ltc2945.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices LTC2945 wide range i2c power monitor
> > > > +
> > > > +maintainers:
> > > > +  - Guenter Roeck <linux@roeck-us.net>
> > >
> > > Maintainer of binding is person interested in the device, e.g. having
> > > the hardware or datasheet. Not the subsystem maintainer. Unless by
> > > coincidence this is the same person here?
> > What do you do with a basic kernel driver which hasn't been touched
> > since it was introduced except for various refactors? He seems to be
> > the one who introduced it and most consistently made changes to it.
>
> FWIW, if I was not ok with being listed as maintainer I would have objected.
>
> Having said that, it is just as fine with me to list someone else.
>
> Guenter
>
> > >
> > >
> > > > +
> > > > +description: |
> > > > +  Analog Devices LTC2945 wide range i2c power monitor over I2C.
> > > > +
> > > > +  https://www.analog.com/media/en/technical-documentation/data-sheets/LTC2945.pdf
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,ltc2945
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  shunt-resistor-micro-ohms:
> > > > +    description:
> > > > +      Shunt resistor value in micro-Ohms
> > > > +    default: 1000
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +
> > > This is a friendly reminder during the review process.
> > >
> > > It seems my previous comments were not fully addressed. Maybe my
> > > feedback got lost between the quotes, maybe you just forgot to apply it.
> > > Please go back to the previous discussion and either implement all
> > > requested changes or keep discussing them.
> > My bad,
> > >
> > > Thank you.
> > >
> > > > +additionalProperties: false
> > > > +
> > >
> > > Best regards,
> > > Krzysztof
> > >
> >
> >
> > --
> > Jonathan Cormier
> > Software Engineer
> >
> > Voice:  315.425.4045 x222
> >
> >
> >
> > http://www.CriticalLink.com
> > 6712 Brooklawn Parkway, Syracuse, NY 13211



-- 
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
