Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180266B628
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjAPDcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjAPDcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:32:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ECF5245;
        Sun, 15 Jan 2023 19:32:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwHdK2nHgz4wgv;
        Mon, 16 Jan 2023 14:32:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673839925;
        bh=MYzrcPtOc5I2lrsnKNs2i9UU6uSObM46NS6qIaN7NpI=;
        h=Date:From:To:Cc:Subject:From;
        b=VNU0b+trYcrro8vRg8vZDg/RmFKdBQLNtgpFUt0ZMXoAkHx4ALjJXT/6F1UvLWdXi
         zsBdrRRd3iUQtJRmwqfBO8IxuyXqwM48tb6/OQX5MhnsmdLFjb6//S/URzUY7OXfh9
         kQvDDXrcDGQqu4KsaA4clTx/xud0xHGlwLjrL4Mhusco0Ar5RkNqmBV5CLKuUtMRqJ
         PTjOaqWYaDAgLSMUs9zcUtoqi4JE2kte3XpD4LrnbtkEqQtrw/zv9xjs16s6aMCMSc
         IsBjHaiuvaAqZSCJeChc8Dbu9kDU+adUROZJ7Xr0OpEvMC3PIvrE5pAdv6hoI0cWWm
         hyX7yjWGODUNQ==
Date:   Mon, 16 Jan 2023 14:32:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     JaimeLiao <jaimeliao.tw@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the nand tree
Message-ID: <20230116143203.3f91f181@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xEUa0vyaTTB++MlFIL6fw4Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xEUa0vyaTTB++MlFIL6fw4Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nand tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/mtd/rawnand.h:1325: warning: Function parameter or member 'co=
nt_read' not described in 'nand_chip'

Introduced by commit

  003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")

--=20
Cheers,
Stephen Rothwell

--Sig_/xEUa0vyaTTB++MlFIL6fw4Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPExTMACgkQAVBC80lX
0GwMewf+LLuOeht3jPg+vLo+lEmCYcGrZZ6bAdDHMiBCFjIuAuWXc/HX18lQLH7o
L2cQs8zTJzQf3O+WSxgeOr/nj2ESSiNObJswqzpS4XDmHrY6QDi4WUO+fIRTQHE2
cq2Ebr1MmsnQuGoKTzh4dg5tUYE6zzIeJ5GwcK2ra6KnGD7GO2fdlVUupVLmWkTJ
pnNx/wPwgqhIYFZ42+K3p+wJPMXK+P16VYtaXKb9/Y27golChnTmejgn0p6cbJLc
5jyXCtUtg9enuO3MnSlC+rN/rAUa7+9anL9+6neLwzd0+S7oDtTISWvyeY/YAojF
/3/ZnzJZHuRcHNxSK3yM4gYqJ39j5w==
=WV5y
-----END PGP SIGNATURE-----

--Sig_/xEUa0vyaTTB++MlFIL6fw4Q--
