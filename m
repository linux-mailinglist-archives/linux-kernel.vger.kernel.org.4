Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C929685DDA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBADTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBADTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:19:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC313402C;
        Tue, 31 Jan 2023 19:19:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P66bX2frMz4x1f;
        Wed,  1 Feb 2023 14:19:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675221576;
        bh=2I4NiJJYJGVQurt7MG3a6nrj+mgg5f3ZHtM8by6ryyM=;
        h=Date:From:To:Cc:Subject:From;
        b=VnPE+/VQfOzMGR77dolYNSlSvCIxwOKYhAtDlvwhG0PWWy85Z8etjHH86p7uuhDA3
         pk45u3R4VVW3hsJdIsQU/bA5AZkPtgvhY50tCGQGBWkzb/GaSex2//fDtTf/BZP5E2
         B0bqCKmKnRwk5i4t5mAM7PzWzc+YK/EvRuaaDHf+oRlQlvSkEccBcspDjRWdFi84Vi
         rxCuY6lMyJwtmdOwjcWrVGVrCZjs3/rUamrZjwkENBOMpuU7NULSJwf+xtNbBcCObw
         wPHyd/IQBuY1ftFoLbZQKMh1Yn8WlXNvPkzZ1cIuA7RzZYhc9CD7VImqJgSL/zB1Nl
         Ft4EmfzpcCFcg==
Date:   Wed, 1 Feb 2023 14:19:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the icc tree
Message-ID: <20230201141935.63472365@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nd4X7fkyFq.llqB0.hsl.Bf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nd4X7fkyFq.llqB0.hsl.Bf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the qcom tree as a different commit
(but the same patch):

  991f1372d028 ("dt-bindings: interconnect: Add QDU1000/QRU1000 devices")

This is commit

  bb8379ce26d0 ("dt-bindings: interconnect: Add QDU1000/QRU1000 devices")

--=20
Cheers,
Stephen Rothwell

--Sig_/nd4X7fkyFq.llqB0.hsl.Bf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZ2kcACgkQAVBC80lX
0GwKRQf+MThbuGqGUz6CcNvLTmyEYUz66eXFCOJBndn9CxqO/tE0/yAZg6MUwFeF
CySFunnvaxDUcDrXX7im3DVX98T9+NYehHfbbTHgKOZB586VC2S8qWuCgY8xs57G
0/wYZU41VO7MvJE7i32svyr4y34lh1i+6UO3tR2ESTRiCjIZ18mkby3t0FVgnzXk
tJqnipQ3BX1UQawhbX2JWlj4p+iJhumHC55ZXMjEvmIeqxlBvwFmJyNKxT14ZR6Q
Z/i/qGA9nW9DJ18KaP88w9JTD3PnElEe6quxAD1foNW2Hm+4OpgIlm1VpEr7GSS7
Nxqd+t2ge3O/vcgPOrpb4B+CcEbMTg==
=qUj5
-----END PGP SIGNATURE-----

--Sig_/nd4X7fkyFq.llqB0.hsl.Bf--
