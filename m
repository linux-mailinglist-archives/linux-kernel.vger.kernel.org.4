Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E766C9401
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjCZLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCZLdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 07:33:25 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C3483DA;
        Sun, 26 Mar 2023 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mH1fB+sUPheKls5CPf/7NICBFAi/P0VBJv24nrc2pe8=; b=ElJ0ojd/qxXlk5TjUWuKt3I/RY
        yD5hf+3YLkbNZgMrFMm7bT2VZ03n42XN+APVm1qjQXfxshB1XhSZPUl4D6QaBWkOmBjLZlofLqsos
        KnsoKXe60zymEXNhQgH0oUHFKejsXY9f+gcyIvRl/IZORLJmqu/nnnxOZ+xLVwqZ2qkvqwpkw1CC7
        lPkVEAZ/71Ihj8/3qKVCvjTXVztwruS0XKdnli/q9/wqZ8z/zIO1/PemDATcEn1zsEXN9jQ2/vlXw
        PW1t0RIoxxQN+DBFCJlEUKV22gH4LWOGjaZyBPXOJS89jc65zgxKEXO5CjVvEtEWHMm27ztqugJfa
        y/buRQrg==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <aurel32@debian.org>)
        id 1pgOch-0022mF-NI; Sun, 26 Mar 2023 11:33:20 +0000
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurel32@debian.org>)
        id 1pgOcY-005Hjx-E1; Sun, 26 Mar 2023 13:33:10 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurel32@debian.org>)
        id 1pgOcW-00G3BS-0g;
        Sun, 26 Mar 2023 13:33:08 +0200
Date:   Sun, 26 Mar 2023 13:33:08 +0200
From:   Aurelien Jarno <aurel32@debian.org>
To:     Vagrant Cascadian <vagrant@debian.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 1033301@bugs.debian.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Tom Saeger <tom.saeger@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kibi@debian.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: Bug#1033301: linux: arm64 kernel size increased from 31 to 39
 MB, causing u-boot-rpi to fail
Message-ID: <ZCAtdOxWVV0vWdWz@aurel32.net>
Mail-Followup-To: Vagrant Cascadian <vagrant@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>, 1033301@bugs.debian.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Tom Saeger <tom.saeger@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kibi@debian.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <167943667390.3323902.2304413357807812348.reportbug@ohm.local>
 <ZBqeh6aN4lFsFPb3@eldamar.lan>
 <87h6u9vpc4.fsf@wireframe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vO92KNZJo0wSkuR2"
Content-Disposition: inline
In-Reply-To: <87h6u9vpc4.fsf@wireframe>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Debian-User: aurel32
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vO92KNZJo0wSkuR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-24 13:58, Vagrant Cascadian wrote:
> Adding u-boot maintainers for rpi (Matthias Brugger, Peter Robinson)
> platforms and u-boot list to CC.
>=20
> On 2023-03-22, Salvatore Bonaccorso wrote:
> > Thanks for tracking this down. I would like to loop in Masahiro and
> > upstream to see if something can/should be done on upstream side.
> >
> > Masahiro, in short, upstream change 994b7ac1697b ("arm64: remove
> > special treatment for the link order of head.o") (which got backported
> > as well to 6.1.14) caused the vmlinuz size to icrease significantly,
> > causing boot failures on Raspberry Pi 3 Model B Plus with u-boot
> > parameters previously working. Full quoting the Debian report below
>=20
> In general it would be nice to not have the kernel grow nearly 25% in
> size from a single commit; was that an expected outcome from the above
> upstream change? Was the "special treament" originally done to keep the
> kernel size down?

This is currently being tracked [1], but the issue seems to be linked to
the version of the tools used in Debian, and the fact that we build our
kernels with BTF support, so the issue is likely to be difficult to find.

[1] https://lore.kernel.org/linux-arm-kernel/ZBovCrMXJk7NPISp@aurel32.net/

> As for u-boot, It seems u-boot might need to update the various load
> addresses for the kernel, device tree and ramdisk at some point
> regardless of weather this particular issue gets fixed in the kernel, as
> the kernel will likely continue to grow a bit over time...

Yes that's probably a sane thing to do, at least in Debian.

> Aurelien Jarno included a patch referenced below which bumps the
> tolerances in u-boot from 36MB to 42MB.
>=20
>=20
> > On Tue, Mar 21, 2023 at 11:11:13PM +0100, Aurelien Jarno wrote:
> >> Following the upgrade of the kernel from 6.1.12-1 to 6.1.15-1 on a
> >> Raspberry Pi 3 Model B Plus, u-boot (from the u-boot-rpi package) fail=
ed
> >> to boot with:
> >>=20
> >> | 40175552 bytes read in 1695 ms (23 MiB/s)
> >> | 43794863 bytes read in 1817 ms (23 MiB/s)
> >> | Moving Image from 0x80000 to 0x200000, end=3D2990000
> >> | ERROR: RD image overlaps OS image (OS=3D0x200000..0x2990000)
> >>=20
> >> I tracked the issue to a significant increase of the kernel size betwe=
en
> >> version 6.1.12-1 and 6.15-1:
> >>=20
> >> | 31492   /boot/vmlinuz-6.1.0-5-arm64
> >> | 39236   /boot/vmlinuz-6.1.0-6-arm64
> >>=20
> >> This is more than the 36MB that is allowed by u-boot with the default
> >> load addresses. A workaround is to shift the load addresses at the
> >> u-boot level as in the attached patch.
> >>=20
> >> I have tracked issue on the upstream kernel side to the following comm=
it
> >> on the stable tree:
> >>=20
> >> | commit 3e3e4d234d46e48480a7c7c35399fa811182e8ef
> >> | Author: Masahiro Yamada <masahiroy@kernel.org>
> >> | Date:   Thu Oct 13 08:35:00 2022 +0900
> >> |=20
> >> |     arm64: remove special treatment for the link order of head.o
> >> |    =20
> >> |     commit 994b7ac1697b4581b7726d2ac64321e3c840229b upstream.
> >> |    =20
> >> |     In the previous discussion (see the Link tag), Ard pointed out t=
hat
> >> |     arm/arm64/kernel/head.o does not need any special treatment - th=
e only
> >> |     piece that must appear right at the start of the binary image is=
 the
> >> |     image header which is emitted into .head.text.
> >> |    =20
> >> |     The linker script does the right thing to do. The build system d=
oes
> >> |     not need to manipulate the link order of head.o.
> >> |    =20
> >> |     Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=
=3D1F8Uy-uAWGVDm4-CG=3DEuA@mail.gmail.com/
> >> |     Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> >> |     Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >> |     Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> >> |     Link: https://lore.kernel.org/r/20221012233500.156764-1-masahiro=
y@kernel.org
> >> |     Signed-off-by: Will Deacon <will@kernel.org>
> >> |     Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> >> |     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>=20
> >> The problem is still reproducible on Linus' master.
> >>=20
> >> I am reporting the bug to the linux package as I believed there is no
> >> real reason for such an increase in the kernel size. In case I missed
> >> something and this is actually wanted, the bug can be reassigned to the
> >> u-boot package.
> >>=20
> >> Regards
> >> Aurelien
> >
> >> --- u-boot-2023.01+dfsg.orig/include/configs/rpi.h
> >> +++ u-boot-2023.01+dfsg/include/configs/rpi.h
> >> @@ -95,32 +95,32 @@
> >>   *   text_offset bytes (specified in the header of the Image) into a =
2MB
> >>   *   boundary. The 'booti' command relocates the image if necessary. =
Linux uses
> >>   *   a default text_offset of 0x80000.  In summary, loading at 0x80000
> >> - *   satisfies all these constraints and reserving memory up to 0x024=
00000
> >> - *   permits fairly large (roughly 36M) kernels.
> >> + *   satisfies all these constraints and reserving memory up to 0x02a=
00000
> >> + *   permits fairly large (roughly 42M) kernels.
> >>   *
> >>   * scriptaddr and pxefile_addr_r can be pretty much anywhere that doe=
sn't
> >>   * conflict with something else. Reserving 1M for each of them at
> >> - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> >> + * 0x02a00000-0x02b00000 and 0x02c00000-0x02d00000 should be plenty.
> >>   *
> >>   * On ARM, both the DTB and any possible initrd must be loaded such t=
hat they
> >>   * fit inside the lowmem mapping in Linux. In practice, this usually =
means not
> >>   * more than ~700M away from the start of the kernel image but this n=
umber can
> >>   * be larger OR smaller depending on e.g. the 'vmalloc=3DxxxM' comman=
d line
> >>   * parameter given to the kernel. So reserving memory from low to high
> >> - * satisfies this constraint again. Reserving 1M at 0x02600000-0x0270=
0000 for
> >> - * the DTB leaves rest of the free RAM to the initrd starting at 0x02=
700000.
> >> + * satisfies this constraint again. Reserving 1M at 0x02c00000-0x02d0=
0000 for
> >> + * the DTB leaves rest of the free RAM to the initrd starting at 0x02=
d00000.
> >>   * Even with the smallest possible CPU-GPU memory split of the CPU ge=
tting
> >> - * only 64M, the remaining 25M starting at 0x02700000 should allow qu=
ite
> >> + * only 64M, the remaining 19M starting at 0x02d00000 should allow qu=
ite
> >>   * large initrds before they start colliding with U-Boot.
> >>   */
> >>  #define ENV_MEM_LAYOUT_SETTINGS \
> >>  	"fdt_high=3D" FDT_HIGH "\0" \
> >>  	"initrd_high=3D" INITRD_HIGH "\0" \
> >>  	"kernel_addr_r=3D0x00080000\0" \
> >> -	"scriptaddr=3D0x02400000\0" \
> >> -	"pxefile_addr_r=3D0x02500000\0" \
> >> -	"fdt_addr_r=3D0x02600000\0" \
> >> -	"ramdisk_addr_r=3D0x02700000\0"
> >> +	"scriptaddr=3D0x02a00000\0" \
> >> +	"pxefile_addr_r=3D0x02b00000\0" \
> >> +	"fdt_addr_r=3D0x02c00000\0" \
> >> +	"ramdisk_addr_r=3D0x02d00000\0"
> >> =20
> >>  #if CONFIG_IS_ENABLED(CMD_MMC)
> >>  	#define BOOT_TARGET_MMC(func) \
>=20
> Bumping from 36MB to 42MB seems address the issue at hand, although
> would it make sense to bump even higher... or is that starting to hit
> other limitations?

=46rom the comment above the code, I understand that the main limitation
is when allocating most of the memory to the GPU, leaving only 64MB to
the CPU.
It seems possible to do that on many RPi:
- On 256MB RPi, the maximum gpu_mem value is 192
- On 512MB RPi, the maximum gpu_mem value is 448
- On >=3D 1GB RPi, the maximum gpu_mem value is 944

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

--vO92KNZJo0wSkuR2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUryGlb40+QrX1Ay4E4jA+JnoM2sFAmQgLXIACgkQE4jA+Jno
M2uUlQ/+MunAqJbcJPHyLS4xWFlMobp1Hi4bjn8iFZq7l/mNSK4To7pzZ/mSo1i4
14L233hlF9ec2k2sZ/0UEZDIcJOn9yqewLEYHYkDsFbOwy4Yn+6WPbRt6XTxlm9p
QkQ/zb7Wt1G4T9Cs12byboGBI1osX9sY4BQ1S10GdcuuW7Pwqm8mO4Frq2My7EGR
wdEOvdcnBce+wy+efckRHUu6+iiHg+LYHY4KWEXLMeOy8PJelsXodK1bCyiyTV3c
G1p+P3cnIGRild7gMQUKv3qWwL+BiorByXMJaKMvFtgF5vb7shz+6ma/OtCMHRmU
uCzo5Hs7oMsxEh6CN72rHW8hkQrwNJsdSXDcgSNF3lVGQLXyVWtoIvHLoXt9Hex3
RKlWIuaJj9hMqspzdRxz6NA/dAToxpOl+r9J72NM4OdX81E53XUVdoUvNsQRFqvM
IgGP9NTG4bePGByDi9Gd95Eo14bl34KQpbZHmTe+eC31WSILSmcw/VYNW6Wk9pFS
B84c/moELOptjV8f9z6zF79tSirub8cepSjFbs9AOPVxCDk2bbKd/I4YFD5kzGQ5
Bp3RHYqGcvOWSponuOS2KCEfXV5LbQkgDJFuENu7XGT5DOJNRavzDeG7PU37RZny
fb6eDdVRAUNEZVvnZ3zYIr1br1w6+Wr4K5H/HnTx76zD5w+dlSs=
=BOh3
-----END PGP SIGNATURE-----

--vO92KNZJo0wSkuR2--
