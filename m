Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85CB639E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK1AF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK1AF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:05:27 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3036EB7ED;
        Sun, 27 Nov 2022 16:05:25 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4654F100003;
        Mon, 28 Nov 2022 00:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669593923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CjpkueS4cLCTFtb8W3kuQwm4Wdu/v56HQGJ8jmW4RA=;
        b=FANHRqXz67sL6B6x9cDSHprotJTJxbZRRHHVeA7T3YpqnfZ8HQlOmY+s7tM62XM90zFAC5
        qjPu9tix/7MU41rG/qvbCApZ/64M5wtz4TcmqN/jL++S7UykHtbAASskCCvZ+dBW/NjayM
        9QasToLZsu1bbxgfvRVeH/WZP5Lh9Ogkual3puakAsPBCQBzJub3flC2F8Naqj5yj6yvqI
        A0EjAqu00adu7eChS9N0/Fv636y+YEMiKffbXubLSVEF5sTUsDnr9UKdR40bgYZ4hFwM5J
        0nGQCzrl7dQoEJlS9cjOiaNEUUJgjZcz3lZgxTvy3KU6ZqAyDqA3PknfnJLRVA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] ARM: dts: armada-38x: Fix compatible string for
 gpios
In-Reply-To: <20220714183328.4137-3-pali@kernel.org>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-3-pali@kernel.org>
Date:   Mon, 28 Nov 2022 01:05:21 +0100
Message-ID: <87wn7g7xku.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Armada 38x supports per CPU interrupts for gpios, like Armada XP. Pre-XP
> variants like Armada 370 do not support per CPU interrupts for gpios.
>
> So change compatible string for Armada 38x from "marvell,armada-370-gpio"
> which indicates pre-XP variant to "marvell,armadaxp-gpio" which indicates
> XP variant or new.
>
> Driver gpio-mvebu.c which handles both pre-XP and XP variants already
> provides support for per CPU interrupts on XP and newer variants.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Fixes: 7cb2acb3fbae ("ARM: dts: mvebu: Add PWM properties for armada-38x")

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada=
-38x.dtsi
> index df3c8d1d8f64..9343de6947b3 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -292,7 +292,7 @@
>  			};
>=20=20
>  			gpio0: gpio@18100 {
> -				compatible =3D "marvell,armada-370-gpio",
> +				compatible =3D "marvell,armadaxp-gpio",
>  					     "marvell,orion-gpio";
>  				reg =3D <0x18100 0x40>, <0x181c0 0x08>;
>  				reg-names =3D "gpio", "pwm";
> @@ -310,7 +310,7 @@
>  			};
>=20=20
>  			gpio1: gpio@18140 {
> -				compatible =3D "marvell,armada-370-gpio",
> +				compatible =3D "marvell,armadaxp-gpio",
>  					     "marvell,orion-gpio";
>  				reg =3D <0x18140 0x40>, <0x181c8 0x08>;
>  				reg-names =3D "gpio", "pwm";
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
