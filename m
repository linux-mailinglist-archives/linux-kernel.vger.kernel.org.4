Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C5071F8F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjFBD1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjFBD1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:27:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F189E43;
        Thu,  1 Jun 2023 20:26:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QXT283V6Cz4whk;
        Fri,  2 Jun 2023 13:26:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685676417;
        bh=3dKJYngvyjWXeWl1yQAmeFmnRGZpr2fkm7A0JbzisGE=;
        h=Date:From:To:Cc:Subject:From;
        b=SVTPX7LMoo3T6xscVxVcnwwj5Gbp+prGcNicOf806t3Ij8tClJCNqJksXjuFC3OCo
         pA7fsZbuUFc8Yldfnkc5pfW6qWdEy7zRDqNiKbNp7MqtCMRq8SmGyACPDeI5JPza5J
         NjQaCtjC0NnQeFZbqPbe3mFzKjQKhOqlv5A4MQGV2O4LhMKYwxl8MmFFxFcCKn5qUp
         BBR2lL9+pTRNrYvyXc//SGR4TYr3duyRUa/DabF0l4R4jcua+usJhV11LAMZTcYY6p
         EZgzUouzGn6E5A9srI9hlM43POTsalCDcmFVugDMMixY4DoP8FUuaYZNR7xr9VttM1
         AwifRBjh+inkg==
Date:   Fri, 2 Jun 2023 13:26:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the char-misc tree
Message-ID: <20230602132654.4497f896@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K26fC4c=8s3oRehc/sNP8Hz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K26fC4c=8s3oRehc/sNP8Hz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the arm-soc tree as different
commits (but the same patches):

  b866e7e7f995 ("misc: sram: Generate unique names for subpools")
  ca3222ac4477 ("dt-bindings: sram: Add compatible for ST-Ericsson U8500 eS=
RAM")

These are commits

  21e5a2d10c8f ("misc: sram: Generate unique names for subpools")
  38bd22dac71e ("dt-bindings: sram: Add compatible for ST-Ericsson U8500 eS=
RAM")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/K26fC4c=8s3oRehc/sNP8Hz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR5YX4ACgkQAVBC80lX
0GxQ6gf8CBnkwEO9lfZGqNKg4pzxAyC84KpMT5TdWBetBsRpPhU61oI+/saa/9si
x1o8SRHTZrvGKzSBsRy6EkhVXlXYM3HS+JbGfKj2pFbrvHVaQ6LTl0DNZuoatry/
fOwpbQEiL00ehDqBNDOiJfR6AfY5C9dJr1PlHbhIcQK80Gw6TtmIpEraUdJ2c/2p
nCCmF7AdjZxXz9Ps9WuhiqHNjmyDjYmaGD+qj9tgtOr30YDiYosf28EKBIdk+meM
Zv3unk/kAYxBHB/zhBleQKWA2bu/pH+kyUd68iTBaXAAGCzVtDeBK2N3APKA3xm6
R6s/7GDCmwjjLCkKzTJwwgdPnfZsnw==
=zBpS
-----END PGP SIGNATURE-----

--Sig_/K26fC4c=8s3oRehc/sNP8Hz--
