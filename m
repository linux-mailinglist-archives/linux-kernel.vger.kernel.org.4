Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B6C69C3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBTAqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBTAqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:46:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D6BB441;
        Sun, 19 Feb 2023 16:46:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKkJP4pHhz4x87;
        Mon, 20 Feb 2023 11:46:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676854006;
        bh=mRRJFhwfvEXGnPExNLCUZFya7MFeG/2yF6ecuT9eXak=;
        h=Date:From:To:Cc:Subject:From;
        b=h+lXuTl/J9flX/tR0fNvD0ly38SQ3qKvxOzEChCh27Jv5VDiRjmCsmTD/IcQervlb
         HoORMqIfdqPYWkwiDKuLCJWIDWgK2lt6aCNmmwnuxEdVb+e1l9qkAfewmm3tgquoR0
         P8aqgUvfBSp+BbEgcIumIjG3ur0JOCPV9gp23cue43c1FZ58EXKi1kUPOEM4R7Rr6Q
         vVHpvem6+bMfiGbJZlDZSEwhJF9glcWOA+y0kvqRypYNbLIot/iqgOK1MN2WG7HEY0
         bX8YzcHINwGLbWMSkmWrXrVsqrLWeaNwnMGeD18i+3MxQTUZwFpBUqL0P6pAB1Lwei
         o7dKGzYqUu8Rg==
Date:   Mon, 20 Feb 2023 11:46:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the block tree with the cifs tree
Message-ID: <20230220114644.72387d19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7aoEBM44xRrOg+dXMINBGE9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7aoEBM44xRrOg+dXMINBGE9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/cifs/misc.c

between commit:

  8378eea2e41f ("cifs: Change the I/O paths to use an iterator rather than =
a page list")

from the cifs tree and commit:

  220ae4a5c2ba ("cifs: use bvec_set_page to initialize bvecs")

from the block tree.

I fixed it up (the former removed the code update by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/7aoEBM44xRrOg+dXMINBGE9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPywvQACgkQAVBC80lX
0GyiiAf/QzEepYJc5ni3VE+v9x1rnc4AFsiITe9F02fghkwpJP4IhftyMLf5uhf+
WfPtn6WpgXe3J1cCBHg7KJUCqg98uqKLhE1X1Y84y+5PHMFCrmjNiEbHQcyyOZ6Y
f33Dxpihe6KcZWisxfLwCqCU5oS5e+aQ1wBdO3bjTpKpnSoUIBnxlfeMSbpkuNDu
UdZD3wR2sPu7DZBiODT1CIs11HwTTPciW9RtbwbnsHPhL4KavBCtFNriq1OAeNz7
Wk/c89kDO2gkYb/G/AG6DO0+XYh2lVyuYyH2+eOU93Mqu/Xo8iAITTXfoP5ptn2n
jMgKHhae+VIffdqcG0q+282kIwEHYg==
=+CyS
-----END PGP SIGNATURE-----

--Sig_/7aoEBM44xRrOg+dXMINBGE9--
