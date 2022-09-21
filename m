Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41F45C01D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiIUPka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiIUPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:40:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102937F9B;
        Wed, 21 Sep 2022 08:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A925861939;
        Wed, 21 Sep 2022 15:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C689C433D6;
        Wed, 21 Sep 2022 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663774684;
        bh=mYiIJXJEj4PIC5KpLmRt+C27ufxIn8s1y923uXrrWMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZdBJVetZPKg9XfhK3NMWJwUvuMmKNHXHAeU6k1on5HXBSm5lKiQIW9l1k7H0Dzak+
         WNx6R6qJC8WI8PtlNIlJAP0ZR/1XBauQOZixnQUe4EGhm/Id1HVGWTFRmXhWrsj49o
         SOyhpGyHsbb92QM8zcGd05ZT3GmS216HnaEhV32nIT82q+Wt6/ldlg7E6Vjf0ZtAS3
         n6ScKDrb+4KFnoCo+zZ2ORQLrhQ8RgT1BhNFFVQHixD20EnPvN3HQDkqvEEQhZf5Co
         /ASvQV+EXTwInyA2QBzJw4vt8fTh1n/5WqXJMb5y2GDnN/VkE6MZI/QYRegImZJEyH
         nhxhlIrj3daTQ==
Date:   Wed, 21 Sep 2022 16:37:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 21
Message-ID: <Yysv1zoONYyZnM+u@sirena.org.uk>
References: <20220921185740.6e19ee1e@canb.auug.org.au>
 <20220921231304.5a5d0624@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QOpJWj8MeXuw4WZq"
Content-Disposition: inline
In-Reply-To: <20220921231304.5a5d0624@canb.auug.org.au>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QOpJWj8MeXuw4WZq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 11:13:04PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Wed, 21 Sep 2022 18:57:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Changes since 20220920:
>=20
> I forgot to mention that there will be no linux-next release tomorrow
> (while all Aussies remember their Queen) or next week.

I'll not be able to pick this up tomorrow but I should be able to
provide some cover for next week.

--QOpJWj8MeXuw4WZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMrL9QACgkQJNaLcl1U
h9CJtQf8Ds+iAnfA3UsCbwajS2iOD126hrwxZH7EHYZrqz0aNVwMLGlwTPMQN+J7
dqtotqcuIZU+3IUBLjQS6t6RpyxEI2ROZ0U6E/hFYCbtPLvHU9Lsepx6Y01Loef0
4/ddGE600Y7lcaBCcU7zREP8HMlOzi9qtD2IdcxQF+rVw5T4RGo22SPt0yis/7Y9
6vOO1LUSHKxK+maSx+jKF+niWoPbRszVqCqtKjxAnTdGpGdbS14ODoBntP2tbCJ8
j8c1lM5rF/LYOYkzuOhdMDaI5/jHAIjoRm8h5v5XG/JzrNnX5xdhFD1Oa07swCYk
tyxyPatR4WCdtufecsIl2GyoUHI63w==
=W3+n
-----END PGP SIGNATURE-----

--QOpJWj8MeXuw4WZq--
