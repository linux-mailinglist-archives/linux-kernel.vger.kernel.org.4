Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4261F66252B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjAIMMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbjAIMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:12:17 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F243613D59;
        Mon,  9 Jan 2023 04:12:15 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id i188so8323988vsi.8;
        Mon, 09 Jan 2023 04:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wy1uKuARPQNLsUvgR4U41MvGrwqwLWtn+Ee7QUsOXw8=;
        b=S/F1dQPOcAiXwTKlcbuvU6DIADfIqdp0YUb/D2AKASIvdM42V5eaP9XNAF2TsSDak5
         bg2LXnbB36Qz5RtlqQgz8440vm7Ul86+78Wk/26Km4IyRUBZRty+V7k294k/NCOZkMTt
         T8SCWb/Idqws2O81JqKyBXQNLBnVdZ12KR4iggB7mXi4wd38XXXqsbDT4DL0IME2QJhJ
         vALwP73LcNWq8DrnzaUegnOlXs+RCt/FHYx45gZa8p/D8G6CJukvdEsWatV+GSQAGVSw
         eaUSJWYyr7t1D5Ttq4e2MLPGmPmel3T5BP0abDJVt8pQsvWXsO7oBywjAbKy84sK7xf5
         8ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wy1uKuARPQNLsUvgR4U41MvGrwqwLWtn+Ee7QUsOXw8=;
        b=CRmsXov3E1BB1VKww2T7ZCZLevbEgvWVB7ELXDvMFCFyaR5sB9BGbmC0ST+F6+oK/7
         kFpBhzBNRZyxfkrj0DVBz1TGfjRAz19Cj20a+26O5qeEWYT4zTTJsnd/NXFoFFd62zuJ
         C8U15gmh3km6q5F6JJhymSnLapu6ZFYxSvMxI78sc0apLGdLKhc7NtjC67l352Q3Wf70
         qD0imdMGy+NCIUkYjB0+4IIg1y5M8R6ClzCBbSVsE1K7PU+7k2RHsb873Fgkngcgx4nI
         19N7cNegzFtaZuLRqs8BVs/pt+DHe+DrHUl14NgkeVhMD8/tFEbBUQ5MMxhQjyvWJm37
         TdAg==
X-Gm-Message-State: AFqh2kqwwXhHMCiP2LS3bz3IC5o60fgAMlo6lCzfvnnYwkP+coeyRfs/
        yQC2k+PLW1igIkG8xuyaaoaB9CksP+jL/NJZvvJYNXFsngQ=
X-Google-Smtp-Source: AMrXdXs4B3IZuW4/ioHp1Tv0Za1G2dq9C62aG5qmySYkzH06QhQ5trpibgGw/8CSMQb8j/7Jjto5ZzjNYp30D77NGjY=
X-Received: by 2002:a05:6102:c4a:b0:3ce:f2da:96a with SMTP id
 y10-20020a0561020c4a00b003cef2da096amr1550916vss.64.1673266334966; Mon, 09
 Jan 2023 04:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20221220112927.440506-1-alistair@alistair23.me>
 <20221220112927.440506-4-alistair@alistair23.me> <20221220131715.femjybikqcnm4lyg@pengutronix.de>
In-Reply-To: <20221220131715.femjybikqcnm4lyg@pengutronix.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 9 Jan 2023 22:11:48 +1000
Message-ID: <CAKmqyKO-Qw3AihUnF7np7_6kr6-ODnXU3aBwph-_9=xSbXRx-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Alistair Francis <alistair@alistair23.me>,
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

On Tue, Dec 20, 2022 at 11:17 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Alistair,
>
> thanks for your patch, please see below.
>
> On 22-12-20, Alistair Francis wrote:
> > Add support for the rohm,bd71815 power controller controller for the
> > reMarkable 2.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  arch/arm/boot/dts/imx7d-remarkable2.dts | 159 ++++++++++++++++++++++++
> >  1 file changed, 159 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > index a138b292ec6a..4387d30d6180 100644
> > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > @@ -92,6 +92,10 @@ wifi_pwrseq: wifi_pwrseq {
> >       };
> >  };
> >
> > +&cpu0 {
> > +     cpu-supply = <&buck1_reg>;
> > +};
> > +
> >  &clks {
> >       assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
> >                         <&clks IMX7D_CLKO2_ROOT_DIV>;
> > @@ -119,6 +123,148 @@ wacom_digitizer: digitizer@9 {
> >       };
> >  };
> >
> > +&i2c2 {
> > +     clock-frequency = <100000>;
>
> We can set this now to 400kHz since the driver can handle quirks now
> internal.

After a discussion on the first patch I'm going to leave this as is.
Let me know if you do want me to change it.

>
> > +     pinctrl-names = "default", "sleep";
> > +     pinctrl-0 = <&pinctrl_i2c2>;
> > +     pinctrl-1 = <&pinctrl_i2c2>;
>
> Do we need a "sleep" config here since this will be the same
> configuration as the "default" one.

Nope, dropped.

>
> > +     status = "okay";
> > +
> > +     bd71815: pmic@4b {
> > +             compatible = "rohm,bd71815";
> > +             reg = <0x4b>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_bd71815>;
> > +             interrupt-parent = <&gpio6>; /* PMIC_INT_B GPIO6_IO16 */
> > +             interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> > +             gpio-controller;
> > +             clocks = <&clks IMX7D_CLKO2_ROOT_SRC>;
> > +             clock-output-names = "bd71815-32k-out";
> > +             #clock-cells = <0>;
> > +             #gpio-cells = <1>;
> > +
> > +             regulators {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +
> > +                     buck1_reg: regulator@0 {
> > +                             reg = <0>;
> > +                             regulator-compatible = "buck1";
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <2000000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                             regulator-ramp-delay = <1250>;
> > +                     };
> > +
> > +                     buck2_reg: regulator@1 {
> > +                             reg = <1>;
> > +                             regulator-compatible = "buck2";
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <2000000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                             regulator-ramp-delay = <1250>;
> > +                     };
> > +
> > +                     buck3_reg: regulator@2 {
> > +                             reg = <2>;
> > +                             regulator-compatible = "buck3";
> > +                             regulator-min-microvolt = <1200000>;
> > +                             regulator-max-microvolt = <2700000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     buck4_reg: regulator@3 {
> > +                             reg = <3>;
> > +                             regulator-compatible = "buck4";
> > +                             regulator-min-microvolt = <1100000>;
> > +                             regulator-max-microvolt = <1850000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     buck5_reg: regulator@4 {
> > +                             reg = <4>;
> > +                             regulator-compatible = "buck5";
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo1_reg: regulator@5 {
> > +                             reg = <5>;
> > +                             regulator-compatible = "ldo1";
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo2_reg: regulator@6 {
> > +                             reg = <6>;
> > +                             regulator-compatible = "ldo2";
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo3_reg: regulator@7 {
> > +                             reg = <7>;
> > +                             regulator-compatible = "ldo3";
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo4_reg: regulator@8 {
> > +                             reg = <8>;
> > +                             regulator-compatible = "ldo4";
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo5_reg: regulator@9 {
> > +                             reg = <9>;
> > +                             regulator-compatible = "ldo5";
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     dvref_reg: regulator@a {
> > +                             reg = <0xa>;
> > +                             regulator-compatible = "dvref";
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     lpsr_reg: regulator@b {
> > +                             reg = <0xb>;
> > +                             regulator-compatible = "lpsr";
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     wled_reg: regulator@c {
> > +                             reg = <0xc>;
> > +                             regulator-compatible = "wled";
> > +                             regulator-min-microamp = <10>;
> > +                             regulator-max-microamp = <25000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
>
> Note: You have marked all regulators as always on, this is rather
> suboptimal due to power consumption.

Good point. The power consumption is already pretty bad, as mainline
doesn't support the i.MX deep sleep. As I know this works I'd like to
keep it as is. I'll test to see if removing them doesn't break
anything and then send a follow up patch.

Alistair

>
> Regards,
>   Marco
>
