Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8C72D4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjFLX1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFLX13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:27:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DF11BC;
        Mon, 12 Jun 2023 16:27:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qg7Bk6lTtz4xGq;
        Tue, 13 Jun 2023 09:27:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686612447;
        bh=DqaDHy7x8ZPctpxeXsTqNqUGIp5lO7D5qcQMr4PtiZs=;
        h=Date:From:To:Cc:Subject:From;
        b=elKELeDh4nnBICe74of5FBPkVHGyoDfGXZ6zELee6KEYQNdz828+g1N3IdUwB4XYy
         M3Sc+tkrw5RpG99gC1Xic1pgzJHiP0B2VMWlPFJpE/lJ+sVai3a3/jYIj5RGLG/nwK
         ZIam6BL7icviXmM0vk5bQw7d9dacmXIzSuaOPOF/Newav7o/yNvp4LroiySWq9EEPx
         ypOgsR307oRmrn/kyt0mO2rDRezW4SrocjrNIWOx9di8J5nSnDKQFjL0SPFxDKTRko
         7N92sC0ZGw+HkA/tD/gKjiFZk9XhH5s71kxhpL9+a6s78zgTOVWHTVBEHeaj+c06eE
         maUmrF30ZXDuw==
Date:   Tue, 13 Jun 2023 09:27:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: bad rebase of the kvms390 tree
Message-ID: <20230613092726.0383cb94@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ux/14a5urm2QMGmyeSri08E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ux/14a5urm2QMGmyeSri08E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The kvms390 tree has been rebased onto Linus' tree incorrectly - it
includes duplicates of 3 commits from Linus' tree.

Please fix this up.

--=20
Cheers,
Stephen Rothwell

--Sig_/ux/14a5urm2QMGmyeSri08E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSHqd4ACgkQAVBC80lX
0Gxiwgf/VL6XTGojKvZpgvAtGFyxIzzs+yNx/PB9XjmKVAhI+IATmgfb+uIbgxdE
5YK/eR/sw+v+Ll4XhcVc+rAO1erXKtyM2527XPmRb7ZPiaKES2fVfJKntY3tAUIQ
jItL8IgslPNLmzre95gec46ZRfdVmnrRpfCL8EE32vf7xVVGKAmXXOwydBG9Udo2
8j79rUDfxhWIR44HhgE7H3NAlgLynJv7WxNZfg87Vds3rgSt095NdDcocjVXM6bK
twO9xHqUhXUzuHsuV73KXj3H55R4Mhn0ep+StEs8JzVB5PUWkIJuULkOFVJN/7tQ
Jc+nAnFpCuAPHlhBzccHDGJd+82UrA==
=BRIo
-----END PGP SIGNATURE-----

--Sig_/ux/14a5urm2QMGmyeSri08E--
