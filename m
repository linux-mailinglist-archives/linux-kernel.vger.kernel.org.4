Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687336D733F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbjDEENr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbjDEENS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:13:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE865A1;
        Tue,  4 Apr 2023 21:10:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PrrjL5M5rz4xDr;
        Wed,  5 Apr 2023 14:08:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680667735;
        bh=jfzJtjCCoBWpeD2YmyWJtPnT5dMJwsavg/kMJjQ1Im4=;
        h=Date:From:To:Cc:Subject:From;
        b=jl0P4ouUZXRr/gK2jjHTVqYM5MJs+qW7ffV4VdZwx+x4xiGkBPYCPNB49gmD49RD5
         rjWDLzpyZ5oPEBZ7v9uRjhLKb4fMPK7vDOzqsasoe5PGqGQRXDeolbY2CBVncAxh3o
         yrvAziUDAqndNTdQ3h4u/loHP7SDSiddkQd/vHNsK6ZJfwwAbRbhprLh2qxGGZa1OE
         td3FYUem3M57Ch1pXcPAGkigdJn9QWZHvub22pGAMYqM/B6oJx65fRB726c1pXU8Wn
         xEr36mPgPAmqvXculrcrHBiyHktHsI910A8Gw9bb+Kptdao4iLCLEvU1GK4t/iumgo
         FPq7EvIg2RNag==
Date:   Wed, 5 Apr 2023 14:08:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: linux-next: manual merge of the slab tree with the mm tree
Message-ID: <20230405140852.04a808e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z+4+f/6XzaGqep7DvXv7JMd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z+4+f/6XzaGqep7DvXv7JMd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  mm/slob.c

between commit:

  3fb083757df1 ("mm: vmscan: refactor updating reclaimed pages in reclaim_s=
tate")

from the mm tree and commit:

  6630e950d532 ("mm/slob: remove slob.c")

from the slab tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z+4+f/6XzaGqep7DvXv7JMd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQs9FUACgkQAVBC80lX
0Gy4ywf/WX+VQIu0WNxYNBdL5nYFdywMudoIr5Np+k9I0dL9TMs1TcHRCHtT9+OT
TBUDK2+Iko8luueRlTLuHq2tBanI1312tlTYC1s6wSnzx8d2x1hZ2JHs2UQDjyCr
jDU0RcsFmTxSmdas8iuK0DSTIAQJ0r+G1RwXLV3G6Pxdds5YWS50oT+UKd1dj8II
wrJF1KGQ6+VZ/328VRot1n/hZ21DDEy/8b/Ibf4bGLLYimUcAgW31QasIeW5v3As
YNpIVoSWbVFTuu4p9nkkVJG07A+lV3I6Ojhy/E73ePXGWfHqjFOmNYSW9Uw3Lj6h
ELaDenr1t0mGv1+vP41k1E4vYQ5q1A==
=pM/D
-----END PGP SIGNATURE-----

--Sig_/Z+4+f/6XzaGqep7DvXv7JMd--
