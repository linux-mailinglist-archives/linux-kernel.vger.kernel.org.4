Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDBC61DDFA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 21:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKEUVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 16:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiKEUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 16:21:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F187113D7B;
        Sat,  5 Nov 2022 13:21:10 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B74696602366;
        Sat,  5 Nov 2022 20:21:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667679669;
        bh=oFL+eFW9VNZnIxnzxItCZONBvkMIY4e/57puUZz/1/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNVy6yZJvOG3XLx5Fjo1uDwg4wiDU9t/6wSOsh7PvTR7WtpCc1yUIGBpSVexsegUB
         kctUn8L3a5VGtkRR5AhCCjZlE4Tx/R2JvKqM1vUfG/9fYVvYhEN0/x6CYDElJPwH+O
         AOBFYOEeNX3fBa3UQG88uS7qZL90BoOVmYQtG2o0yp3mpx1xLDUSSvC7t0i1DsZqEc
         clUYRyRZYnb0QMXO+9c/Ow4VBH/Kbq/xM7QApl+vlCDwwAcdpcR/7yOGQvMIz6X6xY
         Ysr198HLqi2iJyHQTOqz99zXAFHauW2RoOOmtCmSQcCMEvhvg1Om7P9W5ci7QQOqTj
         mTYsuJbn3CCUg==
Received: by mercury (Postfix, from userid 1000)
        id 912401062C1F; Sat,  5 Nov 2022 21:21:07 +0100 (CET)
Date:   Sat, 5 Nov 2022 21:21:07 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Zhang Qing <zhangqing@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Chris Zhong <zyw@rock-chips.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        devicetree@vger.kernel.org,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Purism Kernel Team <kernel@puri.sm>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: supply: bq25890: allow
 power-supply fields
Message-ID: <20221105202107.6iuiahftidyvhlkq@mercury.elektranox.org>
References: <20221102184501.109148-1-krzysztof.kozlowski@linaro.org>
 <20221102184501.109148-2-krzysztof.kozlowski@linaro.org>
 <166759888639.2894265.16300000999459794709.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xrwr6djdhlvsae7h"
Content-Disposition: inline
In-Reply-To: <166759888639.2894265.16300000999459794709.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xrwr6djdhlvsae7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 04, 2022 at 04:54:46PM -0500, Rob Herring wrote:
>=20
> On Wed, 02 Nov 2022 14:45:00 -0400, Krzysztof Kozlowski wrote:
> > The BQ25890 schema references common power-supply.yaml, so allow all its
> > properties to fix warnings like:
> >=20
> >   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: charger@6a: 'mon=
itored-battery', 'power-supplies', ... do not match any of the regexes: 'pi=
nctrl-[0-9]+'
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
> >=20
> > Changes since v1:
> > 1. New patch
> > ---
> >  Documentation/devicetree/bindings/power/supply/bq25890.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--xrwr6djdhlvsae7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNmxbMACgkQ2O7X88g7
+pqyeg/+J35tV/0bGI5gBzwiaSLrPxYKQZ9I2Rk7/hVFT9rOC9BWJGDvCGR43oOH
O9CbKjq7Ur5EdKKPArAoyPcuAT8km9MYflV/6SE/YlqnHHFBpjFFYOrD72oI1MKw
jeIa4XdCzDhh1eA6y9hb77aCA71f3YpgmTWR4JZqSkLJHpKtve08F84DHXmLiCvW
RYeDQmqRs9MghcBM3s+hahO4euBJucBr9GMyqSVK4oDksYRf+MNYsGFtyd2Zc9f3
VSvvqjpwzP1xQaydBOEcHNDLWwVC1C2y+dPYsgSc7CF73WKiX5IkspNdYw8xu0mj
BQzhSgAaNA9FRP0c3jjireMuNsW/1ZGez349zdpwAEYfNZTZnzALbHMcVRta/stT
XkL60sAYwiYjhVejdJNwHTrIm717d6/k5s0cC0H3h+73RcancB3J1tptB49W2X4k
IlL2dwRUcVkDayPa69FJAKFIK2SysQu4M7DQIg7etJZCs/ScO0uKVTdeDWJ1ANGF
i37ld4P8Vksf1W3X5Z2918eDhaOpeTyc2HHs7f9Ua30SmZejuyEO7T0pGLGsuFmO
qeu1/uCtH8WwBoEP+t+7AGqPUvC4+RydzStNdxRvLsc52SRoeZk58Uz/sVeNIUqe
1RKhOqevx34NazEfgH4gVsw9hElaWFiKeplAbgDzVgjCwaQ21sk=
=rEdX
-----END PGP SIGNATURE-----

--xrwr6djdhlvsae7h--
