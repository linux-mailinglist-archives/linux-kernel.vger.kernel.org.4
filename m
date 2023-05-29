Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E147151B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjE2WQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjE2WQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:16:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8814F129;
        Mon, 29 May 2023 15:16:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVVH11G1Zz4x4L;
        Tue, 30 May 2023 08:16:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685398573;
        bh=4lxkf42BO/BakaN72s5mocGpwNrKxX4NZxOwg6NHDTE=;
        h=Date:From:To:Cc:Subject:From;
        b=PwFf+ScLuD7sXN2lQKe34F0T5ifwTvbaHx/+kCU8I6iuL/DiF6I1F3SahXi18JB/D
         rvbWsw1guS1SdoKJL9fOqoPKqCEJppzIHNFi4AEy92R1yWsifi8sxcZmpHbIKVO3wb
         bPYL2+I1B3Y+lZajlWyaMQ6H5zEi0bJorJFiqZ4RuXflz95/JXddmejHd38Y961WEi
         LMVzAoQx4B0vUvflPYxwNruYWx/0e+raYq4B8lRM1fDrAomsrBvsz+tU/JIydxDmXF
         k3EnZ+gDa/AFS7YJ3mrPkQL3sIQsgiWYeCdkfwSzZIW15reqoDJCaJKmQ6ABEvB1K4
         SeDtAPwOhCC5w==
Date:   Tue, 30 May 2023 08:16:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Roger Quadros <rogerq@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the usb tree
Message-ID: <20230530081611.20239925@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mbObDkx7nPlHL1I671yjKaJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mbObDkx7nPlHL1I671yjKaJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b4a4be847184 ("USB: fix up merge of 6.4-rc4 into usb-next")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/mbObDkx7nPlHL1I671yjKaJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1JCwACgkQAVBC80lX
0Gx77gf+Kg3JeZch/OnVqzmEIqJ0fjmjp5Cr/NFOcXll86zK+2BKy/rue4LNNgJq
cgbTG2ZtrCafWsswAhr24yUIlFmn8DTcAjSfPuqDQXDENW5Jq8vT3L0c2oYIVFiU
SmhxxIGXtywh6p4nCO6WYQDkiBOn4fts0Ec1WKv13cqrfXq9VoCThqn3a4rrDubx
kX4Ea+QPfsu20XypyTMeS9T0okE7bCzwku4FKa1maqYCkCig+s379ZqPBPQLsvVK
Qlt5tgUsnc06bx7HXOIksQvylfQ5HjjbO3HzOUIkWb5Gb6L7cp4hju+IEGUYWRXL
mhswP8VP9OR5HZVcUHLqyS+gNBnjTQ==
=7Vr3
-----END PGP SIGNATURE-----

--Sig_/mbObDkx7nPlHL1I671yjKaJ--
