Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0551369756F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjBOE3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjBOE3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:29:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CB91DBBE;
        Tue, 14 Feb 2023 20:29:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGlTJ1qPCz4x4r;
        Wed, 15 Feb 2023 15:29:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676435349;
        bh=k+UyJ0bzyj6iwA5lq4VzIodTsZc9POWZGOJzSpcD3vM=;
        h=Date:From:To:Cc:Subject:From;
        b=oG8kVFNPEB8/2E8SMdywJ6CnsIp+8k2PZmw8TbysJy+f4eAQoH9bd+Kx9zt3FUFKX
         h5IETgUVQDqRLKCBgn7sg224u7vSe36w6I6EQfCuyZ/hAsGgFf2gRLLWkKlYxLtcr8
         h3bxqxT7k/yCZrZvxTbRpDDbzQASCiVs4/eajmTN1wDfQT3I/XwKLJ5DHQV76YO8N1
         nqWh8MvENZ8MEmyiQijk6eii1DTpp38mU/2xqiPeHsI4NPgMzgtsmIdA3Thdm27Qvh
         j4xFNnThd+z5rs+7wBomHk0EsOC2q6/ECxqqKZ65zGMUo5l7by+YDKMcbL6Ug8tEEp
         8dtGB/N8B5F8Q==
Date:   Wed, 15 Feb 2023 15:29:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the clockevents tree
Message-ID: <20230215152907.238e0ba1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P6Y7jCjcak2+er5zS7l16yA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P6Y7jCjcak2+er5zS7l16yA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the tip tree as different commits
(but the same patches):

  e09903cea09e ("clocksource/drivers/riscv: Get rid of clocksource_arch_ini=
t() callback")
  f243533b29c5 ("clocksource/drivers/sh_cmt: Mark driver as non-removable")
  596846da9f03 ("clocksource/drivers/timer-microchip-pit64b: Drop obsolete =
dependency on COMPILE_TEST")
  8e148217ffb9 ("clocksource/drivers/riscv: Increase the clock source ratin=
g")
  969ec81d5a96 ("clocksource/drivers/timer-riscv: Set CLOCK_EVT_FEAT_C3STOP=
 based on DT")
  98ce3981716c ("dt-bindings: timer: Add bindings for the RISC-V timer devi=
ce")
  245fe5328dc7 ("RISC-V: time: initialize hrtimer based broadcast clock eve=
nt device")
  8cf50035875e ("dt-bindings: timer: rk-timer: Add rktimer for rv1126")

These are commits

  3aff0403f814 ("clocksource/drivers/riscv: Get rid of clocksource_arch_ini=
t() callback")
  c3daa4754f3c ("clocksource/drivers/sh_cmt: Mark driver as non-removable")
  8d17aca90bcf ("clocksource/drivers/timer-microchip-pit64b: Drop obsolete =
dependency on COMPILE_TEST")
  674402b0098b ("clocksource/drivers/riscv: Increase the clock source ratin=
g")
  8932a9533a9c ("clocksource/drivers/timer-riscv: Set CLOCK_EVT_FEAT_C3STOP=
 based on DT")
  e2bcf2d876fd ("dt-bindings: timer: Add bindings for the RISC-V timer devi=
ce")
  8b3b8fbb4896 ("RISC-V: time: initialize hrtimer based broadcast clock eve=
nt device")
  b3cbfb792792 ("dt-bindings: timer: rk-timer: Add rktimer for rv1126")

in the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/P6Y7jCjcak2+er5zS7l16yA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPsX5MACgkQAVBC80lX
0GymMQf+MGhtyWOF/mY26ClVhST/JkHUpSbiGou3WXfLHS3Teu2hlEml2uW7gfoY
yQKCep8fVkwvmJQ433o79gndI0xnbCLugUNxGUWtsj285XxS4UDxk4zDCoqMstFz
YcYkw3x0ejNN80v3HdZiQu64UTczy3bjr7JLAndTr+kOgtlNbp209tWelTvDO2mV
ag5frLhnL53ATm5UrLRo2SLsfVrTC/xsuauLkpRKXjSEeP3GIaoJGjLkzLjpF61B
dM7cEgc3vGsHCqRFdjPFEcJLZdpGbmD5udtoK3nKkMwAyAAtqutUTaRM0f2WpPiZ
KFcBOS/NVQMf8TE4+neftR+f/8btiQ==
=JuDu
-----END PGP SIGNATURE-----

--Sig_/P6Y7jCjcak2+er5zS7l16yA--
