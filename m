Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA5A675095
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjATJTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjATJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:19:07 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB54234;
        Fri, 20 Jan 2023 01:19:00 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id q21so2255735vka.3;
        Fri, 20 Jan 2023 01:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TrvMULsU18Bu3BY2RUS8Z8PS61YAToCk0gnu/tBfqKU=;
        b=JDSa4MbFBLFrbjWGX07pR8bRrM6Smgyo+MW0T0GKQNKSaDsVBevDCJg3XYQm4OG8lS
         EmCiDicO1DaEW2XLnuMe7uCbw9/yyvlRYN+c1oK9IBB82t10ekQTtNPDLOKVkig6c4te
         g5hIvNt5BdQYaGZApuNOw9UQMmMDiM6dq8h+Xwi3xqYU6p+uGWz3geC6n26ZM3Gw3/hl
         tjNTML8Oq49orUqyXtlqfRdPqbu7XoEGW+ewmZWRMQLjwD4D3ju1QleebKFYRaQwjUS8
         F0J9KkVZyQDj2IQSo9Aqfod+TbWCD55X03SEXoMwLqgiKZ92ZkfWqE/1dvQxUZ7N0Mvv
         53rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrvMULsU18Bu3BY2RUS8Z8PS61YAToCk0gnu/tBfqKU=;
        b=iXShKut45syr3x+nTC4xGNvzQF2rXIp/XYwgkdStl32LGoMJkGpUItkOtixDDCCnep
         hMxF+BB35fyWW+/ZKdUxYyki70iJis2TWU6PKfTFK/Jm39++uKPNVyMsxqfu/8AQckwg
         LqsjqAAAL52XudZKXsoJTGUiE6B+uhhxqo4i0HC2n7Q4RqUhfvQvNXZmRvQiqyl8MxrB
         n10dXb50wHq344QkDST6Iv39px1WH2pdujou1wfdn291GRTR3geRy9Scx4Fr6LHrA7Oa
         TfLlyAjUqzBp8WGvRYuvGtwgeeHyZb11IEdeyAa4EID2LITbAMHuExZSvhwxyKDC38ED
         qOEQ==
X-Gm-Message-State: AFqh2koex1eLmNROjin7TxmPaSNuUd7cu/q0Kgs2ds8j91Re6Qywi05R
        ukaWaG2HZpcfw+O7ucjFscaZ8ra4r6LE9RVd5k/eCfdhd8ZM9KQN
X-Google-Smtp-Source: AMrXdXtKloAl6sin5GFcLRJ0IANFLHRQ9RU1HfNrza2nDdEx82Yvt43ehV8TBm7nngOwimBp+cp88qqxWXus6383538=
X-Received: by 2002:a05:6122:924:b0:3d5:5f93:53f with SMTP id
 j36-20020a056122092400b003d55f93053fmr1881746vka.7.1674206339845; Fri, 20 Jan
 2023 01:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20221220112927.440506-1-alistair@alistair23.me>
 <20221220112927.440506-4-alistair@alistair23.me> <20221220131715.femjybikqcnm4lyg@pengutronix.de>
 <CAKmqyKO-Qw3AihUnF7np7_6kr6-ODnXU3aBwph-_9=xSbXRx-Q@mail.gmail.com> <CANhJrGOtZZEG0mdVeQTQ=HDB3bUT2kkGbMxbqcvZc_gb_aNETA@mail.gmail.com>
In-Reply-To: <CANhJrGOtZZEG0mdVeQTQ=HDB3bUT2kkGbMxbqcvZc_gb_aNETA@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 20 Jan 2023 19:17:00 +1000
Message-ID: <CAKmqyKMvSYr6WiVrvQWCWeiYF3R-VJmfuwxXczyE9j4QnYB_KA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, linux@armlinux.org.uk, jernej.skrabec@gmail.com,
        kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 5:13 AM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> ma 9. tammik. 2023 klo 14.32 Alistair Francis (alistair23@gmail.com) kirjoitti:
> >
> > On Tue, Dec 20, 2022 at 11:17 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >
> > > Hi Alistair,
> > >
> > > thanks for your patch, please see below.
> > >
> > > On 22-12-20, Alistair Francis wrote:
> > > > Add support for the rohm,bd71815 power controller controller for the
> > > > reMarkable 2.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > ---
> > > >  arch/arm/boot/dts/imx7d-remarkable2.dts | 159 ++++++++++++++++++++++++
> > > >  1 file changed, 159 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > index a138b292ec6a..4387d30d6180 100644
> > > > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > @@ -92,6 +92,10 @@ wifi_pwrseq: wifi_pwrseq {
> > > >       };
> > > >  };
> > > >
> > > > +&cpu0 {
> > > > +     cpu-supply = <&buck1_reg>;
> > > > +};
> > > > +
> > > >  &clks {
> > > >       assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
> > > >                         <&clks IMX7D_CLKO2_ROOT_DIV>;
> > > > @@ -119,6 +123,148 @@ wacom_digitizer: digitizer@9 {
> > > >       };
> > > >  };
> > > >
> > > > +&i2c2 {
> > > > +     clock-frequency = <100000>;
> > >
> > > We can set this now to 400kHz since the driver can handle quirks now
> > > internal.
> >
> > After a discussion on the first patch I'm going to leave this as is.
> > Let me know if you do want me to change it.
> >
> > >
> > > > +     pinctrl-names = "default", "sleep";
> > > > +     pinctrl-0 = <&pinctrl_i2c2>;
> > > > +     pinctrl-1 = <&pinctrl_i2c2>;
> > >
> > > Do we need a "sleep" config here since this will be the same
> > > configuration as the "default" one.
> >
> > Nope, dropped.
> >
> > >
> > > > +     status = "okay";
> > > > +
> > > > +     bd71815: pmic@4b {
> > > > +             compatible = "rohm,bd71815";
> > > > +             reg = <0x4b>;
> > > > +             pinctrl-names = "default";
> > > > +             pinctrl-0 = <&pinctrl_bd71815>;
> > > > +             interrupt-parent = <&gpio6>; /* PMIC_INT_B GPIO6_IO16 */
> > > > +             interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> > > > +             gpio-controller;
> > > > +             clocks = <&clks IMX7D_CLKO2_ROOT_SRC>;
> > > > +             clock-output-names = "bd71815-32k-out";
> > > > +             #clock-cells = <0>;
> > > > +             #gpio-cells = <1>;
> > > > +
> > > > +             regulators {
> > > > +                     #address-cells = <1>;
> > > > +                     #size-cells = <0>;
> > > > +
> > > > +                     buck1_reg: regulator@0 {
> > > > +                             reg = <0>;
> > > > +                             regulator-compatible = "buck1";
> > > > +                             regulator-min-microvolt = <800000>;
> > > > +                             regulator-max-microvolt = <2000000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                             regulator-ramp-delay = <1250>;
> > > > +                     };
> > > > +
> > > > +                     buck2_reg: regulator@1 {
> > > > +                             reg = <1>;
> > > > +                             regulator-compatible = "buck2";
> > > > +                             regulator-min-microvolt = <800000>;
> > > > +                             regulator-max-microvolt = <2000000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                             regulator-ramp-delay = <1250>;
> > > > +                     };
> > > > +
> > > > +                     buck3_reg: regulator@2 {
> > > > +                             reg = <2>;
> > > > +                             regulator-compatible = "buck3";
> > > > +                             regulator-min-microvolt = <1200000>;
> > > > +                             regulator-max-microvolt = <2700000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     buck4_reg: regulator@3 {
> > > > +                             reg = <3>;
> > > > +                             regulator-compatible = "buck4";
> > > > +                             regulator-min-microvolt = <1100000>;
> > > > +                             regulator-max-microvolt = <1850000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     buck5_reg: regulator@4 {
> > > > +                             reg = <4>;
> > > > +                             regulator-compatible = "buck5";
> > > > +                             regulator-min-microvolt = <1800000>;
> > > > +                             regulator-max-microvolt = <3300000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     ldo1_reg: regulator@5 {
> > > > +                             reg = <5>;
> > > > +                             regulator-compatible = "ldo1";
> > > > +                             regulator-min-microvolt = <800000>;
> > > > +                             regulator-max-microvolt = <3300000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     ldo2_reg: regulator@6 {
> > > > +                             reg = <6>;
> > > > +                             regulator-compatible = "ldo2";
> > > > +                             regulator-min-microvolt = <800000>;
> > > > +                             regulator-max-microvolt = <3300000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     ldo3_reg: regulator@7 {
> > > > +                             reg = <7>;
> > > > +                             regulator-compatible = "ldo3";
> > > > +                             regulator-min-microvolt = <800000>;
> > > > +                             regulator-max-microvolt = <3300000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     ldo4_reg: regulator@8 {
> > > > +                             reg = <8>;
> > > > +                             regulator-compatible = "ldo4";
> > > > +                             regulator-min-microvolt = <800000>;
> > > > +                             regulator-max-microvolt = <3300000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     ldo5_reg: regulator@9 {
> > > > +                             reg = <9>;
> > > > +                             regulator-compatible = "ldo5";
> > > > +                             regulator-min-microvolt = <800000>;
> > > > +                             regulator-max-microvolt = <3300000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     dvref_reg: regulator@a {
> > > > +                             reg = <0xa>;
> > > > +                             regulator-compatible = "dvref";
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     lpsr_reg: regulator@b {
> > > > +                             reg = <0xb>;
> > > > +                             regulator-compatible = "lpsr";
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > > > +
> > > > +                     wled_reg: regulator@c {
> > > > +                             reg = <0xc>;
> > > > +                             regulator-compatible = "wled";
> > > > +                             regulator-min-microamp = <10>;
> > > > +                             regulator-max-microamp = <25000>;
> > > > +                             regulator-boot-on;
> > > > +                             regulator-always-on;
> > > > +                     };
> > >
> > > Note: You have marked all regulators as always on, this is rather
> > > suboptimal due to power consumption.
> >
> > Good point. The power consumption is already pretty bad, as mainline
> > doesn't support the i.MX deep sleep. As I know this works I'd like to
> > keep it as is. I'll test to see if removing them doesn't break
> > anything and then send a follow up patch.
>
> I'd like to suggest also seeing what removing the "regulator-boot-on"
> causes. As far as I understand, the "regulator-boot-on" mainly (only?)
> intended to be used in situations where the regulator state can not be
> reliably read from the hardware at the boot-up. AFAIR, unlike the
> BD71837 and BD71847,
> the BD71815 does not have this limitation. (This is just my
> understanding - which is based on some age-old discussions with Mark
> Brown - hence this comment is just a suggestion to try this while
> testing, not a comment intended to be demanding for a change)

I have tried removing both "regulator-boot-on" and "regulator-always-on".

After one boot to userspace (where the display didn't work correctly)
the device now seems to not power up at all. Even u-boot is failing to
start. I'm not sure if the regulators are now in some strange state or
if something is fried.

I'm currently waiting for the battery to discharge to see if that helps.

Alistair

>
> Yours
>     Matti
>
> --
>
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
> Discuss - Estimate - Plan - Report and finally accomplish this:
> void do_work(int time) __attribute__ ((const));
