Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A2E715189
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjE2WK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjE2WKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:10:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33A910D;
        Mon, 29 May 2023 15:10:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVV7x3Xhfz4x4N;
        Tue, 30 May 2023 08:10:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685398208;
        bh=jnSw0ODgyVXJWgbnYlhovVm+7UrKxuhbifjsvrqqRu0=;
        h=Date:From:To:Cc:Subject:From;
        b=MdOjP9A2bCMv9oc14uTKIGGy32x31TbZhMiPdEHr450Fa0Q9h2XRRrX+EoG86Y/cx
         X0/DqwxHy6AMAmE5y4CaUerxek9Kdvzdc4pokJv9g7OLwzbLVMQuInRhqWSmHu8bkZ
         sOz74Wp+Tty5GsCgOzLstBhRBb+KOSB981tXKOFnJBSkiTBaGE+gCMCENo98zj7e41
         Q28SgaPf6vJG2rNoI4xC9nzZDXoZ/boOJIOXBp1LoaF4aNLde3HeAeg2JEKFuBKLv/
         YbfQhBm4eolE4QuqkrCKMTPU6jiRk/jmnGnBKw9GbHQDdIhxonwi14jd5Wo7HoP27r
         PocoDundSht8Q==
Date:   Tue, 30 May 2023 08:10:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the net-next tree
Message-ID: <20230530081003.2ce3874c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sPCZ4fQZk9ECnJ4hW/N4=0+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sPCZ4fQZk9ECnJ4hW/N4=0+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  eefca7ec5142 ("net/handshake: Enable the SNI extension to work properly")
  f921bd41001c ("net/handshake: Unpin sock->file if a handshake is cancelle=
d")
  e36a93e1723e ("net/handshake: handshake_genl_notify() shouldn't ignore @f=
lags")
  7301034026d0 ("net/handshake: Fix uninitialized local variable")
  2200c1a87074 ("net/handshake: Fix handshake_dup() ref counting")
  b16d76fe9a27 ("net/handshake: Remove unneeded check from handshake_dup()")

These are commits

  26fb5480a27d ("net/handshake: Enable the SNI extension to work properly")
  1ce77c998f04 ("net/handshake: Unpin sock->file if a handshake is cancelle=
d")
  fc490880e39d ("net/handshake: handshake_genl_notify() shouldn't ignore @f=
lags")
  7afc6d0a107f ("net/handshake: Fix uninitialized local variable")
  7ea9c1ec66bc ("net/handshake: Fix handshake_dup() ref counting")
  a095326e2c0f ("net/handshake: Remove unneeded check from handshake_dup()")

in Linus' tree.

The net-next commits are also in the bpf-next, ipsec-next, ipvs-next
and wireless-next trees.

--=20
Cheers,
Stephen Rothwell

--Sig_/sPCZ4fQZk9ECnJ4hW/N4=0+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1IrwACgkQAVBC80lX
0Gz0cgf9GDPAu5D1dVA2u7gbJkGr5RK6ySooae74nwoPT854/YKNydVk0jR30Fsm
p5EA/vpRzTFoH59Osj5kLV6sOrI1Zt1m+7G5ai1TT6sjkd7lLogplkOUHCnGeIQ+
4SbGWi3Syl/vPtCox4gA2Wz7k97Qzteba5KFaoV+006ycCFhIMumvREwkfuhMCD0
Pjiyv2avGgFYSHidb7m2DSySY8uKvAQ7GkxqmNJ88UGhCfp4Y9utgh1asRchJgWc
fdqnq/TJw833EgaDcrM67e5Mab8Bc+W88ciBNXGoq2kKqV1FxRA+YTDv2MacXGD+
ow9URg0hJWRROtjKfXMRdTZPVnBOZA==
=RKdx
-----END PGP SIGNATURE-----

--Sig_/sPCZ4fQZk9ECnJ4hW/N4=0+--
