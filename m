Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA378701CBF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjENJuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjENJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36921B6;
        Sun, 14 May 2023 02:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25BED6111E;
        Sun, 14 May 2023 09:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559DFC433EF;
        Sun, 14 May 2023 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684057798;
        bh=guNSqaaUlESAbLan9+RG8kL1OCMP8ebtJ0mKqjsMlwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlAlSaeN8+EXCybzzrEALb2hrhC2bu60CCiNxgOm1/pbpcXlbfRzCi3V0XN1V2uVm
         sYd/3l90AhWk+z8jQOxZ1tFURcrgiKPs9OXer92bAGkbtrWwczy77FY0bB2dafbAeU
         3Fqhi5XUc/JAfKmFR8HUGYHVlT6WkXPHPYeNWzhS+OAbIiyU14FNl2ruMeSUFLCKv1
         0aecU0EqIHCMzZmDKYgVzyL9kL1clCs1mtX4rXC33UWcxKi6xeMSXZAuUN2GeozJf9
         /UzpjqhhyvU9u9TmOIvC5OUeZaKMomzTAhT++8kRNii7j+OuJdONS62vRT60B/Fn0B
         sPSG1uQ9BIwTQ==
Date:   Sun, 14 May 2023 10:49:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux RISC-V <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Chen <vincent.chen@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Subject: Re: [PATCH 3/5] Documentation: riscv: vector: Use bullet lists for
 prctl list
Message-ID: <20230514-proposal-resort-3ce1beeaa089@spud>
References: <20230514090432.78217-1-bagasdotme@gmail.com>
 <20230514090432.78217-4-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JFuOQxTC7sdTVyfx"
Content-Disposition: inline
In-Reply-To: <20230514090432.78217-4-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JFuOQxTC7sdTVyfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Bagas,

On Sun, May 14, 2023 at 04:04:30PM +0700, Bagas Sanjaya wrote:
> The documentation lists two userspace prctl() calls. Use bullet
> lists for the listing.
>=20
> Fixes: 412c68cfeeb178 ("riscv: Add documentation for Vector")

Firstly, these fixes commit hashes would not be stable as this series
has been applied to riscv/for-next [1]. But also, from this commit
onwards, things seem like stylistic comments that would be undeserving
of a Fixes: tag to begin with.
Perhaps you'd be better off suggesting these changes in response to the
original thread [2], so that it goes in "correctly" in the first place?
Andy has to re-submit anyway as there are a few bugs that crept in in
the most recent revision of his series.

Thanks,
Conor.

1 - https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=
=3Dfor-next
2 - https://lore.kernel.org/linux-riscv/20230509103033.11285-25-andy.chiu@s=
ifive.com/

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/riscv/vector.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/riscv/vector.rst b/Documentation/riscv/vector.=
rst
> index 178b3f3f452462..c7bd701c7963b6 100644
> --- a/Documentation/riscv/vector.rst
> +++ b/Documentation/riscv/vector.rst
> @@ -13,7 +13,7 @@ order to support the use of the RISC-V Vector Extension.
>  Two new prctl() calls are added to allow programs to manage the enableme=
nt
>  status for the use of Vector in userspace:
> =20
> -prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
> +* prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
> =20
>      Sets the Vector enablement status of the calling thread, where the c=
ontrol
>      argument consists of two 2-bit enablement statuses and a bit for inh=
eritance
> @@ -89,7 +89,7 @@ prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
>          * Every successful call overwrites a previous setting for the ca=
lling
>            thread.
> =20
> -prctl(PR_RISCV_V_SET_CONTROL)
> +* prctl(PR_RISCV_V_SET_CONTROL)
> =20
>      Gets the same Vector enablement status for the calling thread. Setti=
ng for
>      next execve() call and the inheritance bit are all OR-ed together.
> --=20
> An old man doll... just what I always wanted! - Clara
>=20

--JFuOQxTC7sdTVyfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGCuvQAKCRB4tDGHoIJi
0mcyAPwPiBYobd9BA+IWlX6rYlv8XB7W4+mR4nPs6hKmYxYppAEAngC4C5RD+zHf
HIp7y9wlzNTsI+Lwk3dZR0/6G2oiNwk=
=qbPL
-----END PGP SIGNATURE-----

--JFuOQxTC7sdTVyfx--
