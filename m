Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644CF68B23B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBEWoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBEWoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:44:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45DC1A492;
        Sun,  5 Feb 2023 14:43:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P94F06Ctbz4xyB;
        Mon,  6 Feb 2023 09:43:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675637029;
        bh=ToSRyOnt+SMIl83Moe9rZ2gVH9ENeHgMgmJFsa/u19g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QcVwwGSfNHRrHBvOigiqXS6dmQqn8GxE8EpRtYUCf3gEDw6YWTTEsxiidfElf1Mod
         RnTzwGl3uizT6S4I5lDf59fpiXIaQcyf1Xw9RZiL/bA47D7Gx2kt0xttSFwHBjA/hZ
         tb4VLc+s5hr3TJ48p0sRmVWSRC77NFSJvH8btX4IB0Gl3yU7cuNTTCS0d+w21Dh2Ra
         ZBNSoHdmYv2DGqcXrUUef19Huv8sCdiVfCMZPE2TanOydOWBSSg6iOsHbU0lHy45RF
         ZLCzfiGbPXEK2wa9/EPp8+A4xIdu/iXZwqNYl/lXVmui3vyUeFerSCDa6g0kOUlhmw
         7JqrJDwxY7afQ==
Date:   Mon, 6 Feb 2023 09:43:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20230206094348.42b02026@canb.auug.org.au>
In-Reply-To: <20230206094003.5438e04a@canb.auug.org.au>
References: <20230206094003.5438e04a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+bheUYF/Fx..ut7oIEXULER";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+bheUYF/Fx..ut7oIEXULER
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 6 Feb 2023 09:40:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the risc-v tree got a conflict in:
>=20
>   arch/riscv/include/asm/hwcap.h
>=20
> between commit:
>=20
>   0b1d60d6dd9e ("riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy")
>=20
> from Linus' tree and commits:
>=20
>   80c200b34ee8 ("RISC-V: resort all extensions in consistent orders")
>   d8a3d8a75206 ("riscv: hwcap: make ISA extension ids can be used in asm")
>   bdda5d554e43 ("riscv: introduce riscv_has_extension_[un]likely()")
>   03966594e117 ("riscv: remove riscv_isa_ext_keys[] array and related usa=
ge")
>=20
> from the risc-v tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
                 ^^^^^^^^^
Actually, the latter commits supercede the former one, so I just used
the latter version.

> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

--=20
Cheers,
Stephen Rothwell


--Sig_/+bheUYF/Fx..ut7oIEXULER
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgMSQACgkQAVBC80lX
0GwjlQf9GhLVCtPs4NDcuzMC5SinXJJZKPPC5qjU00SEV8nucX12ZdRplJGmbHVy
uT5/LkqRUJhGrmH+SVpcvODf68qaNGvC1TIEhtFRh9HMn29N1RQN9zVkxvhCi3bH
dYQQ7knMftyJbjgMQp/9Stz13Dt5uzMtc75rknBOhUPxZLOGWK3TgRQw6pLFxKCL
20/EA9ZdzWqy51x7Ktqo7kbuSy/yibPhz3JNEorjxswfXO2RyLecQR/yXY3QO/sO
KJjzfzks2q8Cqg5V94jqBFXHvwrTXAGlvnK6a04FKLQuExLTVcTOM79hZVre/Eyz
xv/paJFG4cbKGUGdWXsiswO3XsqaEg==
=xt/O
-----END PGP SIGNATURE-----

--Sig_/+bheUYF/Fx..ut7oIEXULER--
