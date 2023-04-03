Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67B6D3C92
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDCEva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjDCEvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:51:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F33BBA8;
        Sun,  2 Apr 2023 21:51:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pqdl867S2z4xFX;
        Mon,  3 Apr 2023 14:51:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680497477;
        bh=CI3WCEpLiiUFOSCs3M8n7Nsr6x1Qk746fdzaOak04E0=;
        h=Date:From:To:Cc:Subject:From;
        b=df+WLqBtL8dpogPV/oRb9I9nzJCu+ymmif+vEKs5LtfqEWR/8E8QMeQQoZZ9JPIJX
         gQEocl1CU/UEtEJPS/aO9LfI23+kwW4Lgcjwrr7Gkvg2c3J526FIywJ6zoG0394CKB
         RqGvSEWlCrAo6U+H0I9JR38d4CyZpBGvvhfSkljeoSMZtumwWaEeBS/6jfhD+Rzd1m
         PP8YhjsrdmGO6F0q+GoDXOu7luqAVW7t9Xdouf9CZsE3ZH9ciSGeXH2a7Ym7slqnEQ
         aOwWJu5QfhlIfOxP4AXTR/1uQ9TImWPhqhJaHFJjdPTUkcjt7UyjS+gw64Jk6D2B26
         uubi1GD8ye2HA==
Date:   Mon, 3 Apr 2023 14:51:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ross Zwisler <zwisler@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the ftrace tree
Message-ID: <20230403145115.2849e079@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M5cOPS7S0mpLAIWeixd1ZrW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M5cOPS7S0mpLAIWeixd1ZrW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the mm tree as different commits
(but the same patches):

  4336cc15b9f7 ("selftests: use canonical ftrace path")
  d1c27c55427e ("leaking_addresses: also skip canonical ftrace path")
  c2f92e8b2d24 ("tools/kvm_stat: use canonical ftrace path")

these are commits

  7dcf5bf9ae8a ("selftests: use canonical ftrace path")
  4ea6b3463c3e ("leaking_addresses: also skip canonical ftrace path")
  d791c1b3e996 ("tools/kvm_stat: use canonical ftrace path")

in the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/M5cOPS7S0mpLAIWeixd1ZrW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqW0QACgkQAVBC80lX
0GyXJgf/VmXFONcFKW5FkrZkPslOqwb7vSMd0e0/J+8S6OgteW31vXYkkxV+K7IY
HC2AuPDwkTLVtoaK4LJ8SKkAAAu1UlP59CXBCPoXNRm6MbnobJpPkt9Ejs7/8Fdy
jk9qTA0wEEiEqelRhM2gxKAHDbLCSZ1mXLwUz3ujLKS6xtEL6YBlRUIYcmNiDuYX
sAB1n7ChI5UvucBRQfvc1S2w77QJ5vLXfreNfEAVV7h/44ednC5Jwlrx3BnJYA79
VDDAQc3ieDcNxfX1QHn66Z+DdbeRpnKAh50SYOQNuqIAVsLLbwGyaOdAuV7BVu7y
TIdd+DgWcgI8MPt+WTIlij496Ao/zw==
=8X9p
-----END PGP SIGNATURE-----

--Sig_/M5cOPS7S0mpLAIWeixd1ZrW--
