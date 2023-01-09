Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07355663012
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbjAITN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbjAITNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:13:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732396551;
        Mon,  9 Jan 2023 11:13:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so7816651wms.2;
        Mon, 09 Jan 2023 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f437fFKqvFXo6VszbTWcwAJ56dTSChA8DP9O0zZ9KwQ=;
        b=i1mw6ABlQnADe4eS3bWO+lCVWOij/bdci+9tDwvYNEoi/E2Gs9HPxtLndtATPKyNq7
         Xtgy4bODkY6gR37q8vt6P4oy+oE69nuGkxMg/HOcml5ptoQxotuKsbaVjpGkU98LipbH
         Bxeh0CIHHm/pvEtHfpwjvJ0x10L05zqO/uNi10v6bNM/KdMWuDgJsFj5PWdSK1HDYRJA
         Ksjkhr6ngTA3Ug3RMC1XfPnDZFoylfZmsP9brBYffMbpZGDkbCgL6rU+Zf5X8gUka8vU
         IH+Rafh928vkgTpPKDlW899zZ76J2im9R7W4C//hKhWSsq8DTVSi9W4Z5I7N8Fty4xXD
         7rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f437fFKqvFXo6VszbTWcwAJ56dTSChA8DP9O0zZ9KwQ=;
        b=FwpSNVu6+SnCu5LS3eTmLVhqiBG11yx03pxBOkuVSY+YtIiE0iqpSJgMdRYxogE7Cf
         s1c4wnQF9gzUGBGthnRBNXma8ja/n5+y/haWVy3oFZLU/cZS7elKDCQP653cQltZ+ZK8
         DQfIFudHKraOeh7vtnff9ZDTaNBAgMUyqihUtj0nkyANf6ssfITB19H3XZBxdQFIDJ7b
         ekBtx489+bg6FJgF7HBkuoeLuChKoHx7rxKhELd3K9aUtg8/NpN+kiXbeMoaG6kklqFN
         W0/+kiOPTuh7183VxJXN37ihoBH6KolQNq0gzdj/IAgKfauZG1XDKDxpYFNUdElA2uhT
         usdw==
X-Gm-Message-State: AFqh2koXVEva1isSZmG/zG9TMrzMfeSOWgTQ5UBFZ3to2/Zfo7kmeJko
        6U+Bg/xadRu6eFSRDR4mNMNdik/XXZNGOppzLeM=
X-Google-Smtp-Source: AMrXdXuwB0MvTYwUlQbVcPNLqZreoOs1VlkqVAFeFWWPfxcDsuRAY7R8nLnMQESw5kd8O85XQeDnlRKLTctrl2z7fYY=
X-Received: by 2002:a05:600c:4f48:b0:3cf:7b68:631 with SMTP id
 m8-20020a05600c4f4800b003cf7b680631mr2912878wmq.55.1673291624041; Mon, 09 Jan
 2023 11:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20221220112927.440506-1-alistair@alistair23.me>
 <20221220112927.440506-4-alistair@alistair23.me> <20221220131715.femjybikqcnm4lyg@pengutronix.de>
 <CAKmqyKO-Qw3AihUnF7np7_6kr6-ODnXU3aBwph-_9=xSbXRx-Q@mail.gmail.com>
In-Reply-To: <CAKmqyKO-Qw3AihUnF7np7_6kr6-ODnXU3aBwph-_9=xSbXRx-Q@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Mon, 9 Jan 2023 21:13:32 +0200
Message-ID: <CANhJrGOtZZEG0mdVeQTQ=HDB3bUT2kkGbMxbqcvZc_gb_aNETA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, linux@armlinux.org.uk, jernej.skrabec@gmail.com,
        kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ma 9. tammik. 2023 klo 14.32 Alistair Francis (alistair23@gmail.com) kirjoitti:
>
> On Tue, Dec 20, 2022 at 11:17 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Hi Alistair,
> >
> > thanks for your patch, please see below.
> >
> > On 22-12-20, Alistair Francis wrote:
> > > Add support for the rohm,bd71815 power controller controller for the
> > > reMarkable 2.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > ---
> > >  arch/arm/boot/dts/imx7d-remarkable2.dts | 159 ++++++++++++++++++++++++
> > >  1 file changed, 159 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > index a138b292ec6a..4387d30d6180 100644
> > > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > @@ -92,6 +92,10 @@ wifi_pwrseq: wifi_pwrseq {
> > >       };
> > >  };
> > >
> > > +&cpu0 {
> > > +     cpu-supply = <&buck1_reg>;
> > > +};
> > > +
> > >  &clks {
> > >       assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
> > >                         <&clks IMX7D_CLKO2_ROOT_DIV>;
> > > @@ -119,6 +123,148 @@ wacom_digitizer: digitizer@9 {
> > >       };
> > >  };
> > >
> > > +&i2c2 {
> > > +     clock-frequency = <100000>;
> >
> > We can set this now to 400kHz since the driver can handle quirks now
> > internal.
>
> After a discussion on the first patch I'm going to leave this as is.
> Let me know if you do want me to change it.
>
> >
> > > +     pinctrl-names = "default", "sleep";
> > > +     pinctrl-0 = <&pinctrl_i2c2>;
> > > +     pinctrl-1 = <&pinctrl_i2c2>;
> >
> > Do we need a "sleep" config here since this will be the same
> > configuration as the "default" one.
>
> Nope, dropped.
>
> >
> > > +     status = "okay";
> > > +
> > > +     bd71815: pmic@4b {
> > > +             compatible = "rohm,bd71815";
> > > +             reg = <0x4b>;
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_bd71815>;
> > > +             interrupt-parent = <&gpio6>; /* PMIC_INT_B GPIO6_IO16 */
> > > +             interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> > > +             gpio-controller;
> > > +             clocks = <&clks IMX7D_CLKO2_ROOT_SRC>;
> > > +             clock-output-names = "bd71815-32k-out";
> > > +             #clock-cells = <0>;
> > > +             #gpio-cells = <1>;
> > > +
> > > +             regulators {
> > > +                     #address-cells = <1>;
> > > +                     #size-cells = <0>;
> > > +
> > > +                     buck1_reg: regulator@0 {
> > > +                             reg = <0>;
> > > +                             regulator-compatible = "buck1";
> > > +                             regulator-min-microvolt = <800000>;
> > > +                             regulator-max-microvolt = <2000000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                             regulator-ramp-delay = <1250>;
> > > +                     };
> > > +
> > > +                     buck2_reg: regulator@1 {
> > > +                             reg = <1>;
> > > +                             regulator-compatible = "buck2";
> > > +                             regulator-min-microvolt = <800000>;
> > > +                             regulator-max-microvolt = <2000000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                             regulator-ramp-delay = <1250>;
> > > +                     };
> > > +
> > > +                     buck3_reg: regulator@2 {
> > > +                             reg = <2>;
> > > +                             regulator-compatible = "buck3";
> > > +                             regulator-min-microvolt = <1200000>;
> > > +                             regulator-max-microvolt = <2700000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     buck4_reg: regulator@3 {
> > > +                             reg = <3>;
> > > +                             regulator-compatible = "buck4";
> > > +                             regulator-min-microvolt = <1100000>;
> > > +                             regulator-max-microvolt = <1850000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     buck5_reg: regulator@4 {
> > > +                             reg = <4>;
> > > +                             regulator-compatible = "buck5";
> > > +                             regulator-min-microvolt = <1800000>;
> > > +                             regulator-max-microvolt = <3300000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     ldo1_reg: regulator@5 {
> > > +                             reg = <5>;
> > > +                             regulator-compatible = "ldo1";
> > > +                             regulator-min-microvolt = <800000>;
> > > +                             regulator-max-microvolt = <3300000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     ldo2_reg: regulator@6 {
> > > +                             reg = <6>;
> > > +                             regulator-compatible = "ldo2";
> > > +                             regulator-min-microvolt = <800000>;
> > > +                             regulator-max-microvolt = <3300000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     ldo3_reg: regulator@7 {
> > > +                             reg = <7>;
> > > +                             regulator-compatible = "ldo3";
> > > +                             regulator-min-microvolt = <800000>;
> > > +                             regulator-max-microvolt = <3300000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     ldo4_reg: regulator@8 {
> > > +                             reg = <8>;
> > > +                             regulator-compatible = "ldo4";
> > > +                             regulator-min-microvolt = <800000>;
> > > +                             regulator-max-microvolt = <3300000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     ldo5_reg: regulator@9 {
> > > +                             reg = <9>;
> > > +                             regulator-compatible = "ldo5";
> > > +                             regulator-min-microvolt = <800000>;
> > > +                             regulator-max-microvolt = <3300000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     dvref_reg: regulator@a {
> > > +                             reg = <0xa>;
> > > +                             regulator-compatible = "dvref";
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     lpsr_reg: regulator@b {
> > > +                             reg = <0xb>;
> > > +                             regulator-compatible = "lpsr";
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     wled_reg: regulator@c {
> > > +                             reg = <0xc>;
> > > +                             regulator-compatible = "wled";
> > > +                             regulator-min-microamp = <10>;
> > > +                             regulator-max-microamp = <25000>;
> > > +                             regulator-boot-on;
> > > +                             regulator-always-on;
> > > +                     };
> >
> > Note: You have marked all regulators as always on, this is rather
> > suboptimal due to power consumption.
>
> Good point. The power consumption is already pretty bad, as mainline
> doesn't support the i.MX deep sleep. As I know this works I'd like to
> keep it as is. I'll test to see if removing them doesn't break
> anything and then send a follow up patch.

I'd like to suggest also seeing what removing the "regulator-boot-on"
causes. As far as I understand, the "regulator-boot-on" mainly (only?)
intended to be used in situations where the regulator state can not be
reliably read from the hardware at the boot-up. AFAIR, unlike the
BD71837 and BD71847,
the BD71815 does not have this limitation. (This is just my
understanding - which is based on some age-old discussions with Mark
Brown - hence this comment is just a suggestion to try this while
testing, not a comment intended to be demanding for a change)

Yours
    Matti

-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
