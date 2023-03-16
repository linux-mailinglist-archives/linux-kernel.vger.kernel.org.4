Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02DC6BC5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 06:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCPFfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 01:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCPFfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 01:35:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31A928E6A;
        Wed, 15 Mar 2023 22:35:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x13so3155350edd.1;
        Wed, 15 Mar 2023 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678944912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTn9F6VRaj24/5PlriNhsJPfHboEOWBXCFTCA/ejnmc=;
        b=foflW0AaNkXb+Nls7hLeT8kEUUuYONhJK6/82tE3JTfHODXUMopAvrYh5cldFrl9yd
         W54xUzNlb9WLe4lngeEMWQIw5RMUqUlRBRiDArpKl0KyCy8PVhNeCzJGYkY5tT6jQjTV
         LV3lG0fRbOWAMxUP1a7VkhjEGNC/XqadC8NkK/khq78m4CiVLgLU0KQ0BQItcZPoYxP2
         HVDZKsAyZZqg17gECkF5MfrWBVAZQUiwu2vSBF96dz5AqbO+O9H/BE//AAfibW1jqm1p
         77c7RZAe40erULO1iu1S9qcHOgdSBOpQyBfHk2/md2+benxMKD+UzeCQ3opJSCa8RYa1
         mrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678944912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTn9F6VRaj24/5PlriNhsJPfHboEOWBXCFTCA/ejnmc=;
        b=paawGYhU6fdlZLpuATu4v/Ocvtl8oUeZXUhCueMAzpLyAhv+dMcd14xzDB9S45hvEL
         4h09X1rE4FiAwLjzz6FI+6Ee+NjEpWc3KtpKaNCpInPILOAL7uloH1SOlO1Nn6yxvK86
         9ePSymwZR/oDyjagKGDctyoc78u8TCnbP6SVe7BXGNfaN78ZnZZd+Uwn4foQ8yTrPLts
         EKsEFZigWw6UsQJuObM8JCTfW/+aeOzC9J/YQyimVcKcSadIObCilMeUMwOoza2Oc04u
         +/a1dsWnF4cdreKv6GqLq5vCdysboQhHJn6TTwoFyOKmEkvhsH+HZb2xy3DAX/Wv+bdc
         KzWA==
X-Gm-Message-State: AO0yUKVZCRg4C6PZQzpdAKWXr5GWC4FQuwiYkVceMT5c3PSINNO3hJCQ
        QMX5qFoEHbDrNoW4fLgvjoyxXX7S3VV/mVnvaUw=
X-Google-Smtp-Source: AK7set8aurmvlKhSXW1haPZN3+fpNjlKMeMKoyYecYeYATlpXhQhWJetpPuWeKc7i2GuHMRz4wiBUGWfNXDCjO6mwtM=
X-Received: by 2002:a50:99d6:0:b0:4fb:f19:883 with SMTP id n22-20020a5099d6000000b004fb0f190883mr2815068edb.1.1678944912065;
 Wed, 15 Mar 2023 22:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230315160228.2362-1-cnsztl@gmail.com> <20230315160228.2362-5-cnsztl@gmail.com>
 <CA+E=qVei7T4T0FWhdUFnr5JbCWSgFbGLcmU2OHxx54yvnNR6mw@mail.gmail.com>
In-Reply-To: <CA+E=qVei7T4T0FWhdUFnr5JbCWSgFbGLcmU2OHxx54yvnNR6mw@mail.gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Thu, 16 Mar 2023 13:34:59 +0800
Message-ID: <CAOP2_TiU815F528jVGvDbcg3kSG+ykepU-ZYz7VWMO84GgcwMg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: fix gmac support for NanoPi R5S
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Vasily,

On Thu, Mar 16, 2023 at 8:16=E2=80=AFAM Vasily Khoruzhick <anarsoul@gmail.c=
om> wrote:
>
> On Wed, Mar 15, 2023 at 9:02=E2=80=AFAM Tianling Shen <cnsztl@gmail.com> =
wrote:
> >
> > - Changed phy-mode to rgmii.
> >
> > - Fixed pull type in pinctrl for gmac0.
> >
> > - Removed duplicate properties in mdio node.
> >   These properties are defined in the gmac0 node already.
> >
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/=
arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> > index e9adf5e66529..2a1118f15c29 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> > @@ -57,7 +57,7 @@
> >         assigned-clock-rates =3D <0>, <125000000>;
> >         clock_in_out =3D "output";
> >         phy-handle =3D <&rgmii_phy0>;
> > -       phy-mode =3D "rgmii-id";
> > +       phy-mode =3D "rgmii";
> >         pinctrl-names =3D "default";
> >         pinctrl-0 =3D <&gmac0_miim
> >                      &gmac0_tx_bus2
> > @@ -79,9 +79,6 @@
> >                 reg =3D <1>;
> >                 pinctrl-0 =3D <&eth_phy0_reset_pin>;
> >                 pinctrl-names =3D "default";
> > -               reset-assert-us =3D <10000>;
> > -               reset-deassert-us =3D <50000>;
> > -               reset-gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
>
> Hmm, I don't see RK_PC4 being used anywhere else. gmac0 has RK_PC5 as

Yes, it's a typo, it should be RK_RC5.

> snsp,reset-gpio. So it essentially drops reset for the PHY. Is it
> expected?

snsp,reset-gpio defined reset already, so we don't need to set it here agai=
n.

---

snsp,reset-gpio is the legacy binding, but I still have no idea why
reset-gpios doesn't work,
the dwmac driver will fail to lookup phy:

[   10.398514] rk_gmac-dwmac fe2a0000.ethernet eth0: no phy found
[   10.399061] rk_gmac-dwmac fe2a0000.ethernet eth0: __stmmac_open:
Cannot attach to PHY (error: -19)

Any ideas would be appreciated.

Thanks,
Tianling.

>
> >         };
> >  };
> >
> > @@ -115,7 +112,7 @@
> >  &pinctrl {
> >         gmac0 {
> >                 eth_phy0_reset_pin: eth-phy0-reset-pin {
> > -                       rockchip,pins =3D <0 RK_PC4 RK_FUNC_GPIO &pcfg_=
pull_down>;
> > +                       rockchip,pins =3D <0 RK_PC4 RK_FUNC_GPIO &pcfg_=
pull_up>;
> >                 };
> >         };
> >
> > --
> > 2.17.1
> >
