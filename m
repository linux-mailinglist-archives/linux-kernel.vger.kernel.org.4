Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76A16E1BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDNFoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDNFoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:44:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B42729
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:44:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnCDv-0006uh-5z; Fri, 14 Apr 2023 07:43:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnCDr-00B80h-A8; Fri, 14 Apr 2023 07:43:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnCDq-00D4Dy-F5; Fri, 14 Apr 2023 07:43:46 +0200
Date:   Fri, 14 Apr 2023 07:43:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
        thierry.reding@gmail.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
Message-ID: <20230414054345.ip3ug53ivr3elbpy@pengutronix.de>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="djepqqx6bag6dot5"
Content-Disposition: inline
In-Reply-To: <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--djepqqx6bag6dot5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 12, 2023 at 01:27:13PM +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's display PWM
> block: this is the same as MT8173.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I assume this patch will go in together with the other patches in this
series via an ARM tree? (I.e. not via pwm.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--djepqqx6bag6dot5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ46BAACgkQj4D7WH0S
/k4/QQf+J7sRk5oREfd1w/lHSb4KN9o1xa9cQH4vB6vzHNViu1aEltOjUr7KA5SA
tTJlHyGa+J+Kkdu2A4m4XXQyFN0cp7GcEVUwXzaCzyMbdc4Vs5J7XGkMbhqiqN7/
hECv2dFZr/HfpjI2j32TB1y80TYxrqPzkosZiOWnw0AKa8wVeTgI8M7Rsnc7lFG7
DgW6W75MH1kB6EzYjKUIP9PIXgy7AbM/tnzYf5PItKPiyr+xh6cjeTjcrOHJ+GyF
MRckk8KLWlqIHTfwE5U4lctY5vXAUUrew6K33WHC9eu+3CMs2Tod4G3SrJE7jUCe
EPSYz+vtL3CWQv8IlUJAYPzaNgBcBQ==
=k4oe
-----END PGP SIGNATURE-----

--djepqqx6bag6dot5--
