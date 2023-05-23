Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF970E8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjEWWKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbjEWWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:09:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F383;
        Tue, 23 May 2023 15:09:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQpQL0vjQz4wj7;
        Wed, 24 May 2023 08:09:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684879786;
        bh=iIDoBcVHb/UZ+/Rak8F0hbc2VDnQPKsPhR9nbEg5jnI=;
        h=Date:From:To:Cc:Subject:From;
        b=nnp3Oh3Ex9T0iHbC+71OsYN52qk0NbIMZlVtGKwcmlDDFxgmOeyi9Jmy/xf4Q3WhK
         fYRxq6SxWIGMNjoC7uLdu7opYMq7Gymcceo788rFs1Lg+VzO29DqiKtDrvksbPVYPX
         5JOTFPWEP9plSZ/Sr2d2RRmJVt3//Y5AwDzB+Vbbvj+wMx3UZZVHdRm9fp8F4p5OaV
         f3x+pstSLxOJsFZx+Uraq8P0eAQU2KFM5xBazecbLjHUHpXyHkOVNGrMeHbKIHLT25
         6MPH6utA9eYFAXThcdqlpgeyoBChgSqbOl5H5FjA1UcOcgZWn6nXG3E4cqNUXYh4+t
         6m/WwsYtGaAwA==
Date:   Wed, 24 May 2023 08:09:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mips-fixes tree
Message-ID: <20230524080933.5ed64c2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RDW_oI9pS9cyWTl58Sp9R9d";
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

--Sig_/RDW_oI9pS9cyWTl58Sp9R9d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2d645604f69f ("MIPS: Alchemy: fix dbdma2")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/RDW_oI9pS9cyWTl58Sp9R9d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRtOZ4ACgkQAVBC80lX
0Gx21ggAiv4DuI/CtKgi+6DhahoP+hSzCBbfO0Fm4zhBtbeA3XmbphM4hUI7/xpb
o8EglF9yalMYuKIdC8odsuu70pUcZXBXU3TFfQYskpqazWzR6S9IjQfJnAYE91p0
4ErEzgEeE+cse/KH5nw84aBxF8IUi42D6CaoC5GiuufeRuctZy2gRNgHeyPpKpPR
UxsIhKCP1WVeo581RSvyjKfjANqKTXxrNMHOeiI7ydIm8UI9i53+CbYjY6pNko+L
s25A/zukW4WzkfeQx21LyRpfMQM7klJLivmUMlJGimXUsWVr0mqId5Uch/QdSG4y
Iw1XYXs03DK9KuGG03RMjiVKgkbjaw==
=QS4z
-----END PGP SIGNATURE-----

--Sig_/RDW_oI9pS9cyWTl58Sp9R9d--
