Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E274DA97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjGJPzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjGJPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D871D187
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75AEC6109A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998D1C433C8;
        Mon, 10 Jul 2023 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689004493;
        bh=uvc85Z/Y/Db4zEzIg2Ey1FEQ0IedwddjKgZyzbUnWr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fADFL2VM/uAvW0XxWchrVdb82DIefqNOm2YNLdWyluqOIF+N/0tciZARIcX31Zd1l
         /PQeL3WvbsbTiuKl+1MnZYdENHL4kG/jkNKigJmtNd6Evg3g3OypmuzS508TbYwCfL
         nRDGnOv/Aa3CrGUFB6lxmzhSCZTv6qq8mLmHWDIz0bfEP5pF0ffye5M1jaGJpjcBBa
         +qFoyjCXPMOWYrrGg0/F2xfFcUTNWrYkUSvUzhzMWVTZ+7aEyQxf6CTOuddBzqKthi
         StncoUBjrTgYr/yxtw6nfK7euREVCoE5DRgliHm9rmN/H8MACGeAceS5XMSM9EQTCh
         WweQ0Dg4yR6xw==
Date:   Mon, 10 Jul 2023 16:54:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: spi: Use spi_message_init_with_transfers()
Message-ID: <31140448-98c6-41a8-b3bc-de8e5a17da3a@sirena.org.uk>
References: <20230710142335.66598-1-andriy.shevchenko@linux.intel.com>
 <17de613f-c417-440e-95c6-3cf65607dc99@sirena.org.uk>
 <ZKwdW0l8NlDx9Rnb@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4RF58DCFcjc3ffbq"
Content-Disposition: inline
In-Reply-To: <ZKwdW0l8NlDx9Rnb@smile.fi.intel.com>
X-Cookie: Do you have lysdexia?
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4RF58DCFcjc3ffbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 06:01:47PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 03:38:55PM +0100, Mark Brown wrote:
>=20
> > > +	spi_message_init_with_transfers(&async->m, async->t, val ? 2 : 1);

> > I'm not sure this is a legibility win.

> Fair enough. Since it's not an inlined call, ion x86_64 it gives +64 bytes
> to the code.

> Let's drop it.

Sure.  The ones without the ternery operator are fine.

--4RF58DCFcjc3ffbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsKcgACgkQJNaLcl1U
h9APZgf/Rm3ZhAKPQ1zJI81gP3LK3i/0+EciG+42QKyC6OSdlz3W31JA0cZl8LWG
GbflE99bWoCqK4uJUgyCWPgz6Z9VtDW95wrFMDX9a46s1jO4lPpJmt9KyWG7vaDR
QCPTBST0QkJU5AJ6Qkw5kHpFlOVDPs+gkRmHO+nP3lDPlFTcb34+UONQev5g/qrc
C9KpLdf0nYpdWfLa4Baoyi6iVOcUf6gy1LB2b1U1wvjcGJJ1lzlp86qVxgX0UjXG
MAFXyz2Stv6qmJfiCoaNu6CPy53F+jDtlbW/LmSpXgTP3O8GBD9RhT+PV5SM1Szu
AaDbKCLV/Js00P3J5BnVDrbUgSulww==
=5Eba
-----END PGP SIGNATURE-----

--4RF58DCFcjc3ffbq--
