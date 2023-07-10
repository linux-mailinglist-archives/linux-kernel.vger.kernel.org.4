Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BC74DB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGJQib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGJQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C021E8;
        Mon, 10 Jul 2023 09:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21B6F61063;
        Mon, 10 Jul 2023 16:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B7FC433C8;
        Mon, 10 Jul 2023 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689007108;
        bh=Fxz8+nz1c9dZXZma3dpEF6OCZwk8mfyDi3Fn7q3yb6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2rwe0dIJi6Odn6hhVbJn1ebHX7biXrlxpuc0rCtXdGislVv1WZL5Z0eaYB/1/VAO
         jbEFVocdwTH5AbDrGDNU0yb8jnSHxLWaTtKIGwa4t+VOMvitXWNLvQY4ReGCAtrBBY
         8zPb6834EEx4wm7vrDaggdezvdjB80uNotA/WUMyMz4MIbuW0ce5DlVn8wER3I+akK
         XwQyl1JMUwZhp9WQLHX41GNosgYFyByvy/Zs2J7hhDOJNpoiNBPBgaSa9MG/i8pz6J
         hlCietG1zatWWEDU+qLnfwvOHQ9ZBL1VI/fy1VVMKOD9e7L9R9ZqBM3XH2ebR/i1Tp
         CqEC41blvM9SA==
Date:   Mon, 10 Jul 2023 17:38:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] dt-bindings: gpio: Add a header file for Amlogic
 C3 SoCs
Message-ID: <20230710-maybe-mantis-e647d94fd13a@spud>
References: <20230710042812.2007928-1-huqiang.qin@amlogic.com>
 <20230710042812.2007928-2-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j5AdCmeQS6DzLf1m"
Content-Disposition: inline
In-Reply-To: <20230710042812.2007928-2-huqiang.qin@amlogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j5AdCmeQS6DzLf1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 12:28:11PM +0800, Huqiang Qin wrote:
> Add dt-binding and related header file for Amlogic C3 GPIO.
>=20
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
>  .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |  1 +
>  include/dt-bindings/gpio/amlogic-c3-gpio.h    | 72 +++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/amlogic-c3-gpio.h
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinc=
trl-a1.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinct=
rl-a1.yaml
> index 99080c9eaac3..e019b6aa6ca3 100644
> --- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.=
yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.=
yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - amlogic,meson-a1-periphs-pinctrl
>        - amlogic,meson-s4-periphs-pinctrl
> +      - amlogic,c3-periphs-pinctrl

Alphanumerical order here perhaps?

>  required:
>    - compatible
> diff --git a/include/dt-bindings/gpio/amlogic-c3-gpio.h b/include/dt-bind=
ings/gpio/amlogic-c3-gpio.h
> new file mode 100644
> index 000000000000..75c8da6f505f
> --- /dev/null
> +++ b/include/dt-bindings/gpio/amlogic-c3-gpio.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */

Any reason to deviate from the usual license terms for bindings, which is
"GPL-2.0-only OR BSD-2-Clause"?

Cheers,
Conor.


> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + * Author: Huqiang Qin <huqiang.qin@amlogic.com>
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_C3_GPIO_H
> +#define _DT_BINDINGS_AMLOGIC_C3_GPIO_H
> +
> +#define	GPIOE_0		0
> +#define	GPIOE_1		1
> +#define	GPIOE_2		2
> +#define	GPIOE_3		3
> +#define	GPIOE_4		4
> +
> +#define	GPIOB_0		5
> +#define	GPIOB_1		6
> +#define	GPIOB_2		7
> +#define	GPIOB_3		8
> +#define	GPIOB_4		9
> +#define	GPIOB_5		10
> +#define	GPIOB_6		11
> +#define	GPIOB_7		12
> +#define	GPIOB_8		13
> +#define	GPIOB_9		14
> +#define	GPIOB_10	15
> +#define	GPIOB_11	16
> +#define	GPIOB_12	17
> +#define	GPIOB_13	18
> +#define	GPIOB_14	19
> +
> +#define	GPIOC_0		20
> +#define	GPIOC_1		21
> +#define	GPIOC_2		22
> +#define	GPIOC_3		23
> +#define	GPIOC_4		24
> +#define	GPIOC_5		25
> +#define	GPIOC_6		26
> +
> +#define	GPIOX_0		27
> +#define	GPIOX_1		28
> +#define	GPIOX_2		29
> +#define	GPIOX_3		30
> +#define	GPIOX_4		31
> +#define	GPIOX_5		32
> +#define	GPIOX_6		33
> +#define	GPIOX_7		34
> +#define	GPIOX_8		35
> +#define	GPIOX_9		36
> +#define	GPIOX_10	37
> +#define	GPIOX_11	38
> +#define	GPIOX_12	39
> +#define	GPIOX_13	40
> +
> +#define	GPIOD_0		41
> +#define	GPIOD_1		42
> +#define	GPIOD_2		43
> +#define	GPIOD_3		44
> +#define	GPIOD_4		45
> +#define	GPIOD_5		46
> +#define	GPIOD_6		47
> +
> +#define	GPIOA_0		48
> +#define	GPIOA_1		49
> +#define	GPIOA_2		50
> +#define	GPIOA_3		51
> +#define	GPIOA_4		52
> +#define	GPIOA_5		53
> +
> +#define	GPIO_TEST_N	54
> +
> +#endif /* _DT_BINDINGS_AMLOGIC_C3_GPIO_H */
> --=20
> 2.37.1
>=20

--j5AdCmeQS6DzLf1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKwz/wAKCRB4tDGHoIJi
0rEIAQCP3MeY9QpZ837QyziushD+wG7oQQH+/bUiJFdErQw1eQD/UHA++uo9GhtN
+J3t+px8WOPw2tOaHLK0z5Ew8Kf+wg0=
=vmZA
-----END PGP SIGNATURE-----

--j5AdCmeQS6DzLf1m--
