Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819226FFE6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbjELBb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbjELBbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:31:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548C2D4D
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:31:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QHWT43QdRz4x4k;
        Fri, 12 May 2023 11:31:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683855113;
        bh=0gH3VUShNMlqCvDVqctnZgumzzCEoeeUz6JIgUWNCYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KaSBY6Rn5PakQCkkjaKKBtgo55uqknuKS8nAfzG8IJlPfh9ZvXL7D0spSe8deT+IK
         EQWLiOin13xnZDzou/BUKHvuCmMrhQFkOkODW+GdNCy+HVURQlVkEepJxxsGByhAPT
         vMTz6X6n0rWe62Ve5IPjn+fdCeyT/53fsm4uIZVUL5+u237jAXP7OFyXydASsmbiXt
         yXEn9432rkmfWvrZlZ7Qt/wQz5E9F5Bp8OdsSNahx3tRe7QwW3wGLpLuVyFCP8MSX1
         Gb0yk8erKE039jcQDlsIXNJOk+08MrrYftNnSNRR8hRuRS6f1jnx2CLTB9XhuYUYte
         oB7rZTn1QQ+Ag==
Date:   Fri, 12 May 2023 11:31:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [pseudo-PATCH] sort MAINTAINERS file
Message-ID: <20230512113151.3a79bf70@canb.auug.org.au>
In-Reply-To: <CAHk-=wjqkNzpYRzgPAj5hwkYJtwg6UEb+hLUQtUm2OYH93WpfQ@mail.gmail.com>
References: <fb4fa92a-eabe-10b8-fffd-7ffc8a70404b@infradead.org>
        <CAHk-=wjqkNzpYRzgPAj5hwkYJtwg6UEb+hLUQtUm2OYH93WpfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gu8nTEC93Y7SYJOFmrDdPjP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gu8nTEC93Y7SYJOFmrDdPjP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, 10 May 2023 19:59:50 -0500 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> On Wed, May 10, 2023 at 7:01=E2=80=AFPM Randy Dunlap <rdunlap@infradead.o=
rg> wrote:
> >
> > Please run scripts/parse-maintainers.pl to sort the MAINTAINERS file.
> >
> > It has gained more than 100 out-of-order entries since it was last sort=
ed. =20
>=20
> Ugh. That file causes the most conflicts, and sorting it makes it horrend=
ous.
>=20
> But I guess if it should be done, this is about the best time to do it.

Just before -rc1 might be even better - a lot of maintainers trees are
now based on -rc1 :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/Gu8nTEC93Y7SYJOFmrDdPjP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRdlwcACgkQAVBC80lX
0Gywxwf4y2sbJtrOrAKLZnAI+e0Q6PyLlGS9lDLEhzAP2yeQFTyUhO9acgGdHtv7
naphCWVEr4voXkckyIKdf0Gc/E6x6drkpiipVDkEMbA2Xcl7Rv9dSKs9Cjr3ADrQ
QWoTFSZAT/kmUIGQBAj2df4+xlQE3Z0Vgc93dlxxXMrIL8F0b8+HjKHIOSNly4mv
+lKok81bLlqG5DyOqkjKbm0RVxFoTnoHisupwlIISGjpyLGiUBgPEWvXCmkvNjGW
hszbSsCQapWjMvQJVyMOsVkdktz7ha0OBH3LBNN8KabIhDqtdzmENcd5CDneUmpp
81zaXxvq9kEj4KVi2QtkunFFEbV1
=g0ls
-----END PGP SIGNATURE-----

--Sig_/Gu8nTEC93Y7SYJOFmrDdPjP--
