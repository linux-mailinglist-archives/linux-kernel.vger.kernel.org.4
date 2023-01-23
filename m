Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7931B6773DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 02:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjAWBpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 20:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWBpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 20:45:13 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E2F1A494;
        Sun, 22 Jan 2023 17:45:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0Xwb2B3nz4xwy;
        Mon, 23 Jan 2023 12:45:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674438306;
        bh=tNlh6NMoN2mAbHidhWi0u+dbrFSTCK9kKYH9dvtifio=;
        h=Date:From:To:Cc:Subject:From;
        b=VUWQBCTId5HmwBmY9QmFVFWBmEK3u6dnCtyANQlM0mYvQdJolDQf0AQvcBQlthP7u
         KjHQaZyQLvBSyd06zvo4t877wpYqmeJK7fny0W02+ALOedV1leLrriiF/ct1AqVZ3s
         3zuk78HbuzS8t9SsV6S2h5YytxZaSbheaxP+oaYDjxZZJ0wmW5QbWypbL7h1x8+SZW
         caLK2WVGcsDr5ov1ZwHC1zU819k5IvpY0kr44CIfoa8df0PlvIQvX8XKU6mVRrkyMT
         HYCBsAvmtkrfxT4qzmug9KoeD1HUF5gBYy5TYq8t41ULzAL8rks/OPOYxOm6PNDF08
         xsRgzOdm1XSjQ==
Date:   Mon, 23 Jan 2023 12:45:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the fpga tree with the tty tree
Message-ID: <20230123124502.725e8700@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6pkR114R5xtkMszxFu05+11";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6pkR114R5xtkMszxFu05+11
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fpga tree got conflicts in:

  drivers/fpga/dfl.c
  drivers/fpga/dfl.h

between commit:

  4747ab89b4a6 ("fpga: dfl: add basic support for DFHv1")

from the tty tree and commits:

  3afe90d5b7a4 ("fpga: dfl: kernel-doc corrections")
  e5541aae450e ("fpga: dfl: more kernel-doc corrections")

from the fpga tree.

I fixed it up (overlapping fixes, I used the former version) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6pkR114R5xtkMszxFu05+11
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPN5p4ACgkQAVBC80lX
0Gw55gf/ZNFINdaYzfuBw+LlqWcOq8rlHM4e9blp4++QQXn0KILJr7jj1hU/uGF0
haApalWBbl/sNDoGkFVkPaOc/XkJuRoXUySKfIUcuk8ukBiO08WPPpz0efc3ZJVk
jftomMEEyJO5GHzvkT0CmtvCNieCseIrvhmUf7RsETiGaeKSpxaAEjexBUUhojH4
Zf0nqhmTjHbxq4jmZ+klfVwRNafyVCB+Gf/HcwC4YAubs9AQ42dlv7AA83eW+Fsp
GnjxkdKxrXa3bVwBIoLJDyymbpzhfqQgX07LJWVUJSPSiSLxuj97oO2oojW6/3U2
JTK6hencTIOYzPgfuYqz94bunKH/Sg==
=eeO4
-----END PGP SIGNATURE-----

--Sig_/6pkR114R5xtkMszxFu05+11--
