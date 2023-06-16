Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF7733A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjFPTiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFPTiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:38:18 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DAC119;
        Fri, 16 Jun 2023 12:38:18 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 08FBF1C0E70; Fri, 16 Jun 2023 21:38:17 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:38:16 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jim Wylder <jwylder@google.com>, broonie@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH AUTOSEL 4.19 1/8] regmap: Account for register length
 when chunking
Message-ID: <ZIy6KMbGTS9AU3JY@duo.ucw.cz>
References: <20230615113956.649736-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3/lGInkc0WWYLbnF"
Content-Disposition: inline
In-Reply-To: <20230615113956.649736-1-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3/lGInkc0WWYLbnF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Currently, when regmap_raw_write() splits the data, it uses the
> max_raw_write value defined for the bus.  For any bus that includes
> the target register address in the max_raw_write value, the chunked
> transmission will always exceed the maximum transmission length.
> To avoid this problem, subtract the length of the register and the
> padding from the maximum transmission.
>=20
> Signed-off-by: Jim Wylder <jwylder@google.com
> Link: https://lore.kernel.org/r/20230517152444.3690870-2-jwylder@google.c=
om
> Signed-off-by: Mark Brown <broonie@kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Some ">"s are missing in the email addresses.

Best regards,
							Pavel
						=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3/lGInkc0WWYLbnF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy6KAAKCRAw5/Bqldv6
8ndLAJ4qzkz1rbTzWg1dRwIMxadNX3+GqwCeOSWNZDTril9wZiTb2zg1nYPsazI=
=gj1j
-----END PGP SIGNATURE-----

--3/lGInkc0WWYLbnF--
