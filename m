Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5BF6F9CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjEGXiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEGXiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763CA1BF7;
        Sun,  7 May 2023 16:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04D1161017;
        Sun,  7 May 2023 23:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EC8C433EF;
        Sun,  7 May 2023 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683502729;
        bh=WmmGaEaDKGwBE2JtCM7J4OMGZbrbtEfQo53Aio6mxLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKufYhEJvGRZrv9rtyK9CX6lt1XhzPJ0jCW+mBWu0ovohMHGsODOuJ4PeypDLyXm1
         yF8ENUuOXKaDuLTzTjU+0OICsRkc1OaFrhc1J/ZALBvYiOSh+l2nl4cBH0PF3fcmQ/
         ZTaLJjzxeCoixomjbRL2/209wSiK/bQlGUnmfa+i+gEWCEJrZqZFdMQNbvkscaYT/+
         kNaV/T1mWTUzp9aaztyA7PH/0FnL/+Pcr3atssBwDYwlJb55HsaxO8A48xZQPEVx/W
         Xs+t3r27Snzf0Y5KGdQeMa/TAIrXl+oNv5bUsn6EymPU3w4ViMdpebLAnmUogHHhAO
         c4Xm+TmjOkU8Q==
Date:   Mon, 8 May 2023 08:38:44 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Svyatoslav Ryhel <clamor95@gmail.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, jiapeng.chong@linux.alibaba.com,
        ion@agorria.com, robh@kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.3 06/24] ASoC: tegra: Support coupled mic-hp
 detection
Message-ID: <ZFg2hP9ed1hz+tAl@finisterre.sirena.org.uk>
References: <20230507003022.4070535-1-sashal@kernel.org>
 <20230507003022.4070535-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y59NH35YlGEIWGGV"
Content-Disposition: inline
In-Reply-To: <20230507003022.4070535-6-sashal@kernel.org>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y59NH35YlGEIWGGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 08:30:02PM -0400, Sasha Levin wrote:
> From: Svyatoslav Ryhel <clamor95@gmail.com>
>=20
> [ Upstream commit eb0b8481c2e03a5ae01f6bea60b42109bd12b6fe ]
>=20
> This quirk is used for cases when there is GPIO which detects
> any type of 3.5 Jack insertion and actual type of jack is defined
> by other GPIO. 3.5 Jack GPIO generates interrupt and MIC GPIO
> indicates type of Jack only if 3.5 Jack GPIO is active.

This is also a new feature and obviously out of scope for stable.

--y59NH35YlGEIWGGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRYNoQACgkQJNaLcl1U
h9DUfAf/fJSrvAFvB2PEgnbZ7+HVKFhP+DVHDcWAPVfRTxH65rP2P7zHxSCvw2bl
io/USGxVZvTVnbsIp/rn/SLjv0SuLrazlhSuWED4ejyX9OsZQa4H0bRHOqRPmVjw
001Af8uWmnAScDqUc/aL7H90QpkEqeLA+K/QKn0xS4hIdTp22mW+fY3YV2J72EMc
VYb6vlxT9Pf0lLKYYUrKmUXsodwPiG0kggfdRlNg6iTR65+ZKI/JcuZAR9p7jAyf
jn4JxG34aEhZ8p9dqA/OxJx/KQPik76KZKE/ECDGRzYDbBPdQgSSkxqUve9y/dwI
oplIizRdi8O8D6jw+CbfEH6UjCXvZA==
=rKBH
-----END PGP SIGNATURE-----

--y59NH35YlGEIWGGV--
