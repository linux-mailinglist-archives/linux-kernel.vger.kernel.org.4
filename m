Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9156067E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJTSHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiJTSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:07:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B215ECF0;
        Thu, 20 Oct 2022 11:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24EA2B8274A;
        Thu, 20 Oct 2022 18:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32644C433D6;
        Thu, 20 Oct 2022 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666289235;
        bh=a/CirfHVh8b3ZDdDKkjlFwXw3bQiZRvXewi5RbBI6DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0eDlrSPmUKrwYq5VpIV7sngQKzukZuEP1mHuvxzpXjCuyGf78PGpL9y8sh8Rhqlk
         1NDMrYrvCj8Gtone9uWlnK9iFl7rJ28YGZIJMrd9TiE6EIBSmOuYsM54IrmEvaWDB0
         JD9aSVbefYsCSerm6dM4E0FkEIAkp+KCQfDFpacePHXwILe1Cf/Wo3h90LqUUtjVvT
         lXt3FHks2+4XkhKVpMBqUjM8dX0t41VTo72y+JFsyMHc0jvXgOv3+VKqVHG7L7S1Ih
         I9BDnpiZfBDlsJe6DYL/PSBBBEgyalma7KXjkzj+ZAFv5f9RSvvj+Ckdl3fPs5e+qT
         MH4QYrtpUY3RQ==
Date:   Thu, 20 Oct 2022 19:07:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1GOTtYIeOFmrmm7@sirena.org.uk>
References: <Y1AczgwCEQO2gvQ2@sirena.org.uk>
 <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
 <Y1F2a6CR+9sY66Zz@sirena.org.uk>
 <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
 <Y1F+Pw52nN195qDO@sirena.org.uk>
 <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
 <Y1GEqa07/b25utui@sirena.org.uk>
 <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
 <Y1GJL8/YfeoUy8wB@sirena.org.uk>
 <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BRFCv6Eiimv8ODUL"
Content-Disposition: inline
In-Reply-To: <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BRFCv6Eiimv8ODUL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 08:55:02PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 20, 2022 at 06:45:19PM +0100, Mark Brown wrote:

> > Not sure I quite get what you're proposing here but I *think* so,
> > assuming you mean checking the values if the property is present (and
> > error out if the property isn't there at all and you're instantiating
> > via a MFD rather than direct PCI/DT binding I guess)?

> When we instantiate via MFD, we (semi-)manually create resources for each=
 of
> the children. These resources may or may not have a dedicated names. Those
> names can be given _only_ inside the source code in the kernel, so it mea=
ns
> it is _explicit_ telling, that we are know where the device in question c=
omes
> from.

> 	if (resource_with_name_present()) {
> 		ret =3D device_property_...

> Like you said, checking property only when we have resource present _by n=
ame_
> and bail out if there is none.

Remember that device_property backs onto fwnode so properties can come
=66rom _DSD properties too since fwnode will query any source of
properties (and further remember that things will be going through
multiple trees so even with stuff purely in the kernel things could get
out of sync).  I think the code would have to also check that it was a
MFD child at least, you couldn't get _DSD on a child node so that should
be fine.

--BRFCv6Eiimv8ODUL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNRjk4ACgkQJNaLcl1U
h9Aa5gf+Li8nAm1wcGGB+Y07UKUpEKCSK0gYWI+WrjeeVhnJOV48ruFsHVy4V9Eu
2ODR1xr/oY6Pu8Mc31KwO7btICMmGS9RJRiove1+oJQVS6SUUGV8x5jw2eBLy1wY
uvBtLsScl1UNr+rQtSyjodWQwglWL2Fpz43dsp+86RyhD/HcmmJ9uJlK4tvQV1Hp
NtbgYTpx/ENhpw9RrKgSXlOp4Q0UD3cKpTGq3t5jKXYiA2g+xtgN+yurmZZU7E/+
T528tYGmJ+rsIKXr/OuzaPiccRL07JZ3x3++ro0ntbKYtve50svenz6jjmt8vJ0B
8i/ykM6qu6WbMu3WsZyPwwfDodOKow==
=8/xp
-----END PGP SIGNATURE-----

--BRFCv6Eiimv8ODUL--
