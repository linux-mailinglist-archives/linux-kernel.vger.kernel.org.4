Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD1626EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 11:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiKMKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 05:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiKMKWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:22:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91AA11807;
        Sun, 13 Nov 2022 02:22:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N97mR3Zl8z4xGT;
        Sun, 13 Nov 2022 21:22:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668334951;
        bh=avZe2WAWuXja39KSCs5UOQ0remMVEoczYF+XEPEYSDw=;
        h=Date:From:To:Cc:Subject:From;
        b=phKNYJ34MlhSsk9iIGh79ZShQVVRTpnF1y+PZTRzZCNuInDBZOywBGKDDFZKtVEJE
         Awq0UTz70piqYlxMq48Hduo+Kz5pgtC/N6pzXHqilf7ftEIvIjxyzsi60aCUbEs2mP
         LeCDg0/vhgKX8ve7QA3YG4T6tJxz/nQddRoScYKXm+Oo3xbfbomAAH1n30/RfqewwV
         rB33SzMFC+EYmvMk924DayodL43bvmJwk4nhJ9DaPHCFBxSwNNhcXiRUQQobnuwDAj
         N4wW956nn/bdC4TufbjLAKXbNGI/F8+pg9Co6Gc7q8lhITlbi8oittmyuprscZZFh4
         VP43TztgHDRpg==
Date:   Sun, 13 Nov 2022 20:49:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: linux-next: Fixes tag needs some work in the ntfs3 tree
Message-ID: <20221113204242.1c7ff242@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9UJYGv/5GlVJcOVSk9Y1QJJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9UJYGv/5GlVJcOVSk9Y1QJJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  019d22eb0eb7 ("fs/ntfs3: Validate attribute data and valid sizes")

Fixes tag

  Fixes: (82cae269cfa95) fs/ntfs3: Add initialization of super block

has these problem(s):

  - No SHA1 recognised

Just use

	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/9UJYGv/5GlVJcOVSk9Y1QJJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNwvZgACgkQAVBC80lX
0GwosQf7BK/fsBNeDR7vKslJFvrt4SdsdSoUk+LM/Htnw1YAL7dfGtVcOm4aHSut
Fz4GImfm0iSarb+JEwmwv9bNe649BAUjLWuNzLEQReeu01g0CUtZHtmqn6LthZdS
LQNcZj4YjPLMEmSNU646+dCG8CBiANrHQrNwlAtrZVk8P/t2RpX7LAAOkZNdoD98
oqR/Jdtinp9Cua7/NTMkrcvGHEK9a+OYnmJ5e1Of4n3qdNsS76OVGUoMB9dCIaqt
zi4p31lx3i7PDOeFl46q1xiIYK68DD/NZJDqs1ZA/hdz++SX+IQ/vPRO23bTTVh1
NX70rk31uktsyAaZRzabRrNCgpOkng==
=QeOv
-----END PGP SIGNATURE-----

--Sig_/9UJYGv/5GlVJcOVSk9Y1QJJ--
