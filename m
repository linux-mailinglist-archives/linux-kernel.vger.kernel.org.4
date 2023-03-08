Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2133A6B0E34
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjCHQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjCHQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:08:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A8038EA6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:08:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72DA261467
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EE6C433D2;
        Wed,  8 Mar 2023 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678291691;
        bh=e4NbZWKO/V45NaOYQf+6f1MNBCr8ETT1f5nT2bzQUUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cslh1bZC3DrYN3zxF41wTCqITPLFLnWK+SCXXr3ggkRoHYw9FBMfvJVX7ctCPwc8H
         qYBVOqJz8aBjk8s5twOOmKDxl7W6oGwLeE2p++E7arFd2GFr+ZfNX2oJMkEzLiUvXh
         1HHTPdT90mfqhbUOsCdM+N8C1BVJlr6hCiRIzdCID0ZPZ0bw6DOTGW0TFlrZaBDcEm
         /2rFok3ltl6u3xY8ZwNnh9gXUVIMfGcow7wgvT1FSPdwig5eYqTT0TVMux3hE+mpaL
         CIWjALqfTTZ6nL+tILWZ7xQRWGyeuIQOrvCQC1m4rz7DU71Nn4jRjzkblrnUAS1CBN
         ScDULCAMLCRaw==
Date:   Wed, 8 Mar 2023 16:08:07 +0000
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
Message-ID: <9d44f863-8644-459a-9fd7-918f742d437e@spud>
References: <202212221206.Lt61kYrt-lkp@intel.com>
 <e1680223-2819-172e-20ea-daea3282e9eb@infradead.org>
 <Y6tAgP7UoP3aYBjq@spud>
 <d5bd9e86-473e-7577-4472-33eb2acbe8fa@infradead.org>
 <Y/lUvq3TSXL6tJOk@spud>
 <ae2452d4-52cf-4e11-8248-05fb7be77dc8@infradead.org>
 <4F5BE5CB-1AB5-4725-860A-1231A72FCE1D@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L8FKWPrPzRFHqD5a"
Content-Disposition: inline
In-Reply-To: <4F5BE5CB-1AB5-4725-860A-1231A72FCE1D@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L8FKWPrPzRFHqD5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2023 at 01:43:44PM +0000, Conor Dooley wrote:
>=20
>=20
> On 25 February 2023 00:28:36 GMT, Randy Dunlap <rdunlap@infradead.org> wr=
ote:
> >
> >
> >On 2/24/23 16:22, Conor Dooley wrote:
> >> On Fri, Feb 24, 2023 at 04:12:49PM -0800, Randy Dunlap wrote:
> >>> Hi Conor, Palmer,
> >>>
> >>> On 12/27/22 10:59, Conor Dooley wrote:
> >>>> Hey Randy,
> >>>>
> >>>> On Thu, Dec 22, 2022 at 05:00:06PM -0800, Randy Dunlap wrote:
> >>>>> On 12/21/22 20:49, kernel test robot wrote:
> >>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git master
> >>>>>> head:   9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
> >>>>>> commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.so=
cs: Add ARCH_RENESAS kconfig option
> >>>>>> date:   6 weeks ago
> >>>>>> config: riscv-kismet-CONFIG_IOMMU_IO_PGTABLE_LPAE-CONFIG_IPMMU_VMS=
A-0-0
> >>>>>> reproduce:
> >>>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git/commit/?id=3D8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
> >>>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/=
kernel/git/torvalds/linux.git
> >>>>>>         git fetch --no-tags linus master
> >>>>>>         git checkout 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
> >>>>>>         # 1. reproduce by kismet
> >>>>>>            # install kmax per https://github.com/paulgazz/kmax/blo=
b/master/README.md
> >>>>>>            kismet --linux-ksrc=3Dlinux --selectees CONFIG_IOMMU_IO=
_PGTABLE_LPAE --selectors CONFIG_IPMMU_VMSA -a=3Driscv
> >>>>>>         # 2. reproduce by make
> >>>>>>            # save the config file to linux source tree
> >>>>>>            cd linux
> >>>>>>            make ARCH=3Driscv olddefconfig
> >>>>>>
> >>>>>> If you fix the issue, kindly add following tag where applicable
> >>>>>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>>>>
> >>>>>> kismet warnings: (new ones prefixed by >>)
> >>>>>>>> kismet: WARNING: unmet direct dependencies detected for IOMMU_IO=
_PGTABLE_LPAE when selected by IPMMU_VMSA
> >>>>>>    .config:4814:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI=
' invalid for ARCH_MMAP_RND_BITS
> >>>>>>   =20
> >>>>>>    WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABL=
E_LPAE
> >>>>>>      Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMP=
ILE_TEST [=3Dy] && !GENERIC_ATOMIC64 [=3Dy])
> >>>>>>      Selected by [y]:
> >>>>>>      - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS =
[=3Dy] || COMPILE_TEST [=3Dy] && !GENERIC_ATOMIC64 [=3Dy])
> >>>>>>
> >>>>>
> >>>>> Maybe this:
> >>>>>
> >>>>> ---
> >>>>>  drivers/iommu/Kconfig |    3 ++-
> >>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> >>>>> --- a/drivers/iommu/Kconfig
> >>>>> +++ b/drivers/iommu/Kconfig
> >>>>> @@ -32,7 +32,8 @@ config IOMMU_IO_PGTABLE
> >>>>>  config IOMMU_IO_PGTABLE_LPAE
> >>>>>  	bool "ARMv7/v8 Long Descriptor Format"
> >>>>>  	select IOMMU_IO_PGTABLE
> >>>>> -	depends on ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> >>>>> +	depends on ARM || ARM64 || ARCH_RENESAS || \
> >>>>> +		(COMPILE_TEST && !GENERIC_ATOMIC64)
> >>>>>  	help
> >>>>>  	  Enable support for the ARM long descriptor pagetable format.
> >>>>>  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
> >>>>>
> >>>>>
> >>>>> or is way off?
> >>>>
> >>>> Apologies for the radio silence here..
> >>>>
> >>>> Palmer initially sent a workaround and there was some discussion the=
re:
> >>>> https://lore.kernel.org/all/20221214180409.7354-1-palmer@rivosinc.co=
m/
> >>>> Guo sent a patch too:
> >>>> https://lore.kernel.org/linux-riscv/20221215073212.1966823-1-guoren@=
kernel.org/
> >>>>
> >>>> I suppose Christmas is doing Christmas things :)
> >>>
> >>> Has this been solved (merged) yet?
> >>> I'm still seeing a warning on linux-next-20230224.
> >>=20
> >> I thought it was fixed in the iommu tree with this series:
> >> https://lore.kernel.org/all/7a53ac6f-640b-436d-9bfa-3e49066b2460@arm.c=
om/
> >>=20
> >> If it is not, I'll take a look tomorrow...
> >
> >I see this warning on today's linux-next-20230224:
> >
> >WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
> >  Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE_TEST =
[=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
> >  Selected by [y]:
> >  - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=3Dy] ||=
 COMPILE_TEST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
> >
> >with the attached config file. Please have a look.
>=20
> My main hard drive in my dev machine died overnight, so I'll have to rena=
ge on my tomorrow promise above.

I finally got around to looking at this today. I tried Palmer's original
reproducer (riscv32 allmodconfig) on top of v6.3-rc1 & this randconfig +
olddefconfig on it, and couldn't get the selection to trigger.
Maybe I misunderstand the randconfig process, but I had thought that
olddefconfig was supposed to be (the equivalent of) idempotent for
randconfigs.

Robin did make some changes to the IOMMU Kconfig stuff that landed in
v6.3, so perhaps that's what has eventually sorted this out.

Please LMK if I've misunderstood & ruined the randconfig w/
olddefconfig!

Cheers,
Conor.


--L8FKWPrPzRFHqD5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAiy5wAKCRB4tDGHoIJi
0ntcAQCLjikAV45Qq4/uG+EzSVedxdIDV3svsRLUtvmkOy8QSgEA6L7W3j3Sx0U8
RiTAkJnJ1t+OsTI4wzdUYH7o3h7xMwk=
=i5s6
-----END PGP SIGNATURE-----

--L8FKWPrPzRFHqD5a--
