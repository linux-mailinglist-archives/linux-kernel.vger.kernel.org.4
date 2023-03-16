Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9DC6BC24B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjCPARH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCPARE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:17:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046F762B71;
        Wed, 15 Mar 2023 17:16:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m2so13599wrh.6;
        Wed, 15 Mar 2023 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678925817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTV9EnLtEgkBc71Ccit1w3PTMeFKwTnDyhAhw89XVNI=;
        b=hQ3dQ4U3LsqaKJ5WcJzbeOWMpFCEwWkMEhQyaeWkxDNosIIMYFJh5XPwDi0XutMGx3
         iWeL6vUkJrFVx851HEDZcEFrKA96ldy1hzI0eyixb9G2BVNjusRi+sRGBX8f3RrVLFuy
         ZWJaAxZ0NQRwPE0U5lneRBzHTh8Lob3yfWTEHY4f0QPNu0/UifRt51b+tRRjfWzBfQPb
         L1DynkWDgb5gq67C6Hb95hg+zcK+hASUdlXQb0em6ecML5TfoQJAfP3J7uVB2g24bra4
         Igdob8AJR/kAn9LTWjMk8r1HyUQn5NPhi5QGiRzpO1I1+XaM2CYCXZzuIj/aUldbv8DS
         YLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTV9EnLtEgkBc71Ccit1w3PTMeFKwTnDyhAhw89XVNI=;
        b=M5G6AunkCtCEzc4tE34umIG+qUilc42mzOzCCRwyMoAfztFK6zWZHStObnLTK7oOM/
         sf+Zv+p6E4UerN1HnsrE+t9ht3AjT8ZqBbCpso5JC0Wu0rrm5HQW7tgyPPnXDgLXyZ+q
         GSUqYuDyN6AmAqT0DZTTo5MKawMl1POnh0+Gxi7oqdLY7SYYGsLKxc6Z+Se0K5LeH6Rh
         x1biznpyVfl/kmyzFqAEYIYFpkwEgUk8dBe1tlR4XejkY2rCg2wIzXnGE2K/0PnoC10y
         CaTPp+DTXLQSdaiY/bzAkPLHHmRPwFNHijsE5gLGb1CdmfgVg3tACPhuELr2CC2Gga/i
         Uz3Q==
X-Gm-Message-State: AO0yUKU5dzg/AKg1JneF9BTbyX8CzQkdQta12qMW9FBzN77iHx2wJl3Q
        kapv85921J+o5l3DCc1mcev2YwKshO2NcxaUaOw=
X-Google-Smtp-Source: AK7set/pluI8RhE5QmBIHGlQNxPKXPr3AZKOWkXiMh/E85uReVoHRs8JGxaSYzON7hxQ26BbpJUfIjxf2X9EZICRXzY=
X-Received: by 2002:a5d:63d1:0:b0:2ce:ac97:6f51 with SMTP id
 c17-20020a5d63d1000000b002ceac976f51mr763875wrw.13.1678925817370; Wed, 15 Mar
 2023 17:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230315160228.2362-1-cnsztl@gmail.com> <20230315160228.2362-5-cnsztl@gmail.com>
In-Reply-To: <20230315160228.2362-5-cnsztl@gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 15 Mar 2023 17:16:30 -0700
Message-ID: <CA+E=qVei7T4T0FWhdUFnr5JbCWSgFbGLcmU2OHxx54yvnNR6mw@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: fix gmac support for NanoPi R5S
To:     Tianling Shen <cnsztl@gmail.com>
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

On Wed, Mar 15, 2023 at 9:02=E2=80=AFAM Tianling Shen <cnsztl@gmail.com> wr=
ote:
>
> - Changed phy-mode to rgmii.
>
> - Fixed pull type in pinctrl for gmac0.
>
> - Removed duplicate properties in mdio node.
>   These properties are defined in the gmac0 node already.
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/ar=
m64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> index e9adf5e66529..2a1118f15c29 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> @@ -57,7 +57,7 @@
>         assigned-clock-rates =3D <0>, <125000000>;
>         clock_in_out =3D "output";
>         phy-handle =3D <&rgmii_phy0>;
> -       phy-mode =3D "rgmii-id";
> +       phy-mode =3D "rgmii";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&gmac0_miim
>                      &gmac0_tx_bus2
> @@ -79,9 +79,6 @@
>                 reg =3D <1>;
>                 pinctrl-0 =3D <&eth_phy0_reset_pin>;
>                 pinctrl-names =3D "default";
> -               reset-assert-us =3D <10000>;
> -               reset-deassert-us =3D <50000>;
> -               reset-gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;

Hmm, I don't see RK_PC4 being used anywhere else. gmac0 has RK_PC5 as
snsp,reset-gpio. So it essentially drops reset for the PHY. Is it
expected?

>         };
>  };
>
> @@ -115,7 +112,7 @@
>  &pinctrl {
>         gmac0 {
>                 eth_phy0_reset_pin: eth-phy0-reset-pin {
> -                       rockchip,pins =3D <0 RK_PC4 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> +                       rockchip,pins =3D <0 RK_PC4 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
>                 };
>         };
>
> --
> 2.17.1
>
