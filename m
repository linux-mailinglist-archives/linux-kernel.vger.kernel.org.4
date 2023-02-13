Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8565693D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBME10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBME1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:27:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD1B658A;
        Sun, 12 Feb 2023 20:27:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFWX34xdtz4x7w;
        Mon, 13 Feb 2023 15:27:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676262436;
        bh=QBLOixEKMyJTRw9Dx8TsB7SolLJ47foRlXu7tR57uNI=;
        h=Date:From:To:Cc:Subject:From;
        b=aWfdlNFVrCZgTKpwf74drMb/oVRugDuGlspC/whTacj10s8yEpro6CalxNwWJP0kQ
         Wn5dWHU/hX/XpRDWgXKyYNOkNa/U04l9bSTXga+8/UUnuU3TQf5mI67ohSaAmOkxxt
         umsYxiex6fTTFt2BEQ1tzmN1qxf9H0fENk0aO7r7iePOOoXjUamjxmwYhW6wYWdGNf
         5GfYO4EEs9KR/z7/3MsZsnTknOoy35OjV150Aa7c3OaVGmmUdnM2VXVGErDVdOeoSu
         96ze/JjKZqdxzAfEz3ZYmQbFnsc34hr/QHSZg/witGJsTTZ2PYDFOmG1fsa7eCeqg2
         8hZN7jFY+OM4w==
Date:   Mon, 13 Feb 2023 15:27:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard@nod.at>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the uml tree
Message-ID: <20230213152714.78b844f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uslQ4RnyvVFo8jlhTBRa2PQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uslQ4RnyvVFo8jlhTBRa2PQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the uml tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/rust/arch-support.rst:20: WARNING: Blank line required after =
table.

Introduced by commit

  0438aadfa69a ("rust: arch/um: Add support for CONFIG_RUST under x86_64 UM=
L")

--=20
Cheers,
Stephen Rothwell

--Sig_/uslQ4RnyvVFo8jlhTBRa2PQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPpvCIACgkQAVBC80lX
0GzaDAf/ejdkLxMdCp4QoI30K1SN7jcyfLUE/MuVbfCl06jSzzMu1C1Qy24U94ee
dOVyRNktk500IUayVUEs5/tHDuQq2TYqGnHMWst6Dc3bC8AWavo7nG4nG6ESGrYU
F//q7vLUOnowVwf57DMORe9CxWrZJmcRwS33H6AFfKpTcU4LfkO/c/eskIhdAO0Y
rZinP+rn4GjEsoMiJP3EOZ7gMuuPr6jsUQZdmvecFs1e55fwOBEphQFhRr8Xucq1
vxRw9/hMzmn19ju/ZT9Eh2kOueA+wGIzJzHe+C2xwiEvYDP9YXtKmZjhN1EkYcTh
hwpsokhPUxUwDYjFCZ1nYk3iCQJgsQ==
=Y9zU
-----END PGP SIGNATURE-----

--Sig_/uslQ4RnyvVFo8jlhTBRa2PQ--
