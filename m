Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6C6B0501
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCHKwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCHKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:52:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C599D193E9;
        Wed,  8 Mar 2023 02:51:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so63815158edb.12;
        Wed, 08 Mar 2023 02:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678272717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIGXUdTyGYEAvfYauZes4mGKDsBm8GNHDJGq3IqAjjk=;
        b=Tj7F0uK3t9woK4ZprxGcmcrwOw1Lu/3uG0XuhEMc36FgsN+ZZLYXce9N3UrX5utBrF
         +DtMr9i42hjb86LZxqeOcQ23qpx6qzkbNyPJTFG9ovQPs/8YgcV45yawSjMNvO+IqpAM
         fnVeIhp8woIXjY+5w8eivTzMhjS/nkAWZFcRR5p3MlZ5QtBk/sNu9jLuO5BFAXA8HnbH
         yYicdKplEXVgnlDC7/QaFl6rjW6YEg5r/ehxHt8fkxHIhuDJpfigHsIMMZyJBicruP6H
         qSnJr6i6t4FE6Gs2kDByNyZOxYgk8yhRkmh1VRNF7dpsGxdvRQii19Y5sMCc0/9cD+y2
         A2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIGXUdTyGYEAvfYauZes4mGKDsBm8GNHDJGq3IqAjjk=;
        b=zFPHQxYtkZOOJ6tFPEsM84Qbl1Kn2zJgxEwd0Wp5KOJgOyOfCB1bO+CsgY4OkfsnP3
         LSWPulEOBzzzBnM0FOhDoubFTz0RqWLNTY4eniFvrJuPXajgAwGNPLxnDcmp84CfeEkm
         udy+0y4zIlNmtwfJTamJHntGq3cEvIGu9INUA9oz/I46wcY0cUUQvyrO3Wt48iqO2Exb
         QBPEPRpDiKSNsGVJL0OAMzUEgMKJlkbg2KI46egc/Q8ieZXG5RLLGAi0+sp0GQ+IkFwM
         wHpguw3oz9djLD4nwwzn10k2p8VXpGfhp9gemjLgOP2qJD8OBNW5KUh7QES+/tBckJ72
         iCmw==
X-Gm-Message-State: AO0yUKW+6YVAe7GyleWHHzBVdNrhN7+59sQdRxUHZMV/Xx/vIPe7fAwC
        yfy59BLiUWjZ/u8W1i6+dJQxB2J80IlnRwWP5W0=
X-Google-Smtp-Source: AK7set8LlXbfdxrATbhRJ12ZcNTUwoucTiN7KCHe7QE54jyOQI8UBMhkGFL/PitBXtsvvj8lVKXr/MzPAGAT4XRNzSc=
X-Received: by 2002:a50:d4c5:0:b0:4c0:71e6:9dc5 with SMTP id
 e5-20020a50d4c5000000b004c071e69dc5mr2678714edj.1.1678272717356; Wed, 08 Mar
 2023 02:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20230308084419.11934-1-clamor95@gmail.com> <20230308084419.11934-2-clamor95@gmail.com>
 <95fa5f0f-cf53-7a37-2170-98b81c0982f1@linaro.org> <CAPVz0n1QDFyHiGAa7UOuuwPiSH+ELiYNeO9-fxPWrOWkWqEuHg@mail.gmail.com>
 <bbc7c183-3f98-9ea4-d5e5-0d58dd65d416@linaro.org>
In-Reply-To: <bbc7c183-3f98-9ea4-d5e5-0d58dd65d416@linaro.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 12:51:46 +0200
Message-ID: <CAPVz0n3sKH_7x=aNVLaHVN0F1FWLVRW+MGoj9qBO9V=TDuv_jQ@mail.gmail.com>
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

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 12:44 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 08/03/2023 10:15, Svyatoslav Ryhel wrote:
>
> >> max17040 does not have ADC temperature input... so is it system
> >> configuration?
> >>
> >
> > yes, I own a device (LG Optimus Vu P895) which uses max17043
> > coupled with ADC thermal sensor
> >
> >>> +
> >>> +  io-channel-names:
> >>> +    items:
> >>> +      - const: temp
> >>
> >> Drop the names property, not needed for one item.
> >>
> >
> > Alright, but driver patch expects temp name. I will look if this
> > is adjustable.
>
> I think I saw cases without names.
>

There is no io-channel without a name. And io-channels are mostly used
by power supply devices.

> >
> >>> +
> >>>    wakeup-source:
> >>>      type: boolean
> >>>      description: |
> >>> @@ -95,3 +109,26 @@ examples:
> >>>          wakeup-source;
> >>>        };
> >>>      };
> >>> +  - |
> >>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>> +    i2c0 {
> >>> +      #address-cells =3D <1>;
> >>> +      #size-cells =3D <0>;
> >>> +
> >>> +      fuel-gauge@36 {
> >>> +        compatible =3D "maxim,max17043";
> >>> +        reg =3D <0x36>;
> >>> +
> >>> +        interrupt-parent =3D <&gpio>;
> >>> +        interrupts =3D <144 IRQ_TYPE_EDGE_FALLING>;
> >>> +
> >>> +        monitored-battery =3D <&battery>;
> >>> +        power-supplies =3D <&charger>;
> >>
> >> But here you suggests something else than VDD... The hardware does not
> >> take charger as input. It takes power supply - vdd.
> >>
> >
> > Power system allows passing properties from other power devices.
> > In this case battery health and status are passed from charger.
>
> So this is not an input to device? Then it does not really look like
> property of this hardware. Fuel gauge does not control the charger, also
> from system configuration point of view.
>

It is not controlling charger, the charger provides the status and
health of the battery to the fuel gauge. This option is also used in
other fuel gauges.

> Best regards,
> Krzysztof
>
