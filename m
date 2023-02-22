Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056769FDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjBVVcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBVVcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:32:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8461934013;
        Wed, 22 Feb 2023 13:32:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMTrY6VPbz4x5Z;
        Thu, 23 Feb 2023 08:32:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677101535;
        bh=vU8E9Q2HGk9qEtbjG5MMNc+ltitMHRZT05rfowHAMBo=;
        h=Date:From:To:Cc:Subject:From;
        b=SyTbctYcGQs8iMX4kxpA6T7Q1X9/pYiR2aeBWGRwTBv6TMTnC8E06TNx/BGRuJKil
         dESim5b0GM52KSAq6mNfWOGlG813ZAx3AE0eEmfMBoyiwEBro/6wSzTArR3jWG+cX8
         YziMLgxMK6FlHBfZlfHax6pjVfKrpatbSIaDmRnITm8GM1kSyPnGrS0A0qZ2Vntii/
         HtC2ORQeKnb11xcL7YYySOnzpzdlomrjr1mALmfDwaoPAqisr4bQ8pF+vbATaNtExL
         TuKA3wzVDpluA5/AcThvp5F3USyTdIvtE06BQK+rnqUz9AKfQMARywqnEddRMFv44x
         N3UenqflMWD6w==
Date:   Thu, 23 Feb 2023 08:32:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Denis Arefev <arefev@swemel.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the smack tree
Message-ID: <20230223083212.60713ca0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_gqmnaN20Z8CBBsf9uoFh7G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_gqmnaN20Z8CBBsf9uoFh7G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  c0e48d3f7722 ("smackfs: Added check catlen")

This is commit

  ccfd889acb06 ("smackfs: Added check catlen")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/_gqmnaN20Z8CBBsf9uoFh7G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP2idwACgkQAVBC80lX
0GwbPgf/a/c2qfYsQakdZxDn9P8BIHUx++kNyPpzpzXfY6bTJ/tSxP3c0kteEMdH
XdX7/RzO29YLVKyaM9kbJa/sPB1aA9DV73zdDYDly+b21zEjIiWbJwV22gJguv72
Jw5EWv8eFe+jhcflUJ74+lOoAVnop/rj6IcG5NfQjbTX5JguFYIb3fl5uaj655dR
d0P5yNEXhHlHY0hMJyS5SgJabLIvUJtTgqL9mGZVyszojWgjQJNPqkvgE1kf8Te+
nY8krQl5ghZkp0wck76oo/W7gB3xpWSY4/hyQ9Cayfu8jZxkidqnt+9SNIWJuaZC
HIOBNCgZk1nceajmD8mNucOzr290xA==
=OH2Q
-----END PGP SIGNATURE-----

--Sig_/_gqmnaN20Z8CBBsf9uoFh7G--
