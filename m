Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC373A0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFVMNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjFVMNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA66199E;
        Thu, 22 Jun 2023 05:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E2DD61807;
        Thu, 22 Jun 2023 12:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05272C433C0;
        Thu, 22 Jun 2023 12:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687436009;
        bh=PGOGQGOXTZziMMV8nEYl3izDXzKlD36UBk87Cs8a5Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qg8ETrRo6Fh49qASL295/66y1yxMWmP5rwPmEcppgEw6EIyO+evpneQl9i88UGlR3
         2Ry0++2IJkFPcosKI0xsQpQSNT8azxSK+YhwsX8Qrq78D2qLvywdWrn6VN2vCvdOVc
         vrodZg7mIRCwLL0ulQ3C2OjxyS9ooPWrgvEdy93TX0Eiw4SRWb4R01u1jWDtkX/MCR
         aGiBiBs4WXUS+Q5LBEWfR/W7RVHez0U2O/U/NV7GhCnU/65Jd6t+kf4BKFh90KBEcV
         NES4r+wJN1X44Bwkgfh8UOknDwNXHA/lp67xpOf2eA5v0jhHFQ2mtydvxniXqWweIx
         3HfFsXNUcOrrQ==
Date:   Thu, 22 Jun 2023 13:13:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 7/8] arm64: tegra: Update AHUB clock parent and rate on
 Tegra234
Message-ID: <410e46f1-11ab-4775-9328-48aa45906b48@sirena.org.uk>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
 <1687433656-7892-8-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MhoiR7vHGfkcD/ZI"
Content-Disposition: inline
In-Reply-To: <1687433656-7892-8-git-send-email-spujar@nvidia.com>
X-Cookie: Please ignore previous fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MhoiR7vHGfkcD/ZI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 05:04:15PM +0530, Sameer Pujar wrote:
> From: Sheetal <sheetal@nvidia.com>
>=20
> I2S data sanity tests fail beyond a bit clock frequency of 6.144MHz.
> This happens because the AHUB clock rate is too low and it shows
> 9.83MHz on boot.
>=20
> The maximum rate of PLLA_OUT0 is 49.152MHz and is used to serve I/O
> clocks. It is recommended that AHUB clock operates higher than this.
> Thus fix this by using PLLP_OUT0 as parent clock for AHUB instead of
> PLLA_OUT0 and fix the rate to 81.6MHz.
>=20
> Fixes: dc94a94daa39 ("arm64: tegra: Add audio devices on Tegra234")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sheetal <sheetal@nvidia.com>

Fixes should come before cleanups in a patch series to ensure that they
can be applied and sent as fixes without dependencies on non-fixes.

--MhoiR7vHGfkcD/ZI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSUOuIACgkQJNaLcl1U
h9BQ/wf6A4ZIp6SU+zUdNVkskOaaEKPYmqfrTPDbpRk/OjSwjwUkjhFHjTHRqgru
XB1GbDE8bpF3kcHit/PkdtdrUmYNyfrZ5PNmv+56UlyObu4TBSr6hkAieHg9HDF4
Oa9hQ0CxfK/IOmUKPG+uSZtXcpk1orWMzx/Q1Yg5RpikhgodSsBwUXlkw79Q68FY
ybogyto/jHAUshuJ9PsP9T9SEs2hQKKybh0ckaXIXI4XYjXkX/D2Ds91YAGxmKnz
DOhIpH8tASXpujxD2mdYoX62sIKrUdtirlgAMUYH8RUbPL7+NiZrL+9H5J/vPLmZ
zxRtzlYRZN88Vt8t9ah8dI8kFm/56w==
=bQo1
-----END PGP SIGNATURE-----

--MhoiR7vHGfkcD/ZI--
