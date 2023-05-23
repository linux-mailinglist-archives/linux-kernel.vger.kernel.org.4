Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110F970E03C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbjEWPSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbjEWPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:17:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DF1A6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD2461713
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990EBC433D2;
        Tue, 23 May 2023 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684855051;
        bh=bwctC7XYmQln4TsZqiaxhSdZk+qn8u+7yeiXE+He5Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtHTCOiVrz3CKC5P+x7iWv5gMHFFCwdPAx7+hpxn9DaGZvBsYBc1xwvG8qSonDDkk
         lTwpBWxRMJXzIKsKvgH5+/zzfsfbCv/VU8m2SpGA6XP5/ERFMtvA3ucfCKSnELvL/Y
         dhS0zTyGkUsQiukeFEpQAt49K4B/7FZHEtHSKgg3FUvca+/8YdHKyDtq7zr21g4p50
         DtDR1HSIeH9wtpM5XGdBo7wh1eNIqXps2vcDsilgY/FPjqJDZD1fg1DNwd33oJtlGK
         Cy3Xn4oaEOJ/rRdqAuo7eMtF5WgZy58CKeZceFlHYD4U3xXfUziqRoCdWYvP91YfqY
         ErS0p6fClznKg==
Date:   Tue, 23 May 2023 16:17:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Osama Muhammad <osmtendev@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Streamline debugfs operations
Message-ID: <96def590-4ffa-4201-a1b8-0ad2c8ec718e@sirena.org.uk>
References: <587f259fb8634daa268595f60fa52c3c4d9bbec2.1684854090.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YDPNubV4eKLZEE7l"
Content-Disposition: inline
In-Reply-To: <587f259fb8634daa268595f60fa52c3c4d9bbec2.1684854090.git.geert+renesas@glider.be>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YDPNubV4eKLZEE7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 05:03:58PM +0200, Geert Uytterhoeven wrote:

> Fix the error check on the return value of debugfs_create_dir() in
> create_regulator(), which was missed before.
>=20
> Fixes: 2bf1c45be3b8f3a3 ("regulator: Fix error checking for debugfs_creat=
e_dir")

Also: this should be a separate patch.

--YDPNubV4eKLZEE7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRs2QYACgkQJNaLcl1U
h9A47Qf7BA/q3tmUIC7I4n6SXQ4RU85CtXIPGWGNk+FGhsIoXErPO3BuO4N8HVrj
9TuG+eH+XtFopbVj4d7yPBjBi/RKsc9e9npZm6X2Dlv3ZUUtEXkvQx2fVguku5sv
TmVCyF7aLNHQcXhp13xdwBrQXOqkZdicXw0tgMgP6+cnbVUWoMVg/wQRACTWiQ/N
BwmleISgtQj/blaxDYMzqk9hVI7We5Go6/sfs19EcpH/EVoWepuwMpnlP0Sq9Wbh
Qb6q6V8gDfGvSnYtyPR/+99iAWP98uz/orFguzXzbRvlXjMtLA7hADLdOvInxBFD
RJpxzJoQ07cedKAzbTF+qYZ+9qitbw==
=XfmV
-----END PGP SIGNATURE-----

--YDPNubV4eKLZEE7l--
