Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771556A2E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBZFvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZFu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:50:59 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C72136EF;
        Sat, 25 Feb 2023 21:50:58 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id x14so6050519vso.9;
        Sat, 25 Feb 2023 21:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGqPUTQh9HX4h89ETpMPBhe4K434YzMwNSAO/8kdHXg=;
        b=JhOjZ2HBugtO9RnA/CuWwnGMYU6DOJDNGl7NS4ddDrIK4/vvKSad2zzAbXtZ9nBdCC
         PpvopsIpllQ0tLixihCprLXmCsYfkPa9YHpwhDD/GoAe4REnMXEPJUbnfGgE2jJ/4ZYY
         NoktTRJF4as+qcWhClZu/U/XWzJpDZfaBskgwgQSGEKZb8iTE7DkwD8GOjFACMk553jC
         IkvGEqsjlOhiijHdLwUheBBmph9YzPgI3iARRspRxNqsBo9xT7Fv8z1N56QxSbVl9/Td
         OYHPSbGFVrQp361kyHdkvBwg5CotLHIfNN8JSFq2yyGc50W8/B25yA9qw1OFgHY2gk0/
         r+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGqPUTQh9HX4h89ETpMPBhe4K434YzMwNSAO/8kdHXg=;
        b=tfd440ml3viPrHpiu4ZRWcCmA263H6Elb5UrtTtE7vckVHTJrKVgiiY4pQab+kmJqv
         rSKl200kEXWUQ3+bfTtoskmUt9+NgvkSFo+qTNutfprz2C2a0elOWPp7ZkavpXa5nD5i
         iIyd4X4Pq+5Hut+bG0DjJNCbWoFc4ll1W5cY1NHjnLQcfmzwEIIqp+hQK/eFOipg01bv
         Ad/tiiM/+/IF+5MSOpnHd/9b6kh9X1xCtOWx+tLThE8vvDM5rUur2cXyVqMD4aVBUZ89
         wz/W+ahHuw1q+agYEQzjDfoMxm2QwXy7dIjfBtrL1e1Sc26RCsMvF+qcyz0rB8Buff1t
         eTow==
X-Gm-Message-State: AO0yUKW8dZ46UrpPdCdxkSQfl2D5m/HhEus0pH/aHvxFUf+jPIB9X/bQ
        9zmqAnfpsJWDlLAVHfRKuj53aSdRwtOEnX1y+eo=
X-Google-Smtp-Source: AK7set9S1fxeKRdobtGyz63m9rmQYw9SVuEuxIlT6cqBBT0T4epBHesUW+SWrqjKrFT5GvNWKAGQVF2Fj3nHmV3sf/Q=
X-Received: by 2002:a05:6102:34c6:b0:402:9a0c:b682 with SMTP id
 a6-20020a05610234c600b004029a0cb682mr5251991vst.5.1677390657454; Sat, 25 Feb
 2023 21:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20230225113712.340612-1-alistair@alistair23.me>
 <20230225113712.340612-4-alistair@alistair23.me> <52813148-fef6-aac3-09ff-65aac8426528@gmail.com>
In-Reply-To: <52813148-fef6-aac3-09ff-65aac8426528@gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 26 Feb 2023 15:50:31 +1000
Message-ID: <CAKmqyKPoOX5rg3CyCU=UAsZQaH3AMd-d0f-XT_wuRQdnTFc20w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de,
        kernel@pengutronix.de, jernej.skrabec@gmail.com,
        linux@armlinux.org.uk, festevam@gmail.com
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

On Sun, Feb 26, 2023 at 12:22 AM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> Hi Alistair,
>
> On 2/25/23 13:37, Alistair Francis wrote:
> > Add support for the rohm,bd71815 power controller controller for the
> > reMarkable 2.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >   arch/arm/boot/dts/imx7d-remarkable2.dts | 158 ++++++++++++++++++++++++
> >   1 file changed, 158 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > index 288fc8611117..9ecb733545cc 100644
> > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > @@ -91,6 +91,10 @@ wifi_pwrseq: wifi_pwrseq {
> >       };
> >   };
> >
> > +&cpu0 {
> > +     cpu-supply = <&buck1_reg>;
> > +};
> > +
> >   &clks {
> >       assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
> >                         <&clks IMX7D_CLKO2_ROOT_DIV>;
> > @@ -118,6 +122,147 @@ wacom_digitizer: digitizer@9 {
> >       };
> >   };
> >
> > +&i2c2 {
> > +     clock-frequency = <100000>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_i2c2>;
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
>
> I'm sure you have learned to regard my comments with certain care ;) (I
> think it was you for whom I gave an advice - which resulted a board to
> be bricked :| So, please treat my comment as if I did not know what I am
> talking about).

That was me! The board wasn't bricked though, luckily as it's my only
device. It took a month of full battery discharge cycles but I managed
to replace the device tree with a working one :)

>
> Anyways, I believe the "regulator-compatible" is deprecated and should
> no longer be used to match the node with the regulator? Instead, the
> regulator node name itself should be used for the matching.
>
> ref.
> https://elixir.bootlin.com/linux/latest/source/drivers/regulator/of_regulator.c#L380
>
> I don't think the regulator-compatible can even be found from the
> regulator.yaml binding list...

You're right. Thanks for that, I have removed them and replaced them
with "regulator-name" to match the documentation.

>
> With this remark - (and what ever it is worth):
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

Alistair

>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
