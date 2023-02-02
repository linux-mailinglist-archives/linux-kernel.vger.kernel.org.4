Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90A56888C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjBBVJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBBVJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:09:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222D4712D3;
        Thu,  2 Feb 2023 13:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F24DCE2C9A;
        Thu,  2 Feb 2023 21:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD2C433EF;
        Thu,  2 Feb 2023 21:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675372193;
        bh=7pj3Q04mglkAHU9R7M/fyCJkxPB/t6ObwgRFG5d6NqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0emkEoiA9I0KbTjXxTrG0QIVNUCsCqZWPtqOeRXq6MWFM0eVBnwrHZ7ogfNzhLas
         sh0+37XDzZQMaPE7ApWjTgPBnuSYPAyse/LbG7B77NNelG2vQppCOFmYHT454S9c5i
         Zg/GkRWomOCciMWN8b5YW7rTqsbxQsTfTR6JWtg2brDi25zAlt/0pAbTqMRrAOyZd6
         iHtlMY9gWbxKjiFh7q3P3hcYCYDTtTMSpxPnoeo4EH1ny8AHft/nTO/6iWjpE/HtJF
         /zvAMbD4YA5+97mP6YEs/dM/de+o8vGsXf+Am9lR1oyWNSM6dX9wip8KA8lkzOcwhm
         RqWyIx/T95sYA==
Date:   Thu, 2 Feb 2023 21:09:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Message-ID: <Y9wmnfTi/p4FuRmd@sirena.org.uk>
References: <YzIzUjUuJKf0mkKg@work>
 <fcd83e77-a3fb-9061-771a-8509ea6f5950@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAhHNtSkqZO523WD"
Content-Disposition: inline
In-Reply-To: <fcd83e77-a3fb-9061-771a-8509ea6f5950@embeddedor.com>
X-Cookie: Swim at your own risk.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eAhHNtSkqZO523WD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2023 at 02:34:17PM -0600, Gustavo A. R. Silva wrote:
> Hi Takashi,
>=20
> I wonder if this can go through your tree.
>=20
> It's already been reviewed by a couple of people. :)

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--eAhHNtSkqZO523WD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPcJpwACgkQJNaLcl1U
h9A/vAf+PnLTOL+T2xyGoUbHCmmknCRAW5rThtQnG1eP4MK+E9C0f7ez4U++B45u
gtx3srMbZtTrLia7pDg3/Uy2xhdjUjOE/u/J9VzHyr1AyiTmLZcse/B2UsjfA7UN
iTMhls3ozwnVOvJSY7diCuIcTn3gvxIWtfq0Vl8mulzqdOMl1xDUbVF5oAODR7B0
1iYvJ2av1ZXfW1Bp0pM2tpOo62V8cB44WqYgDe4PEYQ9IobTdBGWtmo0FbQVSLpc
evfsMMmUMDTrgJXzEikD6pUc+J/ExBTuh3K6hagoCfKci3MBNIx5TxFBM00YlB56
blbuDvwS4PEcbJgtWOOuBj6rnhfffw==
=EnD1
-----END PGP SIGNATURE-----

--eAhHNtSkqZO523WD--
