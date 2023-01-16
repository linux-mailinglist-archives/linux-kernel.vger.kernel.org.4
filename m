Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD666B54B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjAPBi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjAPBiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:38:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9F66EAF;
        Sun, 15 Jan 2023 17:38:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwF663Hkfz4wgq;
        Mon, 16 Jan 2023 12:38:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673833102;
        bh=bchoLYLmRdaqaBe/F5Ff2MdvahnWoO14ZXlyvluYbtI=;
        h=Date:From:To:Cc:Subject:From;
        b=unmDEYbkU/Tri2Of14PZdDGql0jPMDGqv6VoQcYTM3Tukt1/QZ3mVnRQa8xicPzcV
         mbrnm8Wbrvlehzml/XM3QZ8hsaQvCFQOm3zYghcCatILfCglEU8bApRT0n8ThnHEZp
         aIhk8WmMMj2RkTb8QtBnV194Xefcic+tqiASUyAImOZ+nBvaRZwNuMPW26oJl5YbuG
         5kfk7MU3lw0vEXjC9BXLqXFw35z6tgP3NIyOoHr1nQppX1haW2QObdDh5TBrt26faD
         dJcpwdb8La/GIr0MFhm2/ERN4pGhlr6A2qt1MnuH7O6LvrHqHe+sYZWp1uddi4yDWl
         5rD6JdTQ5mUAg==
Date:   Mon, 16 Jan 2023 12:38:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rcu tree
Message-ID: <20230116123821.41d336ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+AjM21RVvHKRxUXsHR++tmn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+AjM21RVvHKRxUXsHR++tmn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tip tree as a different commit
(but the same patch):

  836dc5db1d87 ("context_tracking: Use arch_atomic_*() in __ct_user_enter a=
nd __ct_user_exit")

It is commit

  0e26e1de0032 ("context_tracking: Fix noinstr vs KASAN")

in the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+AjM21RVvHKRxUXsHR++tmn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEqo0ACgkQAVBC80lX
0GySGAgAmFI6TtP8yOENpoCrgDHKPSzH0iIHNG2cRZeYbOlWm8cBH7KrQO2cwNzJ
61+sB4pWGJrT5tUtP5DTxFJ1PouMrFdvAUuitDpzZCcneDS6/YndvW4lP6YtWeiq
dYUVanwHok/FLC8Drmhaq6mMg2KQHJSDyFTiNbmKoMRdfEhY3VRXfcam/GUq9z9z
0s/XU4pPrbpAmdNVAmlpJ3JAsGyhD8Q4WiCPEFMASQmdmCYYy9f8FbWkOWY1Vo+P
ZeXg2/ahrIPY1qwVEVh9eSM09NNiDinCJe/eCHgnOJMbQhMc263vXP4swhpZwWXT
0YIKNZGaeV9s4hkFtVOqalT/tOpchA==
=jdJQ
-----END PGP SIGNATURE-----

--Sig_/+AjM21RVvHKRxUXsHR++tmn--
