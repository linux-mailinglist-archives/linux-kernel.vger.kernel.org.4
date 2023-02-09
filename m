Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81006912B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjBIVmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBIVmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:42:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EBD5EF8C;
        Thu,  9 Feb 2023 13:42:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PCVgz5rXmz4xNH;
        Fri, 10 Feb 2023 08:42:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675978928;
        bh=o5fGlGfKlehbbAX71AMiopqNNE0Wpcu4jLN3S+L/6mM=;
        h=Date:From:To:Cc:Subject:From;
        b=df33plrOY7cLuNkHt0Wjqyt0t5zunl8NnWIwemltRLe8ddC2MyfHTFIrX+XmRnqv3
         Ys9kcT9wOa2nSMvrKoQwI7j3pVd/5uTmSnKktCzUGI/Mbccm5lJirFdZPh+xgwqFaV
         WPEop4tbGm2efR2wnxS4hxxHjvyglaTqRJtW4StoLNcGSND7zRQMI1pL5UBTKuGpJz
         c3l0/Ze5uBxPYYwKsJc1SRZ+bVl34Q/FnRaq0rBZXCCCvP3wBiIqKphEQqvGhwmwYw
         lGtOh/d8XvXWuegEp7DyICsG5K1jpJa1WG6m8vnzhkUcY+zG6rujsTskuvC0MR+0nZ
         Nvmjaqksn/TqQ==
Date:   Fri, 10 Feb 2023 08:42:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Walt Holman <waltholman09@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the hid tree
Message-ID: <20230210084207.4d02d107@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j_k2hVQNwzZN3_D_IziOMEj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j_k2hVQNwzZN3_D_IziOMEj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f1fc9fbc8394 ("HID: Add support for Logitech G923 Xbox Edition steering w=
heel")

is missing a Signed-off-by from its author.

This is just a typo - "Signed-of-by".

--=20
Cheers,
Stephen Rothwell

--Sig_/j_k2hVQNwzZN3_D_IziOMEj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPlaK8ACgkQAVBC80lX
0GxrzAf/ZP00UcWAfT9OYOk+AhTalgxjxBb8+kgzT33vw8TM31bL0vnmIwI+g5Kh
0djuMb1YbifBPBv3gkJa4FpqUcTasBnhgL9tXL6k0H6lUL62BaAVAujUS8IaLZT/
Jlu3ayl//QpUV8fe9ZCltIRgEhlwOwKeI/CMIdNMyUNWLC84xxWHd26Yd35zgALs
gUG9aVnDcyTF6typlqhmrAViYHtkIOmyLXDJqHIoML7UWdS5JZfCx1msW7FBkwQq
uhbN+u30yqph6M8POhfnCEZLrvzG0usluRH+3eZ/Bk5agU/nIn8uky4zPaKyghXz
SPn4Fzf+tCIJ4mRYyoswVXgYwApt2Q==
=0VZw
-----END PGP SIGNATURE-----

--Sig_/j_k2hVQNwzZN3_D_IziOMEj--
