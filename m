Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AC261803E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiKCOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiKCOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:55:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE31A22E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29ACAB828B6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAB8C433C1;
        Thu,  3 Nov 2022 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487290;
        bh=J/Mrqt5cSb9EmAuVlO5p8mbv49K7Ek4GmlqoaL+qCUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqMKcozu8B/5nZMtK358scAF3GdP14NdM4nYi24GLKl5eNmjrQMaww8seGxkXQso5
         /HahNH3m8FAsbWWkpKqsfjaoTK1yAAs8VGtpglRY/C/2L4yt9bkKG1EmlZU6G0dOA0
         d09wpnqFFGKW4CpjRirLbHpUvI5+UM4uRozSnnLSSJZJj1GV4kqZ3ZpidIvbJQgXfj
         y/KY53cyuBBYSm4vEUUzRv1gJrLviGC8UF3WpsF3IUYhCdZ9uTXsSuDPgAHf7zP7St
         oWNkDZg6SSQad1YPi37YM72rZirXWg+9vwYamkLylXKhzNqYmSf7Xm2cpJi0+1nqBa
         qwyjV4Z2ZhvUA==
Date:   Thu, 3 Nov 2022 14:54:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au
Subject: Re: [PATCH v2 1/5] regmap: Add FSI bus support
Message-ID: <Y2PWNYfu9l5rRznX@sirena.org.uk>
References: <20221102205148.1334459-1-eajames@linux.ibm.com>
 <20221102205148.1334459-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yawlT2jPO1KGCfcJ"
Content-Disposition: inline
In-Reply-To: <20221102205148.1334459-2-eajames@linux.ibm.com>
X-Cookie: Dead? No excuse for laying off work.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yawlT2jPO1KGCfcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2022 at 03:51:44PM -0500, Eddie James wrote:
> Add regmap support for the FSI bus.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/base/regmap/Kconfig      |   6 +-
>  drivers/base/regmap/Makefile     |   1 +
>  drivers/base/regmap/regmap-fsi.c | 231 +++++++++++++++++++++++++++++++
>  include/linux/regmap.h           |  37 +++++

I thought the plan was to put this in the MFD since that's the only
user?

--yawlT2jPO1KGCfcJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNj1jQACgkQJNaLcl1U
h9A//wf+IMeLVf0fj3uWgLub9DNpq1aKtVk+bYkn69LXBSojQycNicxzTKV88v9i
xdSpLSvRiMutQLUclG81UfEW/eTGh8MmrU+fzqGJT4/UQKLRr0gxy3TMyCHbUrHC
0nBVh6cyM+yoqk/gaMwE/ewO2bwaB6EhXMHTfQdGbg/fx9ww1pySkJgAuXRv7MId
aYLgvC+o5r9QzNHaZRo8LeKmEqjsiY6/gj4HamwQ4mvHmOkLFdLwgVix05nMjff2
I3BsjzXeG4ghMcCYlfyWDQijGo2fCk3o+fdG8da+QTtK1YAnj/DTuBifctYfOCEu
0470h5mkvGff87M6K4ACf+tvBQpKqA==
=JOfd
-----END PGP SIGNATURE-----

--yawlT2jPO1KGCfcJ--
