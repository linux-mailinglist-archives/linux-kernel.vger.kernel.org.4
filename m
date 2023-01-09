Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1651662653
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjAINAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbjAIM6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:58:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A7927194
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:56:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EC0BB80DD2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E48C433F1;
        Mon,  9 Jan 2023 12:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673268977;
        bh=LR9BuGWChT03M61XikBm8S6FvKArWqu7e6r0lnM1Des=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8YZbq1wXlkRtGJCtd2CEMKqep79EsUjzCV+dKVr5bWdhFfSxJpUeDcAW9aZsmBc/
         VUXs1If7eJqiFSGXs/mwLeu0+VHL3vzQImE6Al1/ZlGIrwqvjpwF8fTvcdaCxDoMvr
         P8RhG1xzNQILim9e+lmWZvcD8LRY2AL8dBuTgHDeKU2Rh41KVoKSCeP8Md3MOHjPn4
         kB5ZLokjDxxXJnENiMoySOe+qMCmypgF2MyK8EY4+zbFXzmmh3NgWqwsSW/J1gi6+t
         uEuFInJO+OD0eQ4XdF4RfrQzNgnXPG0cIfw4OoYuNjHDAgH+74a8QcrShxqkFRtLD4
         5ntE1OQKjPEZA==
Date:   Mon, 9 Jan 2023 12:56:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     syed saba kareem <ssabakar@amd.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, lgirdwood@gmail.com,
        Syed.SabaKareem@amd.com, ndesaulniers@google.com, trix@redhat.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: ps: Fix uninitialized ret in
 create_acp64_platform_devs()
Message-ID: <Y7wO64ZkCeUPWVB6@sirena.org.uk>
References: <20230105-wsometimes-uninitialized-pci-ps-c-v2-1-c50321676325@kernel.org>
 <6ebdd688-a1e5-f687-2842-b5005fdd89db@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d7IcEJuYnckhwJud"
Content-Disposition: inline
In-Reply-To: <6ebdd688-a1e5-f687-2842-b5005fdd89db@amd.com>
X-Cookie: Editing is a rewording activity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d7IcEJuYnckhwJud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2023 at 05:00:11PM +0530, syed saba kareem wrote:

> > Suggested-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Reviewed-by : Syed Saba Kareem<syed.sabakareem@amd.com>

Note that if you use a different name (here you've got capital letters
on the words in your name) or misformat the line (you've got an extra
space before the colon and are missing one before the email address)
then the tooling won't pick up your tags.

--d7IcEJuYnckhwJud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO8DusACgkQJNaLcl1U
h9BlZQf+KmHcOAEx+KzXe6nxDhZ64/CKq9lEbYNhdPrklgJcid8BwlvHD0Y4z8+x
eeXadCbsaDoAwplTFYWbFXIcFlDGOBMU0Dp0ogI3rlrNFijEo8ztgYnD5OWXAlqC
sQL+S5fShD0Ocnzc7fHIsFvtCTBVd2iepbCYHX+tCxCEWS4dV4F2Lk5K4YEVtHfe
bcNVe7lRocKUH4efMZnw+6GH2lED56cArgOMRMyv3SNIn5bxBlZojBpBnFcLsgYh
PCHyQyz5IlypaKdC1ifMbPg+zCwcHHxwkWDQvV7O5TzhKwt94UpBNPPnh25aVh7W
1lshclPhXWdYQ0PgLoD+W2Seqkn9cQ==
=raZ8
-----END PGP SIGNATURE-----

--d7IcEJuYnckhwJud--
