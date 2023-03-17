Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2B6BF0BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCQSbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCQSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:31:44 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C6D4AFC2;
        Fri, 17 Mar 2023 11:31:42 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p203so6684938ybb.13;
        Fri, 17 Mar 2023 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679077902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvJ70W31eDPBtGDHoN0dzmi83vmZajj1b0iRIfuS03Y=;
        b=jmKdJM6f8PDERiOtpMu1id19q+4IxichfhRBZJesSGpYuNotT/6XnOnA+hgfrS4K1E
         ltxutcIo5C4wdfTZ5FZs3+YP7V3YmUwF8BcGlRGPmrgAfqcvjspG896N+Co8W3DK4rwD
         ouE6bo6drRML/2N7tb4fen267q7V+PzK7XFEKrVHWhoocWNOg80UKMNCazkA7p7nzzcj
         NC0Bou7Dx9Gxd/VAlkZR1cIGjLuH83tEB21Rb5kd15ojz5ghHx3Tu86Gk9R3pqwEisq7
         Qq5clh/wOIHlFF+aCnrur0mW3AgS0q9L2U2ghKzXOX8lg9yupKfN5WyjVtPDb2zQiAMb
         /CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679077902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvJ70W31eDPBtGDHoN0dzmi83vmZajj1b0iRIfuS03Y=;
        b=7mSUEQtZH7giLly/CArPdwPjF6io73BjszN2BONLgCDMu53BJNES0y0JnWa1bTYe+v
         ImqUjS6ebodOS2MdZaWT3WrXshtddDpscEb7CoIgbe/4EY5kV258eYas9c6iXHrqfAxu
         GYXtR9vgtIlhztzJrsuZejlPzaX6f0s9CFZhI/z4EmOVtIBcfI5dwQjCRUgJ+69RBKA+
         rjRfLB/PZEJlEwmImbdOrwnlBxNbOlsJh/A8XSLD05Nh0p2QZspLJe2YwHmEUv+6vw1d
         lvuvR6A3qLzLXKOo5JSrFiBy1boJxAH4tn6Ppzyuu7XrMvAetIHJQPFwAqSO08lnc5xw
         1Zdg==
X-Gm-Message-State: AO0yUKX3/b/qXGLT8S+YayMakM5lN1ZRBbTWXARxRdZpmlIOI7Bpa+J2
        sS9ul6JcxZSrwizvXMmQFNmx1UxmYJWQLLsLMqE=
X-Google-Smtp-Source: AK7set95lw36pV9wpSdvM3RdFH/9Jn4PZZTKxs7PXXkh5kb5tY7xddMq54lT1HoQZAOwfpcjtbFy30OHTjTSE1JNHEI=
X-Received: by 2002:a25:d4e:0:b0:9fc:e3d7:d60f with SMTP id
 75-20020a250d4e000000b009fce3d7d60fmr320384ybn.5.1679077901938; Fri, 17 Mar
 2023 11:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230317123314.145121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230317123314.145121-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <TYCPR01MB10588B29A18ABE00374AD07A3B7BD9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB10588B29A18ABE00374AD07A3B7BD9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 17 Mar 2023 18:31:15 +0000
Message-ID: <CA+V-a8sOib64rA3YRkHa3X-SiSpnn70QJK6DDqg7pX05X2phFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support
To:     Chris Paterson <Chris.Paterson2@renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Chris,

Thank you for the review.

On Fri, Mar 17, 2023 at 6:03=E2=80=AFPM Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello Prabhakar,
>
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 17 March 2023 12:33
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable CRU, CSI on RZ/G2L SMARC EVK and tie the CSI to OV5645 sensor
> > using Device Tree overlay. rz-smarc-cru-csi-ov5645.dtsi is created so
> > that RZ/G2L alike EVKs can make use of it.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > setenv bootfile kernel_fdt.itb
> > tftpboot ${bootfile}
> > bootm ${fileaddr}#rzg2l-smarc#ov5645
> >
> > v1->v2
> > * New patch
> > ---
> >  arch/arm64/boot/dts/renesas/Makefile          |  1 +
> >  .../r9a07g044l2-smarc-cru-csi-ov5645.dtso     | 18 ++++
> >  .../dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  | 87 +++++++++++++++++++
> >  3 files changed, 106 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-
> > csi-ov5645.dtso
> >  create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-
> > ov5645.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/renesas/Makefile
> > b/arch/arm64/boot/dts/renesas/Makefile
> > index 23b10c03091c..a553d99175cb 100644
> > --- a/arch/arm64/boot/dts/renesas/Makefile
> > +++ b/arch/arm64/boot/dts/renesas/Makefile
> > @@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_R9A07G043) +=3D r9a07g043u11-
> > smarc.dtb
> >
> >  dtb-$(CONFIG_ARCH_R9A07G044) +=3D r9a07g044c2-smarc.dtb
> >  dtb-$(CONFIG_ARCH_R9A07G044) +=3D r9a07g044l2-smarc.dtb
> > +dtb-$(CONFIG_ARCH_R9A07G044) +=3D r9a07g044l2-smarc-cru-csi-
> > ov5645.dtbo
> >
> >  dtb-$(CONFIG_ARCH_R9A07G054) +=3D r9a07g054l2-smarc.dtb
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-
> > ov5645.dtso b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-
> > ov5645.dtso
> > new file mode 100644
> > index 000000000000..40cece1491bb
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
> > @@ -0,0 +1,18 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree overlay for the RZ/G2L SMARC EVK with OV5645 camera
> > + * connected to CSI and CRU enabled.
> > + *
> > + * Copyright (C) 2023 Renesas Electronics Corp.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +#define OV5645_PARENT_I2C i2c0
> > +#include "rz-smarc-cru-csi-ov5645.dtsi"
> > +
> > +&ov5645 {
> > +     enable-gpios =3D <&pinctrl RZG2L_GPIO(2, 0) GPIO_ACTIVE_HIGH>;
> > +     reset-gpios =3D <&pinctrl RZG2L_GPIO(40, 2) GPIO_ACTIVE_LOW>;
> > +};
> > diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
> > b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
> > new file mode 100644
> > index 000000000000..95286bf2066e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Common Device Tree for the RZ/G2L SMARC EVK (and alike EVKs) with
> > + * OV5645 camera connected to CSI and CRU enabled.
> > + *
> > + * Copyright (C) 2023 Renesas Electronics Corp.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
The above two lines are not required here.

> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
>
> Are either of these includes used in this file?
> Or should they move to the overlay?
>
Good catch, yes they need to be moved into the overlay file instead.

Cheers,
Prabhakar
