Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EC260977D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 02:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJXA2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 20:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJXA2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 20:28:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318136CF65;
        Sun, 23 Oct 2022 17:28:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MwbXc0NCmz4xGG;
        Mon, 24 Oct 2022 11:28:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666571329;
        bh=oXkht8PncIo7uboj9jDm3LdspsvJwecchJoIiSPHl90=;
        h=Date:From:To:Cc:Subject:From;
        b=sTb9a2ute5IPFdAagJvbqTJLyM3Ibs/kyxBsRoZ2BjsuJe4aPAcbEuibVNth/yZ/S
         /oGCfy8nR/9p1W1M0E6GOChW7QjQrf8UZNK/y4cI73IsSAbxqrDVxp55tQUv0tLgF2
         YfCWLJzw7RpzYpFgLfGUd9RK/tBLaF1FaFNHPg0AdiSqHpfbglzwfzYcACJj9FjcSG
         cNaGjBREOz7G+HO1TnZ1c2ScG4NYCK46+eL4mRtQqUsppQwQrIhnXsgoxXkGkwpJ0w
         91TBEQeJviXLfxi+fA7UATJ8vPS90ouLSFRFgwifq3y3vCARcy8/tFs0DTjwxFcO7t
         BeR3V0LIkcLJw==
Date:   Mon, 24 Oct 2022 11:28:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20221024112845.5efaa8c1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gylz_XNc9jVNztUtivDOobD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gylz_XNc9jVNztUtivDOobD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

vmlinux.o: warning: objtool: get_cpu_entry_area+0x4: call to cea_offset() l=
eaves .noinstr.text section

Presumably something to do with commit

  1248fb6a8201 ("x86/mm: Randomize per-cpu entry area")

--=20
Cheers,
Stephen Rothwell

--Sig_/gylz_XNc9jVNztUtivDOobD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNV3D0ACgkQAVBC80lX
0Gzc0AgAloBNTU69KXOu+PbqKlcmt9FyceaR4yvw6QlUmLasPzfL5WTu0iSt9x95
8nf3tCgbrr9461kTdXVyx5oNR9b3LSXuJlPXmQAQLLd2Wkt24BFdvHmsm2Fhiz20
PKnvNNoFbJEtgYvEOOewCtAaYugZPQhbAlrYJFV3zCbvXZdiaRiH11RGVczlVcgX
xlbUpyw6j4CwI6G/Nl3LVG3ETpTwva3GtYvnh0gvWTDLua97avso/teDvtYbXonC
glT6+OjSQWVkHlvJ6GTXrKoOozJ2f/yNxG2RaOSs8bkaPOZgYyvvt3fdl0jqfBKQ
Jh3dt/KTgz0MuW/uQv/AMZbxYpwP4Q==
=aQVl
-----END PGP SIGNATURE-----

--Sig_/gylz_XNc9jVNztUtivDOobD--
