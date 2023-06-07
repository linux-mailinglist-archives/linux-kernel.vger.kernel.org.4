Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E407E725D15
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbjFGL3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbjFGL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BB41BC6;
        Wed,  7 Jun 2023 04:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1338560C58;
        Wed,  7 Jun 2023 11:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A729C433EF;
        Wed,  7 Jun 2023 11:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686137345;
        bh=0YWf+o7Xye4E9eXePegQbCM+6aymWifggrFVEC88RXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uNhLA4VzEI2Mv5824IMpBMgv9KQd3RsVnpNduOHjv95cvSHi1QUGfHrsy71DCXQhT
         zo1LnfOPw3joDanmv/x4Ikcousaum8xclOa6HSDPMS3Ze9OlLTzdA17Y+ZOTNnfW93
         sgzdZc05IeR60rnzNI7K+N7Dw5EhS6xoMHvMVqVbi+DalDHR74eTczl9ogdk2OcXxP
         8ZwLGwr3rUs83O0znJNieFHcfwxuJ/WxiiSe5NqhZphQ1jOOVkKFo5gAgZI+W7oxt+
         GgL+Q+4KCIvGXW5TFDgUDsgquUv3wm+74r0twTozVm65hbI8d4lR6L6fU2QoiFYlfq
         VdemOlVd7tGaw==
Date:   Wed, 7 Jun 2023 12:29:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the regulator tree
Message-ID: <38913e8e-4578-4c4f-a6cd-6f6e628957af@sirena.org.uk>
References: <20230607163743.1c266a7f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3+bTFYwajOTKhLCl"
Content-Disposition: inline
In-Reply-To: <20230607163743.1c266a7f@canb.auug.org.au>
X-Cookie: Keep away from edge.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3+bTFYwajOTKhLCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 04:37:43PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commit is also in the mfd tree as a different commit
> (but the same patch):
>=20
>   75c8cb2f4cb2 ("mfd: axp20x: Add support for AXP313a PMIC")
>=20
> This is commit
>=20
>   2f518d914bd3 ("mfd: axp20x: Add support for AXP313a PMIC")
>=20
> in the mfd tree.

Hrm, that was a tag I pulled from Lee rather than something I applied -
not sure what's going on there.

--3+bTFYwajOTKhLCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSAafsACgkQJNaLcl1U
h9DoSwf+JJPbmXcuO3ZRX8iXbL8BytPcrH8QUdoL3hM6XNkFaXN4KSaYugBJTM2w
r2HvYEEa6NRHqGX5//NZFivo3hfqQbWIChbRF4a3ieVi/iwidaizI4OKYuoOy0+Z
R1vkoTVZBV7IlhPvsnMHNxZE+3ja12C8RcoPmNfJylbnhcOnFpmcRoob0KR/LL38
v8bR+x40gDnELyJmDQyXv1ereHr23PhdD1qan+tgOLaaIWDreIo3s0X1Wa04YdLu
0uG4hS5eIT/fABYrYRX3uyFDzQPkMT9hkZ7HJMg7GEm8SN7pHeqAsVTHG7/1v4Sz
ksP4c9exiwcoFIMJhW3r5t6U+ZMU5w==
=IyWe
-----END PGP SIGNATURE-----

--3+bTFYwajOTKhLCl--
