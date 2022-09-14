Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4D5B8F67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiINTyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiINTyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:54:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34AC2728
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:54:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYYSu-0002uX-BS; Wed, 14 Sep 2022 21:54:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYYSr-000krh-Ou; Wed, 14 Sep 2022 21:54:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYYSp-000vzE-Kt; Wed, 14 Sep 2022 21:54:27 +0200
Date:   Wed, 14 Sep 2022 21:54:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH,1/2] dt-bindings: pwm: Add compatible for Mediatek MT8188
Message-ID: <20220914195421.23z5r3notsmx4sdw@pengutronix.de>
References: <1661239875-19841-1-git-send-email-xinlei.lee@mediatek.com>
 <1661239875-19841-2-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="23bdvmkeqotnlzsg"
Content-Disposition: inline
In-Reply-To: <1661239875-19841-2-git-send-email-xinlei.lee@mediatek.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--23bdvmkeqotnlzsg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Aug 23, 2022 at 03:31:14PM +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
>=20
> Add dt-binding documentation of pwm for MediaTek MT8188 SoC.
>=20
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--23bdvmkeqotnlzsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMiMWsACgkQwfwUeK3K
7AkHuAf/YbpnjsXH7ZSoZyTgl2dDDyrYOAiNHDLVW+9H2izU/kcIloGBS5Cifd88
cf0jqYzIm6oF8Sfl6U8Bs6y38ug7Nb396Pg3RKTcDfkoTgo5fSvIBNcIEZhFWknB
jIMGHvo0sG584nxnPGtc4qWiczVJjb7ETSG9LQH5hAZYCEPbVTAFlAkzwTlOFAXg
JtViZbxO5bWiWoN4BZjMQW7DLIhP1S0rLBzLuIBjth6N8Z/jV0ySgrK/jJCbQ/fm
J20NpniXnGVPIo7UFtI8YaCCw/deVgd7LlD2IVRU+DiXN/mrDhM710INLFkLNBG6
+qnJwyVQncs6gTiC5UZXdaNtfWxhpA==
=RVce
-----END PGP SIGNATURE-----

--23bdvmkeqotnlzsg--
