Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF746B056B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCHLHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCHLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:06:41 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587981E9E0;
        Wed,  8 Mar 2023 03:06:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ay14so60418826edb.11;
        Wed, 08 Mar 2023 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678273575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj1NSq9Hwkzbdc9qScfK7arGAJhtoW0osbkt6uKb2Pw=;
        b=KPiuPOm6CRMsvKwiRUFu+j8NOO3NZD0WQpIenOa6qSPk+zF34pE3144wXvVm2DdOPW
         vrwoWTPgOy04vk6MvIA8OkHjYxtgX+DbzNhL6kFtcTeahsY/OvA7nhDQZogOJdlLFLHL
         rDGiLeRZpDyUlHVxmBudrAoQ4ulVfi9lP9vuypzmeUsjW+176uFZ1VVn8uIObxLzPJQg
         5/4bW9aaW2RWxUM8TBn2ENz/QmNhwu1IslK9dX+Fx107XRAP83D52vhcujTO8h5qSxDv
         VwmFcV08FBvGip5Quc1cj/MmlWojzly1rvpiI9ELqzWCjdGpt1TCKislVDcVIE30j6lr
         Jp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj1NSq9Hwkzbdc9qScfK7arGAJhtoW0osbkt6uKb2Pw=;
        b=2HsPuGY2McCEbaD7QGYTh5D9/V2O4CcIqsgwf+q83uL5H7JQzIpFmTvDYEad9Lbcjm
         CrbSokRx7iJ8ccsHaozKgK1P5d1fXN7pEJHMp5AYoNhzZt89Cul/ZfgqhNBAN8rz8vV5
         +RZomOs1AciLmuuAjjPciJjFwaevh1bkTdJ0cdHZGd/1gfvEFKeiLj9jjx/V1tjms2bT
         iRGNbRLY5mpww2OYaGgSHH11nnHRUc7r2ti0bP3lovGkf2rzOHIiqe9Af2mmowVKS9TV
         Rr2jdmV72lSkGx2nhE2UYV4u/eV2cA2pxbfi5WMoVM8T02rTgShMzPmW+XNp9zU6fHK2
         /V4A==
X-Gm-Message-State: AO0yUKXyV/CBXNopgXVR45xmrpmAmEnn3+7hRRlZwe13ONWAMoKCGf2t
        vrZkhkYaFH0xbh1VbO2qn7fCiLCCEhSpgtkL+dE=
X-Google-Smtp-Source: AK7set+OxxQoP+4FRJyo8FEiebypka8/QpXT3Mczt/dBtgdG5Q2FsRLov82os55XmkE5NjqCqZVwYJf2Hf+2G0pGWis=
X-Received: by 2002:a17:906:274f:b0:8ec:793a:c3f6 with SMTP id
 a15-20020a170906274f00b008ec793ac3f6mr8315190ejd.11.1678273574904; Wed, 08
 Mar 2023 03:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20230308084419.11934-1-clamor95@gmail.com> <20230308084419.11934-2-clamor95@gmail.com>
 <95fa5f0f-cf53-7a37-2170-98b81c0982f1@linaro.org> <CAPVz0n1QDFyHiGAa7UOuuwPiSH+ELiYNeO9-fxPWrOWkWqEuHg@mail.gmail.com>
 <bbc7c183-3f98-9ea4-d5e5-0d58dd65d416@linaro.org> <CAPVz0n3sKH_7x=aNVLaHVN0F1FWLVRW+MGoj9qBO9V=TDuv_jQ@mail.gmail.com>
 <d0d0617d-8a2e-7a71-f4fe-f69896f84ede@linaro.org>
In-Reply-To: <d0d0617d-8a2e-7a71-f4fe-f69896f84ede@linaro.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 13:06:03 +0200
Message-ID: <CAPVz0n2XTJdSELoE9-P=r6ntAOT0PHEgoFTiyMz577z5wzF1QQ@mail.gmail.com>
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

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 12:53 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 08/03/2023 11:51, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 12:44 K=
rzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On 08/03/2023 10:15, Svyatoslav Ryhel wrote:
> >>
> >>>> max17040 does not have ADC temperature input... so is it system
> >>>> configuration?
> >>>>
> >>>
> >>> yes, I own a device (LG Optimus Vu P895) which uses max17043
> >>> coupled with ADC thermal sensor
> >>>
> >>>>> +
> >>>>> +  io-channel-names:
> >>>>> +    items:
> >>>>> +      - const: temp
> >>>>
> >>>> Drop the names property, not needed for one item.
> >>>>
> >>>
> >>> Alright, but driver patch expects temp name. I will look if this
> >>> is adjustable.
> >>
> >> I think I saw cases without names.
> >>
> >
> > There is no io-channel without a name. And io-channels are mostly used
> > by power supply devices.
> >
> >>>
> >>>>> +
> >>>>>    wakeup-source:
> >>>>>      type: boolean
> >>>>>      description: |
> >>>>> @@ -95,3 +109,26 @@ examples:
> >>>>>          wakeup-source;
> >>>>>        };
> >>>>>      };
> >>>>> +  - |
> >>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>>>> +    i2c0 {
> >>>>> +      #address-cells =3D <1>;
> >>>>> +      #size-cells =3D <0>;
> >>>>> +
> >>>>> +      fuel-gauge@36 {
> >>>>> +        compatible =3D "maxim,max17043";
> >>>>> +        reg =3D <0x36>;
> >>>>> +
> >>>>> +        interrupt-parent =3D <&gpio>;
> >>>>> +        interrupts =3D <144 IRQ_TYPE_EDGE_FALLING>;
> >>>>> +
> >>>>> +        monitored-battery =3D <&battery>;
> >>>>> +        power-supplies =3D <&charger>;
> >>>>
> >>>> But here you suggests something else than VDD... The hardware does n=
ot
> >>>> take charger as input. It takes power supply - vdd.
> >>>>
> >>>
> >>> Power system allows passing properties from other power devices.
> >>> In this case battery health and status are passed from charger.
> >>
> >> So this is not an input to device? Then it does not really look like
> >> property of this hardware. Fuel gauge does not control the charger, al=
so
> >> from system configuration point of view.
> >>
> >
> > It is not controlling charger, the charger provides the status and
> > health of the battery to the fuel gauge. This option is also used in
> > other fuel gauges.
>
> How regulator provides health and status of the battery? I don't understa=
nd.
>

It is not a regulator, it is a charger! Dedicated chip responsible for
controlling charging. And its configuration allows it to get battery
health and status, because this fuel gauge does not have this
function.

> Best regards,
> Krzysztof
>
