Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B95715484
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjE3EhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjE3EhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:37:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D03B0;
        Mon, 29 May 2023 21:37:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVfkf3HTTz4x3g;
        Tue, 30 May 2023 14:37:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685421434;
        bh=kNWtLo8ghy5vwb5JyMlcVxxAML2QhxKyddKUE0BxM8Y=;
        h=Date:From:To:Cc:Subject:From;
        b=EGkHJBwDsJ8hf7ZIpTkxwu7iIER8xcaIjFA8gmyc23/LrNJsaBVQ193pqePt/TQaj
         atfk/V3WfqqoRty8OfPVuvblOY12paFIu6VOCNInlRfvrySfAB/AjMOsGMlKsNztMY
         O+dfBePQDbsa6rgIStk6S5WIVraZI6qvqbCw0wTzmiLP7LZWq0s5Yi1DgBWfepcTQz
         Y/Bq3/azCCEoYEY4xwSIGfZDedq4gTgT7pGAh2EMlUfhz5xnEm5XbM4jsNTlNMTKSx
         9O+57tEvAIL6WLcQKcrrLtZ8RaWMdn/wDvJVER7gYsSbHdyaHMh/lXBQtBshcsYzUn
         VGpWkodvuJlnw==
Date:   Tue, 30 May 2023 14:37:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the fastrpc tree
Message-ID: <20230530143713.4cd58e31@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ORyttW0h06tCQQJtDy.wAKK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ORyttW0h06tCQQJtDy.wAKK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the char-misc.current tree as different
commits (but the same patches):

  3a1f192ad1b4 ("misc: fastrpc: reject new invocations during device remova=
l")
  578b3c7d15e6 ("misc: fastrpc: return -EPIPE to invocations on device remo=
val")
  5fad4a6b2d8f ("misc: fastrpc: Reassign memory ownership only for remote h=
eap")
  dc37d43b894e ("misc: fastrpc: Pass proper scm arguments for secure map re=
quest")

These are commits

  46248400d81e ("misc: fastrpc: reject new invocations during device remova=
l")
  b6a062853ddf ("misc: fastrpc: return -EPIPE to invocations on device remo=
val")
  3c7d0079a183 ("misc: fastrpc: Reassign memory ownership only for remote h=
eap")
  a6e766dea0a2 ("misc: fastrpc: Pass proper scm arguments for secure map re=
quest")

in the char-misc.current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ORyttW0h06tCQQJtDy.wAKK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1fXkACgkQAVBC80lX
0Gyc5Af8DvzCv+f0k9SaZuE1m1si2A5Mq2ek+iU63yv6IuEChjsCpxlxEpFZkyLH
RpUg454h9u/YgGGa2IXE+d3amlf4oicwZB1JE955vRtoDQV9U7qy0pXyQWs0XJYY
u7I1AvZ+rlXj/VaXyWh/MzcR43sPy3IKzFzWxcIpIoXP1PCAt9dIPc8QcJjx8Rdg
rTgV6slcOa+0r08agUblNbDNzG0xeynhq/9WCKfboEMkXuyEZLe+fk87uPGO2PDX
oRi0I1XmR2f0uhSfv22/6xm4ZUnicJYdx9g8Ykn5cky7oBGdeikYVb5oD2LuWqcZ
OVQsmuXpvkre9LkPdYPycdMANMCHHQ==
=pwNF
-----END PGP SIGNATURE-----

--Sig_/ORyttW0h06tCQQJtDy.wAKK--
