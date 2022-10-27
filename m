Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EAD60F74B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiJ0Mbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiJ0Mbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E39C58B1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AFFA622BE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5399C433D6;
        Thu, 27 Oct 2022 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666873894;
        bh=jB3Sy3lQh+g42Om28hBG9fQIjHlM5JaLLJYyHJKWjqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4UIJiMZIz803b/bD8pE8mTWS4jlKFxUWbFy6b/ooalf6/SBwhR2KLD013OKf2l84
         pEmCH7LGUlyOyTevHgooK/A8DOTbW6/QtvAnhcox8o3l+8SfVz2hUJDsft+TaPvqTz
         Fu025ZDYu7KNjrddMFEgmJCkmL6gyjpQGzaLkWcfhb9W2JtaBSMmX/AZQ4q6pItkzs
         D6E2/1aLy6dOk27kbUkmJxfgF9pwCM/ssEHxTGsEQr+sxZ3y7XXRXghAtT+ezj7s8Q
         paWMeMTOuE3+wQw7h/Jbm31FwNRLT/odwnS9zji+/g/nmkXZ8fPKFlmCLucfI3IY0X
         xlc83wz5aI7YA==
Date:   Thu, 27 Oct 2022 13:31:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Bergin <peter@berginkonsult.se>
Cc:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoc: cs42xx8-i2c.c: add module device table for of
Message-ID: <Y1p6ILuOA6Dgjh7o@sirena.org.uk>
References: <20221027115057.442925-1-peter@berginkonsult.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jdB2L9eetq1D28fw"
Content-Disposition: inline
In-Reply-To: <20221027115057.442925-1-peter@berginkonsult.se>
X-Cookie: Forgive and forget.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jdB2L9eetq1D28fw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 01:50:56PM +0200, Peter Bergin wrote:
> When trying to connect the device with the driver through of
> it is not working. The of_device_id is defined in cs42xx8.c
> but is not correctly included in cs42xx8-i2c.c. Also add the
> matching table for of in the i2c file.
>=20
> Signed-off-by: Peter Bergin <peter@berginkonsult.se>
> ---
>  sound/soc/codecs/cs42xx8-i2c.c | 7 +++++++
>  1 file changed, 7 insertions(+)

This should move the ID table out of cs42xx8.c, not just duplicate it.

--jdB2L9eetq1D28fw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNaeh8ACgkQJNaLcl1U
h9B8CQf8DD7owUCdSXZJtO0j/G7dVE9/97tFr5nvpkSXlsLfX2B9h8X7EB5RX9WC
6JaI0Ord7nqIj+NZXtxdakI17hpTPZ8Jxm9CDNCb5VHFp9GxAF+wh06Q4JdPysSk
IpQ4Hex72fTd3N2HyyXIf5si0GzJ5kGxwyeXinG/ScudKzngfNlA12q+Pt3bfu0H
g/9sNqirIYaqgHeacnJ/Ns6KLc/ZK9wLTrEFgu6rsn+CVo3aBmAXeyz38RA2g+lz
RqM/3xUYFWgBXtFKw0Mziw4CYMvq5EJ08FJCrbP9SEGDyg010P8YFfnkZrQP+7PJ
3W66WXwqwdbZeuUh3BIDM5bApty4Rg==
=zgpj
-----END PGP SIGNATURE-----

--jdB2L9eetq1D28fw--
