Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C494639E94
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 02:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiK1BHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 20:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK1BHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 20:07:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84084BC20;
        Sun, 27 Nov 2022 17:07:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL6kr2vkcz4wgv;
        Mon, 28 Nov 2022 12:07:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669597637;
        bh=dhcTWUZIbf9mIzvVAIeKVAjJWbZSofWY1W04gPLMEzM=;
        h=Date:From:To:Cc:Subject:From;
        b=oKsbAzoK357kN2kjDOyL9x24peALL7YCCMlpfNgr4quWF9CJj9KJnuWX7phyg9ZIs
         5hA1TqHL/vjc0wLJxPYW8nez3cikteRQ24A6Ns753T0dhFy/rpmO3CpGeoCAlMqQh9
         cp6Sh436qsyhK+7D7+YT9l1HHtomzM3zw7mscKZHjKJsZCeY7Q+T1PNYtsM1wzZ4U9
         ntKCLS4+ilmhFQHkDys2p9bhcGcdQ9ywLAXfwpbxig3mASy7U9AMUIL2RVr1+eo7mb
         yBBvsDH8kecGl02xtHaWpw2qqdb3KtUuZFa5W/4kGxK3dLQhXPwpNsBKGDIBAcliU8
         w5aioRFq6mlsQ==
Date:   Mon, 28 Nov 2022 12:07:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the v4l-dvb-next tree
Message-ID: <20221128120712.3a330276@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+U8i.2aiK_k_ft79SofHTo0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+U8i.2aiK_k_ft79SofHTo0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/staging/media/atomisp/pci/hmm/hmm_bo.c

between commit:

  f5cb5adaa8ec ("media: atomisp: Drop userptr support from hmm")

from the v4l-dvb-next tree and commit:

  062c9b2996e9 ("mm: Pass down mm_struct to untagged_addr()")

from the tip tree.

I fixed it up (the fomer removed the line updated by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/+U8i.2aiK_k_ft79SofHTo0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOECcEACgkQAVBC80lX
0Gy3Awf/bHDtbsffrvfbkDngqR3sJht/jDujUJXxPmIXMcTQnMeSSv84uzg522wO
5PVuR3MuU3ewAFAotbLwjDxdNs+vU4drL18xKHFgjUsDx7xIj0WyPj2QA+rIgyA6
t6wEnbgOfLetY8WybNkanWvmRV4lORqrqgUiEKIQsy1hAMTFjd0k3HwFMtLG3NgN
OTWfjnwSwQni4OifQTxOoE9UiFT4w5y025L2reHI9xFKIsztsJ9NMR6g2RZZocdL
xpKeKurJrVUI1MI9MvQlODvKqNKBjF8rGKiO+SAuvzq8gy5zrz7HEX3uEvCP/jul
crxm+oyn8pEYCvvkdB63pYZn3qDksA==
=BXGS
-----END PGP SIGNATURE-----

--Sig_/+U8i.2aiK_k_ft79SofHTo0--
