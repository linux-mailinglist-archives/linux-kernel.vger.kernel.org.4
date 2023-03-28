Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A622E6CCD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjC1Wcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC1Wcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:32:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3091BD7;
        Tue, 28 Mar 2023 15:32:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PmPZP2Vpwz4x1N;
        Wed, 29 Mar 2023 09:32:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680042749;
        bh=6Ik4XDH7ouHE+G+2WGSbpXZlGssVM+j+tla7bg4mPAU=;
        h=Date:From:To:Cc:Subject:From;
        b=hRlnUrhI2WsWCl1csAfuIgaprZ/J8moefipq3Y5SNI3D9DINy6G0Jk/x+qoC254C2
         E4JP0ragiytaFnFZ59CRYBv6x0xZZC/Yl+l5nVIWfghfxUojSzkDv65oV3eiNhwVxe
         MVF1XMGSXD+XO9L6C5tgFdxoL5j5d2EcmuYFOAHVDvb+/SrIbtX4ZjwTGTRqx8RkJ7
         PBvrrfkAHV0nr9ZW/RwNLK8WnX/+4OVlvyDydo6etjpJzx6we6wHz/CNEdF9Mzxggn
         Hd/Z4/wq8qpREiM/KMaSHeTmPKZ/z8FuSnxED+bxr9+dqYMuP3qZ0o66q/PUE69Z2J
         UjvuGVWUze2qw==
Date:   Wed, 29 Mar 2023 09:32:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhenhua Huang <quic_zhenhuah@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the arm64 tree
Message-ID: <20230329093206.6711826e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A_BK7GenuvmvPPb3ophqYcM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A_BK7GenuvmvPPb3ophqYcM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree as a different commit (but
the same patch):

  bfa7965b33ab ("mm,kfence: decouple kfence from page granularity mapping j=
udgement")

This is commit

  1224b9c78773 ("mm,kfence: decouple kfence from page granularity mapping j=
udgement")

in the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/A_BK7GenuvmvPPb3ophqYcM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQjauYACgkQAVBC80lX
0Gya/Af9Fe0G3jJ1XOxsp+K3JNFZ40ePXt+dXVlkpVHyNNpm40UVBS2u5ja9GqO5
pb3Xtgbz+Z85XjkjAfOL4+HuNS8aMX2sBjpW38ntSYVs1yRWgD75kiLzJqXjiOyQ
qLPuCuZ7sa+0m4SV+2DhV/21oVpjq6b9c1VF2siqrWKESFEJbbRo6vq10S2GipwR
caMmkCHB9/Hv8H1t0xEEIJZSCz+E9MRxtzV2fVD8oV63GsAXmpHr3ZDbdQL61H7v
lKyRlFPDZwnbZCqFrODWwZt79OpWgoUhbFrhbSv07Gul5t9Mvel6lsSWzaqWnSVF
UM+2l5Op/DY3LSnQzKYQoSB1i8wdiQ==
=8zmi
-----END PGP SIGNATURE-----

--Sig_/A_BK7GenuvmvPPb3ophqYcM--
