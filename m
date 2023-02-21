Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6AC69E983
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBUVaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBUVaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:30:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872461E5DC;
        Tue, 21 Feb 2023 13:30:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLsrh53Xcz4x84;
        Wed, 22 Feb 2023 08:30:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677015012;
        bh=GcdhFg/34oEPhninJe+vXf/3292ztoRJEUgvyOHE4qU=;
        h=Date:From:To:Cc:Subject:From;
        b=OTLG5EtdyygfU4afLEMBGrBAgbbWF5V3cT/wyK55niQEDOkpmVb2jBgHA0Xj7kfws
         MTm2j0j8kPCQOrLZd3KqefDcdpsTTiJvXQTCRBwMQF2ukQMAJiPPqWjQJs5jIon/8d
         y3/SVV9q0zhDQr98LRQf0Ys2WHBnFAccH5nPijKzf/Lo5gQQJW/NqV6DaQ4GuOlCDK
         Gs22TmCCeWSXcLu4pOVm6af2HfxQv7nVAjjyFuMHNfaBT2TiBEVHSZJ5n1vF0kfnuy
         D5g36u+1cCrzZjPUVRLwgnzdnkO3MTskF0+mYug6axE0TUeanSAiwzWYrQ7a5ibw5m
         2yM5NNac9xCdA==
Date:   Wed, 22 Feb 2023 08:29:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the ext4 tree
Message-ID: <20230222082956.019ed332@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c4UFk8H=0ya6HhILawxv1I+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c4UFk8H=0ya6HhILawxv1I+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  d99a55a94a0d ("ext4: fix function prototype mismatch for ext4_feat_ktype")

This is commit

  118901ad1f25 ("ext4: Fix function prototype mismatch for ext4_feat_ktype")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/c4UFk8H=0ya6HhILawxv1I+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP1N9QACgkQAVBC80lX
0GwDywf/RqBPa2h+z6FGkyxkG4tlJNFnT0eckaVyvZkgwvi4Ur81xvRnQZveFt65
q3h4e0PJoUN4XoD9z7h14rcI4JHpuwgtIQy04Fya7wbQ81JBcZ+uUDdL7cfLyVfO
4N+JSQDtP1oKtwTBW9ClxLYvJbv+3ow2k2ze4zEGcsqMLGW/Ly78K+aLnLWtb8aT
J7CMx1sQa2FdEWZnJrgiYnt9xiOr2KP+jywVxQGo2EgNqrG3d3KLN5F3+/bbgo/7
+naXZkVbIM8PamP77u8YlXhk43iFOFW49xHlHhbWtpojCNvkejN1DUNLrDsmdQPm
YzHj5Fllqpwl4khK5AWfFZIHW9As5w==
=oPiU
-----END PGP SIGNATURE-----

--Sig_/c4UFk8H=0ya6HhILawxv1I+--
