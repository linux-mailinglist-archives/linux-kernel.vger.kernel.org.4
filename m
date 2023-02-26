Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A866A34D5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBZWxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBZWxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:53:36 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7B4C15C;
        Sun, 26 Feb 2023 14:53:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PPzSX0srCz4x7s;
        Mon, 27 Feb 2023 09:53:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677452012;
        bh=K0WpDKDfax4BUv6bQL8WDOCANkN0ML2jDeB2DB3uhi4=;
        h=Date:From:To:Cc:Subject:From;
        b=gsMBhYxC6ih6KpHt+eUzFn3UvvElfc7qDGkMxEFqePmxBvmAb7GyaFdKfzTj4Wn1V
         ZxSxWSsPkd6lxfdW1GQ97DWNrBNTw4U3l16aapfaYf72gPh09st1K033+FFbW/EJ8H
         IsnHnUF10r5UPePJn1luVYPtfFQelWvJ0INbVBMdY2e0a3bYwj2334HK7D+Gv0SOfX
         9YAnrrWtHjqe5rQIsG892G8aHOzxKLawlpoBopm4J6+jrU1/QPkKxFCkCIwFHPFl6z
         4C0coeWT8qNN0lsLQTxIRJkkCHjwV06RBJnDqbZDRIzhOOhfoYpniMWw6j7UZ+gAXf
         1RY26J/NM3A2Q==
Date:   Mon, 27 Feb 2023 09:53:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Edward Humes <aurxenon@lunos.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>, Song Liu <song@kernel.org>
Subject: linux-next: manual merge of the modules tree with Linus' tree
Message-ID: <20230227095331.70887930@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hgfYJLNPPt+9Mt4=YrFVUR8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hgfYJLNPPt+9Mt4=YrFVUR8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  arch/alpha/kernel/module.c

between commit:

  b6b17a8b3ecd ("alpha: fix R_ALPHA_LITERAL reloc for large modules")

from the origin tree and commit:

  a76b092b5655 ("module: replace module_layout with module_memory")

from the modules tree.

I fixed it up (the former removed the code modificed by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/hgfYJLNPPt+9Mt4=YrFVUR8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP74usACgkQAVBC80lX
0GxnYQf/SvitaJCvL/epjMLt1jDj1U18U5CuqhFMOAqQG0HvVezw4DGSMmuru8SR
f0+qvTCAkQ9uImTFDG8KgX/5BQx0o0ec8WFYHvMhb1GBkzCVQEVi59aJjTRRTgPu
L0t7t7XA3ZaFjlRs/VRyGz2zgEBrBeIqvrRKLjeHxsuTGGQzvTZRLZobQGUjoqto
OI1vy6pwDJBFwhhJuIUw4y7HqCsluLhewZfsCtwjfVZ/UR3g99uK7gUnt/IU9mHp
st0PKsBgN0LRQmLseWLRg3cl6hmCEHjIb1oiIWYFTEryBgHd2FUb9wkDirCP7fq6
9NVnBDvDWY7T/sKS2iiJ6ndpzmjGOQ==
=JVz9
-----END PGP SIGNATURE-----

--Sig_/hgfYJLNPPt+9Mt4=YrFVUR8--
