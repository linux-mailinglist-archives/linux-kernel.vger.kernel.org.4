Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACEC652EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiLUJpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiLUJpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:45:00 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF391CB11;
        Wed, 21 Dec 2022 01:44:52 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id d2so9973084qvp.12;
        Wed, 21 Dec 2022 01:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTRZjVs+ZC10gzSWts1gaTVyTRmh0bhpzUVwXGomS1w=;
        b=eY2hF663BlPaZN1wWAX6Io9R1Scmlmn8/jVlfaBdk84Y0+DgZC/um30n67ZqkhPOZT
         H+p15ZbvBnwgtRQA7PSmS13BywkeRFvZIgawiqq45gbwziFeC/56QnxciRsn/791U4Li
         4aVrQ8NcQdXDOFz7RiXcP5wBz9ktQDiZxwpLE7a1e0OlAzSc/9+xBJ6o6A7ixW9MH2k6
         ja5+m0D4D96rWsgoQH3M5rJ2Y83NDJhadME23X8VQT3zmmrbz2dE5mu549JP2WoFh+LT
         yhBGXjnXEodpkq2APeDcmByTd0fuCkdDFtJJnO0+rR2B4vU5xMOhLAyo4pyCzDTjnxab
         k/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTRZjVs+ZC10gzSWts1gaTVyTRmh0bhpzUVwXGomS1w=;
        b=d2ayTbORw4AHCuB3bsw9xkZWHvY/rShMXyWBH+dECGvsslE5a/pm9fNL7svW/vOV3o
         G/iHgdAD8KszHJH5tgPxM1iBeKFOBsLObe53avMWtl+1vKnK8zd0wLrQ9F7a/enPzb4u
         fzSL3iqbfzWE8VY2cfj9R3/y09j7GQaRkoGwqsGKGkc7mjG4BYV3mXJqPXyjdhha/GGW
         ZLyqj4PYmZueRxItua/14DMw1C38tx+SIi1zg1DM94+XJ7+Q8oAfwGGIkXcUFnFfoHR7
         yLRl/Vrg+sVllmjFG4QZb5x1au0iEtfFOfB7v3XYytDPFbg9dlutYIPqFBtgyOC2/ICq
         1qmg==
X-Gm-Message-State: AFqh2krMgv037WjDF+NXNDsZ9/zynVY/FsXMPaHNRg9+cwvyAZcfRG3E
        DNCMab3yIlCU7KSFe51NDOWvfr4RQCwBBvqt30o=
X-Google-Smtp-Source: AMrXdXu704n6GIrHINsRbdHORuCEAF2r0AGnKH97K2Ba4BQmlgR92ssx33aWwW4mekPiUne5Nyzc85mc9Djn2Jo5z3M=
X-Received: by 2002:a05:6214:a91:b0:4bb:7998:fed6 with SMTP id
 ev17-20020a0562140a9100b004bb7998fed6mr52641qvb.86.1671615891052; Wed, 21 Dec
 2022 01:44:51 -0800 (PST)
MIME-Version: 1.0
References: <Y6KdvAlWLMG4whJh@VM-66-53-centos> <88357291-3cdd-8d5a-fdec-38bd081a4235@linaro.org>
In-Reply-To: <88357291-3cdd-8d5a-fdec-38bd081a4235@linaro.org>
From:   ty <zonyitoo@gmail.com>
Date:   Wed, 21 Dec 2022 17:44:40 +0800
Message-ID: <CAMmci2XmJ2kN=SBR=GHqDs+ZKhBO0dnjEsPCR_w7sjxNgi=_NQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: rockchip: Add EmbedFire LubanCat 1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
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

Dear Kozlowski,

Before making a new PATCH v5 with the whole .dts file, here is a small
patch base on the current v4.

This node name was missed in this PATCH.

---

@@ -74,7 +74,7 @@

     vin-supply =3D <&usb_5v>;

   };



-  vcc3v3_sys: vcc3v3-sys {

+  vcc3v3_sys: vcc3v3-sys-regulator {

     compatible =3D "regulator-fixed";

     regulator-name =3D "vcc3v3_sys";

     regulator-always-on;



Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
12=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=89 16:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On 21/12/2022 06:46, Yuteng Zhong wrote:
> > from: DHDAXCW <lasstp5011@gmail.com>
> >
> > LubanCat 1 is a Rockchip RK3566 SBC based
> > is developed by EmbedFire Electronics Co., Ltd.
> > Mini Linux Card Type Cheap Computer Development Board
> >
> > It has the following characteristics:
> > - MicroSD card slot, onboard eMMC flash memory
> > - 1GbE Realtek RTL8211F Ethernet Transceiver
> > - 1 USB Type-C port (power and USB2.0 OTG)
> > - 1 USB 3.0 Host port
> > - 3 USB 2.0 Host ports
> > - 1 HDMI
> > - 1 infrared receiver
> > - 1 MIPI DSI
> > - 1 MIPI CSI
> > - 1 x 4-section headphone jack
> > - Mini PCIe socket (USB or PCIe)
> > - 1 SIM Card slot
> > - 1 SYS LED and 1 PWR LED
> > - 40-pin GPIO expansion header
> >
> > Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> > Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> > ---
> >
> > Changed in V2:
> >   - Remove RNG node
> > Changed in V3:
> >   - Sent E-mail with a wrong attachment
> > Changed in V4:
> >   - Modify all node names
> >
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3566-lubancat-1.dts   | 598 ++++++++++++++++++
> >  2 files changed, 599 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
> > index 0a76a2ebb5f6..e52bda04d45a 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-soquartz-blad=
e.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-soquartz-cm4.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-soquartz-model-a.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-box-demo.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3566-lubancat-1.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-bpi-r2-pro.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-evb1-v10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-odroid-m1.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts b/arch/=
arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> > new file mode 100644
> > index 000000000000..443fcfabbd16
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> > @@ -0,0 +1,598 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > +* Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> > +*/
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include <dt-bindings/soc/rockchip,vop2.h>
> > +#include "rk3566.dtsi"
> > +
> > +/ {
> > +     model =3D "EmbedFire LubanCat 1";
> > +     compatible =3D "embedfire,lubancat-1", "rockchip,rk3566";
> > +
> > +     aliases {
> > +             ethernet0 =3D &gmac1;
> > +             mmc0 =3D &sdmmc0;
> > +             mmc1 =3D &sdhci;
> > +     };
> > +
> > +     chosen: chosen {
> > +             stdout-path =3D "serial2:1500000n8";
> > +     };
> > +
> > +     gmac1_clkin: external-gmac1-clock {
> > +             compatible =3D "fixed-clock";
> > +             clock-frequency =3D <125000000>;
> > +             clock-output-names =3D "gmac1_clkin";
> > +             #clock-cells =3D <0>;
> > +     };
> > +
> > +     hdmi-con {
> > +             compatible =3D "hdmi-connector";
> > +             type =3D "a";
> > +
> > +             port {
> > +                     hdmi_con_in: endpoint {
> > +                             remote-endpoint =3D <&hdmi_out_con>;
> > +                     };
> > +             };
> > +     };
> > +
> > +     gpio-leds {
> > +             compatible =3D "gpio-leds";
> > +
> > +             sys_led: sys-led {
> > +                     label =3D "sys_led";
> > +                     linux,default-trigger =3D "heartbeat";
> > +                     default-state =3D "on";
> > +                     gpios =3D <&gpio0 RK_PC5 GPIO_ACTIVE_LOW>;
> > +                     pinctrl-names =3D "default";
> > +                     pinctrl-0 =3D <&sys_led_pin>;
> > +             };
> > +     };
> > +
> > +     usb_5v: usb-5v-regulator {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "usb_5v";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +     };
> > +
> > +     vcc5v0_sys: vcc5v0-sys-regulator {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vcc5v0_sys";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             vin-supply =3D <&usb_5v>;
> > +     };
> > +
> > +     vcc3v3_sys: vcc3v3-sys {
>
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
> Thank you.
>
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vcc3v3_sys";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             vin-supply =3D <&vcc5v0_sys>;
> > +     };
> > +
> > +     vcc3v3_pcie: vcc3v3-pcie-regulator {
>
>
> Best regards,
> Krzysztof
>


--=20
Y. T. Zhong
Student of The University of Hong Kong, major in Computer Science.
E-mail: zonyitoo@gmail.com
