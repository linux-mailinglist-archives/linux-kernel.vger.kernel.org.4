Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213066A2576
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBYAWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBYAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B466F014
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:22:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B251FB81D6D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 00:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FC0C433EF;
        Sat, 25 Feb 2023 00:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677284547;
        bh=Qss6SEUxbI2WLKHhyg6K0GdmTUqio7emWAHXD4SdPD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIG2fQ4ezLsZgixCuhgwtH5VMEEi1AYYv347q+42bX46PJz74BqM3Su1WwqdhVhug
         ipkhypRJH2XqwcjsB3nJvTIC7XsLFeuUiP75dPa5oekG4FjzMYaI7pXpacErhDRzn2
         kBPc32+EnXWXMA+JaZfORkcll9km1qilXXoqIVHgGmGhSl26xucxCPdy7VmFy21RzM
         /Ln6me2znCbJ3o5GBJdQSnm7BYkDZ32fWbOVcFh7/TctXiu9QfCVcaU+XVOO4WLqsh
         UDnwogMeMtNWc2XhI9nN5G3B9FmQCIaF7UomqoLImlR1CPyl7uEqlEdngv/9HFBY4w
         eIVrbM24VwADw==
Date:   Sat, 25 Feb 2023 00:22:22 +0000
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
Message-ID: <Y/lUvq3TSXL6tJOk@spud>
References: <202212221206.Lt61kYrt-lkp@intel.com>
 <e1680223-2819-172e-20ea-daea3282e9eb@infradead.org>
 <Y6tAgP7UoP3aYBjq@spud>
 <d5bd9e86-473e-7577-4472-33eb2acbe8fa@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Iawm1F09jJguo10X"
Content-Disposition: inline
In-Reply-To: <d5bd9e86-473e-7577-4472-33eb2acbe8fa@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Iawm1F09jJguo10X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2023 at 04:12:49PM -0800, Randy Dunlap wrote:
> Hi Conor, Palmer,
>=20
> On 12/27/22 10:59, Conor Dooley wrote:
> > Hey Randy,
> >=20
> > On Thu, Dec 22, 2022 at 05:00:06PM -0800, Randy Dunlap wrote:
> >> On 12/21/22 20:49, kernel test robot wrote:
> >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git master
> >>> head:   9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
> >>> commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.socs:=
 Add ARCH_RENESAS kconfig option
> >>> date:   6 weeks ago
> >>> config: riscv-kismet-CONFIG_IOMMU_IO_PGTABLE_LPAE-CONFIG_IPMMU_VMSA-0=
-0
> >>> reproduce:
> >>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
> >>>         git remote add linus https://git.kernel.org/pub/scm/linux/ker=
nel/git/torvalds/linux.git
> >>>         git fetch --no-tags linus master
> >>>         git checkout 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
> >>>         # 1. reproduce by kismet
> >>>            # install kmax per https://github.com/paulgazz/kmax/blob/m=
aster/README.md
> >>>            kismet --linux-ksrc=3Dlinux --selectees CONFIG_IOMMU_IO_PG=
TABLE_LPAE --selectors CONFIG_IPMMU_VMSA -a=3Driscv
> >>>         # 2. reproduce by make
> >>>            # save the config file to linux source tree
> >>>            cd linux
> >>>            make ARCH=3Driscv olddefconfig
> >>>
> >>> If you fix the issue, kindly add following tag where applicable
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>
> >>> kismet warnings: (new ones prefixed by >>)
> >>>>> kismet: WARNING: unmet direct dependencies detected for IOMMU_IO_PG=
TABLE_LPAE when selected by IPMMU_VMSA
> >>>    .config:4814:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' i=
nvalid for ARCH_MMAP_RND_BITS
> >>>   =20
> >>>    WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_L=
PAE
> >>>      Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE=
_TEST [=3Dy] && !GENERIC_ATOMIC64 [=3Dy])
> >>>      Selected by [y]:
> >>>      - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=
=3Dy] || COMPILE_TEST [=3Dy] && !GENERIC_ATOMIC64 [=3Dy])
> >>>
> >>
> >> Maybe this:
> >>
> >> ---
> >>  drivers/iommu/Kconfig |    3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> >> --- a/drivers/iommu/Kconfig
> >> +++ b/drivers/iommu/Kconfig
> >> @@ -32,7 +32,8 @@ config IOMMU_IO_PGTABLE
> >>  config IOMMU_IO_PGTABLE_LPAE
> >>  	bool "ARMv7/v8 Long Descriptor Format"
> >>  	select IOMMU_IO_PGTABLE
> >> -	depends on ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> >> +	depends on ARM || ARM64 || ARCH_RENESAS || \
> >> +		(COMPILE_TEST && !GENERIC_ATOMIC64)
> >>  	help
> >>  	  Enable support for the ARM long descriptor pagetable format.
> >>  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
> >>
> >>
> >> or is way off?
> >=20
> > Apologies for the radio silence here..
> >=20
> > Palmer initially sent a workaround and there was some discussion there:
> > https://lore.kernel.org/all/20221214180409.7354-1-palmer@rivosinc.com/
> > Guo sent a patch too:
> > https://lore.kernel.org/linux-riscv/20221215073212.1966823-1-guoren@ker=
nel.org/
> >=20
> > I suppose Christmas is doing Christmas things :)
>=20
> Has this been solved (merged) yet?
> I'm still seeing a warning on linux-next-20230224.

I thought it was fixed in the iommu tree with this series:
https://lore.kernel.org/all/7a53ac6f-640b-436d-9bfa-3e49066b2460@arm.com/

If it is not, I'll take a look tomorrow...

--Iawm1F09jJguo10X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/lUvgAKCRB4tDGHoIJi
0p8lAQCU+UmkWkyATaId/nIF1qjSHlGT8wtiNz27kjySSV7BRgD+OxVsF2CfsLdd
huSzCbwV3/hA4JkKjnPME24s3tf+7gs=
=2R1r
-----END PGP SIGNATURE-----

--Iawm1F09jJguo10X--
