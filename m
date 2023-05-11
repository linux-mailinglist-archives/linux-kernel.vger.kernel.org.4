Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAFC6FFD6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbjEKXje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbjEKXjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:39:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CDA170D;
        Thu, 11 May 2023 16:39:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QHSzJ00S6z4x2c;
        Fri, 12 May 2023 09:39:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683848364;
        bh=jbFycTOzGO/rHyNPtmryfI+yiFtnzBiWqTgbjL9IAKo=;
        h=Date:From:To:Cc:Subject:From;
        b=tvArHnoNxurci3tgqUrTU72XJkUiuEFkpEfywexl3XHfzU8576DmOZoHBWcolHaz8
         ufXsx2Jk+5KHCCE++HYQWN3chXBZPn/ycyhoGEm3qy1ET+KUlcOus7ltAWhkaMB+ua
         PbVuZdKeKooVUpbtB3Loqcl1Rls+HX1NEVTScwFWkU+1w5JUipsMKE2UchCVcDPvvq
         2gFHOYNxx/23QM8Gg+eYG9o6137g7cYpoaU3kqSU6DrQQCOo8faHRw9pM77bRUuZYN
         NKtY++S31rkn3aE96yg/HC+eQm/TGBL0c2EEAIWuh05Tse/ksGmnOctI9stvgpoISr
         s1mK43Ps94EEA==
Date:   Fri, 12 May 2023 09:39:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the fpga-fixes tree with Linus' tree
Message-ID: <20230512093922.05dd8ba7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DxyIIQq5mwMQb0gdYdUgGso";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DxyIIQq5mwMQb0gdYdUgGso
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fpga-fixes tree got a conflict in:

  MAINTAINERS

between commit:

  80e62bc8487b ("MAINTAINERS: re-sort all entries and fields")

from Linus' tree and commit:

  01b03f6266f4 ("MAINTAINERS: update Microchip MPF FPGA reviewers")

from the fpga-fixes tree.

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
index 9120487cfcef,ba64194dc7df..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -13831,14 -13741,6 +13831,14 @@@ L:	linux-serial@vger.kernel.or
  S:	Maintained
  F:	drivers/tty/serial/8250/8250_pci1xxxx.c
 =20
 +MICROCHIP POLARFIRE FPGA DRIVERS
 +M:	Conor Dooley <conor.dooley@microchip.com>
- R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
++R:	Vladimir Georgiev <v.georgiev@metrotek.ru>
 +L:	linux-fpga@vger.kernel.org
 +S:	Supported
 +F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 +F:	drivers/fpga/microchip-spi.c
 +
  MICROCHIP PWM DRIVER
  M:	Claudiu Beznea <claudiu.beznea@microchip.com>
  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

--Sig_/DxyIIQq5mwMQb0gdYdUgGso
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRdfKoACgkQAVBC80lX
0GzunQf/bKDoyTKck+Bq5cp6E3VTz4ZdA9sBSIpS//Qgb0gkrZiXP4qEfMi+mJlB
EKsKUjH+975eKLGsVh8YLMPG+arONhGJMBVLzvWjLfWDLaRcSeFXCqIbxolHVqEH
9EQnIax1NsjB8sdxKmOi/avh2J/6xUQz93QmfXdkptmgydZxiSYymTra4dycJ+rY
/9CP9MYW6kS56x6DIKY7HPpD/yHltZEdgRll7vBdVa5Suj8DezNQNXH0kn5+mFyG
fVTE3tfklKVMgF2sIScbdY+4Ora+7TmwpZZOx/0tJnn6t+AYG6tnsFA125IkBtfR
IIZQmWJ6yzL5XTzgTl3h8gOXWhmSSA==
=9RoG
-----END PGP SIGNATURE-----

--Sig_/DxyIIQq5mwMQb0gdYdUgGso--
