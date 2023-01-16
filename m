Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0B66B534
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAPBVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjAPBVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:21:52 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413E65B2;
        Sun, 15 Jan 2023 17:21:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwDkt3F7Cz4xN6;
        Mon, 16 Jan 2023 12:21:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673832105;
        bh=s6a3fbHEePGD6xbPmWZyx7SzDSw7oGPGLojIKQvJFKA=;
        h=Date:From:To:Cc:Subject:From;
        b=OnfNsXu0xnqngBfiapub5HSVuy5wqOsartJW2X+0gQFkjAX2ceD72qoA3PjrgkDms
         OqCc0c1KWX7QNjPFYomFLyOVS+WK0mAMC1MAh+B6lJSM2G3vQo8/HTqEcgihm7moB+
         jD5LFHZuhUEm5qpVm1cT2ShWIPdHfdk/B4U3qXszSWgS4n1OhOcg5Kk4Ho/S5yXCVa
         18yuRhZAvRFBWs798IiSKSO0lEEsCxnfYNSBsI4mG9wdEDo6ZhkBZDfE3GYmsysvXz
         Inhckhgbv+9sMiyk2B44E+2hlqFgvB09tj34X/13AxhfEBxGrCp1omeBLYJ4R4/b0e
         3TH9o5PVPvL6A==
Date:   Mon, 16 Jan 2023 12:21:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20230116122141.2623f59a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BNtVrXc8fIhy67b3S5A600d";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BNtVrXc8fIhy67b3S5A600d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/arm/mach-omap2/pm24xx.c

between commit:

  d2200da9e6de ("ARM: omap2: remove unused omap2_pm_init")

from the arm-soc tree and commit:

  259c95afac6f ("arm, OMAP2: Use WFI for omap2_pm_idle()")

from the tip tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/BNtVrXc8fIhy67b3S5A600d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEpqUACgkQAVBC80lX
0Gz/AAf9H2pTHhahVCuCemnOjqySvCE9mI9u0SbajK/warK6TvEtDJ9Vi45fatGV
AONCZ+XXwvD8xUS5+5KVnfw4xQHdQG/0F71TENPGp337lh77DWq4r2hIBM/WGbVo
i3VCx+7NKDuLLFMGj2VW/GNttJIugJ3lpQue4/n+0QQlFS9KXN+x3r9sim1AjnM5
OEQ1cmIthgqScr9ScMrz+pPhc7UNP0l0REMn1bgSo1X8X9cgE0vvSqkbzj2aSHSF
3FA2QPSC4I/wrXJVsK9sbyzAuism5byS3Z2GCF1+G0xl8Mu/Jc0DMLDTFrNTHjqk
gke/U/P1hupuNUO0z76dkzh909EJsQ==
=PAgO
-----END PGP SIGNATURE-----

--Sig_/BNtVrXc8fIhy67b3S5A600d--
