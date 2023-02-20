Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9F69C436
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 03:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBTCi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 21:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBTCi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 21:38:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9C7BDF4;
        Sun, 19 Feb 2023 18:38:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKmnh4tJWz4x7j;
        Mon, 20 Feb 2023 13:38:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676860729;
        bh=kQu1F+RDwjHG3rjNe9SpadXlH+7cyo4aDGC2pJK6KhE=;
        h=Date:From:To:Cc:Subject:From;
        b=B/7O5kl54pwHm9mL8IfMFV+YCQcyM4mzPEEVxWSwUKD0+5xkKytnQVeEqsvGIkjZJ
         MRYsG0wKZGkbYEkPvcLMTwGdJRvcAZ1Tkarux/QWU10t2gMZhLhKEXSznoBCqtrgjD
         hmY2w+Lpjn7UmLWNwZXrumsD/xMD8AoEnjzsWOeAUkKzlyf5Bm+uAF/xQzvZuaH1gd
         IUDC3DIUWUbD3XsFLtJulxK0Om8gRUIe+A0zXlJUzlYEfrzcZFNwmUHbQNg/lftfk8
         R9MBwCtEgpAad+ajZL7yczsiDY45XeHCQLSNyykmt2bzdobKeSCRcXu6SYw0SQRQ34
         yfOzLpuukDCPw==
Date:   Mon, 20 Feb 2023 13:38:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the driver-core tree
Message-ID: <20230220133847.11dacf2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q1bgAjt=aXfmJJ=qrZ6Bp0e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q1bgAjt=aXfmJJ=qrZ6Bp0e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the pm and opp trees as a different commit
(but the same patch):

  9f467f6375af ("OPP: fix error checking in opp_migrate_dentry()")

This is commit

  eca4c0eea534 ("OPP: fix error checking in opp_migrate_dentry()")

in the pm and opp trees.

--=20
Cheers,
Stephen Rothwell

--Sig_/q1bgAjt=aXfmJJ=qrZ6Bp0e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPy3TcACgkQAVBC80lX
0Gyc/gf/RcH5Fb8wDS1M3hTtkixV4jyDTuP8RFW7l6LUnzuwv0SN94dCUfAymiWY
lfJzOWM0ldycC3oXsAqMEkttEzJtcE+CQuMOvF40uiGaWA2an6zuwscYQ/0Iferv
5eU1aB+3evHaG08g7OnD6cKdfgeb/2MOSPWj0jbn59pc7YUB8AQBm0ZIdzj7RLHM
OoM9v4KLnURuGRlFuWXGHybN+Aagb/4mrtToLZ056r0AhAaT8SLaL1A8h05wdzHe
oJEpa6CnD/LYEI0Mu4gQoWuilXmC2qCzR5xp+S6rBtucsAO3lmaKOojcWn010Gxz
B4uUR7yyIzxSFRnosscokxYmX0ERwg==
=cWNn
-----END PGP SIGNATURE-----

--Sig_/q1bgAjt=aXfmJJ=qrZ6Bp0e--
