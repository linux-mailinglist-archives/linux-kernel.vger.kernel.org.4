Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633A6A10F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBWT7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBWT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:59:18 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9787F5BBA6;
        Thu, 23 Feb 2023 11:59:17 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d75so2741855qkg.0;
        Thu, 23 Feb 2023 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHJ2Tour39Pcu7rE3vk2406jNDGR2eEYkhY7MkBLAg0=;
        b=m2LOlCBLOGlzLHUrW1OWx6R5hNB3VgIh0/KOWRtRaJMB2lFLG+qDl0BvSKvqaNOHJU
         ZznAKgwqfnEaDSH9j2QBJ4YfaB6EeihTSr7yNnA5e4qg4JmmTRvE/pFF19Ze80UlFXS+
         slzdU4fNX9EO8MpcXIPUcZal29ORpyozGdT/6rrG907zhlcvOUS4RZGrWBpfUtFW+3Pv
         V0HZ90w96q/+z9PXgWUEAfi9LsOQubvZowr2xJnHnFQ9gmg6Knf2i8L5zEtIiD7/Y6LD
         D/iGJwtXWj0psx6ZbO0vtLamBqT3DpqspypiiRv8kHlyy6EI4OQlADbxcCagjWYpkMPl
         MlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHJ2Tour39Pcu7rE3vk2406jNDGR2eEYkhY7MkBLAg0=;
        b=Jigxpv+OGNxEXtLwmQfARKdtZUNK6Y97U4Ng67ms1umAzr4mI77LHj5Wxu9dQISCoi
         GdOM+38ruqwUAWDVTNWH/e7GWK8MebI5b+MViyWDPc4/ofkN6sMUp7txZMqu5e9lY3BN
         ug++jXPKDg+DhxxY2NsGWeoPTaA8PIi1s1BdITvUNs2JY0V2F93Dzx2bCmx4bcHptJ1n
         LqwgHpudnG65MjhFYk7d514x4mxM85JvidAsWgYqmb+ZAxSKmVHDPDIBOFZx8sTZdmPq
         2PmkeaHKLON3lPbauD9bNtD0ABw7Q5S3Bp4PTapFBtLi4Yn0lb5APIEYDjyX4evcyGyD
         BzSQ==
X-Gm-Message-State: AO0yUKXAhTTKP3hTDucX7AefE/Wcbv/X1JknYYLX5fJuQjNdu2jf1mth
        NdCVRrzFn44yzrtkPpg+ho+uuiaIPZY99gwsC48=
X-Google-Smtp-Source: AK7set+so9OMdRdcSDBk4ViAndEPGZmK0WgjxgFVFfenqAXN3P/gRNELprDwFf+g+yI2BGCZrVa+utw2kmmmgXt7YZg=
X-Received: by 2002:a37:78d:0:b0:742:5eae:2daa with SMTP id
 135-20020a37078d000000b007425eae2daamr451013qkh.10.1677182356665; Thu, 23 Feb
 2023 11:59:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
 <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com> <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Feb 2023 21:58:40 +0200
Message-ID: <CAHp75VdoUDMvVk1uMQcAKQteL6gbYGpoKpFn96ysdS81LjPGCQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:08 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>
> > > > +       npins =3D MLXBF3_GPIO_MAX_PINS_PER_BLOCK;
> > > > +       device_property_read_u32(dev, "npins", &npins);
> > >
> > > I don't see DT bindings for this property (being added in this series=
). Is it
> > already established one?
> > >
> > > Ah that=E2=80=99s my bad. The property should be called "ngpios" like=
 in the DT
> > documentation. Will fix.
> >
> > And why do you need it? What's a corner case that the GPIO library does=
n't
> > handle yet?
>
> We have 2 gpiochips, gpiochip 0 supports 32 gpio pins and gpiochip 1 supp=
orts only 24 pins.
> If I remove the logic from gpio-mlxbf3.c, the gpiolib.c logic will correc=
tly set the ngpios =3D 32 for gpiochip 0 but will wrongly set ngpios=3D32 f=
or gpiogchip 1:

So, either you need to have two entries in DT per chip or ngpios should be =
56.

--=20
With Best Regards,
Andy Shevchenko
