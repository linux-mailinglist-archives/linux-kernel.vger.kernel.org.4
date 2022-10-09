Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211F95F903B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 00:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiJIWWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 18:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiJIWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 18:21:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775221CB1B;
        Sun,  9 Oct 2022 15:17:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MlxGS5W22z4wgv;
        Mon, 10 Oct 2022 09:16:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665353793;
        bh=5JXiyZ2rBUBWg3NdZnRUOBYGxdaJVI3zNREgAnnnSGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RVxnEoNnLYmLN/XeKRBBN0MbOXQ7XdNGTwIFR7MAqcDRQC+OXtn6AWacO5gOP8gJP
         pairn8Mfsct4dLSrLqwliTM9oUgUXDPB2m04UNsCzJncJ9IUO6xkSqOLJj2qfCIFnj
         5w2iCiFpfYsFHYY4KCHtxRQ//JycHRaIsKMKx+PAPPBdMsWizVTQu9cfsAO8reCMp6
         SJMo7QCx3AKrCy+OT91tXDROL4CJMvHvAZZ5KfPsVTGb5LRepEisAPHmuQVDfLo1hI
         8RvipvyxQorPHaOXKeGeqvacFqTPPAlzRZ9nLR7VGKgepxnV7rN0SvmxCUnDJ0xmJF
         0gXpZ1KGBKcbA==
Date:   Mon, 10 Oct 2022 09:16:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the kbuild
 tree
Message-ID: <20221010091614.20a89f56@canb.auug.org.au>
In-Reply-To: <20221004091205.2677b823@canb.auug.org.au>
References: <20221004091205.2677b823@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.km7qOSO.2uHzBoxFdOk.nC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.km7qOSO.2uHzBoxFdOk.nC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Oct 2022 09:12:05 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the powerpc tree got a conflict in:
>=20
>   arch/powerpc/kernel/Makefile
>=20
> between commit:
>=20
>   321648455061 ("kbuild: use obj-y instead extra-y for objects placed at =
the head")
>=20
> from the kbuild tree and commit:
>=20
>   dfc3095cec27 ("powerpc: Remove CONFIG_FSL_BOOKE")
>=20
> from the powerpc tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/powerpc/kernel/Makefile
> index ad3decb9f20b,1f121c188805..000000000000
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@@ -118,12 -116,12 +116,12 @@@ obj-$(CONFIG_PPC_E500)		+=3D cpu_setup_e5
>   obj-$(CONFIG_PPC_DOORBELL)	+=3D dbell.o
>   obj-$(CONFIG_JUMP_LABEL)	+=3D jump_label.o
>  =20
>  -extra-$(CONFIG_PPC64)		:=3D head_64.o
>  -extra-$(CONFIG_PPC_BOOK3S_32)	:=3D head_book3s_32.o
>  -extra-$(CONFIG_40x)		:=3D head_40x.o
>  -extra-$(CONFIG_44x)		:=3D head_44x.o
>  -extra-$(CONFIG_PPC_85xx)	:=3D head_85xx.o
>  -extra-$(CONFIG_PPC_8xx)		:=3D head_8xx.o
>  +obj-$(CONFIG_PPC64)		+=3D head_64.o
>  +obj-$(CONFIG_PPC_BOOK3S_32)	+=3D head_book3s_32.o
>  +obj-$(CONFIG_40x)		+=3D head_40x.o
>  +obj-$(CONFIG_44x)		+=3D head_44x.o
> - obj-$(CONFIG_FSL_BOOKE)		+=3D head_fsl_booke.o
> ++obj-$(CONFIG_PPC_85xx)		:=3D head_85xx.o
>  +obj-$(CONFIG_PPC_8xx)		+=3D head_8xx.o
>   extra-y				+=3D vmlinux.lds
>  =20
>   obj-$(CONFIG_RELOCATABLE)	+=3D reloc_$(BITS).o

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/.km7qOSO.2uHzBoxFdOk.nC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNDSC8ACgkQAVBC80lX
0Gy6egf8CKc2goJR5uR31lWy7MtzaXaEXtSJhagzpfue8Ykt1sikkbMLJt+i2WVt
zK2/ehfB9wV6o37xfSdeL3slBnX7bkhqEI6oolypnozHXRArTYbtCO1uVs0cO2kR
+vR1h/TzNcApDlPnZ6DKEjpVDAv3uQyFFuMy9CrTR8lq4ZR7xL/5l9ksfcd02vOO
+aSrN0UDZ05BeFF5AzQs7wBl4iBrDqr+1atpqtxxSmyAJqs+yT2w8mjov8+u2x2p
HUL/F+PepQhGYLFY+M1x56VYH8BLx2SPBc1wM+LZtfGPIYCV/Aw8Ma8i6VKhV2a1
hnOJqR8ie93KM+zhra1hgZrxlurK+g==
=ID1k
-----END PGP SIGNATURE-----

--Sig_/.km7qOSO.2uHzBoxFdOk.nC--
