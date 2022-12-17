Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C76505DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 01:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiLSATg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 19:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLSATd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 19:19:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1157F634A;
        Sun, 18 Dec 2022 16:19:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nb0gy2y8Fz4xGP;
        Mon, 19 Dec 2022 11:19:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671409166;
        bh=/DDefxEnWsbZzUAzjj4Yz8aABn22y20BLvAjpkgsP6c=;
        h=Date:From:To:Cc:Subject:From;
        b=ei2xi9yaSfK3QcMZSM7kgl16Rv3fxH7fALSUoRTn7xzOeto7LdIXCgVDNjoSvGaHk
         BnXBZkqnItLDrM1AgWCqVAd0YI8xhpTpWHvLbI6l8bcuy7p/NbbutQdMPZoqBQPahM
         LuEIuLtJNgSQgTekryi9JZSL1CevcI+6vmmAfgk5VMShq2AaPH7hnQCoZSptXQvlbo
         84EOKPvLVW6T6BEsjZN2fpD6O5u9ODyzm4kKEEByEs58jtGAiGaWPm9YNX5k2Dkr/u
         V7JAyhjsn7ubOqN1SFIwseRa/O4Y5p+1y2xp4EooGmXn87T5K/PhP8FQrPEZ+uGpH3
         N/rylhLrQdqfQ==
Date:   Sun, 18 Dec 2022 06:22:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20221218062235.443758ae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/akgCzYeh/QiJmkniLvKkUp8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/akgCzYeh/QiJmkniLvKkUp8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/cgroup-v1/memory.rst:723: WARNING: Title underlin=
e too short.

8. Move charges at task migration (DEPRECATED!)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  67c497111586 ("mm: memcontrol: deprecate charge moving")

--=20
Cheers,
Stephen Rothwell

--Sig_/akgCzYeh/QiJmkniLvKkUp8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOeFvwACgkQAVBC80lX
0GwpWQf+LSxPtmJIpboEcIe8na1qKmCnvl8qw8Ld+tuOlBY9pg6zeZqbceEo0qPE
lNhYOWTlYduyX3i2Mxo2QeVL862MVuBS8Zcz4UOxcTUErmzIbiFBCm2AZ82PMZP9
LqE2Jmja6oYhUqqHyc8Do/tyEANtM0aXKalZMXxEtfC5Zgrst8NxSRmVUzV86Jju
vTChtV+DF6bDtUQYdrneCOz8U6qV+0vyuOQaX0eDazrquyJCksaFdXlI+ktd37W8
QEeQrUJxJlIR/lZbXSEPaQwTDrc/seNoHT4ojK5qUHzVl9MoAlZdTNgX9rkChTiS
412QWnlsxKlIOtHA9Y1iGvAdSt+p2Q==
=Z5ZQ
-----END PGP SIGNATURE-----

--Sig_/akgCzYeh/QiJmkniLvKkUp8--
