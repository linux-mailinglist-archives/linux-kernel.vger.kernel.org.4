Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23E8639E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiK1AGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1AGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:06:11 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144FED2F9;
        Sun, 27 Nov 2022 16:06:07 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5372460004;
        Mon, 28 Nov 2022 00:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669593966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8yFoMHy3atA7kG1NwGAioCrol6vDnI6vHnkyW11LWI=;
        b=ZyizfoENn1p2qU1poda2tPHci/Rzry9VtVWGycCpGHPr59jRIDgbalYpc5PpPIiUanYyHA
        FSRb9ALWKnnK6G3I2t/osExHlo4KWGYYwAGDdiugiVWFreSz7QoNEdblmA1QmSaYgHKMqG
        P4iEYY02Htxr2BlIuCqG6fEwAnniLaHgpFo1zw8B8ed4uPUlb3M2KrfjGgoWhStaII3l/Z
        FQSH68u2cNBAkqD24XJlabrQdzwf1CQB8NljBoLueFwXCryFInvPUcwVAV1LCCDU1BoJ5f
        0peP/cOyMj/3e4RN5bDv3LWWR0+Ss+xjT6CV4IRU46IqQxHja14hBxuBAPElNA==
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
Subject: Re: [PATCH v2 4/4] ARM: dts: armada-39x: Fix compatible string for
 gpios
In-Reply-To: <20220714183328.4137-4-pali@kernel.org>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-4-pali@kernel.org>
Date:   Mon, 28 Nov 2022 01:05:58 +0100
Message-ID: <87tu2k7xjt.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Armada 39x supports per CPU interrupts for gpios, like Armada XP.
>
> So add compatible string "marvell,armadaxp-gpio" for Armada 39x GPIO node=
s.
>
> Driver gpio-mvebu.c which handles both pre-XP and XP variants already
> provides support for per CPU interrupts on XP and newer variants.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Fixes: d81a914fc630 ("ARM: dts: mvebu: armada-39x: add missing nodes desc=
ribing GPIO's")

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-39x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada=
-39x.dtsi
> index e0b7c2099831..ef3a3859802c 100644
> --- a/arch/arm/boot/dts/armada-39x.dtsi
> +++ b/arch/arm/boot/dts/armada-39x.dtsi
> @@ -213,7 +213,7 @@
>  			};
>=20=20
>  			gpio0: gpio@18100 {
> -				compatible =3D "marvell,orion-gpio";
> +				compatible =3D "marvell,armadaxp-gpio", "marvell,orion-gpio";
>  				reg =3D <0x18100 0x40>;
>  				ngpios =3D <32>;
>  				gpio-controller;
> @@ -227,7 +227,7 @@
>  			};
>=20=20
>  			gpio1: gpio@18140 {
> -				compatible =3D "marvell,orion-gpio";
> +				compatible =3D "marvell,armadaxp-gpio", "marvell,orion-gpio";
>  				reg =3D <0x18140 0x40>;
>  				ngpios =3D <28>;
>  				gpio-controller;
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
