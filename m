Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E739469EA21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBUW0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBUW0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:26:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15B311CB;
        Tue, 21 Feb 2023 14:26:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLv5n5qCBz4x7W;
        Wed, 22 Feb 2023 09:26:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677018398;
        bh=V1/f9v59w+BVbIzsyiRBrchs4SsCIO2L06KQEk7jpA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZyVLlP3+jhCznDZf2I22GMuAPDlQ0xzgkpPzr4kheZt3b/qEDJju4QQEFoaEL/srf
         9StJimAXlG3X9hU5Smi6dGNypIVpbBbdAdn9ao/5CT6EihGEIkfawtBDzcrvd+OWrS
         DKxEJLrMUyN7nD8by4w/4TTH0WO5PCU1MNtWCusltSuA1gHFYBuoRAJdkpA0TbRNTk
         xwfcyo3UiEFnBDdf2ojmEXQSV6nce3kHw+8pfDEUn8VcYOmEGRjJXk3fs8FtWBT7jr
         W7gMz9z/g+WK3UNRmiKbiDr4FDBc02jGMle5/jxIrl6HvqQagomRD0j0BVSu9v1QFd
         j7JO/F0g+SASw==
Date:   Wed, 22 Feb 2023 09:26:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the arm-soc tree with the kbuild
 tree
Message-ID: <20230222092637.07b4b106@canb.auug.org.au>
In-Reply-To: <20230130095638.72fdea23@canb.auug.org.au>
References: <20230130095638.72fdea23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zEU1Ik=qaAycgxbfJvwRplA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zEU1Ik=qaAycgxbfJvwRplA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 30 Jan 2023 09:56:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the arm-soc tree got a conflict in:
>=20
>   arch/arm/mach-s3c/Makefile
>=20
> between commit:
>=20
>   608d67522f28 ("kbuild: remove --include-dir MAKEFLAG from top Makefile")
>=20
> from the kbuild tree and commits:
>=20
>   61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
>   1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks")
>=20
> from the arm-soc tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc arch/arm/mach-s3c/Makefile
> index deb44326b828,988c49672715..000000000000
> --- a/arch/arm/mach-s3c/Makefile
> +++ b/arch/arm/mach-s3c/Makefile
> @@@ -2,13 -2,7 +2,7 @@@
>   #
>   # Copyright 2009 Simtec Electronics
>  =20
> - ifdef CONFIG_ARCH_S3C24XX
> - include $(srctree)/$(src)/Makefile.s3c24xx
> - endif
> -=20
> - ifdef CONFIG_ARCH_S3C64XX
>  -include $(src)/Makefile.s3c64xx
>  +include $(srctree)/$(src)/Makefile.s3c64xx
> - endif
>  =20
>   # Objects we always build independent of SoC choice
>  =20

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/zEU1Ik=qaAycgxbfJvwRplA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP1RR0ACgkQAVBC80lX
0Gxv0wgAm3Rn4bU7fp9ZlekGWFfD2iVk/+p8KbZ/GqB9fZFKn3+2o4D+KNEiIADV
EIvzUQtBEzGWSfztyffJi1rMW6AuKTzW3Ktoc4kJorVHSuU/nCoZI4m5BTeBbjsQ
Lxr1iRB/0VWBdSXrNYv0x03v+cjJEhqrD28iaZ1jqSbf3M/61ZmdMHkP5nqs2DkY
9rrDGRqtUXU9EQkFBT5zn74AmDqwf8k0qYc+SowGELMi2mljiRzxNfyt8JvJ6zzJ
5lbNZqhreC76zf4/jsQ0jrleJVBIMEJ+yJrcaTmPK5qVAayOxxHnQz9v4096/hkB
Kp8nrxW+UsJ7gAaotgRzAPulHDxcRA==
=TcAS
-----END PGP SIGNATURE-----

--Sig_/zEU1Ik=qaAycgxbfJvwRplA--
