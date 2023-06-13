Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31E372D8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbjFMFKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjFMFKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:10:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C5138;
        Mon, 12 Jun 2023 22:10:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QgGpB6jTDz4x4F;
        Tue, 13 Jun 2023 15:10:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686633011;
        bh=gS8ZgeG/D1C4ve6OwfzP8KEIIec23uK77blgMCsGrYw=;
        h=Date:From:To:Cc:Subject:From;
        b=XPwh/mVbl9Cf7Eqk1skPZjZM9y0POt3mFK4facadGxtXq5BIdv7Co28S/LtO3uvSC
         GpYfGHgvpDY+zv1E54CdcUOAySL3dLJannqpQjWAp6WCSIv2s5XrSIOHr5nlnEfPm6
         FXyyKk95MG9rk3+rY6XtXm5okR2KOkgCjA0eJ6FK1VOEpuzLAOAgM3kWnRivwg+NIO
         HX9GN7mJ6ZpLOEj8cuZxQs4XGmtgiCFugAvJBD/u4wKlYb/gieYg4UcWRnoI1X4agr
         TVFNjgKep+OXlJrGyRwps9Wcv1cJZbyXBLGcKDufHOYDrW3Mx6Edk+Ky28ExOMTyNY
         QznVwGyh92ylg==
Date:   Tue, 13 Jun 2023 15:10:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: linux-next: manual merge of the slab tree with the mips tree
Message-ID: <20230613151008.28167567@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7gW10odH2_zDOaApifuqX9f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7gW10odH2_zDOaApifuqX9f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  arch/mips/configs/ci20_defconfig

between commit:

  e94c1e492139 ("MIPS: configs: CI20: Regenerate defconfig")

from the mips tree and commit:

  eb07c4f39c3e ("mm/slab: rename CONFIG_SLAB to CONFIG_SLAB_DEPRECATED")

from the slab tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/mips/configs/ci20_defconfig
index 920b27977dac,28eb15a1ffc4..000000000000
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@@ -23,15 -25,12 +23,14 @@@ CONFIG_MACH_INGENIC_SOC=3D
  CONFIG_JZ4780_CI20=3Dy
  CONFIG_HIGHMEM=3Dy
  CONFIG_HZ_100=3Dy
 -# CONFIG_SECCOMP is not set
  # CONFIG_SUSPEND is not set
 +# CONFIG_SECCOMP is not set
  CONFIG_MODULES=3Dy
  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
- CONFIG_SLAB=3Dy
 +# CONFIG_COMPAT_BRK is not set
  # CONFIG_COMPACTION is not set
  CONFIG_CMA=3Dy
 +# CONFIG_VM_EVENT_COUNTERS is not set
  CONFIG_NET=3Dy
  CONFIG_PACKET=3Dy
  CONFIG_UNIX=3Dy

--Sig_/7gW10odH2_zDOaApifuqX9f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSH+jAACgkQAVBC80lX
0Gzdawf+Mj36p5k1rdTcF6ywTI7qzcTCVopFTF8RKsB5RrPTXRiLoYAKRuQrA++N
QMRSHjr6ulvZNK7QICfjhWPkZAPa6CeHG0kSKg7ya+eDH84kNk0n/hlHNF81c2Pk
KBgno6Tig/8tPzdd1VfNS7I4jCNS6UtJ6jJhw5vXcsG0ac240hIMCSORgZwuhQKM
mr5gHzXOdfo/ykEo/5vsPBiSNKtNsuD8NNVxiwEnA2E5niMVNO9Mesw4vLXMVZar
Vkilmtm9kSGmb2vpgtTgUvdZqNSWjxpzfmzFl/G0N4o+4QwKv2UvNSzlkU0A9/LS
VLZ+H4cgqy0kY+wcwciSb4o7rAxKCQ==
=E51w
-----END PGP SIGNATURE-----

--Sig_/7gW10odH2_zDOaApifuqX9f--
