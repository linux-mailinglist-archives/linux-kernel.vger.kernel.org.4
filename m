Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376A0656E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiL0S7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0S7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:59:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD3FD108
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 10:59:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB4A6120C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 18:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF91C433EF;
        Tue, 27 Dec 2022 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672167557;
        bh=Qn+m0nFAT9ZNwVVdZj2KPeTzIUkk4H9rkLVFQDo9wrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHUBhqoZYHEP5/tYlk7K5eDB4TgiY0PHncPVGLEDNjMG+xKpq/Z7A7IAplTw0Ryed
         N2clVCImpG0Up+jfqUP+XxkmZKw1vkKyNWi+0GJ/6ezc6GBZkZ+hk3mwzQ4XULYxPr
         JJxCuzTrB8jUzEZ+naBFk8ALQNjmW+D8rWbdEwDNCRZ2Kn8FKf9FJkTa8dGxlOV4t1
         HyxP2WRNk+dMZ71ekwN0ad5t4qY/1BgVUW0ZAnexa4kE4d8Xb2Zq5DWQvV2/ZNxhSF
         Xw4wYdLc4PKpwumRJzca3uluZ6lfGhum+pjNrYIS8g4HVVT21zB1HBX9oz6ydJwcm2
         NhsugiE8qf0xA==
Date:   Tue, 27 Dec 2022 18:59:12 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 IOMMU_IO_PGTABLE_LPAE when selected by IPMMU_VMSA
Message-ID: <Y6tAgP7UoP3aYBjq@spud>
References: <202212221206.Lt61kYrt-lkp@intel.com>
 <e1680223-2819-172e-20ea-daea3282e9eb@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MtaQOvggsNiMCdq7"
Content-Disposition: inline
In-Reply-To: <e1680223-2819-172e-20ea-daea3282e9eb@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MtaQOvggsNiMCdq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Randy,

On Thu, Dec 22, 2022 at 05:00:06PM -0800, Randy Dunlap wrote:
> On 12/21/22 20:49, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
> > commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.socs: A=
dd ARCH_RENESAS kconfig option
> > date:   6 weeks ago
> > config: riscv-kismet-CONFIG_IOMMU_IO_PGTABLE_LPAE-CONFIG_IPMMU_VMSA-0-0
> > reproduce:
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kerne=
l/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
> >         # 1. reproduce by kismet
> >            # install kmax per https://github.com/paulgazz/kmax/blob/mas=
ter/README.md
> >            kismet --linux-ksrc=3Dlinux --selectees CONFIG_IOMMU_IO_PGTA=
BLE_LPAE --selectors CONFIG_IPMMU_VMSA -a=3Driscv
> >         # 2. reproduce by make
> >            # save the config file to linux source tree
> >            cd linux
> >            make ARCH=3Driscv olddefconfig
> >=20
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> >=20
> > kismet warnings: (new ones prefixed by >>)
> >>> kismet: WARNING: unmet direct dependencies detected for IOMMU_IO_PGTA=
BLE_LPAE when selected by IPMMU_VMSA
> >    .config:4814:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' inv=
alid for ARCH_MMAP_RND_BITS
> >   =20
> >    WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
> >      Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE_T=
EST [=3Dy] && !GENERIC_ATOMIC64 [=3Dy])
> >      Selected by [y]:
> >      - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=3Dy=
] || COMPILE_TEST [=3Dy] && !GENERIC_ATOMIC64 [=3Dy])
> >=20
>=20
> Maybe this:
>=20
> ---
>  drivers/iommu/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -32,7 +32,8 @@ config IOMMU_IO_PGTABLE
>  config IOMMU_IO_PGTABLE_LPAE
>  	bool "ARMv7/v8 Long Descriptor Format"
>  	select IOMMU_IO_PGTABLE
> -	depends on ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on ARM || ARM64 || ARCH_RENESAS || \
> +		(COMPILE_TEST && !GENERIC_ATOMIC64)
>  	help
>  	  Enable support for the ARM long descriptor pagetable format.
>  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
>=20
>=20
> or is way off?

Apologies for the radio silence here..

Palmer initially sent a workaround and there was some discussion there:
https://lore.kernel.org/all/20221214180409.7354-1-palmer@rivosinc.com/
Guo sent a patch too:
https://lore.kernel.org/linux-riscv/20221215073212.1966823-1-guoren@kernel.=
org/

I suppose Christmas is doing Christmas things :)

Thanks,
Conor.


--MtaQOvggsNiMCdq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6tAgAAKCRB4tDGHoIJi
0iNeAP9Qrq4IWyn5TklutoCL8xcd+CsP3xMipIRMbYkPO6qtUgD/THGKBpG4PMl6
7773RRj2qse2AGe9KxdQlg8x3ZxwngA=
=OA0L
-----END PGP SIGNATURE-----

--MtaQOvggsNiMCdq7--
