Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AABA6F23DD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 11:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjD2Jcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD2Jcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 05:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F8172A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 637F360920
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 09:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC560C433D2;
        Sat, 29 Apr 2023 09:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682760757;
        bh=1769BdjMLXLnUwLK8f8JVBPR8cBqGG+XblOEkEa7eYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPRGpsaJk7zUD8bD5Ekgq3hdByXNDrGIkXpUV1fgOL5E5SXd7hNlxbjs9hWUUls8b
         cP9mvJ0Lcc+gZyQqezGk5H13Qy4mOTJbGXZ5ANohkTp9KVsHqniI3QdxjDiLlktPQi
         HB210EcR6/5VGP/lrV5HLrIJKbXhfn3eFdUXfv9wSDRHDQ0Odo7xFLADWohvMGkRhI
         M+ctaWn1AlR3m/b0bU7fon+TmLXBWJV3smZBRnLjszinDJm+t7n/raE/eAaiGCAVtl
         fVCu8PZaSTL2QnQUcLBo9hBqI0Lzu1dX/cIXk3o1ecspFPKzl6YnriRC5eT/+MkQoh
         W3PwApNElxtNA==
Date:   Sat, 29 Apr 2023 10:32:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] RISC-V: fixup in-flight collision with
 ARCH_WANT_OPTIMIZE_VMEMMAP rename
Message-ID: <20230429-neurology-sudoku-8d53b23d01b8@spud>
References: <20230429-trilogy-jolly-12bf5c53d62d@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDiTzWvV7OasW/BT"
Content-Disposition: inline
In-Reply-To: <20230429-trilogy-jolly-12bf5c53d62d@spud>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDiTzWvV7OasW/BT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 29, 2023 at 10:27:33AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> Lukas warned that ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP had been
> renamed in the mm tree & that RISC-V would need a fixup as part of the
> merge. The warning was missed however, and RISC-V is selecting the
> orphaned Kconfig option.
>=20
> Fixes: 89d77f71f493 ("Merge tag 'riscv-for-linus-6.4-mw1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/riscv/linux")
> Reported-by: Lukas Bulwhan <lukas.bulwhan@gmail.com>

That should have been Lukas Bulwahn <lukas.bulwahn@gmail.com>.
This is what I get for hand-typing an email address that I could have
copied from lore I suppose.

> Link: https://lore.kernel.org/linux-riscv/CAKXUXMyVeg2kQK_edKHtMD3eADrDK_=
PKhCSVkMrLDdYgTQQ5rg@mail.gmail.com/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I guess you picking this up for your second PR makes the most sense
> Palmer?
>=20
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> CC: Lukas Bulwhan <lukas.bulwhan@gmail.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5c88ac4b52be..e1bdb3fb16cc 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -46,9 +46,9 @@ config RISCV
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
> -	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>  	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
> +	select ARCH_WANT_OPTIMIZE_VMEMMAP
>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select BUILDTIME_TABLE_SORT if MMU
> --=20
> 2.39.2
>=20

--qDiTzWvV7OasW/BT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEzkMQAKCRB4tDGHoIJi
0o3GAQC7V+gnYkJqWi+6caRdyr0vEFPODHvJQ+YIuoiH4YEu5QD8DlxZmcCK3fje
a2rYdGJXluGu1Z+roEhtMr/ab8vDVQ0=
=1Va4
-----END PGP SIGNATURE-----

--qDiTzWvV7OasW/BT--
