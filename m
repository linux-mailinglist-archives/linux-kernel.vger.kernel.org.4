Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908D06F080B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbjD0PPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbjD0PPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB6D46B8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A82563DC1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECECC433EF;
        Thu, 27 Apr 2023 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682608543;
        bh=V9IhCG9PqemeCE3Qpq3sG1yB+zpcZYg7iAHmogiH5dE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IY7pN3G3jvke8e9mAO+bGzpaclxNpETDlrGPcrujTLdysJq0jpF8LO0QcwuGdkjtj
         0v9bUNfVVy/kgTISSJpgTL5tZC7Ubn1qAyjYceGd2K9TyAUhCs6fhhFEWHywy7Oxsc
         sw3ofMYDBlugcajGlsgdPWDDgXCdr6QSwupa6SAUczMH8eN7sEprupZry54j76ndaf
         /evj570FKGggnfDqMW9I11D1MF7fU8DGlVAUZWLK1NiouRqcmfPoIKxYziTOJ2BlOo
         qLGXHOwXdmjcZIkkDAip0E+z+C7659BtTKhklBcZgxcWsg0k6dNzjmh/dwkk+XF0D+
         O8ZG1ZPs/Y/+Q==
Date:   Thu, 27 Apr 2023 16:15:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: wm831x: Use maple tree register cache
Message-ID: <d01e8784-5fb8-41e5-bbdd-8983f559c4f0@sirena.org.uk>
References: <20230419-mfd-wm831x-maple-v1-1-e03e39d7bb0b@kernel.org>
 <20230427151134.GW50521@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LttHvgb6LLjcoLby"
Content-Disposition: inline
In-Reply-To: <20230427151134.GW50521@google.com>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LttHvgb6LLjcoLby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 04:11:34PM +0100, Lee Jones wrote:
> On Tue, 25 Apr 2023, Mark Brown wrote:
>=20
> > regmap has introduced a maple tree based register cache which makes use=
 of
> > this more advanced data structure which has been added to the kernel
> > recently. Maple trees are much flatter than rbtrees, meaning that they =
do

> Applied, thanks

Note that the maple tree support for regmap has only landed in Linus'
tree during the current merge window, I wasn't anticipating this being
applied until -rc1 due to it being sent after the merge window opened.

--LttHvgb6LLjcoLby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRKkZoACgkQJNaLcl1U
h9CYcwf/XZP9qGcOhhUjg/kYzz4RZ7K9AAxma4fMWLOEOtg7YVzwBIPq4+gdlJtN
FtcXYmkLdlvAgEvZ26WAqXl6lGjIB9Ljc9K+yU+PHbYKtVpPMC5xouYEBnmmp2VY
jM3+qjaIkx8+X1pjPc4YhRDhH87nqKlBoNGjjJdKPesmpUzSfl0pmc6L+0ZAWzWS
qAsNg8rbpf2sM5dgy4F1TxmZyz8mTnfCX3/AgZuChCVl0G30qbXlLrULOQ0ZMtLT
BEuqVfW9eKHxR5cdmrazhkvdKy7CkThxehIdwkfH/j8eHOaFkkezMHsMrX6+hDgz
ZxqxAE+lzS8utRVzNDKb1n6YLmHb2g==
=wJh+
-----END PGP SIGNATURE-----

--LttHvgb6LLjcoLby--
