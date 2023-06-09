Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F272954E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbjFIJdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjFIJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:32:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57C59E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9069461ADB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6742C433D2;
        Fri,  9 Jun 2023 09:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686302829;
        bh=cWZeV8HVLa+sC4JHhjCUy+s2S2gLf+9/1DXpIeyFYsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O621Fiivi0bNAlMfCzAZm3alagGposqSf3GowogB11NpioSBflfNUX3/X+cotI8Ec
         qUOU2AydPs08XSDckyNlqZ3qNnNiP7l7IBIH4WprlD2BgU/cfu/AjVqt3u8lhmzTER
         Bz0ihGJ9/VQ/iuLOUFzQW2Sf1NvQ5ARk/wQv9c8PiqyXCHukNQWYnXL4DMOLF6qjfC
         8RBeh8sXTOOGUF4mx9rSRBJfDS4euptL8Z7WnAwonzceqCeU+HC43QM14foBvr7GhR
         l5BHSgv/zZjpWN51zU9D+SRGveNcHsWbAIqFQ8tmjL2TTf8GHcwnSwMda+F+TsQY8M
         HiMJlbpvJR6cA==
Date:   Fri, 9 Jun 2023 10:27:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, festevam@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix rootwait= again
Message-ID: <7523e53a-9124-4129-8fa5-2adda1a7cb61@sirena.org.uk>
References: <20230609051737.328930-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p39CFgCe1xZpy2i7"
Content-Disposition: inline
In-Reply-To: <20230609051737.328930-1-hch@lst.de>
X-Cookie: Tom's hungry, time to eat lunch.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p39CFgCe1xZpy2i7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 07:17:37AM +0200, Christoph Hellwig wrote:
> The previous rootwait fix added an -EINVAL return to a completely
> bogus superflous branch, fix this.
>=20
> Fixes: 1341c7d2ccf4 ("block: fix rootwait=3D")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Fabio Estevam <festevam@gmail.com>

Tested-by: Mark Brown <broonie@kernel.org>

--p39CFgCe1xZpy2i7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSC8GcACgkQJNaLcl1U
h9ACcwf8Dyy/hwK4ZQmupvSHm2MQ1uRUi8Z/Fem2XexPsIbiTKLAMWIZ9tN66l3K
NwCuQyuAqQPPfF35xXf7zsSqoQ7olnSQ1jvpk9POtGbSalS8JcZSBF8I3BqdqTnb
ZxAkjKrM1ayNQCmb1F0mQJlhpmAB76VnWvrnx5J1lpwc0CaxYWDZdyqHPm6gOz3b
0zZM6i8zeOjddkb9DMRvXMj9Bu7ZppIPAR//MJPgf4UfwN2zL0VlNZ89GZud9VFo
48TXju3e/+t9+b4VT1pWBnf2zDyqylHieJCOYUUeyB2x/mUZufH1HPPt6J/LNpgz
JwBp9RsJTDM4vWz+jpfVJ7ShClDHbQ==
=W8xq
-----END PGP SIGNATURE-----

--p39CFgCe1xZpy2i7--
