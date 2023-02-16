Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B057698946
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBPAas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBPAaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:30:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452EC42BC9;
        Wed, 15 Feb 2023 16:30:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHG7c3dmVz4x5X;
        Thu, 16 Feb 2023 11:30:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676507437;
        bh=8ToH5Hy9Jqn84CJPYUsxz6idIucqqXBwd1ipim0YCnw=;
        h=Date:From:To:Cc:Subject:From;
        b=OULtGq/Ch1HhpMWfCjkC0TQ9QnddGZNdGAcPu1EBWsDg79n4WyxXzlLnyJ/vyy3CT
         b9egGh7ZnsnPZzEnoYakrArVOH4Lrkkw7Oj7W6exhFU3uqtiNUuo+S+zXWwBZmSntP
         aRocBO26V/c7LtuyO3XMHEmFTP3/k4U7KmZIP8R1VTNWcW5mojhWDn4p63Cp1918wW
         E1IBzgNXiSVIPU81fcMH3UvYx4Vfk7NfBhCoCAUiiXeJqZaeyMlmipzIfoFSGX+Ky8
         MmeNXiBdzGWs0TZsmO7JJ1dfi7m9K6/klUKdrwILi9SwnkhAiesmqSwS3Te3KZGXq2
         TUO+Xar05/0TA==
Date:   Thu, 16 Feb 2023 11:30:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Cc:     Alain Volmat <avolmat@me.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: linux-next: manual merge of the spi tree with the i2c tree
Message-ID: <20230216113035.3050871a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_NQtuGwfo+tEnw0WYtHkIEX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FORGED_SPF_HELO,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_NQtuGwfo+tEnw0WYtHkIEX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the spi tree got a conflict in:

  MAINTAINERS

between commit:

  b3de755d6041 ("dt-bindings: i2c: i2c-st: convert to DT schema")

from the i2c tree and commit:

  7ec844a2c753 ("spi: spi-st-ssc: convert to DT schema")

from the spi tree.

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
index 71e92d3c51c6,daa33e7bb457..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -2791,7 -2925,8 +2791,8 @@@ M:	Patrice Chotard <patrice.chotard@fos
  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
  S:	Maintained
  W:	http://www.stlinux.com
+ F:	Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
 -F:	Documentation/devicetree/bindings/i2c/i2c-st.txt
 +F:	Documentation/devicetree/bindings/i2c/st,sti-i2c.yaml
  F:	arch/arm/boot/dts/sti*
  F:	arch/arm/mach-sti/
  F:	drivers/ata/ahci_st.c

--Sig_/_NQtuGwfo+tEnw0WYtHkIEX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPteSsACgkQAVBC80lX
0GwVhgf+O092/OcvSItvBp7tlxhdQ+X/IBaoE+0xte68jTS1YIvQCmJXPIJQhW6x
yyOn+bvws9Fj3wO7+KG26IsspEx5SpWoJjCbgDOgiTBIvYccXhnbL/IB9dP4VaxV
ckjhbiiO88thG6c3zhWNumFj5RYq8X24Pw4wYzwqHN73WzV7y8WnYOJETBN/dL3Q
FFNhaRkzKgwT8ooU7wzL+Rv/uAkXkCoki5B7xh4BussCaVsh2dDUMYIEYGGz/aJT
mWK347SczxgvHEdYy0Oktuvqz81y6fpUHaGPIjdKZuYMOpmpGqKDcsB0YW8wa5W1
KzOhTvEuVKXUPzhx+4AnCIjXS1luNg==
=dS3K
-----END PGP SIGNATURE-----

--Sig_/_NQtuGwfo+tEnw0WYtHkIEX--
