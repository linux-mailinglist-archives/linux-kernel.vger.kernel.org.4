Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8946C9441
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjCZMbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCZMbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:31:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6D76B1;
        Sun, 26 Mar 2023 05:31:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so3492993wmq.3;
        Sun, 26 Mar 2023 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679833899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoHL+pdwMo9hK8zxjS4mzFQRPu/UQKxxXEvDJq+ttZY=;
        b=AHKGIITCXHyXB1joXi2mO29w1R5+PifrXllUXZVc0AXlX/A9TFLc8uXPOAVrm06FnO
         WmRtzCW+i1bEKLjrVuohAxJhvtIH1AHPV/wUO1SI2U7IAG1i7AVNubRNHraIAt4xP1I7
         A3LLTzKsCm8/ljK9MRgyQJmJZV0VJZ3a0f69cLf52j6WBXrZ9Vm4h5CLk0X39AxoMSmJ
         7XKNadTm5wrLsfUS/uhfdIU9rK1zUw5cGQfCLJya49etN1Kah7yLAiLVSRA+aksUytWQ
         eanlbyUJcpstxaB7g20CYZ2Sc0ZfTKQzjY7td1KZJHZ8X+AyHs7rvSOtoYYIWkkB6Pzj
         WmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679833899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoHL+pdwMo9hK8zxjS4mzFQRPu/UQKxxXEvDJq+ttZY=;
        b=hi2icrl0agRd/e4GVA3UVWteisE9N4sTbIfaeL6dzw8B9h00kfOaJvpe0iDNFex3yr
         5MMZQb49LyqX0rT0DMca2FAqL9Ht0Dd+LxIE82lsXRizcUxcSDgco2BaymOrztPzhBJJ
         +ogHt+obqER0Kbflvs6zw3aOhGoxKpimLVylPb5Q6bmwTtNVFr6PVV/2N9mf20Nn+4RU
         g9u5SoJfaWHOcllQu4f2Cbx0vlrm7LY2aEJv8NibxRIp7+SBgsUP+y/jOx//EqA/oXCD
         PYdaW8Ajr8PoEINJVeNPJOsHovQT5elQtUp8zk41L/49UpYkNZ8tvNeHWVbqA0fQXYUu
         cBZg==
X-Gm-Message-State: AO0yUKVczu58OyWnmxXM6SkClLssyzQNHc6yIc+9qSTIyhx5jhv9tlbm
        6bJZuFJHA3cwG1VDyQV+T9zkOh15gKqixGawS5E06L88ZOTx0w==
X-Google-Smtp-Source: AK7set9bo+NQ4ZSXBRygc8+jzXxsPq5IhJ/ncMbKfrksS/ZYnL/J2wrqhLdwDQIlTm9fbmduw6PyoZGbjwnjUenIVo4=
X-Received: by 2002:a05:600c:204:b0:3ea:8ed9:5f3e with SMTP id
 4-20020a05600c020400b003ea8ed95f3emr1641870wmi.4.1679833899099; Sun, 26 Mar
 2023 05:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230326001535.149539-1-bigbeeshane@gmail.com> <a5966d2b-3e8f-3518-8f71-a4ed8de4b725@linaro.org>
In-Reply-To: <a5966d2b-3e8f-3518-8f71-a4ed8de4b725@linaro.org>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Sun, 26 Mar 2023 13:31:28 +0100
Message-ID: <CABnpCuD4GYyTkdV1UZjMXFmkXfY77bhgvyE-F2xA6e+DW_STEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: Add basic NanoPi R6S (RK3588S) Support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Missing bindings documentation.

> Please run scripts/checkpatch.pl and fix reported warnings.

Sorry I was missing the DTS bindings patch, will send that
one over this evening

On Sun, Mar 26, 2023 at 10:38=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/03/2023 01:15, Shane Francis wrote:
> > This adds basic support for the NanoPi R6S SBC
> >
> > Currently working :
> >   - UART
> >   - mmc storage (internal)
> >   - RGMII / GMAC 1Gb ethernet
> >   - SYS LED
> >
> > Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 126 ++++++++++++++++++
> >  2 files changed, 127 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
> > index 99a44c400d6a..39cad757d29d 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -91,3 +91,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-edgeble-neu6a=
-io.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-evb1-v10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-rock-5b.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-rock-5a.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-nanopi-r6s.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch=
/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> > new file mode 100644
> > index 000000000000..21b26539a855
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> > @@ -0,0 +1,126 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include "rk3588s.dtsi"
> > +
> > +/ {
> > +     model =3D "NanoPi R6S - RK3588S";
> > +     compatible =3D "friendlyelec,nanopi6", "rockchip,rk3588";
>
> Missing bindings documentation.
>
> Please run scripts/checkpatch.pl and fix reported warnings.
>
> Best regards,
> Krzysztof
>
