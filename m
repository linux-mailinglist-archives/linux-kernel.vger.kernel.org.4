Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22ED721C0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 04:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjFECeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 22:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFECeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 22:34:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5FBC;
        Sun,  4 Jun 2023 19:34:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZHk151vcz4x3x;
        Mon,  5 Jun 2023 12:34:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685932458;
        bh=7LjtbyNDYM6Iums6LGt2yUN+xDJzekAcnjVaZQLQ84k=;
        h=Date:From:To:Cc:Subject:From;
        b=rII1T6nj/JNkWvuEFCCnGFU0WFOhmrWEC1LejC3RXoso1ra7AuidwNTCZePSvrKo4
         r2ED5YK4mE6A8v2VEEJVlJejsTXxIr/jjIRnQp7BlVKl3hGuCId0WkFhdxb77uPHiU
         OOd/ZAdRaU5FuJp84F9eqxWzar3Df+DOhlY2yhp3Dx7eRFF9XoIMpK8Z8dHmJyRf2H
         6xn+eu4NPeAd6raYMFp8sgYrljwluiupa4vsLfCOagW5E+vE0Dvm0PZ0F7WEBhhDuF
         KCK8rwgE2VLKBV5LfbxqhP2hDx/s/30r9npuH9QTz7JxUsvboN1V5noVkhBjpm2j0v
         n1t7fUM2HmIaw==
Date:   Mon, 5 Jun 2023 12:34:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kspp tree
Message-ID: <20230605123415.451f64e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T8ItEyVW_z7h+dbqRLN_XXJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T8ItEyVW_z7h+dbqRLN_XXJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree as a different commit (but
the same patch):

  4cc6886bd8b3 ("checkpatch: Check for 0-length and 1-element arrays")

This is commit

  bb1876dc1487 ("checkpatch: check for 0-length and 1-element arrays")

in the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/T8ItEyVW_z7h+dbqRLN_XXJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9SacACgkQAVBC80lX
0GzAMgf+Mbff+WCEGZVJ/ar+NZmtcTZw6YXJM1qkEZX6TH7x+eoWqwV+eT27UIoo
uiOsIc1ASVNFKC1XYWmC0dSVW4maIpH985HJXksqwX3uN6GDriGBp5y+gRcnqqqw
9jNLB7DJL7rGAo0KcPGxBlJAFKuIfhGPg1V7uEguiRSPIVotMEIFD31aciQ5WyHz
rv5OZO9tx8LEYszMAvGuVZAnVyIqehHjIWbJkFOWoUgqBLDrZN4ZtCwOFaJNPa14
N1tLs4r6Tz+63UX6sQDHGxZhQB15kehbcnL5chT14I+ELCg8IgFisuEMimpZWM06
zUnhLxPAkeOb9RMP/saxdK7zi65JvA==
=spqI
-----END PGP SIGNATURE-----

--Sig_/T8ItEyVW_z7h+dbqRLN_XXJ--
