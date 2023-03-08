Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005B36B02A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCHJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjCHJPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:15:18 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D418B3B3EB;
        Wed,  8 Mar 2023 01:15:16 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s11so62888368edy.8;
        Wed, 08 Mar 2023 01:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYU6xRrCo7Eg4hpvG3XnYtcuIZBEd0DQKy28YwzSQQk=;
        b=BVf2goqkrlUSEMtDBpvfeCdTaiRd9bxccoO+Rjo3QAZAamxoeWvvp/yx7POY3RKHsd
         3PCy3jFAApYZfvsqizHREi0dE6FpxyeBwnEquHb+IOL/fw5qpVL93x7lOS1AskM4mLo6
         rpkx3zG9tn8dEeUNjHlDmqutDlUcOrHTTpVG0WRvMQhpT5DPxTu/giPO2X1V5tk9zkF9
         5HoG4r/0GUjBU493cdqxQqfNGUQ2pB4RyAr1DEyKUPXPm+snWKg39b9cOKfuML/g8ZXo
         Ll9wnqB3dIaTyP4IFsOeXn0t3pGAwiqBtWjwL43tvL9OWYmLMuNA5tYxIJOTZDomQY15
         78Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYU6xRrCo7Eg4hpvG3XnYtcuIZBEd0DQKy28YwzSQQk=;
        b=dgaT2JfmzmDCy8BM7O10uE+BXDSb9NaKj/sR05/6UcNhksNTHMpi9mJBNfPPNx1sT6
         k0Y8WyM9rhcpHV+SsBmnj8+GBE8wYhsaIQYGJl9D04Z83ISxFN8TbuuA2CBc0jpxRs2e
         jG0TNxRuCBcHxzQ4zQzpzg3i+esdoOg66NafSaUfgcef1BHwmixKkD9vuQLDXZhfYjli
         JHypeE6KAH+RuYlxpLvcrN5EOnqTGTXJclWIjYpDIOd2TfAQrnJe+CDyBrsivcGHv+Cy
         B8JPSiKtdADl9uL5+5tKJho6tUfti4ejHp+YEHr4sNTIfH6BFEqU6Pj333fD4IID/Agg
         jkcg==
X-Gm-Message-State: AO0yUKU8eJ7MXvgnzqe0S6TkiiU8GSQE8KwICbmWi7R50lX9G9fB/x4m
        YHSnZTwX+OtqW33smlqTc01wJSOwaYnKBymflhUamT4g1Vq8tg==
X-Google-Smtp-Source: AK7set9NuxHx5r1ed+t/LZOyuUmXUIjveQgkGkdbiPTDl8JLn1WsDdd/qAkdEgg/CWChRn66jUlcaUs7AQiuSZIsTnY=
X-Received: by 2002:a17:906:f47:b0:877:747f:f6e5 with SMTP id
 h7-20020a1709060f4700b00877747ff6e5mr8304223ejj.11.1678266915351; Wed, 08 Mar
 2023 01:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20230308084419.11934-1-clamor95@gmail.com> <20230308084419.11934-2-clamor95@gmail.com>
 <95fa5f0f-cf53-7a37-2170-98b81c0982f1@linaro.org>
In-Reply-To: <95fa5f0f-cf53-7a37-2170-98b81c0982f1@linaro.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 11:15:04 +0200
Message-ID: <CAPVz0n1QDFyHiGAa7UOuuwPiSH+ELiYNeO9-fxPWrOWkWqEuHg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: power: supply: maxim,max17040: update properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 11:04 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 08/03/2023 09:44, Svyatoslav Ryhel wrote:
> > Add simple cell, status, health and temperature properties.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/power/supply/maxim,max17040.yaml | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17=
040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.ya=
ml
> > index 3a529326ecbd..6f1c25b4729f 100644
> > --- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yam=
l
> > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yam=
l
> > @@ -55,6 +55,20 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  monitored-battery:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle to the battery node being monitored
> > +
> > +  power-supplies: true
>
> This should be rather specific input name, e.g. vdd-supply.
>

it is not vdd it is actual charger device

> > +
> > +  io-channels:
> > +    items:
> > +      - description: battery temperature
>
>
>
> max17040 does not have ADC temperature input... so is it system
> configuration?
>

yes, I own a device (LG Optimus Vu P895) which uses max17043
coupled with ADC thermal sensor

> > +
> > +  io-channel-names:
> > +    items:
> > +      - const: temp
>
> Drop the names property, not needed for one item.
>

Alright, but driver patch expects temp name. I will look if this
is adjustable.

> > +
> >    wakeup-source:
> >      type: boolean
> >      description: |
> > @@ -95,3 +109,26 @@ examples:
> >          wakeup-source;
> >        };
> >      };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c0 {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      fuel-gauge@36 {
> > +        compatible =3D "maxim,max17043";
> > +        reg =3D <0x36>;
> > +
> > +        interrupt-parent =3D <&gpio>;
> > +        interrupts =3D <144 IRQ_TYPE_EDGE_FALLING>;
> > +
> > +        monitored-battery =3D <&battery>;
> > +        power-supplies =3D <&charger>;
>
> But here you suggests something else than VDD... The hardware does not
> take charger as input. It takes power supply - vdd.
>

Power system allows passing properties from other power devices.
In this case battery health and status are passed from charger.

> > +
> > +        io-channels =3D <&adc 8>;
>
> Just add these to existing example.
>

Not sure if it is a good idea, as you wish.

> > +        io-channel-names =3D "temp";
> > +
> > +        maxim,alert-low-soc-level =3D <10>;
> > +        wakeup-source;
> > +      };
> > +    };
>
> Best regards,
> Krzysztof
>

Best regards,
Svyatoslav R.
