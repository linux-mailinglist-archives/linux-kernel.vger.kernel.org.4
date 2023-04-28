Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1475C6F1FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbjD1Uxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbjD1Uxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:53:45 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14AF1719;
        Fri, 28 Apr 2023 13:53:43 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-76dae081228so157133241.2;
        Fri, 28 Apr 2023 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682715223; x=1685307223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRYO52blVuIjsOSLyVlbkequxT+e3yW4z+4sA1lzj5A=;
        b=H7ejqF0RJ8HO9k7UgwEUKBPHQSgxcDlr/xgGbySmFBJfc7ChK3pRNPbBX9fC2E+Rkf
         e6fcW1/saGQbRiFSZz8b5VHp4i07vnC9gqt/qE9DFsTwD8v0cBzKYHTp3/mLTr6CHbNO
         rL8KnMqahFyapQXK48UzpDTILsnyJ/KmE6kHKMTBMdTu1ELDLIdFbqawdATU1hfNXBTQ
         eGX1YN1RLbvnQnF8gaekFxMo1LQNvieeIEkWepQN0dH3OhvLN/GlUCfiRtC4ntPPV6WU
         gdSIqqCTYXekgtXCV6RNxE+N6gdQR1fXyNGDB1Dj6qEw+c6v1k/Bf1NxEuikJW5wTYRL
         dHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682715223; x=1685307223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRYO52blVuIjsOSLyVlbkequxT+e3yW4z+4sA1lzj5A=;
        b=Vo+9hTSLaJKLLVGOLPIok8AuGVuMvlpE0frFhpvj3kOCXL60w5SPAIsTzzxFXB6LXW
         OtbTVYOJJMkMTJYGErtwcVfRjIT9w6YcsKIFL5Pnh7+8J5rmqunnO7hJ9qTzfNDd+q8w
         RLZOMkxA7tKS3wwrhFtp/qi9VLKEViBcNAhigIpVReRkNFfIVKVp6Ag59YFllGm3Bwd3
         5Qbrvfndj5ppUvN3SBPhHfdD9M4EmVnS32aoTfp68LUtgstzX2tHr2yyMK9ORhX++je9
         T45lgSjK9/EjjxgQ1Mf7eNE3TgBbyxyRrpgyRsFuNnehl43de4lUNjJYY4tLOHJn5d5k
         GFIg==
X-Gm-Message-State: AC+VfDyaLpuwTGJzRHc+m8W+Z+D8V8kVYfzu4iywMP0JT/sZrrb5TQUf
        77vr3hOFsNHM4a89zy9nySgHcfjv1AczDdTHqeA=
X-Google-Smtp-Source: ACHHUZ5dtyhB7wkfx17vKwIAdsNhr1LLTqVEcPSLcN60jFiC6cARjWzhVpel3Qnfv1+NnkX+H+VZ1lJMZ57FK7zzUio=
X-Received: by 2002:a1f:41c9:0:b0:43f:ec5d:51e1 with SMTP id
 o192-20020a1f41c9000000b0043fec5d51e1mr3235818vka.9.1682715222835; Fri, 28
 Apr 2023 13:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230428105453.110254-1-jpanis@baylibre.com> <CAOCHtYgKfJ4cXULvs8YrJ6+-UnrbBWQgXL+d6OMHOOexuj4uiQ@mail.gmail.com>
In-Reply-To: <CAOCHtYgKfJ4cXULvs8YrJ6+-UnrbBWQgXL+d6OMHOOexuj4uiQ@mail.gmail.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Fri, 28 Apr 2023 15:53:16 -0500
Message-ID: <CAOCHtYgreXmtcuRDRu3UWRhPJ0-k2E+3YYhxp_AaPf-sObuR1Q@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: Add am335x-boneblack-pps.dts
To:     Julien Panis <jpanis@baylibre.com>
Cc:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 9:44=E2=80=AFAM Robert Nelson <robertcnelson@gmail.=
com> wrote:
>
> On Fri, Apr 28, 2023 at 6:00=E2=80=AFAM Julien Panis <jpanis@baylibre.com=
> wrote:
> >
> > From: Lokesh Vutla <lokeshvutla@ti.com>
> >
> > Add a new am335x-boneblack-pps.dts that can be used to configure TIMER7
> > in PWM mode. This PWM signal can be used as a PPS signal when
> > synchronized to PTP clock. Typically this synchronization is done by a
> > userspace program. This PPS signal can be observed on pin P8.8.
> >
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > ---
> >  arch/arm/boot/dts/Makefile                 |  1 +
> >  arch/arm/boot/dts/am335x-boneblack-pps.dts | 25 ++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/am335x-boneblack-pps.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index efe4152e5846..d74158aae72d 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -939,6 +939,7 @@ dtb-$(CONFIG_SOC_AM33XX) +=3D \
> >         am335x-base0033.dtb \
> >         am335x-bone.dtb \
> >         am335x-boneblack.dtb \
> > +       am335x-boneblack-pps.dtb \
> >         am335x-boneblack-wireless.dtb \
> >         am335x-boneblue.dtb \
> >         am335x-bonegreen.dtb \
> > diff --git a/arch/arm/boot/dts/am335x-boneblack-pps.dts b/arch/arm/boot=
/dts/am335x-boneblack-pps.dts
> > new file mode 100644
> > index 000000000000..88d2bc3fd759
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/am335x-boneblack-pps.dts
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.c=
om/
> > + */
> > +
> > +#include "am335x-boneblack.dts"
> > +
> > +&am33xx_pinmux {
> > +       pwm7_pins: pinmux_pwm7_pins {
> > +               pinctrl-single,pins =3D <
> > +                       AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUT=
PUT_PULLDOWN, MUX_MODE2)
> > +               >;
> > +       };
> > +};
> > +
> > +/{
> > +       pwm7: dmtimer-pwm7 {
> > +               compatible =3D "ti,omap-dmtimer-pwm";
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pwm7_pins>;
> > +               #pwm-cells =3D <3>;
> > +               ti,timers =3D <&timer7>;
> > +               ti,clock-source =3D <0x00>; /* timer_sys_ck */
> > +       };
> > +};
>
> I know this commit is pretty small, but mainline now has overlay support:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D0fff0e49d72a53c51d8903fbadb2e6a84e531c4a
>
> At what point do we finally merge in the many dozen *BeagleBone*
> overlays, or do we still wait for :
> https://lore.kernel.org/lkml/20220328000915.15041-1-ansuelsmth@gmail.com/

OH SIde note, #2... thanks @Nishanth Menon !

We do have this example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8e01fb15b8157a825d309ea2598b494dd81a7b42

So instead of `am335x-boneblack-pps.dtb` it could be: ....
am335x-bone-dmtimer-pwm7.dtbo or even am335x-dmtimer-pwm7.dtbo ?

Thoughts?

--=20
Robert Nelson
https://rcn-ee.com/
