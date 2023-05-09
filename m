Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F86FD178
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjEIVdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbjEIVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826A4A268;
        Tue,  9 May 2023 14:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A06A61375;
        Tue,  9 May 2023 21:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DB0C4339B;
        Tue,  9 May 2023 21:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667849;
        bh=TV3iq4M+Rv3zhN9J5JlzxPrprg0eHHr6VLCMjCYMMck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqOXwCPhHpvlfvzNC2XLzHgxG6WH5eSr1z2xMCH6cEAjKQ9hMLdEmWMxKmDCViYlO
         WcM7J6XBLvSp3D1CTAoCK6B2cn+W5fp3jw/iA+NXkQzoNENtST3VVTN6dzUnFIXFmT
         zGZYYtzlGxgoOLPR+40NiZ9zCUCZklYazMVbtZg64Fq2sZpbadAXxNruiQ8N3i0v93
         pZoUl8gKJMVhMZdLTBzM08jL1qWOlOW4uRX0v7y33U7hjDmQ3z29V/kIeJzqzYu7Pr
         1PPh1ukZhHJOBxxBos4OVhoW6corTf/PSE7OSTTq0SZlYsDoyEy987B2Jdux/pf4KQ
         2Ba+/nvpqd3UA==
Date:   Tue, 9 May 2023 22:30:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
Message-ID: <20230509-tacking-polo-d841ebfffcd0@spud>
References: <20230509030653.039732630@linuxfoundation.org>
 <0837e157-8615-418a-a3d3-1c14af11aba5@roeck-us.net>
 <20230509-robust-crate-5fe128d00e6d@spud>
 <ce667220-5803-4b6a-a2d2-f538289af584@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XZAFXv1xCRIWO+qY"
Content-Disposition: inline
In-Reply-To: <ce667220-5803-4b6a-a2d2-f538289af584@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XZAFXv1xCRIWO+qY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 02:18:35PM -0700, Guenter Roeck wrote:
> On Tue, May 09, 2023 at 09:41:42PM +0100, Conor Dooley wrote:
> > On Tue, May 09, 2023 at 12:57:58PM -0700, Guenter Roeck wrote:
> > > On Tue, May 09, 2023 at 05:26:31AM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.28 release.
> > > > There are 610 patches in this series, all will be posted as a respo=
nse
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >=20
> > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > Anything received after that time might be too late.
> > > >=20
> > >=20
> > > Build results:
> > > 	total: 155 pass: 155 fail: 0
> > > Qemu test results:
> > > 	total: 519 pass: 519 fail: 0
> > >=20
> > > New persistent runtime warning when booting riscv32/64 images:
> >=20
> > You sure this is new? I seem to be able to reproduce for QEMU (which I
>=20
> New for my tests, yes.
>=20
> > don't usually test) in several versions of 6.1. Don't see it in (my)
> > hardware though, as the particular platform doesn't end up calling the
> > offending function. Out of curiosity, what's your QEMU invocation?
>=20
> Example boot from initrd:
>=20
> qemu-system-riscv64 -M virt -m 512M \
>      -no-reboot -kernel arch/riscv/boot/Image \
>      -initrd rootfs.cpio \
>      -device e1000,netdev=3Dnet0 \
>      -netdev user,id=3Dnet0 -bios default \
>      -append "panic=3D-1 rdinit=3D/sbin/init console=3DttyS0,115200 early=
con=3Duart8250,mmio,0x10000000,115200" \
>      -nographic -monitor none

Cool, was mainly interested in seeing if you were explicitly enabling
any ISA extensions. NGL, I expected to see some.

> qemu version is 8.0, but I don't think that makes a difference.

I'm on 7.2.50 (v7.2.0-2653-g7080c3ab79-dirty) as it is where I ended
during my last bisection of QEMU. But aye, makes no odds - I see it on a
more recent 8.0.50 version too.

> What does your command line look like ?

In this particular instance:
	qemu-system-riscv64 -M virt \
		-m 2G -smp 5 \
		-nographic \
		-kernel $(vmlinux_bin) \
		-initrd $(initramfs)

> > Anyways, looks like a partial backport is the cause. How's it look with:

> This fixes the problem for me.

Cool, shall send it as a real patch. Thanks.

--XZAFXv1xCRIWO+qY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFq7gwAKCRB4tDGHoIJi
0pWvAQDpsknEvAm568mJ3lmPfIERipnx+EYNfwlScWRVYAPZTgD/UnSqcJTWGhHz
An66ZI9Yfv3VaPqoUvYIezKns6Xa/w0=
=LNau
-----END PGP SIGNATURE-----

--XZAFXv1xCRIWO+qY--
