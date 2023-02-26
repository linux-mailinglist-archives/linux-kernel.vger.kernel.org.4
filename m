Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD286A2E7C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBZFw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBZFwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:52:47 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69FD136EF;
        Sat, 25 Feb 2023 21:52:46 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id x14so6053215vso.9;
        Sat, 25 Feb 2023 21:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2H4Vh3JQEN1PhARpU0GTYpYqzp5jLNHawwZOVptfOk=;
        b=nBrjA9gf93Wv1r7E/fwn2YVmNO9mbMQnSARhXaoLn0sVcV5I1CM86kfUOjYrxZgGTJ
         f3xvQlDd0tAR301V30W0jOhP0ZfxKCWik67qI7wHnKP9aE0i6LiztDQ6h3XgFbafGPwv
         Zk8oVB3Uidg7VQcTSQ8ilusDI6Js8hB+kiLpGoGOjv5J/0CUE25sY7tHWa36JXltOlgv
         1lIJJahMr6aNK7l5vACyOcnzU54X8tQfKXy4LbWlqgGYNfuuxn3sBE/oMP9ECC9ekA/R
         ISQ/ewj5h4DDfeVa3XO2endeFx3uSm6MdvvGo6gzfm4vQoFuCxCF6dkcvvRep6gaIpwI
         uiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2H4Vh3JQEN1PhARpU0GTYpYqzp5jLNHawwZOVptfOk=;
        b=sBCygAMZR+Iiu/+49fk5xrb3sGnLjSJ2hu2B+b2eYUUNcgDcm+aERNPTRJctdfDs0s
         hfOdJTey+JbJ92KeuaSJIwsXlLcFsjxAxITaQztTKLVc7nGEWdQjY28jjuPDRdwwVtuU
         TrHsOXOyk3/uCXVQODX2IcZZbHKRTkbuIwt/uLBj6d6uCjDIv6Y2IR+/LNz+aSHvXHd6
         nfxh96kWcBYMw3bNm7GUbk9WkLoaXVUaHEaD+oSTnR523KNzjU3gyjQa0nvp92iamaTR
         qLQqU4ZAK+D7QX9zczNG23Nt4JIkkOGPaBcL+hAS2PcMiW/JLPIw1KTC0a3ZXz6UvoDL
         tRzQ==
X-Gm-Message-State: AO0yUKXMRRZH/8dwigrPyYQrcnaAq6VpZ2cujDwfsIUimGww5ZLz17Th
        2dXvoq4iKNTnysUuFpU3GkkrQpK2eVvpTtFP15E=
X-Google-Smtp-Source: AK7set9UIGHgIySyWRZA7668der+RjU5uY/74VdNrOKuNVsqxPQuUApOuo6GdWnoYTEogHc/mJhuuAuXLkcX1njp88Q=
X-Received: by 2002:a67:db02:0:b0:411:c666:583b with SMTP id
 z2-20020a67db02000000b00411c666583bmr5020787vsj.5.1677390765792; Sat, 25 Feb
 2023 21:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20230225113712.340612-1-alistair@alistair23.me>
 <20230225113712.340612-4-alistair@alistair23.me> <CAOMZO5COg7wZbG3aWcwMsvTBQ9Ft8CQ9wearXMh+00o29CTaeg@mail.gmail.com>
In-Reply-To: <CAOMZO5COg7wZbG3aWcwMsvTBQ9Ft8CQ9wearXMh+00o29CTaeg@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 26 Feb 2023 15:52:19 +1000
Message-ID: <CAKmqyKPuuHcqYqNinrSfziN1+=5bVTyg=8eZh5j=yYS3BEWMRA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de,
        kernel@pengutronix.de, jernej.skrabec@gmail.com,
        linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 6:37 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Sat, Feb 25, 2023 at 8:37=E2=80=AFAM Alistair Francis <alistair@alista=
ir23.me> wrote:
>
> > +&i2c2 {
> > +       clock-frequency =3D <100000>;
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_i2c2>;
> > +       status =3D "okay";
> > +
> > +       bd71815: pmic@4b {
> > +               compatible =3D "rohm,bd71815";
> > +               reg =3D <0x4b>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pinctrl_bd71815>;
> > +               interrupt-parent =3D <&gpio6>; /* PMIC_INT_B GPIO6_IO16=
 */
> > +               interrupts =3D <16 IRQ_TYPE_LEVEL_LOW>;
> > +               gpio-controller;
> > +               clocks =3D <&clks IMX7D_CLKO2_ROOT_SRC>;
> > +               clock-output-names =3D "bd71815-32k-out";
> > +               #clock-cells =3D <0>;
> > +               #gpio-cells =3D <1>;
>
> The binding document says #gpio-cells =3D <2>;

Fixed!

>
> > +
> > +               regulators {
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <0>;
> > +
> > +                       buck1_reg: regulator@0 {
> > +                               reg =3D <0>;
>
> The regulator@0 and reg should not be present.

Fixed

>
> Please check Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml

Thanks, I double checked my latest code against the bindings.

Alistair
