Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5D64CC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiLNOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiLNOVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:21:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7700221815
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:21:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2613FB818C8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229C5C433D2;
        Wed, 14 Dec 2022 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671027699;
        bh=XELl5MpYJmNqmidd3UXimpL3bgXtaqv3Qx+sVGvAPqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBmJ6jXJyyc33GgITfQFBmsAjvjIuBZ2FhAxvO8NIz+IGlz9JDaVXTetInukL1FMA
         b8QNXZ5G2soc0gLnvxNzk2HwaCbURQA2yHxvb3UfDMIyDqLPHvfXLFQsai9MoxV805
         0PpfTPFmFAAcLWjwr8aoCuSUg9LMU6s3kVwj80MRVILVqvLidjNaw2nTOs2EuozLXF
         LcOYKSsCdireU938/GiY5c3jNkrt4hggRMCtYboJQXd1wQ+bpQ96UNqT57R0JTyZMv
         FLbCnVhSCKlQTvwFWkU1O/jcBnxPgAI46BHVrLDKG/vV84PRFSAqunbi4KtImNorX0
         7azkTUs1EL9dg==
Date:   Wed, 14 Dec 2022 14:21:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     tiwai@suse.com, perex@perex.cz, piotr.wojtaszczyk@timesys.com,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: da7213: Add support for mono, set frame width
 to 32 when possible
Message-ID: <Y5nb7ik1cCKo+FlR@sirena.org.uk>
References: <20221214044058.6289-1-David.Rau.opensource@dm.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R02+LBkw4li2rDmN"
Content-Disposition: inline
In-Reply-To: <20221214044058.6289-1-David.Rau.opensource@dm.renesas.com>
X-Cookie: I disagree with unanimity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R02+LBkw4li2rDmN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2022 at 04:40:58AM +0000, David Rau wrote:
> This adds the DAI mono mode support and set the frame width to 32
>=20
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> Tested-by: David Rau <David.Rau.opensource@dm.renesas.com>
> Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>

I only have patch 2 here, what's the story with dependencies?

--R02+LBkw4li2rDmN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOZ2+4ACgkQJNaLcl1U
h9DTIAf+JurQw0206DrQWVPvayaIM+o/SG7RV9QRNaXEk70ookZk6hcl3EJz/1oj
oyiWMH3szulLe58B+5XRy/xJ89PErBUVvoixM2m2aS8oRImDNeQvkeUx7SyyiBge
uhYRzstdO1gVBMYNDBnAGNykMqR7qHOEVcYFkfpthiCa53lu5Ut0bxtkJO2gGWFG
Y024TimprsyIXepsSlkhi3Rd7BygilSFki0LxBAJbSuC5GidC0gB/crto0y2buGD
V/KRUmO/b7pWTW/Hysx3X48ntD5f3VHu4t/wXjM4ayg9wZDwLQnXmyZpy0fLEdyc
rcSzeIiiB7ARoeZ4N/j1QBycB8UWQg==
=Ts+T
-----END PGP SIGNATURE-----

--R02+LBkw4li2rDmN--
