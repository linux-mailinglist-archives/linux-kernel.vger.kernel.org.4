Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54502725231
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbjFGCts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbjFGCtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:49:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F34173B;
        Tue,  6 Jun 2023 19:49:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbWys5lx6z4x2c;
        Wed,  7 Jun 2023 12:49:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686106182;
        bh=p4WYXBm5g9XpG8NseMMQfZiots8SAt9XgjuCPQKpv7A=;
        h=Date:From:To:Cc:Subject:From;
        b=bAHzvnAWlagNhmg0s5xLkWMQun1d5/taGKFkBtJ1oWpIbfbovCs1uJk5k+5xW1diX
         WJhvneoOGtEhc58RGHujZXhJEYyZBXkNx6qoyMPXWkrNaGNsscT1cxNh7X9u4Uj4qQ
         KMl9SzZQ2t71kUYZGjX7ri+ZwUeLtwT0fJqz4l/vetjj6vygT2wz5MdZAlmINyYFcp
         jv6PS4kjNp9t4KrxPxOMfrXJoWY28UzQMAkuKUWOAM4B7UR8+Oj1VXNcfNF6sR7vI7
         MlwNmGKj181io2aiJCPYF5mdfsg0v0cB8j9f/AcpsdorqhVJi1KYUwVB+HpVCdy++p
         SIBDDKbYrJbrg==
Date:   Wed, 7 Jun 2023 12:49:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the landlock tree
Message-ID: <20230607124940.44af88bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xUsCv_fhtCsSO7bn8kCdi_J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xUsCv_fhtCsSO7bn8kCdi_J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the landlock tree, today's linux-next build (htmldocs)
produced these warnings:

security/landlock/ruleset.h:97: warning: Enum value ' #if IS_ENABLED(CONFIG=
_INET);LANDLOCK_KEY_NET_PORT =3D 2' not described in enum 'landlock_key_typ=
e'
security/landlock/ruleset.h:97: warning: Excess enum value 'LANDLOCK_KEY_NE=
T_PORT' description in 'landlock_key_type'

Introduced by commit

  09fc199d0e51 ("landlock: Add network rules and TCP hooks support")

--=20
Cheers,
Stephen Rothwell

--Sig_/xUsCv_fhtCsSO7bn8kCdi_J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR/8EQACgkQAVBC80lX
0Gz3kwf+OWjSbuqazQuqS3GJnWYDlHfcEjKrpUh15ynNki9MjWc+nqApdVxSfnEJ
sGE2y58gFisH+ovw3/QYVt6qlHCadg7cVjzw2NoEzxDHiqeYf2GLzwS/o83qOgwF
malgugHq0Nml7fqV64l4aXR2ASm7tdg3FWzXyopIi0Xpy6JlJNhJrxU+V7x4foem
KcKCqG7Ty0aNVhj8qYsHNTHp9Ri4hnlPfJSFzPde6jwMkCHSV02IHeU1+05lnl3Z
l1rxwBlUI3RDsuirwjwZCjz4gvz+i/tzXqXnFlHRVDWHHpxbi1OXwo8Xoe01mXbW
Qo3U3dwkXbUTn+t1OoF3Rhd4EnJrRQ==
=FzhJ
-----END PGP SIGNATURE-----

--Sig_/xUsCv_fhtCsSO7bn8kCdi_J--
