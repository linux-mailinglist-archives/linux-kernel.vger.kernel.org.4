Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6996F1AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbjD1OpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjD1OpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:45:13 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F291326A5;
        Fri, 28 Apr 2023 07:45:11 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-42e51230afcso8771137.0;
        Fri, 28 Apr 2023 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682693111; x=1685285111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WQK7u5uz2CHg54GpE0t/aU1Db+XDUfrdkRM7v2mYWI=;
        b=fFcZJGAwp++jtP0/hTAPabIKRlMdYbKEaaskT7cQ4sOzTrlDwNUfVIXI/fmOvgutu5
         B6TgJu/lKSKidAswj8BDo9ce/rQG34eTvZdL/Uv4U4R3AUNva2ekPXjDUcjg/2Y2Z1io
         8jks80r28IkYJC4lmq2U4njFm/eNPi/f5KT9aKJGivJdjueVp4+WGMnejjeiVwpACQ2D
         PS0rax6j0Dg9VvZa9pTco/YgNehFbvNdN4t6rTYm51lxaBgEKsfdllrWOVJR3ItvYlN1
         /a/b6eHrTdorKQI4ubJO9gLLKd4rvK5AY0JS/rWNBnRtVuPXd0H2SF+SSoUBXESvKah6
         l1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682693111; x=1685285111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WQK7u5uz2CHg54GpE0t/aU1Db+XDUfrdkRM7v2mYWI=;
        b=c0UBrsNkPg+wEvujAde39xFWfmzRAwYfwcXyt1+nOGmJdw8jAAgXHJZdIbidCmYe9+
         KkrqjPCmTV6dDxHv7rEyGasZDU6meMAi1IYnXcyNp/pAgidcHaRtbOCXlKGAsKvo5lNg
         yVTJ3lUq+bi/0GFigBW3aYwer2NFv3fzuPHFpd8UNGzeUjVFwZg0yI3lt/RFEAqF1SvH
         GbTW7VpupFttwH7Ji5f2M5+qHa9rjaO2Ke/YUkuFHzdLiVsu36gDcplln/kCw8PacMYr
         j6p3xqRYIBwKfjxAjRF3LAQ5UusI0+pzcX75eRcOYXrq2v/wp19h2edH1BKjL4YDBzgz
         S7lQ==
X-Gm-Message-State: AC+VfDwHZGvERRmXyvwCNnSo50CQvGsa13kbJ/WTb6qKRmWBtNqxuL0h
        Mt9iI3MdtwfijR9IPFu+REY7Pel8alubMlSj4T0=
X-Google-Smtp-Source: ACHHUZ6ddCrxyxsU99j9thZI4WCeWSX+BROb5gyuOULzRIorRvUiWvX8kw0ISJV+jvwxjANaJdUmLXEvnlyEu+VEQlc=
X-Received: by 2002:a67:f6c3:0:b0:42f:e7f3:923f with SMTP id
 v3-20020a67f6c3000000b0042fe7f3923fmr2816115vso.13.1682693110896; Fri, 28 Apr
 2023 07:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230428105453.110254-1-jpanis@baylibre.com>
In-Reply-To: <20230428105453.110254-1-jpanis@baylibre.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Fri, 28 Apr 2023 09:44:45 -0500
Message-ID: <CAOCHtYgKfJ4cXULvs8YrJ6+-UnrbBWQgXL+d6OMHOOexuj4uiQ@mail.gmail.com>
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

On Fri, Apr 28, 2023 at 6:00=E2=80=AFAM Julien Panis <jpanis@baylibre.com> =
wrote:
>
> From: Lokesh Vutla <lokeshvutla@ti.com>
>
> Add a new am335x-boneblack-pps.dts that can be used to configure TIMER7
> in PWM mode. This PWM signal can be used as a PPS signal when
> synchronized to PTP clock. Typically this synchronization is done by a
> userspace program. This PPS signal can be observed on pin P8.8.
>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  arch/arm/boot/dts/Makefile                 |  1 +
>  arch/arm/boot/dts/am335x-boneblack-pps.dts | 25 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-boneblack-pps.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index efe4152e5846..d74158aae72d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -939,6 +939,7 @@ dtb-$(CONFIG_SOC_AM33XX) +=3D \
>         am335x-base0033.dtb \
>         am335x-bone.dtb \
>         am335x-boneblack.dtb \
> +       am335x-boneblack-pps.dtb \
>         am335x-boneblack-wireless.dtb \
>         am335x-boneblue.dtb \
>         am335x-bonegreen.dtb \
> diff --git a/arch/arm/boot/dts/am335x-boneblack-pps.dts b/arch/arm/boot/d=
ts/am335x-boneblack-pps.dts
> new file mode 100644
> index 000000000000..88d2bc3fd759
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-boneblack-pps.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com=
/
> + */
> +
> +#include "am335x-boneblack.dts"
> +
> +&am33xx_pinmux {
> +       pwm7_pins: pinmux_pwm7_pins {
> +               pinctrl-single,pins =3D <
> +                       AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPU=
T_PULLDOWN, MUX_MODE2)
> +               >;
> +       };
> +};
> +
> +/{
> +       pwm7: dmtimer-pwm7 {
> +               compatible =3D "ti,omap-dmtimer-pwm";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pwm7_pins>;
> +               #pwm-cells =3D <3>;
> +               ti,timers =3D <&timer7>;
> +               ti,clock-source =3D <0x00>; /* timer_sys_ck */
> +       };
> +};

I know this commit is pretty small, but mainline now has overlay support:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D0fff0e49d72a53c51d8903fbadb2e6a84e531c4a

At what point do we finally merge in the many dozen *BeagleBone*
overlays, or do we still wait for :
https://lore.kernel.org/lkml/20220328000915.15041-1-ansuelsmth@gmail.com/

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
