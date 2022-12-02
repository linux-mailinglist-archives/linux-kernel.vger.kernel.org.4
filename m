Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB06404D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiLBKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiLBKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:36:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E7CCD9A9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 786296222D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72D5C433C1;
        Fri,  2 Dec 2022 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669977371;
        bh=u9zLYk7vA/kTb5Kq1zNPxADSlsc2alVjhwgeDfmJoMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ok8fH+bq/Eiv4pC2HdLs0UVS2mOCugVu78sGcGjF25532cN+cWHap90cyktOzGfpn
         shP5EseMzXI/7xbwQetUs0BXDSiouRoTuFto7W97oH9RAVdahZQgDi/gyh6mv4LW3d
         TeasbSv4VXmcaaeL7+A85vq7KlNAYfYbCR/1JekDavH+DVRkOm7mHzWdm38UxG7TYW
         kqAbekddJdp2anSGAAvYkr+lqEdaIASqLVPofP1eXOlw6GoKq1hcWz0NhFrYEacVMu
         re3QPDFM9UsNf2pRsoRNbuKHcJfAXXI3SXmJHvlmub8T6ie61hxAgD8UtLFphZfw2e
         5ipm1lNXOetbQ==
Date:   Fri, 2 Dec 2022 10:36:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jianwen Jiang <jiangjianwen@uniontech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        geert@linux-m68k.org, panqinglin2020@iscas.ac.cn, arnd@arndb.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     Implement ioremap_prot support (v2)
Message-ID: <Y4nVF9sDckD6cNug@spud>
References: <20221202083356.169176-1-jiangjianwen@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gmfZS0+76u997J9s"
Content-Disposition: inline
In-Reply-To: <20221202083356.169176-1-jiangjianwen@uniontech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gmfZS0+76u997J9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

On Fri, Dec 02, 2022 at 04:33:56PM +0800, Jianwen Jiang wrote:a
> [PATCH]     Implement ioremap_prot support (v2)

Some process bits.. Please put the v2 inside the leading [], git
format-patch will do this for you with the `-v N` arg. Also, please add
a subsytem prefix to the $subject & drop the leading spaces.

>     Feature ioremap_prot only needs an implementation of pte_pgprot on ri=
scv.

There's also no need to tab this stuff in

>     That macro is similar to the same one on platform loongarch, mips and=
 sh.
>     We just need:
>     1. replace _PFN_MASK with _PAGE_PFN_MASK in pte_gpprot;
>     2. add "select HAVE_IOREMAP_PROT" into arch/riscv/Kconfig;
>     3. add "depends on MMU" into drivers/fpga/Kconfig to fix the building=
 error "undefined reference to generic_access_phys".
>=20
>     Signed-off-by: Jianwen Jiang <jiangjianwen@uniontech.com>

And this line should not be tabbed in.

> ---
>  arch/riscv/Kconfig            | 1 +
>  arch/riscv/include/asm/page.h | 2 ++
>  drivers/fpga/Kconfig          | 1 +

This needs to go as a separate patch to the FPGA subsystem, with the
FPGA maintainers in to/cc.

>  3 files changed, 4 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fa78595a6089..5ed2c7361040 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -95,6 +95,7 @@ config RISCV
>  	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_GENERIC_VDSO if MMU && 64BIT
> +	select HAVE_IOREMAP_PROT
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_KPROBES if !XIP_KERNEL
>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index ac70b0fd9a9a..cb08a4911d60 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -84,6 +84,8 @@ typedef struct page *pgtable_t;
>  #define __pgd(x)	((pgd_t) { (x) })
>  #define __pgprot(x)	((pgprot_t) { (x) })
> =20
> +#define pte_pgprot(x)  __pgprot(pte_val(x) & ~_PAGE_PFN_MASK)
> +
>  #ifdef CONFIG_64BIT
>  #define PTE_FMT "%016lx"
>  #else
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index bbe0a7cabb75..0493272b8bff 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -5,6 +5,7 @@
> =20
>  menuconfig FPGA
>  	tristate "FPGA Configuration Framework"
> +	depends on MMU

How come no other arch needs this dependancy?

Thanks,
Conor.

>  	help
>  	  Say Y here if you want support for configuring FPGAs from the
>  	  kernel.  The FPGA framework adds an FPGA manager class and FPGA
> --=20
> 2.37.3.446.gd42b38dfb5
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--gmfZS0+76u997J9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY4nU/wAKCRB4tDGHoIJi
0kLIAP9gBXK7W9/psSR7aTqxJQA/JTHtVdBDvLVPq6lGnbMJbwEAyz9CvgP9Dy6Q
wzHLDIGRjwyJ9gUBl3eHRb9xpgDjDw8=
=IWmN
-----END PGP SIGNATURE-----

--gmfZS0+76u997J9s--
