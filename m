Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68ED745BA0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGCLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D9B11F;
        Mon,  3 Jul 2023 04:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D04E060F06;
        Mon,  3 Jul 2023 11:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB618C433C8;
        Mon,  3 Jul 2023 11:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688385125;
        bh=tWLIM36/qhMTK3dKk+SyaW/zoQVACHitHMR1wS12wMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwiBX/wX2djUuYWLea04jp8XCLbq6tT+jNy1zxi8r9Vc/1fJuP3PyWRfehZTfIECJ
         G+uEUX8A6RW5kbMmASGvMRq8fmfSa06m4mK5xwMSgZx7fzO03BqNW+m/HsWXTUBpC2
         +9u+XhAqqNxSOsdRvl2DZlEthmulrkBm8GnqDKY5tx35J8fdLOZ/Y1Phayy/hWmttB
         +6+Oa+4Dkkuoq54Fqat5ghGjOeagdAd6gW/xH1+UywfVQX+kQfW1jGqNnh3ljeON1D
         ddgPMoHugjL5lFqMDttkHf3S0l2M3VSf/LMBRggRcdPU1OV8g3G5WO7Y6x/TNL2Cy7
         8ira+l2OxETpw==
Date:   Mon, 3 Jul 2023 12:51:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com, amit.kachhap@arm.com,
        maz@kernel.org, anshuman.khandual@arm.com, joey.gouly@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 07/12] arm64: cpufeature: detect FEAT_HCX
Message-ID: <b37a9f79-97a8-4f74-a25c-b51128fbc9bb@sirena.org.uk>
References: <20230702195057.1787686-1-sashal@kernel.org>
 <20230702195057.1787686-7-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xpLZgx8TwikDZmE7"
Content-Disposition: inline
In-Reply-To: <20230702195057.1787686-7-sashal@kernel.org>
X-Cookie: Please go away.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xpLZgx8TwikDZmE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2023 at 03:50:52PM -0400, Sasha Levin wrote:
> From: Kristina Martsenko <kristina.martsenko@arm.com>
>=20
> [ Upstream commit b0c756fe996ac930033882ca56410639e5cad1ec ]
>=20
> Detect if the system has the new HCRX_EL2 register added in ARMv8.7/9.2,
> so that subsequent patches can check for its presence.
>=20
> KVM currently relies on the register being present on all CPUs (or
> none), so the kernel will panic if that is not the case. Fortunately no
> such systems currently exist, but this can be revisited if they appear.
> Note that the kernel will not panic if CONFIG_KVM is disabled.

This is a new feature, it's not clear why we'd backport it (especially
since it's a new feature which is a dependency for other features rather
than something that people can use outside of the kernel)?

--xpLZgx8TwikDZmE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSitlwACgkQJNaLcl1U
h9Bvpgf/eXSRnTfHliO0bV9VtU5ADhjMBmc1W+ISfazzcUcrn7/0ADtKledkvofD
tf4uZzpLBr1DzvieSM8L/YSmSLpvCph8X7DlNfBIwrS69H2dtNE4LPTeVr2rD5qt
SD2vWP6KXB6nyk+K3BlT6kbZ51AdoTAO+3PyDNJDBlrUZ4/KGVRU8HbtHiGMtRth
dDN8Nssw8GwXEEYAiROvu0b45sI8KYVwxGsNbFKjK2eJHab623jDWgvep4kf+MlK
UU/m5r9AdD8YVOAw9cCVXNHXwBLAAaRT6NGkdS8inDRaOeKPxQwNCht/EJLZdK2w
P463ovVKihLkSkIBBZZlWVMeGnXQOA==
=oCEb
-----END PGP SIGNATURE-----

--xpLZgx8TwikDZmE7--
