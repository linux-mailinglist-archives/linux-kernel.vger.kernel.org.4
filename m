Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F4E6064CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJTPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJTPjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:39:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31B3B946
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:39:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1olXdq-0006WC-DC; Thu, 20 Oct 2022 17:39:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1olXdn-000LeI-7N; Thu, 20 Oct 2022 17:39:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1olXdo-009MK1-JB; Thu, 20 Oct 2022 17:39:28 +0200
Date:   Thu, 20 Oct 2022 17:39:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v6 01/10] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm-dw-apb-timers-pwm2
Message-ID: <20221020153928.nmkcvusnbkj3hmrv@pengutronix.de>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-2-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bqj5ea2mulyba652"
Content-Disposition: inline
In-Reply-To: <20221020151610.59443-2-ben.dooks@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqj5ea2mulyba652
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ben,

On Thu, Oct 20, 2022 at 04:16:01PM +0100, Ben Dooks wrote:
> Add documentation for the bindings for Synopsys' DesignWare PWM block
> as we will be adding DT/platform support to the Linux driver soon.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>

you would make life a bit easier if you added the tags you got for the
previous rounds (iff the patch didn't change). Here that would be:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bqj5ea2mulyba652
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNRa60ACgkQwfwUeK3K
7AlEqgf/RAvaqkkZmEO4vBw/kXgMdHYmy/shxlWfTzq1TvMUz+/4uuSuDTV17F55
d4NLyyfQrKRqae0MT6Q+3R7ucSxFwAK+xc7nAtArb7ScQjQ3fIqYbJSSWCSy2BoT
aJh9FMbeelzXy+P+3HqQRB0WnvUlg7d+eNXNbEqBHGeW1/OArjy0cIKjup2lu0+t
bqQgGcluUts+d74jaeLHMafvOAAYkjAGNoLTPohkUHEO7csMWTCdvkxEghvX5ljK
3zzaJgsqUlnAjFy8caJRd3lniuBaIBWONha6g+ONMQwnbGyxhcEDyTFPEfYEpqMj
o7fLFYGM/jArjMEqz09EUGQjUf5Z4Q==
=kREB
-----END PGP SIGNATURE-----

--bqj5ea2mulyba652--
