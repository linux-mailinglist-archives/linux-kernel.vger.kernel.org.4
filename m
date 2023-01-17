Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4966D3CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 02:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjAQB0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 20:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAQB0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 20:26:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7981EFEA;
        Mon, 16 Jan 2023 17:26:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwrnF5bvXz4xG5;
        Tue, 17 Jan 2023 12:25:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673918756;
        bh=L5BxRwBIjGaxgwaMH9MFPPUWp51rN4zJLW/6C/Yr0hI=;
        h=Date:From:To:Cc:Subject:From;
        b=dJBZP7tkWgk72jNAUI7VGH1PsvtUbpuA0Dh0eYXB7uuVPAeK5GCF5wan0APnSQH/V
         bBVUqNUmz9ljQKEwEGsrHAkNX+/7lGwJM/d16oj2bYAzZEZ/43O+xpdALy8z0+94lF
         u/NpT42nwGLxrGJ2sGJtlLsF7xTmDUfK2j/pIHBaGb15LS2Jn9Sw2Hl8WLbmfgeMPE
         EWusflkX3cXtiXOXQ7ZVjm4lDBevXtGcLPXS+UcN55qn1avdqfU6KcsAD7CmrViO1n
         fnW2Sbc4TpAJb1PvkTwTsnL7fl8bXQRusWAn6oQ5BrRKGxXkB2eBBFTIr5ANoJFN6Z
         LSTDSkJbTQmcw==
Date:   Tue, 17 Jan 2023 12:25:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: linux-next: manual merge of the iio tree with the arm-soc tree
Message-ID: <20230117122552.64f70650@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pf0aG.cNpqye9VKkHz_RMxl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pf0aG.cNpqye9VKkHz_RMxl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iio tree got a conflict in:

  MAINTAINERS

between commit:

  59ce53421673 ("MAINTAINERS: update file entries after arm multi-platform =
rework and mach-pxa removal")

from the arm-soc tree and commit:

  08025a3bd9e0 ("dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc descr=
iption")

from the iio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 390d79c20a59,9ff472ca1244..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -2071,8 -2091,10 +2071,10 @@@ M:	Hartley Sweeten <hsweeten@visionengr
  M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
  S:	Maintained
+ F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
 +F:	arch/arm/boot/compressed/misc-ep93xx.h
  F:	arch/arm/mach-ep93xx/
 -F:	arch/arm/mach-ep93xx/include/mach/
+ F:	drivers/iio/adc/ep93xx_adc.c
 =20
  ARM/CLKDEV SUPPORT
  M:	Russell King <linux@armlinux.org.uk>

--Sig_/pf0aG.cNpqye9VKkHz_RMxl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPF+SAACgkQAVBC80lX
0Gy1/wf+JgiMusmIb9Nl9rt1k07t2L6+uEg5nVwZcSeNSFE2ny4uZU9+58VVi6Zl
rYPkGWVkdZJV4MFDMM8u1GtdJd57ckHf+CdXKDFzJo5xfUIgO/qXNrug0JyP6CR1
tTLiVIRb6+DDpfYGccXKc3gZJUKsjx3BBAC5itjA26BjRiCGvvSpYSKRshs05NPQ
iaim9n4OAmcCW6djo71P1HJTY/1LO1wF7PXewwG5yRcVfgbtlWNcDDPDteEXFg3Q
bZNQ4yqNz3t9LWes+gpKC7IHB/7mQfpqKW9FtG/DZ4J5HM3GeIkzEMoagXQz81e5
LQlNxfVUeROlVGG32Z9cz5+mJzIHSA==
=R1Ck
-----END PGP SIGNATURE-----

--Sig_/pf0aG.cNpqye9VKkHz_RMxl--
