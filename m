Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87421704591
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjEPGvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjEPGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:51:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE344C2B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:51:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyoVl-0000di-HX; Tue, 16 May 2023 08:50:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyoVi-000XiK-M0; Tue, 16 May 2023 08:50:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyoVi-004v4C-3L; Tue, 16 May 2023 08:50:14 +0200
Date:   Tue, 16 May 2023 08:50:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH v3 0/2] Support PWM on MediaTek MT7981
Message-ID: <20230516065013.u2oqdonovdckuvop@pengutronix.de>
References: <cover.1682007088.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="so7atcmfgma6sw4o"
Content-Disposition: inline
In-Reply-To: <cover.1682007088.git.daniel@makrotopia.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--so7atcmfgma6sw4o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 21, 2023 at 12:22:20AM +0100, Daniel Golle wrote:
> Add support for PWM on the MediaTek MT7981 to pwm-mediatek.c as well
> as new mediatek,mt7981-pwm compatible string to the existing bindings.
>=20
> Changes since v2:
>  * improve commit message, adding that alphabetic order is restored
>=20
> Changes since v1:
>  * use pointer to reg_offset instead of u8 reg_ver and if-else
>=20
> Daniel Golle (2):
>   dt-bindings: pwm: mediatek: Add mediatek,mt7981 compatible
>   pwm: mediatek: Add support for MT7981
>=20
>  .../bindings/pwm/mediatek,mt2712-pwm.yaml     |  1 +
>  drivers/pwm/pwm-mediatek.c                    | 39 +++++++++++++++----
>  2 files changed, 32 insertions(+), 8 deletions(-)

whole series looks good to me,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--so7atcmfgma6sw4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRjJ6UACgkQj4D7WH0S
/k6yuwf/ZduV3pWBQmvuxxeH3faEOg2E0ttlDDUG/4fkQeBgASYpDAQvapTJqj/o
ZIOoIjdBS5X5WbYjl0wshrWc79B6bA/5TUrQxLjc8HRFfN4Q8+Ia+LQH10w/mBND
ShHmmb5CrVwVUa2t6/zrkUoXRUAM1pU+UM0XDvGHBFxRruPcUb8yuU0oEmgFU0ZQ
sJz9teGh1jhvxClHVso2erPoz+l64KNc7XSSyR6lwfMm9sMYnKQFvOyrW/LUOHeu
lkacUxGWTphramLuhvcjatEHqpUrWrvhahwx2k4C0f3aOLZtRTROsZ58xtFtK4Pt
i725zuKbzW6luWcTX+Ac3O8HlFME6Q==
=o+7Q
-----END PGP SIGNATURE-----

--so7atcmfgma6sw4o--
