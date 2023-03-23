Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334A16C6321
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCWJTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjCWJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:19:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30485421E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:19:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfH6a-00036U-HK; Thu, 23 Mar 2023 10:19:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfH6Z-0067Is-BO; Thu, 23 Mar 2023 10:19:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfH6Y-007IMd-Jo; Thu, 23 Mar 2023 10:19:30 +0100
Date:   Thu, 23 Mar 2023 10:19:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     ye.xingchen@zte.com.cn
Cc:     vkoul@kernel.org, kishon@kernel.org, linmq006@gmail.com,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: omap-usb2-phy: Use dev_err_probe()
Message-ID: <20230323091930.svydywwm5t7kmrmh@pengutronix.de>
References: <202303231545522162256@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o3vanfobuja4yooz"
Content-Disposition: inline
In-Reply-To: <202303231545522162256@zte.com.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o3vanfobuja4yooz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 03:45:52PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>=20
> Replace the open-code with dev_err_probe() to simplify the code.
>=20
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o3vanfobuja4yooz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQcGaEACgkQj4D7WH0S
/k414Qf9FL5ZtgkSSkD0Qzx1ffkcsHTCm/iQ4YXqWPX3zHJPsvjXZ2sPnfr/YsW/
tz9cUYJD0XuCWk8OMflPm9W15suvyzZG5x78JCUDYevL/6FRANutjwMQhv/EaUyB
jk5CQEf8AYUaYEib9nAOxxjTR21fAAt0rRjmdPtv1XBHLpnoB2b0hINVYufjjFIE
UcegqN1D4QKWI6HBsLJr+8lqLcYkhzI3agEInoEMV5guMatTgFzXvo6S2Qij6R5S
7C1pZoAWWT1GQCsfft9mcHSxF5mT2fnJG9fkq0LHLQEHogLysYatBDYeJPoLj24/
k7E+mBkx/uHPIKOsQ/8x/xBbru0LbQ==
=6ENB
-----END PGP SIGNATURE-----

--o3vanfobuja4yooz--
