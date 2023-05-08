Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7135B6F9EC8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjEHEtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHEtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:49:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2424214;
        Sun,  7 May 2023 21:49:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF83K5Vlrz4x44;
        Mon,  8 May 2023 14:49:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683521390;
        bh=qNkYkavQBQhM43B/QnIzSxZ97R0FgiH2pTlcB8htIRM=;
        h=Date:From:To:Cc:Subject:From;
        b=WvQoyZ2UfDafiPfoLO/D6BPnr20bpncRW7UpYlpyOq5L0/oeQmsJ4jN0PlE+O9IqF
         i/MwEW+xkc6meNGI63xiHUFUX+VW4N+StYqrrEJ7bIVVVCRUToGFNwPfjLzRnI2kIa
         lMVSTqQajz0H7ZyHT1oiEUdMJUaALIVPUfBWcmY6B0dqEgeXj7M0UdCftyIDuz1fVd
         HE1uswThADQVVT7uv9Xlu5PnS2NGEfVGCA2auqmVi4q5IUqdjianBMXUXlINxvEZUT
         lVPl0OiYRJ3keVTzFMdICYreCvuWHBhA+sPXVG32F563tK+EC6/YHqmXJD2zc5fdbb
         z5jgdYfc7aX/Q==
Date:   Mon, 8 May 2023 14:49:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of Linus' tree
Message-ID: <20230508144947.3ac1dfe9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r9tSTle3SK7RVXgzh7oXUzX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r9tSTle3SK7RVXgzh7oXUzX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

While building Linus' tree, today's linux-next build (htmldocs)
produced these warnings:

kernel/sched/core.c:11496: warning: Cannot understand  * @cid_lock: Guarant=
ee forward-progress of cid allocation.
 on line 11496 - I thought it was a doc line
kernel/sched/core.c:11505: warning: Cannot understand  * @use_cid_lock: Sel=
ect cid allocation behavior: lock-free vs spinlock.
 on line 11505 - I thought it was a doc line

Introduced by commit

  223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")

--=20
Cheers,
Stephen Rothwell

--Sig_/r9tSTle3SK7RVXgzh7oXUzX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYf2sACgkQAVBC80lX
0Gy20wgAhB3kyZrKhrh0sdstJbNkgX+7PnRMN1bfHxCR9GruvfeXNkgpCt2cgKHL
/CKOGoDOAN4rsll7JPqpC4QiU6jhCmg+I0Ymph6SnV3BQPKcSIEKt9S25FFX8BJe
9KMFb1mPICveLURQmGhksn0+QaIC7Ob0oPJ5BEdqi02zrRGYO1+2op39/eDL3aMA
IZ6ErkFrf4TN2EkkebNajXWGatBhrVuwt9ExQqkl5rl56QH4FhdISDorPB1x4W7w
KzDmyY2Ih4yQPnkeWTWkz3n+D3Skkc0aSXJKMHXpw9Didh37TxsFGjZsUC6xp41B
0BCTw6J6/QNgn8LyHlMgzY//SWqsKw==
=CKmi
-----END PGP SIGNATURE-----

--Sig_/r9tSTle3SK7RVXgzh7oXUzX--
