Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6469C3DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 02:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBTBCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 20:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBTBCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 20:02:38 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B4D52C;
        Sun, 19 Feb 2023 17:02:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKkfg3k0sz4x87;
        Mon, 20 Feb 2023 12:02:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676854955;
        bh=99/2cu/oKbkgwuErf6nmajBlS2oLtDnVrf5Qoar4UlM=;
        h=Date:From:To:Cc:Subject:From;
        b=u9VpCBMIAkWUgR/HTyt/Vo2tOoQTn+Wocjf46LioD3xn8lJCTHN1rA5kANC3QnFvL
         b49ld7bwfqfKtdcO6Xd38cgC1C6vvR7zjmdfG2O0l3m/T2bk1LSFQFXYjftVTqHYKq
         zD6DTpqCWqcKZPGzMOWR7Wm1WRHLS3f5KO50HnKmv00v7abe1kdouw1oqpaZesriS/
         DujunLhN93AEBc2BdsCEvKO7HEeSPO/XVqRbV83rPaWyW8NIELx1PueOJ74mNBYkY9
         IumS3+aDGrQTddEndNTbX0cBwBeD/Dwj8gVu5/pl4Jm5JqX7f6zr4j1QwBh+dP5a/m
         17qlsCSKA4HwA==
Date:   Mon, 20 Feb 2023 12:02:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the block tree
Message-ID: <20230220120234.161a6002@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WHhgSQWrYHIpG74LLPSKD21";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WHhgSQWrYHIpG74LLPSKD21
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  78e11ab5adf7 ("mm: Pass info, not iter, into filemap_get_pages()")
  a53cad008099 ("splice: Add a func to do a splice from a buffered file wit=
hout ITER_PIPE")
  f2aa2c5707ac ("splice: Add a func to do a splice from an O_DIRECT file wi=
thout ITER_PIPE")
  51e851b5d16f ("iov_iter: Define flags to qualify page extraction.")
  0fff5a38a770 ("iov_iter: Add a function to extract a page list from an it=
erator")

These are commits

  c935d7b85ae1 ("mm: Pass info, not iter, into filemap_get_pages()")
  03aaa67b45e7 ("splice: Add a func to do a splice from a buffered file wit=
hout ITER_PIPE")
  1dba0a6d58da ("splice: Add a func to do a splice from an O_DIRECT file wi=
thout ITER_PIPE")
  f48b6bcd02a1 ("iov_iter: Define flags to qualify page extraction.")
  c82edb69b878 ("iov_iter: Add a function to extract a page list from an it=
erator")

in the cifs tree.

(A few of these are not exactly the same, but very similar)

--=20
Cheers,
Stephen Rothwell

--Sig_/WHhgSQWrYHIpG74LLPSKD21
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPyxqoACgkQAVBC80lX
0GwhBQf/fd8qSVaIOvjzRqfosD1J2I+EdQtkwUE2Da4HRDKjoTCD/EMMtmTXEI9R
QIApyz/zQYpait3JUT/ukFm3lpxUSlo0Vb8eaAt6u7sG9IorWvsl4U/U2BiXizJk
zICpMZS7dHblaihaYwcnyb1MwQ2v2Dz5c3NGosI9TjPpXFzMmlq+aiSkfWi0RFLA
zn440tDKGBe8DhUi3eK/LAOMKoNriooX2ORLfxXwv+Hm2Riv5yp1ckJWVpU2CSVD
XO0nQohslTNNdiC5Q+NhtfVGpn+hp27qMoN6qhmz3r+cib+GXRplkoa4o6hnoXKE
YwRViAAQ+1t9rEv/ioXcUfsNrVxUdw==
=zCMy
-----END PGP SIGNATURE-----

--Sig_/WHhgSQWrYHIpG74LLPSKD21--
