Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B42468D5FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjBGLv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBGLvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:51:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79BD1720;
        Tue,  7 Feb 2023 03:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BDBE6134A;
        Tue,  7 Feb 2023 11:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC53C4339B;
        Tue,  7 Feb 2023 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675770712;
        bh=NuV4isujyR9+A4tE7QmJErckCg1VM8t4faGWpD/9Hlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tx04d/dFXhXrFpV0On8Y1e3uZzuagt1mtopstLXWWZbHwd6YToYex/lwflmU2SX+d
         5A0woErm1Y4ZpO8kS7JDnnveN7RAO9nmZnEMn/+R11FyuhAVIPSxdaPhCXZD06qrE9
         FgmPDdcDBnKg3IOwBS3TCrWLbSBB0sy1pp7o7GTmevTBXSs5yQ/oUBtt+2+6hRu0GO
         ELw9sgplMx8YexOLpkqhgzo8Z/F8FHwR4ZMoJLs7WVS/nOG7/zx+xTZ9xV4d2oGTQ1
         AAWla7DcdNPZxenR94SbEmI1cgpcbVk9cO/JPtdEyMBoQJUTRUU3BOa9Tk7HWlg+DO
         omepZRdA8NoLQ==
Date:   Tue, 7 Feb 2023 11:51:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     mika.westerberg@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] spi: intel: Remove DANGEROUS tag from pci driver
Message-ID: <Y+I7VG4w7LLfizLo@sirena.org.uk>
References: <20230206183143.75274-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nke6NR22QPsJS30V"
Content-Disposition: inline
In-Reply-To: <20230206183143.75274-1-mauro.lima@eclypsium.com>
X-Cookie: Do not flush.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nke6NR22QPsJS30V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 03:31:42PM -0300, Mauro Lima wrote:
> Given that the PCI driver handles controllers that only work with
> hardware sequencing, we can remove the dangerous tag.
> This patch is the second part of Mika's suggestion [1].
> The first part was accepted in [2].

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--nke6NR22QPsJS30V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPiO1MACgkQJNaLcl1U
h9CLTgf/Qq8N+KpvDckJoxiM0NaOhZFj5XhalERzmrJFSOBKde+8m53XkBnmu40B
+Nc9SiOFNVYCcO1ECc+cNzLbsyyzK+lw/WCV4+L/Zp2INJRjhOQPOB4YeVtBoF8O
6ul3y+de5ksGR+T+g7vBpE/+JWWJKhwbk/m2F5w8tQs1TJnKR0aifE2xyWr0ILmF
MPQ4ll6glTpHUw0DQhMeT5Zpvz9jkmQhRZphJnhimjQF35Dz3vg8Rcsq241Ams3z
f+EpVYzOm6ATSvM4mNWPWWjlwhfsnnyn5OWLqHnITlQy6NS/bQa/q65bgSdd6YYt
jFxTvcKYuA3hyEdPJt+kRldYFV3E1g==
=u+36
-----END PGP SIGNATURE-----

--nke6NR22QPsJS30V--
