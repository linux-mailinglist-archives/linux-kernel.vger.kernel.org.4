Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B725E74DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiIWH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiIWH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:28:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB60E12B4AD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:28:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1obd6m-0001Cg-UD; Fri, 23 Sep 2022 09:28:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1obd6l-002PwT-Ts; Fri, 23 Sep 2022 09:28:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1obd6j-002x7p-Iu; Fri, 23 Sep 2022 09:28:21 +0200
Date:   Fri, 23 Sep 2022 09:28:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@list.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH,v2] dt-bindings: pwm: Add compatible for Mediatek MT8188
Message-ID: <20220923072821.fy732jaayqdyfeht@pengutronix.de>
References: <1663915394-30091-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7db7yim5if2sboqg"
Content-Disposition: inline
In-Reply-To: <1663915394-30091-1-git-send-email-xinlei.lee@mediatek.com>
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


--7db7yim5if2sboqg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

hint: You don't seem to know about git send-email -v2. (Or git
format-patch -v2)

On Fri, Sep 23, 2022 at 02:43:14PM +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
>=20
> Add dt-binding documentation of pwm for MediaTek MT8188 SoC.
>=20
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---

It is usually helpful to note what changed since v1 here. I looked it up
myself now: Only the commit log changed, it was shortend not to mention
development details about how this patch was created.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7db7yim5if2sboqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMtYBIACgkQwfwUeK3K
7AkYGgf/U4i3QfL+sMDHS1hzBnjl2JNNEFmxOmB6Llcg+aW+9/nfQrKvTv+s9qOD
iIppkKLXrPDwN2P7wprRzLOXTPLooQkXV6N0yIIefGbVu6fX8s8mYBeUW58vBVSE
lEfuiKF8kNqCSesxSYohnRbh+A1J3eokuDp7W/2hFuzn0nFEEt0Ec2UDjtf7fmhD
+Cqq/ivOFiD9oiUQxMiarcfqy7PEahD/yRlElg8jHT5ZO9deo+NnLqSead/OqogI
Xlz7YShR2VPQpLdnRLg6tochWd+N9HGIp7QL6BD4n459dxCmJoJQzuUD1Lw1Ft2m
K6vpS1bvwC0CkLKGbTGQY59MLZ79BA==
=wTGz
-----END PGP SIGNATURE-----

--7db7yim5if2sboqg--
