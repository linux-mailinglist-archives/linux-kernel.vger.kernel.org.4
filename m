Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6263572B659
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 06:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjFLETZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 00:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjFLETP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:19:15 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7816191
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 21:19:13 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7872d7b79e1so1348324241.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 21:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686543553; x=1689135553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx4A9BRCU5ewwPpFw/JvRMN4CrH9JPsLaa0C+hCjD+Y=;
        b=AcG+MhTDVeUFw4VgkcXc0mpFQ3IAONDKChX7lRw6JIQY1yg1g1jUs/J9O435mpT8Yz
         X7qLcMoYlrx9ohXPuaczYZh4MOc7TkYBmSv0aTH2QLRYbk7eVwK5tYkad8eIAoM9d5BL
         ResEYYXio0Y8u1ZMQRSpZZBV3LD0nO3gXsS+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686543553; x=1689135553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx4A9BRCU5ewwPpFw/JvRMN4CrH9JPsLaa0C+hCjD+Y=;
        b=bSLMOEGKfX14FUr9A4fjmvoNi0EqGq0IvEr1fKztXNlxHFt+fYu3GZ0qC4f++MFJ+D
         D/Fs2pZJcACtIJ8NqheM+5/PsZBxgAP8JFJnRuIRTHYsIwHvJQmxjHX1SxQ3jLRiLoxk
         JYGUb7qlr8ZdGZOWodWl4qan6U09wOopxWHG+Cxuifd/59ClsEaZAHx+ILW6b4mhS93z
         hfhuPwC2zEtfVumEJRwxjBhb2o0x+pzc7svcYZfLeo65JshTX+y3zS1mD3ShsK6artQR
         AIEhUl8ynZmBGYCEKS7RFdytsNVOyE8FAezXcUOb8Lim0LGyi+Spi1qOhyb+dvH5Orc9
         m8Zg==
X-Gm-Message-State: AC+VfDy8e4OFcT9EZDdUhbqOQeSq2iLbYd91+rUj3yzwza3fHigJLPmu
        IsHChD/BAx6FnjMA9aHkzEVIhMvI6BXVvwgrPS/zdQ==
X-Google-Smtp-Source: ACHHUZ7GUwr6bdnwq9l8jrJ309lzC37SEuo4ApxJy/OUKal08YzmCu7Lw9vdjA0is+QWvB7/BTx9pND+LImnXeU/8w8=
X-Received: by 2002:a67:f60c:0:b0:43d:c290:bac with SMTP id
 k12-20020a67f60c000000b0043dc2900bacmr3111512vso.15.1686543552928; Sun, 11
 Jun 2023 21:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230609083009.2822259-1-wenst@chromium.org> <20230609083009.2822259-4-wenst@chromium.org>
 <20230609-unpaved-propeller-b361fba89913@spud> <20230610-bucket-rebuttal-c7c44c5b0a66@spud>
In-Reply-To: <20230610-bucket-rebuttal-c7c44c5b0a66@spud>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jun 2023 12:19:01 +0800
Message-ID: <CAGXv+5EcXW8P-EuWZp4MFUFAjaNTzEtRP_d8bkrFyPdq2k2Bqw@mail.gmail.com>
Subject: Re: [PATCH 3/9] regulator: mt6358: Merge VCN33_* regulators
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 11:28=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, Jun 09, 2023 at 04:56:05PM +0100, Conor Dooley wrote:
> > On Fri, Jun 09, 2023 at 04:30:00PM +0800, Chen-Yu Tsai wrote:
> > > The VCN33_BT and VCN33_WIFI regulators are actually the same regulato=
r,
> > > having the same voltage setting and output pin. There are simply two
> > > enable bits that are ORed together to enable the regulator.
> > >
> > > Having two regulators representing the same output pin is misleading
> > > from a design matching standpoint, and also error-prone in driver
> > > implementations. If consumers try to set different voltages on either
> > > regulator, the one set later would override the one set before. There
> > > are ways around this, such as chaining them together and having the
> > > downstream one act as a switch. But given there's only one output pin=
,
> > > such a workaround doesn't match reality.
> > >
> > > Remove the VCN33_WIFI regulator. During the probe phase, have the dri=
ver
> > > sync the enable status of VCN33_WIFI to VCN33_BT. Also drop the suffi=
x
> > > so that the regulator name matches the pin name in the datasheet.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > >  drivers/regulator/mt6358-regulator.c       | 65 +++++++++++++++++---=
--
> > >  include/linux/regulator/mt6358-regulator.h |  6 +-
> > >  2 files changed, 52 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator=
/mt6358-regulator.c
> > > index c9e16bd092f6..faf6b0757019 100644
> > > --- a/drivers/regulator/mt6358-regulator.c
> > > +++ b/drivers/regulator/mt6358-regulator.c
> > > @@ -277,7 +277,7 @@ static const unsigned int vcama_voltages[] =3D {
> > >     2800000, 2900000, 3000000,
> > >  };
> > >
> > > -static const unsigned int vcn33_bt_wifi_voltages[] =3D {
> > > +static const unsigned int vcn33_voltages[] =3D {
> > >     3300000, 3400000, 3500000,
> > >  };
> > >
> > > @@ -321,7 +321,7 @@ static const u32 vcama_idx[] =3D {
> > >     0, 7, 9, 10, 11, 12,
> > >  };
> > >
> > > -static const u32 vcn33_bt_wifi_idx[] =3D {
> > > +static const u32 vcn33_idx[] =3D {
> > >     1, 2, 3,
> > >  };
> > >
> > > @@ -566,12 +566,8 @@ static struct mt6358_regulator_info mt6358_regul=
ators[] =3D {
> > >                MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf=
00),
> > >     MT6358_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
> > >                MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> > > -   MT6358_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> > > -              vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> > > -              0, MT6358_VCN33_ANA_CON0, 0x300),
> > > -   MT6358_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
> > > -              vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> > > -              0, MT6358_VCN33_ANA_CON0, 0x300),
> > > +   MT6358_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> > > +              MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x3=
00),
> >
> > Excuse me if I am being daft here, but could you explain how this chang=
e
> > is compatible with existing devicetrees?
>
> Ah, I see in the binding commit there's a "Luckily no device tree actuall=
y
> uses them." Does that just cover the kernel, or does it consider other
> operating systems/bootloaders?

That comment covers the upstream kernel and the downstream ChromeOS kernel
specifically. The bootloader that ChromeOS uses (coreboot) doesn't use
device trees. I don't know what MediaTek uses for their phones though.

AFAIK MediaTek only supports the Linux kernel, be it for Android or ChromeO=
S.
There's not a large community around it, unlike some of the other ARM SoCs.

I did find an old v4.4 Android kernel [1] for the MediaTek Helio P60
(MT6771) that is also paired with MT6358. There are no device tree
references to the VCN33 regulator either. Only the definition exists
in the mt6358.dtsi file, much like what we have upstream.

As far as the regulator driver goes, if it can't find a matching regulator
node, it's the same as if the node doesn't exist, and therefore the given
constraints are not ingested. If no constraints are ingested that can
turn it on, and no consumer references to enable it either, we can say
that the regulator is effectively unused.

ChenYu

[1] https://github.com/nokia-dev/android_kernel_nokia_mt6771
